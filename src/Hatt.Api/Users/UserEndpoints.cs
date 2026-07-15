using System.Security.Claims;
using Hatt.Api.Data;
using Microsoft.EntityFrameworkCore;

namespace Hatt.Api.Users;

public record MeResponse(Guid Id, string AccountType, string? Nickname, string Tier);

public record UpdateMeRequest(string? Nickname);

public static class UserEndpoints
{
    public static IEndpointRouteBuilder MapUserEndpoints(this IEndpointRouteBuilder app)
    {
        var group = app.MapGroup("/v1").RequireAuthorization();

        group.MapGet("/me", async (ClaimsPrincipal principal, HattDbContext db, CancellationToken ct) =>
        {
            var user = await FindUserAsync(principal, db, ct);
            return user is null ? Results.Unauthorized() : Results.Ok(ToResponse(user));
        });

        // Client-owned fields only (nickname). Tier/XP are server-owned and
        // deliberately absent from the request DTO.
        group.MapPatch("/me", async (
            UpdateMeRequest request,
            ClaimsPrincipal principal,
            HattDbContext db,
            CancellationToken ct) =>
        {
            var user = await FindUserAsync(principal, db, ct);
            if (user is null)
            {
                return Results.Unauthorized();
            }

            if (request.Nickname is not null)
            {
                var nickname = request.Nickname.Trim();
                if (nickname.Length is < 2 or > 24)
                {
                    return Results.BadRequest(new { error = "invalid_nickname" });
                }
                user.Nickname = nickname;
            }

            await db.SaveChangesAsync(ct);
            return Results.Ok(ToResponse(user));
        });

        // KVKK "hesabımı ve verilerimi sil" (CLAUDE.md §2): removes the user
        // and, via FK cascades, every device, session (and later: league
        // membership, backups). Immediate and irreversible.
        group.MapDelete("/account", async (
            ClaimsPrincipal principal,
            HattDbContext db,
            CancellationToken ct) =>
        {
            var user = await FindUserAsync(principal, db, ct);
            if (user is null)
            {
                return Results.Unauthorized();
            }

            db.Users.Remove(user);
            await db.SaveChangesAsync(ct);
            return Results.NoContent();
        });

        return app;
    }

    private static async Task<User?> FindUserAsync(
        ClaimsPrincipal principal, HattDbContext db, CancellationToken ct)
    {
        var sub = principal.FindFirstValue(ClaimTypes.NameIdentifier)
            ?? principal.FindFirstValue("sub");
        return Guid.TryParse(sub, out var id)
            ? await db.Users.FirstOrDefaultAsync(u => u.Id == id, ct)
            : null;
    }

    private static MeResponse ToResponse(User user) => new(
        user.Id,
        user.AccountType.ToString().ToLowerInvariant(),
        user.Nickname,
        user.CurrentTier.ToString().ToLowerInvariant());
}
