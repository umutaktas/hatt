using Microsoft.EntityFrameworkCore;

namespace Hatt.Api.Data;

public class HattDbContext(DbContextOptions<HattDbContext> options)
    : DbContext(options)
{
    public DbSet<User> Users => Set<User>();
    public DbSet<UserDevice> Devices => Set<UserDevice>();
    public DbSet<RefreshSession> RefreshSessions => Set<RefreshSession>();
    public DbSet<LeagueWeek> LeagueWeeks => Set<LeagueWeek>();
    public DbSet<LeagueCohort> LeagueCohorts => Set<LeagueCohort>();
    public DbSet<LeagueMember> LeagueMembers => Set<LeagueMember>();
    public DbSet<XpEvent> XpEvents => Set<XpEvent>();

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

        b.Entity<LeagueWeek>(e =>
        {
            e.Property(w => w.Id).HasMaxLength(10); // "2026-W29"
            e.Property(w => w.Status).HasConversion<string>().HasMaxLength(10);
        });

        b.Entity<LeagueCohort>(e =>
        {
            e.Property(c => c.Tier).HasConversion<string>().HasMaxLength(16);
            e.HasIndex(c => new { c.WeekId, c.Tier });
            e.HasOne(c => c.Week)
                .WithMany()
                .HasForeignKey(c => c.WeekId)
                .OnDelete(DeleteBehavior.Cascade);
        });

        b.Entity<LeagueMember>(e =>
        {
            e.HasKey(m => new { m.CohortId, m.UserId });
            // One cohort per user per week.
            e.HasIndex(m => new { m.WeekId, m.UserId }).IsUnique();
            e.Property(m => m.Outcome).HasConversion<string>().HasMaxLength(10);
            e.HasOne(m => m.Cohort)
                .WithMany()
                .HasForeignKey(m => m.CohortId)
                .OnDelete(DeleteBehavior.Cascade);
            // KVKK: account deletion removes league rows too (§6).
            e.HasOne(m => m.User)
                .WithMany()
                .HasForeignKey(m => m.UserId)
                .OnDelete(DeleteBehavior.Cascade);
        });

        b.Entity<XpEvent>(e =>
        {
            e.Property(x => x.SourceType).HasMaxLength(32);
            e.Property(x => x.IdempotencyKey).HasMaxLength(64);
            e.Property(x => x.NodeId).HasMaxLength(64);
            e.Property(x => x.WeekId).HasMaxLength(10);
            // Idempotency: the same completion can never award XP twice.
            e.HasIndex(x => new { x.UserId, x.IdempotencyKey }).IsUnique();
            e.HasIndex(x => new { x.UserId, x.CreatedAt });
            e.HasOne(x => x.User)
                .WithMany()
                .HasForeignKey(x => x.UserId)
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
