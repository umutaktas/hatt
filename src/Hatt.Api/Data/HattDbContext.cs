using Microsoft.EntityFrameworkCore;

namespace Hatt.Api.Data;

public class HattDbContext(DbContextOptions<HattDbContext> options)
    : DbContext(options)
{
    public DbSet<User> Users => Set<User>();
    public DbSet<UserDevice> Devices => Set<UserDevice>();
    public DbSet<RefreshSession> RefreshSessions => Set<RefreshSession>();

    protected override void OnModelCreating(ModelBuilder b)
    {
        b.Entity<User>(e =>
        {
            e.Property(u => u.Nickname).HasMaxLength(24);
            e.Property(u => u.AccountType).HasConversion<string>().HasMaxLength(16);
            e.Property(u => u.CurrentTier).HasConversion<string>().HasMaxLength(16);
        });

        b.Entity<UserDevice>(e =>
        {
            e.Property(d => d.InstallationIdHash).HasMaxLength(64);
            e.HasIndex(d => d.InstallationIdHash).IsUnique();
            e.Property(d => d.Platform).HasMaxLength(16);
            // KVKK: deleting a user removes every trace (§6).
            e.HasOne(d => d.User)
                .WithMany(u => u.Devices)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.Cascade);
        });

        b.Entity<RefreshSession>(e =>
        {
            e.Property(s => s.TokenHash).HasMaxLength(64);
            e.HasIndex(s => s.TokenHash).IsUnique();
            e.HasIndex(s => s.TokenFamilyId);
            e.HasOne(s => s.User)
                .WithMany(u => u.RefreshSessions)
                .HasForeignKey(s => s.UserId)
                .OnDelete(DeleteBehavior.Cascade);
            e.HasOne(s => s.Device)
                .WithMany()
                .HasForeignKey(s => s.DeviceId)
                .OnDelete(DeleteBehavior.Cascade);
        });
    }
}
