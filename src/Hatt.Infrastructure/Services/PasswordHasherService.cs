using System.Security.Cryptography;
using Hatt.Application.Abstractions;

namespace Hatt.Infrastructure.Services;

public class PasswordHasherService : IPasswordHasher
{
    private const int SaltSize = 16;
    private const int KeySize = 32;
    private const int Iterations = 100_000;
    private static readonly HashAlgorithmName HashAlgorithm = HashAlgorithmName.SHA256;

    public string HashPassword(string password)
    {
        byte[] salt = RandomNumberGenerator.GetBytes(SaltSize);
        byte[] hash = Rfc2898DeriveBytes.Pbkdf2(
            password, salt, Iterations, HashAlgorithm, KeySize);
        return $"{Iterations}.{Convert.ToBase64String(salt)}.{Convert.ToBase64String(hash)}";
    }

    public bool VerifyPassword(string password, string hashedPassword)
    {
        if (string.IsNullOrEmpty(hashedPassword)) return false;
        var parts = hashedPassword.Split('.');
        if (parts.Length != 3) return false;
        if (!int.TryParse(parts[0], out int iterations)) return false;

        try
        {
            byte[] salt = Convert.FromBase64String(parts[1]);
            byte[] hash = Convert.FromBase64String(parts[2]);

            byte[] testHash = Rfc2898DeriveBytes.Pbkdf2(
                password, salt, iterations, HashAlgorithm, hash.Length);

            return CryptographicOperations.FixedTimeEquals(hash, testHash);
        }
        catch
        {
            return false;
        }
    }
}
