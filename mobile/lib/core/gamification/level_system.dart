/// Maps cumulative XP to a user level (CLAUDE.md §4.3).
///
/// Thresholds grow roughly quadratically so early levels come fast and later
/// ones require sustained study. Pure Dart and deterministic.
class LevelSystem {
  const LevelSystem();

  /// XP required to *reach* [level] (level 1 starts at 0 XP).
  int xpForLevel(int level) {
    if (level <= 1) return 0;
    final n = level - 1;
    return 50 * n * n + 50 * n; // 100, 300, 600, 1000, ...
  }

  int levelForXp(int totalXp) {
    var level = 1;
    while (xpForLevel(level + 1) <= totalXp) {
      level++;
    }
    return level;
  }

  /// Progress within the current level, 0.0–1.0.
  double progressWithinLevel(int totalXp) {
    final level = levelForXp(totalXp);
    final start = xpForLevel(level);
    final next = xpForLevel(level + 1);
    if (next <= start) return 1;
    return ((totalXp - start) / (next - start)).clamp(0, 1);
  }

  int xpToNextLevel(int totalXp) {
    final level = levelForXp(totalXp);
    return xpForLevel(level + 1) - totalXp;
  }
}
