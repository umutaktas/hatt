# Hatt — Osmanlıca Okuma Antrenörü 📖

Osmanlı Türkçesi (Osmanlıca) okumayı **Duolingo yapısında** öğreten,
yerel-öncelikli (local-first) mobil uygulama ve backend'i.

| Klasör | İçerik | Teknoloji |
|---|---|---|
| [`mobile/`](mobile/) | iOS + Android uygulaması | Flutter, Riverpod, Drift (SQLite) |
| [`backend/`](backend/) | Haftalık lig + hesap silme | Firebase Cloud Functions, Firestore |

## Hızlı başlangıç

```bash
# Mobil
cd mobile
flutter pub get
flutter run          # cihaz/emülatör
flutter test         # 43 test
flutter analyze      # temiz

# Backend
cd backend/functions
npm install
npm run build
```

Ayrıntılar için her klasörün kendi `README.md`'sine bakın. Ürün tanımı ve
mimari kararlar: [`mobile/CLAUDE.md`](mobile/CLAUDE.md).
