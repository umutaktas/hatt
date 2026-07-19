using Hatt.Infrastructure.Services;

namespace Hatt.Api.Tests;

public class PasswordHasherTests
{
    private readonly PasswordHasherService _hasher = new();

    [Fact]
    public void HashPassword_produces_non_empty_hash()
    {
        var hash = _hasher.HashPassword("MySecretPassword123!");
        Assert.NotNull(hash);
        Assert.NotEmpty(hash);
        Assert.Contains(".", hash);
    }

    [Fact]
    public void VerifyPassword_returns_true_for_matching_password()
    {
        var password = "SuperSecretPass!2026";
        var hash = _hasher.HashPassword(password);

        Assert.True(_hasher.VerifyPassword(password, hash));
    }

    [Fact]
    public void VerifyPassword_returns_false_for_wrong_password()
    {
        var hash = _hasher.HashPassword("CorrectPassword123");

        Assert.False(_hasher.VerifyPassword("WrongPassword123", hash));
    }

    [Fact]
    public void VerifyPassword_returns_false_for_invalid_hash_format()
    {
        Assert.False(_hasher.VerifyPassword("password", "invalid_hash_format"));
        Assert.False(_hasher.VerifyPassword("password", ""));
        Assert.False(_hasher.VerifyPassword("password", null!));
    }
}
