using System.Security.Claims;
using Hatt.Application.Abstractions;
using Hatt.Application.DTOs;
using Hatt.Domain.Entities;
using Hatt.Infrastructure.Persistence;
using Hatt.Infrastructure.Services;
using Microsoft.EntityFrameworkCore;

namespace Hatt.Api.Endpoints;

public static class AuthEndpoints
{
    public static IEndpointRouteBuilder MapAuthEndpoints(this IEndpointRouteBuilder app)
    {
        var authGroup = app.MapGroup("/v1/auth").RequireRateLimiting("auth");

        authGroup.MapPost("/anonymous", async (
            AnonymousRequest request,
            HattDbContext db,
            ITokenService tokens,
            TimeProvider clock,
            CancellationToken ct) =>
        {
            if (string.IsNullOrWhiteSpace(request.InstallationId) ||
                request.InstallationId.Length is < 16 or > 128)
            {
                return Results.BadRequest(new { error = "invalid_installation_id" });
            }

            var now = clock.GetUtcNow();
            var device = await GetOrCreateDeviceAsync(db, null, request.InstallationId, request.Platform, now, ct);
            var user = device.User;

            var pair = await IssueSessionAsync(db, tokens, user, device, familyId: Guid.NewGuid(), now, ct);
            await db.SaveChangesAsync(ct);
            return Results.Ok(new AuthResponse(user.Id, pair.AccessToken, pair.RefreshToken, pair.RefreshExpiresAt));
        });

        authGroup.MapPost("/login/email", async (
            EmailLoginRequest request,
            HattDbContext db,
            ITokenService tokens,
            IPasswordHasher passwordHasher,
            TimeProvider clock,
            CancellationToken ct) =>
        {
            if (string.IsNullOrWhiteSpace(request.Email) || string.IsNullOrWhiteSpace(request.Password) ||
                string.IsNullOrWhiteSpace(request.InstallationId) || request.InstallationId.Length is < 16 or > 128)
            {
                return Results.BadRequest(new { error = "invalid_request" });
            }

            var normalizedEmail = request.Email.Trim().ToLowerInvariant();
            var identity = await db.UserIdentities
                .Include(i => i.User)
                .FirstOrDefaultAsync(i => i.Provider == AuthProvider.Email && i.Subject == normalizedEmail, ct);

            if (identity is null || identity.PasswordHash is null || !passwordHasher.VerifyPassword(request.Password, identity.PasswordHash))
            {
                return Results.Unauthorized();
            }

            var now = clock.GetUtcNow();
            var device = await GetOrCreateDeviceAsync(db, identity.User, request.InstallationId, request.Platform, now, ct);
            var pair = await IssueSessionAsync(db, tokens, identity.User, device, familyId: Guid.NewGuid(), now, ct);
            await db.SaveChangesAsync(ct);
            return Results.Ok(new AuthResponse(identity.UserId, pair.AccessToken, pair.RefreshToken, pair.RefreshExpiresAt));
        });

        authGroup.MapPost("/login/oauth", async (
            OAuthLoginRequest request,
            HattDbContext db,
            ITokenService tokens,
            TimeProvider clock,
            CancellationToken ct) =>
        {
            if (!Enum.TryParse<AuthProvider>(request.Provider, true, out var provider) ||
                provider == AuthProvider.Email ||
                string.IsNullOrWhiteSpace(request.Subject) ||
                string.IsNullOrWhiteSpace(request.InstallationId) ||
                request.InstallationId.Length is < 16 or > 128)
            {
                return Results.BadRequest(new { error = "invalid_request" });
            }

            var identity = await db.UserIdentities
                .Include(i => i.User)
                .FirstOrDefaultAsync(i => i.Provider == provider && i.Subject == request.Subject, ct);

            if (identity is null)
            {
                return Results.Unauthorized();
            }

            var now = clock.GetUtcNow();
            var device = await GetOrCreateDeviceAsync(db, identity.User, request.InstallationId, request.Platform, now, ct);
            var pair = await IssueSessionAsync(db, tokens, identity.User, device, familyId: Guid.NewGuid(), now, ct);
            await db.SaveChangesAsync(ct);
            return Results.Ok(new AuthResponse(identity.UserId, pair.AccessToken, pair.RefreshToken, pair.RefreshExpiresAt));
        });

        authGroup.MapPost("/refresh", async (
            RefreshRequest request,
            HattDbContext db,
            ITokenService tokens,
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

        var linkGroup = app.MapGroup("/v1/account/link").RequireAuthorization();

        linkGroup.MapPost("/email", async (
            LinkEmailRequest request,
            ClaimsPrincipal principal,
            HattDbContext db,
            IPasswordHasher passwordHasher,
            TimeProvider clock,
            CancellationToken ct) =>
        {
            if (string.IsNullOrWhiteSpace(request.Email) || !request.Email.Contains('@') ||
                string.IsNullOrWhiteSpace(request.Password) || request.Password.Length < 8)
            {
                return Results.BadRequest(new { error = "invalid_email_or_password" });
            }

            var user = await UserEndpoints.FindUserAsync(principal, db, ct);
            if (user is null)
            {
                return Results.Unauthorized();
            }

            if (user.Identities.Any(i => i.Provider == AuthProvider.Email))
            {
                return Results.BadRequest(new { error = "email_already_linked" });
            }

            var normalizedEmail = request.Email.Trim().ToLowerInvariant();
            var exists = await db.UserIdentities
                .AnyAsync(i => i.Provider == AuthProvider.Email && i.Subject == normalizedEmail, ct);

            if (exists)
            {
                return Results.Conflict(new { error = "email_taken" });
            }

            var now = clock.GetUtcNow();
            var identity = new UserIdentity
            {
                Id = Guid.NewGuid(),
                UserId = user.Id,
                Provider = AuthProvider.Email,
                Subject = normalizedEmail,
                PasswordHash = passwordHasher.HashPassword(request.Password),
                CreatedAt = now,
            };

            db.UserIdentities.Add(identity);
            user.AccountType = AccountType.Registered;

            await db.SaveChangesAsync(ct);
            return Results.Ok(UserEndpoints.ToResponse(user));
        });

        linkGroup.MapPost("/oauth", async (
            LinkOAuthRequest request,
            ClaimsPrincipal principal,
            HattDbContext db,
            TimeProvider clock,
            CancellationToken ct) =>
        {
            if (!Enum.TryParse<AuthProvider>(request.Provider, true, out var provider) ||
                provider == AuthProvider.Email ||
                string.IsNullOrWhiteSpace(request.Subject))
            {
                return Results.BadRequest(new { error = "invalid_provider_or_subject" });
            }

            var user = await UserEndpoints.FindUserAsync(principal, db, ct);
            if (user is null)
            {
                return Results.Unauthorized();
            }

            if (user.Identities.Any(i => i.Provider == provider))
            {
                return Results.BadRequest(new { error = "provider_already_linked" });
            }

            var exists = await db.UserIdentities
                .AnyAsync(i => i.Provider == provider && i.Subject == request.Subject, ct);

            if (exists)
            {
                return Results.Conflict(new { error = "identity_taken" });
            }

            var now = clock.GetUtcNow();
            var identity = new UserIdentity
            {
                Id = Guid.NewGuid(),
                UserId = user.Id,
                Provider = provider,
                Subject = request.Subject,
                CreatedAt = now,
            };

            db.UserIdentities.Add(identity);
            user.AccountType = AccountType.Registered;

            await db.SaveChangesAsync(ct);
            return Results.Ok(UserEndpoints.ToResponse(user));
        });

        return app;
    }

    private static async Task<UserDevice> GetOrCreateDeviceAsync(
        HattDbContext db,
        User? user,
        string installationId,
        string? platform,
        DateTimeOffset now,
        CancellationToken ct)
    {
        var hash = TokenService.HashToken(installationId);
        var device = await db.Devices
            .Include(d => d.User)
            .FirstOrDefaultAsync(d => d.InstallationIdHash == hash, ct);

        if (device is null)
        {
            user ??= new User { Id = Guid.NewGuid(), CreatedAt = now };
            device = new UserDevice
            {
                Id = Guid.NewGuid(),
                User = user,
                UserId = user.Id,
                InstallationIdHash = hash,
                Platform = platform is "ios" or "android" ? platform : null,
                CreatedAt = now,
                LastSeenAt = now,
            };
            if (!db.Users.Local.Contains(user) && await db.Users.FindAsync([user.Id], ct) is null)
            {
                db.Users.Add(user);
            }
            db.Devices.Add(device);
        }
        else
        {
            if (user is not null && device.UserId != user.Id)
            {
                device.UserId = user.Id;
                device.User = user;
            }
            device.LastSeenAt = now;
            device.RevokedAt = null;
        }

        return device;
    }

    private static Task<TokenPair> IssueSessionAsync(
        HattDbContext db,
        ITokenService tokens,
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
