# CHANGELOG

## 0.1.0 — MVP iskeleti (Faz 1–6)

İlk çalışan sürüm. `flutter analyze` temiz, testler geçiyor.

### Faz 1 — Temel
- Flutter + Riverpod proje iskeleti (feature-first).
- Drift (SQLite) şeması: letters, words, reading_passages/passage_lines,
  curriculum_nodes, node_progress, review_states, user_state, exercise_log (§5).
- JSON → DB seed pipeline (idempotent) + içerik modelleri.
- Tema (mürekkep + altın palet), `OttomanText` widget (min 28sp punto kuralı
  burada zorlanır, RTL, hareke toggle), `MascotState` soyutlaması + SVG placeholder'lar.

### Faz 2 — Öğrenme yolu
- `curriculum.json` şeması + `SCHEMA.md`, 2 ünitelik (13 düğüm) örnek müfredat.
- Dikey yol haritası, düğüm kilidi/ilerleme mantığı (bir ders tamamlanınca sonraki açılır).

### Faz 3 — Ders motoru
- 6 egzersiz tipi, ders oturumu akışı (soru → anında geri bildirim + ses → devam).
- Can/XP hesapları, kombo/hatasız bonus, seviye sistemi, ses + kutlama animasyonları.
- Toleranslı transliterasyon karşılaştırıcısı (â/a, î/i, û/u eşdeğer).
- **Birim testleri:** can, XP, seviye, karşılaştırıcı.

### Faz 4 — Aralıklı tekrar
- FSRS-5 motoru (saf Dart). Vadesi gelen kartlardan dinamik `review` düğümleri,
  kuyruk boşsa zayıf/sık kelimelerden karma pratik. Checkpoint sınavı.
- **Birim testleri:** FSRS zamanlama.

### Faz 5 — Backend (feature flag arkasında)
- Backend-agnostik `LeagueService` (offline + korumalı Firestore stub).
- Haftalık lig mantığı (hafta anahtarı Pzt 00:00 UTC, 5 kademe, terfi/tenzil) saf Dart.
- Lig sekmesi "bağlantı yok" durumu. **Birim testleri:** lig haftası.
- Cloud Functions ve Firestore kuralları ayrı depoda (`umutaktas/hatt`).

### Faz 6 — Onboarding & cila
- KVKK açık rıza onboarding ekranı.
- Ayarlar: ses/hareke toggle, "hesabımı ve verilerimi sil" (tam yerel silme).
- Paywall iskeleti (satın alma feature flag arkasında), `EntitlementService`.
- Streak + günlük hedef gösterimi, profil ekranı.

### Bilinen sınırlamalar
- Firebase entegrasyonu korumalı stub (SDK bağlanmayı bekliyor).
- RevenueCat satın alma akışı placeholder.
- Ses/Lottie asset'leri placeholder; maskot basit SVG.
- Local notification (streak hatırlatıcı) bağımlılığı eklendi, zamanlama bağlanacak.
