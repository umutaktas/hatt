namespace Hatt.Application.DTOs;

public record AnonymousRequest(string InstallationId, string? Platform);

public record RefreshRequest(string RefreshToken);

public record EmailLoginRequest(
    string Email,
    string Password,
    string InstallationId,
    string? Platform);

public record OAuthLoginRequest(
    string Provider,
    string Subject,
    string InstallationId,
    string? Platform);

public record LinkEmailRequest(
    string Email,
    string Password);

public record LinkOAuthRequest(
    string Provider,
    string Subject);

public record AuthResponse(
    Guid UserId,
    string AccessToken,
    string RefreshToken,
    DateTimeOffset RefreshExpiresAt);

public record TokenPair(
    string AccessToken,
    string RefreshToken,
    DateTimeOffset RefreshExpiresAt);

public class JwtOptions
{
    public const string SectionName = "Jwt";
    public string SigningKey { get; set; } = null!;
    public int AccessTokenMinutes { get; set; } = 15;
    public int RefreshTokenDays { get; set; } = 60;
}
