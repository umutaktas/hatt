using Hatt.Domain.Entities;
using Hatt.Infrastructure.Persistence;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Time.Testing;

namespace Hatt.Api.Tests;

public class ProgressSyncTests
{
    private static HattDbContext CreateInMemoryDb()
    {
        var options = new DbContextOptionsBuilder<HattDbContext>()
            .UseInMemoryDatabase(Guid.NewGuid().ToString())
            .Options;
        return new HattDbContext(options);
    }

    [Fact]
    public async Task Initial_progress_snapshot_can_be_created()
    {
        using var db = CreateInMemoryDb();
        var clock = new FakeTimeProvider(new DateTimeOffset(2026, 7, 19, 12, 0, 0, TimeSpan.Zero));
        var user = new User { Id = Guid.NewGuid(), CreatedAt = clock.GetUtcNow() };
        db.Users.Add(user);
        await db.SaveChangesAsync();

        var snapshot = new UserProgressSnapshot
        {
            UserId = user.Id,
            Version = 1,
            DataJson = """{"completedLessons":["L1","L2"],"streak":5}""",
            ClientUpdatedAt = clock.GetUtcNow(),
            ServerUpdatedAt = clock.GetUtcNow(),
        };
        db.UserProgressSnapshots.Add(snapshot);
        await db.SaveChangesAsync();

        var saved = await db.UserProgressSnapshots.FirstOrDefaultAsync(s => s.UserId == user.Id);
        Assert.NotNull(saved);
        Assert.Equal(1, saved.Version);
        Assert.Contains("completedLessons", saved.DataJson);
    }

    [Fact]
    public async Task Progress_snapshot_version_increments_on_update()
    {
        using var db = CreateInMemoryDb();
        var clock = new FakeTimeProvider(new DateTimeOffset(2026, 7, 19, 12, 0, 0, TimeSpan.Zero));
        var user = new User { Id = Guid.NewGuid(), CreatedAt = clock.GetUtcNow() };
        db.Users.Add(user);
        
        var snapshot = new UserProgressSnapshot
        {
            UserId = user.Id,
            Version = 1,
            DataJson = """{"streak":1}""",
            ClientUpdatedAt = clock.GetUtcNow(),
            ServerUpdatedAt = clock.GetUtcNow(),
        };
        db.UserProgressSnapshots.Add(snapshot);
        await db.SaveChangesAsync();

        clock.Advance(TimeSpan.FromHours(1));
        var clientReqVersion = 2L;
        snapshot.DataJson = """{"streak":2}""";
        snapshot.Version = Math.Max(snapshot.Version + 1, clientReqVersion);
        snapshot.ServerUpdatedAt = clock.GetUtcNow();

        await db.SaveChangesAsync();

        var updated = await db.UserProgressSnapshots.FirstOrDefaultAsync(s => s.UserId == user.Id);
        Assert.NotNull(updated);
        Assert.Equal(2, updated.Version);
        Assert.Contains("\"streak\":2", updated.DataJson);
    }

    [Fact]
    public async Task Account_deletion_cascades_and_removes_progress_snapshot()
    {
        using var db = CreateInMemoryDb();
        var user = new User { Id = Guid.NewGuid(), CreatedAt = DateTimeOffset.UtcNow };
        db.Users.Add(user);

        db.UserProgressSnapshots.Add(new UserProgressSnapshot
        {
            UserId = user.Id,
            Version = 1,
            DataJson = "{}",
            ClientUpdatedAt = DateTimeOffset.UtcNow,
            ServerUpdatedAt = DateTimeOffset.UtcNow,
        });
        await db.SaveChangesAsync();

        db.Users.Remove(user);
        await db.SaveChangesAsync();

        var snapshotExists = await db.UserProgressSnapshots.AnyAsync(s => s.UserId == user.Id);
        Assert.False(snapshotExists);
    }
}
