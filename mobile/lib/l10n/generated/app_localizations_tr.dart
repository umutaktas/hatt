// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Hatt';

  @override
  String get pathTitle => 'Öğrenme Yolu';

  @override
  String get leagueTitle => 'Lig';

  @override
  String get profileTitle => 'Profil';

  @override
  String get leagueOffline => 'Bağlantı yok';

  @override
  String get leagueOfflineBody =>
      'Lig sıralaması için internet bağlantısı ve hesap gerekir.';

  @override
  String get lessonContinue => 'Devam';

  @override
  String get lessonCheck => 'Kontrol Et';

  @override
  String get correct => 'Doğru!';

  @override
  String get wrong => 'Yanlış';

  @override
  String get lessonComplete => 'Ders tamamlandı!';

  @override
  String xpEarned(int xp) {
    return '$xp XP kazandın';
  }

  @override
  String get outOfHearts => 'Canların bitti';

  @override
  String get outOfHeartsBody =>
      'Yeni can için bekle, pratik yap ya da Premium\'a geç.';

  @override
  String get premiumUnlimitedHearts => 'Premium ile sınırsız can';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get settingsSound => 'Ses efektleri';

  @override
  String get settingsHarakat => 'Hareke göster';

  @override
  String get settingsDeleteAccount => 'Hesabımı ve verilerimi sil';

  @override
  String get typeTransliteration => 'Okunuşunu yaz';

  @override
  String get chooseMeaning => 'Anlamını seç';

  @override
  String get matchPairs => 'Eşleştir';

  @override
  String streakDays(int days) {
    return '$days günlük seri';
  }
}
