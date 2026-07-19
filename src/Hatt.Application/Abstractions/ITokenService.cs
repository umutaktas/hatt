using Hatt.Application.DTOs;

namespace Hatt.Application.Abstractions;

public interface ITokenService
{
    string CreateAccessToken(Guid userId, Guid deviceId, string accountType);
    (string Token, string Hash, DateTimeOffset ExpiresAt) CreateRefreshToken();
}

public interface IPasswordHasher
{
    string HashPassword(string password);
    bool VerifyPassword(string password, string hashedPassword);
}
