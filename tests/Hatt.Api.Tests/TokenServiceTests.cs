using System.IdentityModel.Tokens.Jwt;
using Hatt.Api.Auth;
using Microsoft.Extensions.Time.Testing;

namespace Hatt.Api.Tests;

public class TokenServiceTests
{
    private static readonly JwtOptions Options = new()
    {
        SigningKey = "unit-test-signing-key-with-32-chars!!",
        AccessTokenMinutes = 15,
        RefreshTokenDays = 60,
    };

    private readonly FakeTimeProvider _clock =
        new(new DateTimeOffset(2026, 7, 16, 12, 0, 0, TimeSpan.Zero));

    [Fact]
    public void AccessToken_carries_subject_device_and_expiry()
    {
        var service = new TokenService(Options, _clock);
        var userId = Guid.NewGuid();
        var deviceId = Guid.NewGuid();

        var jwt = service.CreateAccessToken(userId, deviceId, "anonymous");
        var parsed = new JwtSecurityTokenHandler().ReadJwtToken(jwt);

        Assert.Equal(userId.ToString(), parsed.Subject);
        Assert.Equal(deviceId.ToString(),
            parsed.Claims.Single(c => c.Type == "device_id").Value);
        Assert.Equal("anonymous",
            parsed.Claims.Single(c => c.Type == "account_type").Value);
        Assert.Equal(
            _clock.GetUtcNow().AddMinutes(15).UtcDateTime,
            parsed.ValidTo,
            TimeSpan.FromSeconds(5));
    }

    [Fact]
    public void RefreshTokens_are_unique_and_stored_only_as_hash()
    {
        var service = new TokenService(Options, _clock);

        var (token1, hash1, expires1) = service.CreateRefreshToken();
        var (token2, hash2, _) = service.CreateRefreshToken();

        Assert.NotEqual(token1, token2);
        Assert.NotEqual(hash1, hash2);
        Assert.DoesNotContain(token1, hash1); // hash reveals nothing
        Assert.Equal(TokenService.HashToken(token1), hash1);
        Assert.Equal(_clock.GetUtcNow().AddDays(60), expires1);
    }

    [Fact]
    public void HashToken_is_deterministic_sha256_hex()
    {
        var hash = TokenService.HashToken("abc");
        Assert.Equal(64, hash.Length);
        Assert.Equal(TokenService.HashToken("abc"), hash);
        Assert.NotEqual(TokenService.HashToken("abd"), hash);
    }
}
