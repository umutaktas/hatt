using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;
using Hatt.Application.Abstractions;
using Hatt.Application.DTOs;
using Microsoft.IdentityModel.Tokens;

namespace Hatt.Infrastructure.Services;

public class TokenService(JwtOptions options, TimeProvider clock) : ITokenService
{
    public string CreateAccessToken(Guid userId, Guid deviceId, string accountType)
    {
        var now = clock.GetUtcNow();
        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(options.SigningKey));
        var credentials = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

        var token = new JwtSecurityToken(
            issuer: "hatt",
            audience: "hatt-mobile",
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
        return (token, HashToken(token), clock.GetUtcNow().AddDays(options.RefreshTokenDays));
    }

    public static string HashToken(string token) =>
        Convert.ToHexStringLower(SHA256.HashData(Encoding.UTF8.GetBytes(token)));

    public static TokenValidationParameters ValidationParameters(JwtOptions options) => new()
    {
        ValidIssuer = "hatt",
        ValidAudience = "hatt-mobile",
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(options.SigningKey)),
        ValidateIssuer = true,
        ValidateAudience = true,
        ValidateLifetime = true,
        ValidateIssuerSigningKey = true,
        ClockSkew = TimeSpan.FromSeconds(30),
    };
}
