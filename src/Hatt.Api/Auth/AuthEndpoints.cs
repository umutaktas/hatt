using Hatt.Api.Data;
using Microsoft.EntityFrameworkCore;

namespace Hatt.Api.Auth;

public record AnonymousRequest(string InstallationId, string? Platform);

public record RefreshRequest(string RefreshToken);

public record AuthResponse(
    Guid UserId,
    string AccessToken,
    string RefreshToken,
    DateTimeOffset RefreshExpiresAt);

public static class AuthEndpoints
{
    public static IEndpointRouteBuilder MapAuthEndpoints(this IEndpointRouteBuilder app)
    {
        var group = app.MapGroup("/v1/auth").RequireRateLimiting("auth");

        // Anonymous sign-in (CLAUDE.md §2): idempotent per installation id —
        // the same device credential always resolves to the same user.
        group.MapPost("/anonymous", async (
            AnonymousRequest request,
            HattDbContext db,
            TokenService tokens,
            TimeProvider clock,
            CancellationToken ct) =>
        {
            if (string.IsNullOrWhiteSpace(request.InstallationId) ||
                request.InstallationId.Length is < 16 or > 128)
            {
                return Results.BadRequest(new { error = "invalid_installation_id" });
            }

            var now = clock.GetUtcNow();
            var hash = TokenService.HashToken(request.InstallationId);

            var device = await db.Devices
                .Include(d => d.User)
                .FirstOrDefaultAsync(d => d.InstallationIdHash == hash, ct);

            User user;
            if (device is null)
            {
                user = new User { Id = Guid.NewGuid(), CreatedAt = now };
                device = new UserDevice
                {
                    Id = Guid.NewGuid(),
                    User = user,
                    UserId = user.Id,
                    InstallationIdHash = hash,
                    Platform = request.Platform is "ios" or "android" ? request.Platform : null,
                    CreatedAt = now,
                    LastSeenAt = now,
                };
                db.Users.Add(user);
                db.Devices.Add(device);
            }
            else
            {
                if (device.RevokedAt is not null)
                {
                    return Results.Unauthorized();
                }
                user = device.User;
                device.LastSeenAt = now;
            }

            var pair = await IssueSessionAsync(db, tokens, user, device, familyId: Guid.NewGuid(), now, ct);
            await db.SaveChangesAsync(ct);
            return Results.Ok(new AuthResponse(user.Id, pair.AccessToken, pair.RefreshToken, pair.RefreshExpiresAt));
        });

        // Rotating refresh. Presenting an already-rotated token revokes the
        // whole family (stolen-token defence).
        group.MapPost("/refresh", async (
            RefreshRequest request,
            HattDbContext db,
            TokenService tokens,
            TimeProvider clock,
            CancellationToken ct) =>
        {
            if (string.IsNullOrWhiteSpace(request.RefreshToken))
            {
                return Results.Unauthorized();
            }

            var now = clock.GetUtcNow();
            var hash = TokenService.HashToken(request.RefreshToken);
            var session = await db.RefreshSessions
                .Include(s => s.User)
                .Include(s => s.Device)
                .FirstOrDefaultAsync(s => s.TokenHash == hash, ct);

            if (session is null)
            {
                return Results.Unauthorized();
            }

            if (!session.IsActive(now))
            {
                if (session.ReplacedById is not null)
                {
                    // Reuse of a rotated token — revoke the entire family.
                    await db.RefreshSessions
                        .Where(s => s.TokenFamilyId == session.TokenFamilyId && s.RevokedAt == null)
                        .ExecuteUpdateAsync(u => u.SetProperty(s => s.RevokedAt, now), ct);
                }
                return Results.Unauthorized();
            }

            var pair = await IssueSessionAsync(
                db, tokens, session.User, session.Device, session.TokenFamilyId, now, ct,
                rotatedFrom: session);
            session.Device.LastSeenAt = now;
            await db.SaveChangesAsync(ct);
            return Results.Ok(new AuthResponse(session.UserId, pair.AccessToken, pair.RefreshToken, pair.RefreshExpiresAt));
        });

        return app;
    }

    private static Task<TokenPair> IssueSessionAsync(
        HattDbContext db,
        TokenService tokens,
        User user,
        UserDevice device,
        Guid familyId,
        DateTimeOffset now,
        CancellationToken ct,
        RefreshSession? rotatedFrom = null)
    {
        var (refreshToken, refreshHash, expiresAt) = tokens.CreateRefreshToken();
        var session = new RefreshSession
        {
            Id = Guid.NewGuid(),
            UserId = user.Id,
            User = user,
            DeviceId = device.Id,
            Device = device,
            TokenHash = refreshHash,
            TokenFamilyId = familyId,
            CreatedAt = now,
            ExpiresAt = expiresAt,
        };
        db.RefreshSessions.Add(session);
        if (rotatedFrom is not null)
        {
            rotatedFrom.ReplacedById = session.Id;
        }

        var accessToken = tokens.CreateAccessToken(
            user.Id, device.Id, user.AccountType.ToString().ToLowerInvariant());
        return Task.FromResult(new TokenPair(accessToken, refreshToken, expiresAt));
    }
}
