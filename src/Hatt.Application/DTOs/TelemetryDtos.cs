namespace Hatt.Application.DTOs;

public record TelemetryEventDto(
    string EventName,
    Dictionary<string, string>? Properties,
    DateTimeOffset Timestamp);

public record TelemetryBatchRequest(
    List<TelemetryEventDto> Events);
