namespace Hatt.Application.DTOs;

public record CompleteLessonRequest(
    string NodeId,
    int TotalExercises,
    int CorrectFirstTry,
    int TotalWrong,
    int MaxCombo);

public record LeagueStandingDto(
    int Rank,
    string Nickname,
    int WeeklyXp,
    bool IsMe);

public record LeagueCurrentResponse(
    string WeekId,
    string Tier,
    DateTimeOffset WeekEnd,
    int PromoteCount,
    int RelegateCount,
    List<LeagueStandingDto> Standings);

public record LeagueLastResultResponse(
    string WeekId,
    string Tier,
    int FinalRank,
    string Outcome,
    string NextTier);
