using System.Security.Claims;
using System.Text.Json;
using Hatt.Application.DTOs;
using Hatt.Domain.Entities;
using Hatt.Domain.Services;
using Hatt.Infrastructure.Persistence;

namespace Hatt.Api.Endpoints;

public static class TelemetryEndpoints
{
    public static IEndpointRouteBuilder MapTelemetryEndpoints(this IEndpointRouteBuilder app)
    {
        var group = app.MapGroup("/v1/telemetry").RequireAuthorization();

        group.MapPost("/events", async (
            TelemetryBatchRequest request,
            ClaimsPrincipal principal,
            HattDbContext db,
            ILoggerFactory loggerFactory,
            CancellationToken ct) =>
        {
            if (request.Events is null || request.Events.Count == 0)
            {
                return Results.BadRequest(new { error = "empty_batch" });
            }

            if (request.Events.Count > 50)
            {
                return Results.BadRequest(new { error = "batch_too_large" });
            }

            var user = await UserEndpoints.FindUserAsync(principal, db, ct);
            var userId = user?.Id;

            var logger = loggerFactory.CreateLogger("Telemetry");
            var validEntities = new List<TelemetryEvent>();

            foreach (var evt in request.Events)
            {
                if (!TelemetryValidator.IsAllowed(evt.EventName))
                {
                    continue;
                }

                var propsJson = evt.Properties is not null && evt.Properties.Count > 0
                    ? JsonSerializer.Serialize(evt.Properties)
                    : null;

                logger.LogInformation(
                    "Telemetry Event: {EventName} User: {UserId} Props: {Properties}",
                    evt.EventName, userId, propsJson);

                validEntities.Add(new TelemetryEvent
                {
                    Id = Guid.NewGuid(),
                    UserId = userId,
                    EventName = evt.EventName.Trim().ToLowerInvariant(),
                    PropertiesJson = propsJson,
                    Timestamp = evt.Timestamp,
                });
            }

            if (validEntities.Count > 0)
            {
                db.TelemetryEvents.AddRange(validEntities);
                await db.SaveChangesAsync(ct);
            }

            return Results.Ok(new { processed = validEntities.Count });
        });

        return app;
    }
}
