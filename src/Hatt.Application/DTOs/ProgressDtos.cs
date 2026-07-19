using System.Text.Json.Nodes;

namespace Hatt.Application.DTOs;

public record ProgressSyncRequest(
    long Version,
    JsonNode Data,
    DateTimeOffset ClientUpdatedAt);

public record ProgressSyncResponse(
    long Version,
    JsonNode Data,
    DateTimeOffset ClientUpdatedAt,
    DateTimeOffset ServerUpdatedAt);
