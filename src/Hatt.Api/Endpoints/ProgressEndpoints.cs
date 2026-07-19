using System.Security.Claims;
using System.Text.Json.Nodes;
using Hatt.Application.DTOs;
using Hatt.Domain.Entities;
using Hatt.Infrastructure.Persistence;
using Microsoft.EntityFrameworkCore;

namespace Hatt.Api.Endpoints;

public static class ProgressEndpoints
{
    public static IEndpointRouteBuilder MapProgressEndpoints(this IEndpointRouteBuilder app)
    {
        var group = app.MapGroup("/v1/progress").RequireAuthorization();

        group.MapGet("", async (
            ClaimsPrincipal principal,
            HattDbContext db,
            CancellationToken ct) =>
        {
            var user = await UserEndpoints.FindUserAsync(principal, db, ct);
            if (user is null)
            {
                return Results.Unauthorized();
            }

            var snapshot = await db.UserProgressSnapshots
                .FirstOrDefaultAsync(s => s.UserId == user.Id, ct);

            if (snapshot is null)
            {
                return Results.NotFound(new { error = "progress_not_found" });
            }

            var dataNode = JsonNode.Parse(snapshot.DataJson) ?? new JsonObject();
            return Results.Ok(new ProgressSyncResponse(
                snapshot.Version,
                dataNode,
                snapshot.ClientUpdatedAt,
                snapshot.ServerUpdatedAt));
        });

        group.MapPut("", async (
            ProgressSyncRequest request,
            ClaimsPrincipal principal,
            HattDbContext db,
            TimeProvider clock,
            CancellationToken ct) =>
        {
            if (request.Data is null)
            {
                return Results.BadRequest(new { error = "invalid_data" });
            }

            var user = await UserEndpoints.FindUserAsync(principal, db, ct);
            if (user is null)
            {
                return Results.Unauthorized();
            }

            var now = clock.GetUtcNow();
            var snapshot = await db.UserProgressSnapshots
                .FirstOrDefaultAsync(s => s.UserId == user.Id, ct);

            if (snapshot is not null)
            {
                if (request.Version > 0 && request.Version < snapshot.Version)
                {
                    var currentData = JsonNode.Parse(snapshot.DataJson) ?? new JsonObject();
                    return Results.Conflict(new
                    {
                        error = "version_conflict",
                        current = new ProgressSyncResponse(
                            snapshot.Version,
                            currentData,
                            snapshot.ClientUpdatedAt,
                            snapshot.ServerUpdatedAt)
                    });
                }

                snapshot.DataJson = request.Data.ToJsonString();
                snapshot.Version = Math.Max(snapshot.Version + 1, request.Version);
                snapshot.ClientUpdatedAt = request.ClientUpdatedAt;
                snapshot.ServerUpdatedAt = now;
            }
            else
            {
                snapshot = new UserProgressSnapshot
                {
                    UserId = user.Id,
                    User = user,
                    Version = Math.Max(1, request.Version),
                    DataJson = request.Data.ToJsonString(),
                    ClientUpdatedAt = request.ClientUpdatedAt,
                    ServerUpdatedAt = now,
                };
                db.UserProgressSnapshots.Add(snapshot);
            }

            await db.SaveChangesAsync(ct);

            var savedDataNode = JsonNode.Parse(snapshot.DataJson) ?? new JsonObject();
            return Results.Ok(new ProgressSyncResponse(
                snapshot.Version,
                savedDataNode,
                snapshot.ClientUpdatedAt,
                snapshot.ServerUpdatedAt));
        });

        return app;
    }
}
