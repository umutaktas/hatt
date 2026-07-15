# Hatt — Osmanlıca Okuma Antrenörü 📖

Osmanlı Türkçesi (Osmanlıca) okumayı **Duolingo yapısında** öğreten, yerel-öncelikli
(local-first) Flutter mobil uygulaması. iOS + Android.

> Bu depo **mobil uygulamadır**. Backend (Firebase Cloud Functions + Firestore
> kuralları) ayrı depodadır: [`umutaktas/hatt`](https://github.com/umutaktas/hatt).

## Öne çıkanlar

- **Tek öğrenme yolu (path):** dikey ünite/ders haritası, düğüm kilidi/ilerleme.
- **6 egzersiz tipi:** çoktan seçmeli (OSM→TR, TR→OSM), benzer harf ayrımı,
  serbest transliterasyon yazma (toleranslı karşılaştırıcı), eşleştirme, satır okuma.
- **Oyunlaştırma:** can (hearts), XP + seviye, günlük seri (streak) + dondurucu,
  haftalık lig, maskot "Kamış", ses efektleri, kutlama animasyonları.
- **FSRS aralıklı tekrar:** vadesi gelen kartlardan dinamik `review` dersleri.
- **Local-first:** içerik + ilerleme cihazda (Drift/SQLite). Firebase yalnızca
  lig + yedek için, **feature flag arkasında** — backend olmadan da tam çalışır.
- **Erişilebilirlik:** tüm Osmanlıca metin `OttomanText` ile min **28sp**
  (okuma egzersizlerinde 34–40sp), RTL, hareke aç/kapa.

## Mimari (feature-first)

```
lib/
  core/
    gamification/   XP, hearts, streak, level, transliteration matcher (saf Dart, test edildi)
    fsrs/           FSRS-5 aralıklı tekrar motoru (saf Dart, test edildi)
    db/             Drift şeması + veritabanı (§5)
    seed/           JSON → DB seed pipeline
    content/        içerik modelleri
    widgets/        OttomanText (punto kuralı burada zorlanır), StatHeader
    mascot/         MascotState soyutlaması + view
    audio/          SoundService
    theme/, config/, providers/
  features/
    path/  lesson/  review/  league/  profile/  onboarding/  paywall/  settings/
  l10n/             tr (dolu) + en (iskelet)
assets/content/     curriculum.json, letters.json, words.json, passages.json, SCHEMA.md
```

State management **Riverpod**. Ayrıntılı yapı için `CLAUDE.md`'ye bakın.

## Çalıştırma

```bash
flutter pub get
flutter run                 # iOS/Android cihaz veya emülatör
flutter analyze             # temiz
flutter test                # birim + widget testleri
```

> **Not (sqlite3):** `pubspec.yaml` içinde native-assets hook'u sistem/paketli
> sqlite3'ü kullanacak şekilde ayarlıdır (`hooks.user_defines.sqlite3.source:
> system`) — sanal/CI ortamlarında indirmeyi engellemek için. Cihazda
> `sqlite3_flutter_libs` kütüphaneyi sağlar.

## Testler

Kritik saf-Dart mantığı tam test kapsamındadır (spec §9 gereği):

- `transliteration_matcher_test.dart` — toleranslı karşılaştırıcı
- `gamification_test.dart` — XP, can yenilenme, seviye, streak + dondurucu
- `fsrs_test.dart` — FSRS zamanlama (stabilite/güçlük/vade)
- `league_logic_test.dart` — hafta anahtarı, terfi/tenzil
- `exercise_builder_test.dart` — egzersiz üretimi
- `database_seed_test.dart` — gerçek JSON ile uçtan uca seed
- `ottoman_text_test.dart` — 28sp punto kuralı + hareke temizleme

## Firebase (opsiyonel, Faz 5)

Uygulama backend olmadan tam çalışır (Lig sekmesi "bağlantı yok" gösterir).
Etkinleştirmek için:

1. `flutterfire configure` çalıştırın (`firebase_options.dart` üretir).
2. Firebase paketlerini ekleyin ve
   `lib/features/league/data/firestore_league_service.dart` içindeki korumalı
   (guarded) uygulamayı bağlayın.
3. `lib/core/config/feature_flags.dart` → `firebaseEnabled = true`.
4. Backend deposunu (`umutaktas/hatt`) deploy edin.

## Kapsam dışı (MVP)

AI kitabe çözücü, el yazısı seviyeleri, arkadaş/sosyal, web sürümü, push kampanyaları.
