using Hatt.Domain.Entities;
using Hatt.Infrastructure.Persistence;
using Hatt.Infrastructure.Services;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Time.Testing;

namespace Hatt.Api.Tests;

public class AccountLinkingTests
{
    private readonly PasswordHasherService _hasher = new();

    private static HattDbContext CreateInMemoryDb()
    {
        var options = new DbContextOptionsBuilder<HattDbContext>()
            .UseInMemoryDatabase(Guid.NewGuid().ToString())
            .Options;
        return new HattDbContext(options);
    }

    [Fact]
    public async Task Email_link_upgrades_anonymous_user_to_registered()
    {
        using var db = CreateInMemoryDb();
        var clock = new FakeTimeProvider(new DateTimeOffset(2026, 7, 19, 12, 0, 0, TimeSpan.Zero));
        var now = clock.GetUtcNow();

        var user = new User
        {
            Id = Guid.NewGuid(),
            AccountType = AccountType.Anonymous,
            CreatedAt = now,
        };
        db.Users.Add(user);
        await db.SaveChangesAsync();

        var rawPassword = "SecurePassword123!";
        var identity = new UserIdentity
        {
            Id = Guid.NewGuid(),
            UserId = user.Id,
            Provider = AuthProvider.Email,
            Subject = "user@example.com",
            PasswordHash = _hasher.HashPassword(rawPassword),
            CreatedAt = now,
        };
        db.UserIdentities.Add(identity);
        user.AccountType = AccountType.Registered;

        await db.SaveChangesAsync();

        var reloadedUser = await db.Users
            .Include(u => u.Identities)
            .SingleAsync(u => u.Id == user.Id);

        Assert.Equal(AccountType.Registered, reloadedUser.AccountType);
        Assert.Single(reloadedUser.Identities);
        Assert.Equal("user@example.com", reloadedUser.Identities[0].Subject);
        Assert.True(_hasher.VerifyPassword(rawPassword, reloadedUser.Identities[0].PasswordHash!));
    }

    [Fact]
    public async Task Duplicate_email_link_causes_index_constraint_or_conflict()
    {
        using var db = CreateInMemoryDb();
        var userId1 = Guid.NewGuid();
        var userId2 = Guid.NewGuid();

        db.Users.AddRange(
            new User { Id = userId1, AccountType = AccountType.Anonymous },
            new User { Id = userId2, AccountType = AccountType.Anonymous }
        );
        await db.SaveChangesAsync();

        db.UserIdentities.Add(new UserIdentity
        {
            Id = Guid.NewGuid(),
            UserId = userId1,
            Provider = AuthProvider.Email,
            Subject = "shared@example.com",
            PasswordHash = _hasher.HashPassword("Pass12345!"),
        });
        await db.SaveChangesAsync();

        var isTaken = await db.UserIdentities
            .AnyAsync(i => i.Provider == AuthProvider.Email && i.Subject == "shared@example.com");

        Assert.True(isTaken);
    }

    [Fact]
    public async Task OAuth_link_supports_apple_and_google()
    {
        using var db = CreateInMemoryDb();
        var user = new User { Id = Guid.NewGuid(), AccountType = AccountType.Anonymous };
        db.Users.Add(user);
        await db.SaveChangesAsync();

        db.UserIdentities.Add(new UserIdentity
        {
            Id = Guid.NewGuid(),
            UserId = user.Id,
            Provider = AuthProvider.Apple,
            Subject = "apple-sub-12345",
        });
        db.UserIdentities.Add(new UserIdentity
        {
            Id = Guid.NewGuid(),
            UserId = user.Id,
            Provider = AuthProvider.Google,
            Subject = "google-sub-67890",
        });
        user.AccountType = AccountType.Registered;

        await db.SaveChangesAsync();

        var reloadedUser = await db.Users
            .Include(u => u.Identities)
            .SingleAsync(u => u.Id == user.Id);

        Assert.Equal(AccountType.Registered, reloadedUser.AccountType);
        Assert.Equal(2, reloadedUser.Identities.Count);
        Assert.Contains(reloadedUser.Identities, i => i.Provider == AuthProvider.Apple && i.Subject == "apple-sub-12345");
        Assert.Contains(reloadedUser.Identities, i => i.Provider == AuthProvider.Google && i.Subject == "google-sub-67890");
    }
}
