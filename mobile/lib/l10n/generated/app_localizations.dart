import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('tr'),
    Locale('en')
  ];

  /// Application name
  ///
  /// In tr, this message translates to:
  /// **'Hatt'**
  String get appTitle;

  /// No description provided for @pathTitle.
  ///
  /// In tr, this message translates to:
  /// **'Öğrenme Yolu'**
  String get pathTitle;

  /// No description provided for @leagueTitle.
  ///
  /// In tr, this message translates to:
  /// **'Lig'**
  String get leagueTitle;

  /// No description provided for @profileTitle.
  ///
  /// In tr, this message translates to:
  /// **'Profil'**
  String get profileTitle;

  /// No description provided for @leagueOffline.
  ///
  /// In tr, this message translates to:
  /// **'Bağlantı yok'**
  String get leagueOffline;

  /// No description provided for @leagueOfflineBody.
  ///
  /// In tr, this message translates to:
  /// **'Lig sıralaması için internet bağlantısı ve hesap gerekir.'**
  String get leagueOfflineBody;

  /// No description provided for @lessonContinue.
  ///
  /// In tr, this message translates to:
  /// **'Devam'**
  String get lessonContinue;

  /// No description provided for @lessonCheck.
  ///
  /// In tr, this message translates to:
  /// **'Kontrol Et'**
  String get lessonCheck;

  /// No description provided for @correct.
  ///
  /// In tr, this message translates to:
  /// **'Doğru!'**
  String get correct;

  /// No description provided for @wrong.
  ///
  /// In tr, this message translates to:
  /// **'Yanlış'**
  String get wrong;

  /// No description provided for @lessonComplete.
  ///
  /// In tr, this message translates to:
  /// **'Ders tamamlandı!'**
  String get lessonComplete;

  /// No description provided for @xpEarned.
  ///
  /// In tr, this message translates to:
  /// **'{xp} XP kazandın'**
  String xpEarned(int xp);

  /// No description provided for @outOfHearts.
  ///
  /// In tr, this message translates to:
  /// **'Canların bitti'**
  String get outOfHearts;

  /// No description provided for @outOfHeartsBody.
  ///
  /// In tr, this message translates to:
  /// **'Yeni can için bekle, pratik yap ya da Premium\'a geç.'**
  String get outOfHeartsBody;

  /// No description provided for @premiumUnlimitedHearts.
  ///
  /// In tr, this message translates to:
  /// **'Premium ile sınırsız can'**
  String get premiumUnlimitedHearts;

  /// No description provided for @settingsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Ayarlar'**
  String get settingsTitle;

  /// No description provided for @settingsSound.
  ///
  /// In tr, this message translates to:
  /// **'Ses efektleri'**
  String get settingsSound;

  /// No description provided for @settingsHarakat.
  ///
  /// In tr, this message translates to:
  /// **'Hareke göster'**
  String get settingsHarakat;

  /// No description provided for @settingsDeleteAccount.
  ///
  /// In tr, this message translates to:
  /// **'Hesabımı ve verilerimi sil'**
  String get settingsDeleteAccount;

  /// No description provided for @typeTransliteration.
  ///
  /// In tr, this message translates to:
  /// **'Okunuşunu yaz'**
  String get typeTransliteration;

  /// No description provided for @chooseMeaning.
  ///
  /// In tr, this message translates to:
  /// **'Anlamını seç'**
  String get chooseMeaning;

  /// No description provided for @matchPairs.
  ///
  /// In tr, this message translates to:
  /// **'Eşleştir'**
  String get matchPairs;

  /// No description provided for @streakDays.
  ///
  /// In tr, this message translates to:
  /// **'{days} günlük seri'**
  String streakDays(int days);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
