using System.Security.Claims;
using Hatt.Application.DTOs;
using Hatt.Domain.Entities;
using Hatt.Infrastructure.Persistence;
using Microsoft.EntityFrameworkCore;

namespace Hatt.Api.Endpoints;

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

    public static async Task<User?> FindUserAsync(
        ClaimsPrincipal principal, HattDbContext db, CancellationToken ct)
    {
        var sub = principal.FindFirstValue(ClaimTypes.NameIdentifier)
            ?? principal.FindFirstValue("sub");
        return Guid.TryParse(sub, out var id)
            ? await db.Users
                .Include(u => u.Identities)
                .FirstOrDefaultAsync(u => u.Id == id, ct)
            : null;
    }

    public static MeResponse ToResponse(User user) => new(
        user.Id,
        user.AccountType.ToString().ToLowerInvariant(),
        user.Nickname,
        user.CurrentTier.ToString().ToLowerInvariant(),
        user.Identities.Select(i => i.Provider.ToString().ToLowerInvariant()).ToList());
}
