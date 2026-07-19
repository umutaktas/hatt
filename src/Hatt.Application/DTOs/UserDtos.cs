namespace Hatt.Application.DTOs;

public record MeResponse(
    Guid Id,
    string AccountType,
    string? Nickname,
    string Tier,
    List<string> LinkedProviders);

public record UpdateMeRequest(string? Nickname);
