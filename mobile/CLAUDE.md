# PROJE: Osmanlıca Okuma Antrenörü (çalışma adı: "Hatt")

Bu dosya proje kökündeki `CLAUDE.md`'dir ve MVP'nin tamamını kapsayan tanımdır.
Fazlar sırayla uygulanır; her fazın sonunda çalışır ve test edilebilir bir
uygulama olur. Bu depo **mobil uygulamadır**; backend ayrı depoda:
`umutaktas/hatt`.

## 1. Ürün Vizyonu

Osmanlı Türkçesi (Osmanlıca) okumayı **Duolingo yapısında** öğreten, abonelik
gelirli bir mobil uygulama (iOS + Android). Hedef kitle: tarih/ilahiyat/edebiyat
öğrencileri, akademisyenler, yetişkin meraklılar, diaspora. Ton: yetişkinlere
hitap eden, ciddi ama motive edici bir oyunlaştırma — mekanikler Duolingo,
estetik çocuksu değil.

Rekabet avantajı: gerçek tarihi metinlerle (kitabe fotoğrafları, matbu metinler,
sözlük maddeleri) çalışan, tek öğrenme yolu (path) üzerinde ilerleyen tek
Osmanlıca uygulaması olmak.

## 2. Teknoloji ve Mimari Kararlar (SABİT — değiştirme)

- **Flutter** (tek kod tabanı, iOS + Android). Dart 3.x, null-safe.
- **State management:** Riverpod.
- **Yerel veritabanı:** Drift (SQLite). İçerik ve ilerleme öncelikle cihazda
  tutulur (**local-first**); içerik, uygulama paketiyle gelen JSON + görsel
  asset'lerden seed edilir.
- **Backend: Firebase** (yalnızca şunlar için):
  - **Anonymous Auth** varsayılan; e-posta/Google/Apple girişi opsiyonel
    "hesabını yedekle" akışıyla sonradan bağlanır (account linking).
  - **Firestore:** haftalık lig/sıralama verisi + ilerleme yedeği (senkronizasyon
    tek yönlü basit: cihaz → bulut, çakışmada cihaz kazanır).
  - **Cloud Functions:** haftalık lig kümelerinin oluşturulması ve hafta sonu
    ödül/küme yenileme işi (scheduled function).
  - **Crashlytics + Analytics:** temel event'ler.
  - KVKK/GDPR: onboarding'de açık rıza ekranı; anonim kimlikle kişisel veri
    toplanmaz; hesap bağlanırsa yalnız e-posta saklanır; "hesabımı ve verilerimi
    sil" butonu Ayarlar'da zorunlu (Function ile tam silme).
- **Spaced repetition:** FSRS algoritması. FSRS motoru arka planda çalışır ve
  **yoldaki tekrar derslerinin içeriğini** belirler (madde 5).
- **Abonelik:** RevenueCat SDK — MVP'de iskelet + paywall ekranı; ürün ID'leri
  placeholder, satın alma akışı feature flag arkasında.
- **Ses:** `audioplayers` ile kısa efektler; ses seviyesi/kapatma Ayarlar'da.
- **Mimari:** feature-first klasör yapısı (`lib/features/...`, `lib/core`).
- **Test:** her feature için en az unit test (özellikle FSRS zamanlama, can/XP
  hesapları, lig haftası mantığı) + kritik akışlar için widget test.

## 3. KRİTİK KISIT: Osmanlıca Metin Görüntüleme

- Osmanlıca/Arapça metin HER YERDE büyük puntoda: **minimum 28sp, okuma
  egzersizlerinde 34-40sp.** Kural `OttomanText` widget'ında zorlanır, tüm
  ekranlar bu widget'ı kullanır.
- RTL desteği doğru kurulur: Arapça metin blokları RTL, Latin transliterasyon LTR.
- Font: Noto Naskh Arabic varsayılan; rika seviyeleri için görsel tabanlı içerik
  kullanılır, font ile rika taklidi YAPILMAZ.
- Harekeli/harekesiz gösterim toggle'ı ilgili egzersizlerde bulunur.

## 4. Duolingo Yapısı: Yol, Üniteler, Oyunlaştırma

### 4.1 Öğrenme Yolu (tek doğrusal path)
- Ana ekran = dikey kaydırılan yol haritası: düğümler (dersler) → 5-8 derste bir
  ünite, ünite sonunda checkpoint sınavı.
- Düğüm tipleri: `letter`, `vocab`, `reading`, `review` (FSRS vadesi gelenlerden
  dinamik), `checkpoint`.
- `review` düğümleri yola otomatik enjekte edilir; içeriği o anki FSRS
  kuyruğundan üretilir. Kuyruk boşsa zayıf harf/kelimelerden karma pratik.
- Bir ders = 8-12 egzersizlik oturum; ilerleme çubuğu üstte, Duolingo akışı.
- İçerik müfredatı `assets/content/curriculum.json`'da; şema `assets/content/SCHEMA.md`.

### 4.2 Egzersiz Tipleri (MVP seti)
1. Çoktan seçmeli harf/kelime tanıma (Osmanlıca → Türkçe)
2. Ters yön (Türkçe → Osmanlıca seçenekler)
3. Benzer harf ayrımı (ب/ت/ث gibi)
4. Serbest transliterasyon yazma (toleranslı karşılaştırıcı: â/a, î/i, û/u eşdeğer)
5. Eşleştirme (5 çift: Osmanlıca ↔ Türkçe)
6. Satır okuma (okuma parçası satırı → transliterasyon yaz)

### 4.3 Oyunlaştırma
- **Can (hearts):** 5 can; yanlışta 1 gider. Bitince bekle (4 saatte 1),
  pratik yap (review), ya da **Premium = sınırsız can**.
- **XP + seviye:** ders sonu XP (temel 10 + kombo/hatasız bonus), seviye eşikleri.
- **Günlük seri (streak):** koruma hakkı (dondurucu) haftada 1 ücretsiz, fazlası Premium.
- **Haftalık lig:** Firestore'da 20-30 kişilik kümeler, haftalık XP sıralaması,
  üst dilim yükselir / alt dilim düşer (Bronz → Elmas, 5 kademe). Cloud Function
  pazartesi 00:00 UTC'de yeniler.
- **Maskot:** kamış kalem karakteri "Kamış". Durumlar: normal/kutlama/üzgün/uyuyan.
  Kod tarafında `MascotState` enum'u ile soyutlanır.
- **Ses efektleri** ve **kutlama animasyonları**; Ayarlar'dan kapatılabilir.

## 5. Veri Modeli

**Drift (cihaz):** letters, words, reading_passages + passage_lines,
curriculum_nodes, node_progress, review_states (FSRS), user_state, exercise_log.

**Firestore (bulut):** `users/{uid}` (takma ad, XP, streak, tier — PII yok);
`leagues/{weekId}/cohorts/{cohortId}/members` (uid, weeklyXp). Güvenlik kuralları:
kullanıcı yalnız kendi dokümanını yazar; lig XP yazımı server timestamp + makul
üst sınır ile.

## 6. Ücretsiz / Premium Ayrımı

- Ücretsiz: tüm yol erişilebilir ama can sistemiyle sınırlı; haftada 1 dondurucu.
- **Premium:** sınırsız can, sınırsız dondurucu, sınırsız checkpoint atlama, zayıf
  nokta analizi, (gelecekte) AI kitabe çözücü.
- Ayrım tek `EntitlementService` üzerinden; UI'da kilit ikonları.

## 7. Kapsam DIŞI

AI kitabe çözücü ("yakında" kartı), el yazısı seviyeleri, arkadaş/mesaj/kulüp,
web sürümü, push kampanyaları (yalnız local notification: seri hatırlatıcı).

## 8. Uygulama Fazları

1. Proje iskeleti, Drift şeması, seed pipeline, tema, `OttomanText`, `MascotState`.
2. Yol haritası + curriculum.json şeması + düğüm kilidi/ilerleme.
3. Ders motoru — 6 egzersiz tipi, can/XP, ses + kutlama (unit test).
4. FSRS + dinamik `review` + checkpoint (unit test).
5. Firebase — auth, yedek, haftalık lig (Firestore + scheduled Function).
6. Onboarding, streak + local notification, paywall iskeleti, Ayarlar (veri silme).

Her fazın sonunda: `flutter analyze` temiz, testler geçer, CHANGELOG maddesi.

## 9. Çalışma Kuralları

- Kod ve tanımlayıcılar İngilizce; kullanıcıya görünen metinler Türkçe
  (i18n: `flutter_localizations` + arb; şimdilik `tr` dolu, `en` iskelet).
- Erişilebilirlik: interaktif öğeler min 48dp; Osmanlıca punto kuralı tartışmaya kapalı.
- Firebase başlatma feature flag arkasında; backend olmadan da uygulama açılır
  (lig sekmesi "bağlantı yok").
