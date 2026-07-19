using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Hatt.Infrastructure.Persistence.Migrations
{
    /// <inheritdoc />
    public partial class AddProgressSyncAndAccountLinking : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "UserIdentities",
                columns: table => new
                {
                    Id = table.Column<Guid>(type: "uuid", nullable: false),
                    UserId = table.Column<Guid>(type: "uuid", nullable: false),
                    Provider = table.Column<string>(type: "character varying(16)", maxLength: 16, nullable: false),
                    Subject = table.Column<string>(type: "character varying(256)", maxLength: 256, nullable: false),
                    PasswordHash = table.Column<string>(type: "text", nullable: true),
                    CreatedAt = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UserIdentities", x => x.Id);
                    table.ForeignKey(
                        name: "FK_UserIdentities_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateTable(
                name: "UserProgressSnapshots",
                columns: table => new
                {
                    UserId = table.Column<Guid>(type: "uuid", nullable: false),
                    Version = table.Column<long>(type: "bigint", nullable: false),
                    DataJson = table.Column<string>(type: "jsonb", nullable: false),
                    ClientUpdatedAt = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false),
                    ServerUpdatedAt = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_UserProgressSnapshots", x => x.UserId);
                    table.ForeignKey(
                        name: "FK_UserProgressSnapshots_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_UserIdentities_Provider_Subject",
                table: "UserIdentities",
                columns: new[] { "Provider", "Subject" },
                unique: true);

            migrationBuilder.CreateIndex(
                name: "IX_UserIdentities_UserId",
                table: "UserIdentities",
                column: "UserId");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "UserIdentities");

            migrationBuilder.DropTable(
                name: "UserProgressSnapshots");
        }
    }
}
