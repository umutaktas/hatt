// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Hatt';

  @override
  String get pathTitle => 'Learning Path';

  @override
  String get leagueTitle => 'League';

  @override
  String get profileTitle => 'Profile';

  @override
  String get leagueOffline => 'No connection';

  @override
  String get leagueOfflineBody =>
      'The league leaderboard needs an internet connection and an account.';

  @override
  String get lessonContinue => 'Continue';

  @override
  String get lessonCheck => 'Check';

  @override
  String get correct => 'Correct!';

  @override
  String get wrong => 'Wrong';

  @override
  String get lessonComplete => 'Lesson complete!';

  @override
  String xpEarned(int xp) {
    return 'You earned $xp XP';
  }

  @override
  String get outOfHearts => 'Out of hearts';

  @override
  String get outOfHeartsBody => 'Wait for a heart, practice, or go Premium.';

  @override
  String get premiumUnlimitedHearts => 'Unlimited hearts with Premium';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsSound => 'Sound effects';

  @override
  String get settingsHarakat => 'Show harakat';

  @override
  String get settingsDeleteAccount => 'Delete my account and data';

  @override
  String get typeTransliteration => 'Type the reading';

  @override
  String get chooseMeaning => 'Choose the meaning';

  @override
  String get matchPairs => 'Match the pairs';

  @override
  String streakDays(int days) {
    return '$days-day streak';
  }
}
