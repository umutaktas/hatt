using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;
using Microsoft.IdentityModel.Tokens;

namespace Hatt.Api.Auth;

public record JwtOptions
{
    public const string SectionName = "Jwt";

    public string Issuer { get; init; } = "hatt";
    public string Audience { get; init; } = "hatt-mobile";

    /// <summary>HS256 key; provide via env `Jwt__SigningKey` in production.</summary>
    public string SigningKey { get; init; } = string.Empty;

    public int AccessTokenMinutes { get; init; } = 15;
    public int RefreshTokenDays { get; init; } = 60;
}

public record TokenPair(string AccessToken, string RefreshToken, DateTimeOffset RefreshExpiresAt);

/// <summary>
/// Issues short-lived access JWTs and opaque rotating refresh tokens. Refresh
/// tokens are 256-bit random values; only their SHA-256 hash is persisted.
/// </summary>
public class TokenService(JwtOptions options, TimeProvider clock)
{
    public string CreateAccessToken(Guid userId, Guid deviceId, string accountType)
    {
        var now = clock.GetUtcNow();
        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(options.SigningKey));
        var credentials = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

        var token = new JwtSecurityToken(
            issuer: options.Issuer,
            audience: options.Audience,
            claims:
            [
                new Claim(JwtRegisteredClaimNames.Sub, userId.ToString()),
                new Claim("device_id", deviceId.ToString()),
                new Claim("account_type", accountType),
            ],
            notBefore: now.UtcDateTime,
            expires: now.AddMinutes(options.AccessTokenMinutes).UtcDateTime,
            signingCredentials: credentials);

        return new JwtSecurityTokenHandler().WriteToken(token);
    }

    public (string Token, string Hash, DateTimeOffset ExpiresAt) CreateRefreshToken()
    {
        var bytes = RandomNumberGenerator.GetBytes(32);
        var token = Convert.ToBase64String(bytes)
            .Replace('+', '-').Replace('/', '_').TrimEnd('=');
        return (token, HashToken(token),
            clock.GetUtcNow().AddDays(options.RefreshTokenDays));
    }

    /// <summary>SHA-256 hex — used for refresh tokens and installation ids.</summary>
    public static string HashToken(string token) =>
        Convert.ToHexStringLower(SHA256.HashData(Encoding.UTF8.GetBytes(token)));

    public static TokenValidationParameters ValidationParameters(JwtOptions options) => new()
    {
        ValidIssuer = options.Issuer,
        ValidAudience = options.Audience,
        IssuerSigningKey =
            new SymmetricSecurityKey(Encoding.UTF8.GetBytes(options.SigningKey)),
        ValidateIssuer = true,
        ValidateAudience = true,
        ValidateLifetime = true,
        ValidateIssuerSigningKey = true,
        ClockSkew = TimeSpan.FromSeconds(30),
    };
}
