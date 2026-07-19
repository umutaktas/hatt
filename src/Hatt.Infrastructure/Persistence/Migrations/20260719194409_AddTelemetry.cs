using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Hatt.Infrastructure.Persistence.Migrations
{
    /// <inheritdoc />
    public partial class AddTelemetry : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<DateTimeOffset>(
                name: "LastXpAt",
                table: "LeagueMembers",
                type: "timestamp with time zone",
                nullable: false,
                defaultValue: new DateTimeOffset(new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new TimeSpan(0, 0, 0, 0, 0)));

            migrationBuilder.AddColumn<DateTimeOffset>(
                name: "CreatedAt",
                table: "LeagueCohorts",
                type: "timestamp with time zone",
                nullable: false,
                defaultValue: new DateTimeOffset(new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified), new TimeSpan(0, 0, 0, 0, 0)));

            migrationBuilder.CreateTable(
                name: "TelemetryEvents",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    UserId = table.Column<Guid>(type: "uuid", nullable: true),
                    EventName = table.Column<string>(type: "character varying(64)", maxLength: 64, nullable: false),
                    PropertiesJson = table.Column<string>(type: "jsonb", nullable: true),
                    Timestamp = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_TelemetryEvents", x => x.Id);
                    table.ForeignKey(
                        name: "FK_TelemetryEvents_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_TelemetryEvents_EventName",
                table: "TelemetryEvents",
                column: "EventName");

            migrationBuilder.CreateIndex(
                name: "IX_TelemetryEvents_Timestamp",
                table: "TelemetryEvents",
                column: "Timestamp");

            migrationBuilder.CreateIndex(
                name: "IX_TelemetryEvents_UserId",
                table: "TelemetryEvents",
                column: "UserId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "TelemetryEvents");

            migrationBuilder.DropColumn(
                name: "LastXpAt",
                table: "LeagueMembers");

            migrationBuilder.DropColumn(
                name: "CreatedAt",
                table: "LeagueCohorts");
        }
    }
}
