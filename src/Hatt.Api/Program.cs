using System.Threading.RateLimiting;
using Hangfire;
using Hangfire.PostgreSql;
using Hatt.Api.Endpoints;
using Hatt.Application.Abstractions;
using Hatt.Application.DTOs;
using Hatt.Infrastructure.Persistence;
using Hatt.Infrastructure.Services;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.RateLimiting;
using Microsoft.EntityFrameworkCore;
using Serilog;

var builder = WebApplication.CreateBuilder(args);

// Structured JSON logs (ops requirement).
builder.Host.UseSerilog((context, config) => config
    .ReadFrom.Configuration(context.Configuration)
    .Enrich.FromLogContext()
    .WriteTo.Console());

var jwtOptions = builder.Configuration
    .GetSection(JwtOptions.SectionName).Get<JwtOptions>() ?? new JwtOptions();
if (string.IsNullOrEmpty(jwtOptions.SigningKey))
{
    throw new InvalidOperationException(
        "Jwt:SigningKey is required (env: Jwt__SigningKey).");
}

builder.Services.AddSingleton(jwtOptions);
builder.Services.AddSingleton(TimeProvider.System);
builder.Services.AddSingleton<ITokenService, TokenService>();
builder.Services.AddSingleton<IPasswordHasher, PasswordHasherService>();

builder.Services.AddDbContext<HattDbContext>(options =>
    options.UseNpgsql(builder.Configuration.GetConnectionString("Hatt"),
        b => b.MigrationsAssembly(typeof(HattDbContext).Assembly.FullName)));

builder.Services
    .AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
        options.TokenValidationParameters = TokenService.ValidationParameters(jwtOptions));
builder.Services.AddAuthorization();

// Fixed-window rate limit on auth endpoints.
builder.Services.AddRateLimiter(options =>
{
    options.RejectionStatusCode = StatusCodes.Status429TooManyRequests;
    options.AddPolicy("auth", context =>
        RateLimitPartition.GetFixedWindowLimiter(
            context.Connection.RemoteIpAddress?.ToString() ?? "unknown",
            _ => new FixedWindowRateLimiterOptions
            {
                Window = TimeSpan.FromMinutes(1),
                PermitLimit = 20,
            }));
});

builder.Services.AddScoped<LeagueService>();
builder.Services.AddScoped<LeagueRolloverJob>();

// Hangfire
builder.Services.AddHangfire(config => config
    .SetDataCompatibilityLevel(CompatibilityLevel.Version_180)
    .UseSimpleAssemblyNameTypeSerializer()
    .UseRecommendedSerializerSettings()
    .UsePostgreSqlStorage(options =>
        options.UseNpgsqlConnection(builder.Configuration.GetConnectionString("Hatt"))));
builder.Services.AddHangfireServer();

builder.Services.AddHealthChecks()
    .AddDbContextCheck<HattDbContext>("database");

var app = builder.Build();

app.UseSerilogRequestLogging();
app.UseRateLimiter();
app.UseAuthentication();
app.UseAuthorization();

app.MapHealthChecks("/health/live");
app.MapHealthChecks("/health/ready");

app.MapAuthEndpoints();
app.MapUserEndpoints();
app.MapLeagueEndpoints();
app.MapProgressEndpoints();
app.MapTelemetryEndpoints();

if (!app.Environment.IsProduction())
{
    using var scope = app.Services.CreateScope();
    await scope.ServiceProvider.GetRequiredService<HattDbContext>()
        .Database.MigrateAsync();

    app.MapPost("/dev/rollover/{weekId}", async (
        string weekId, LeagueRolloverJob job, CancellationToken ct) =>
    {
        await job.SettleWeekAsync(weekId, ct);
        return Results.Ok(new { settled = weekId });
    });
}

app.Services.GetRequiredService<IRecurringJobManager>()
    .AddOrUpdate<LeagueRolloverJob>(
        "league-rollover",
        job => job.RunAsync(CancellationToken.None),
        "0 0 * * 1",
        new RecurringJobOptions { TimeZone = TimeZoneInfo.Utc });

app.Run();

// Exposed for WebApplicationFactory-based integration tests.
public partial class Program;
