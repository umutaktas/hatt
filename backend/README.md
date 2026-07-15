# Hatt — Backend (Firebase)

Osmanlıca okuma antrenörü **Hatt**'ın backend'i. Kapsam bilinçli olarak küçüktür:
uygulama **local-first**'tür; backend yalnızca **haftalık lig** ve **hesap/veri
silme** işlevlerini sağlar (CLAUDE.md §2, §5).

> Mobil uygulama ayrı depoda: [`umutaktas/hatt.mobile`](https://github.com/umutaktas/hatt.mobile).

## İçerik

```
firebase.json              Firestore + Functions yapılandırması
firestore.rules            Güvenlik kuralları (§5)
firestore.indexes.json     Lig sorguları için indeksler
.firebaserc.example        Proje kimliği örneği (kopyalayıp .firebaserc yapın)
functions/
  src/
    index.ts               Fonksiyon giriş noktası
    league.ts              Haftalık lig yenileme (scheduled, Pzt 00:00 UTC)
    account.ts             KVKK "hesabımı ve verilerimi sil" (callable)
    week.ts                Hafta anahtarı (mobil ile birebir aynı mantık)
```

## Cloud Functions

- **`rolloverLeagues`** — Cron `0 0 * * 1` (her Pazartesi 00:00 UTC). Biten
  haftayı sonuçlandırır: her kümeyi haftalık XP'ye göre sıralar, ilk N terfi /
  son N tenzil (Bronz→Elmas 5 kademe), kullanıcı `tier`'ını yazar, yeni hafta
  için kümeleri kademeye göre yeniden oluşturur (~25 kişi/küme).
- **`deleteAccount`** — Kimliği doğrulanmış kullanıcı için `users/{uid}` dokümanı
  ve Auth hesabını siler. Lig üyelik satırları PII içermez (yalnız takma ad) ve
  bir sonraki haftalık yenilemede sıfırdan oluşturulur.

## Firestore düzeni

```
users/{uid}                                        { nickname, totalXp, streak, tier }
leagues/{weekId}/cohorts/{cohortId}                { tier, memberCount }
leagues/{weekId}/cohorts/{cohortId}/members/{uid}  { nickname, weeklyXp, tier }
```

## Kurulum ve deploy

```bash
cd functions && npm install && npm run build   # TypeScript derleme

cp .firebaserc.example .firebaserc             # proje kimliğinizi yazın
firebase deploy --only firestore:rules
firebase deploy --only firestore:indexes
firebase deploy --only functions

# Yerel geliştirme:
npm run serve                                  # functions emülatörü
```

## Güvenlik kuralları özeti (§5)

- Kullanıcı yalnız kendi `users/{uid}` dokümanını okur/yazar; takma ad zorunlu,
  gerçek ad istenmez.
- Lig sıralaması giriş yapan herkese okunur; üye yalnız kendi `weeklyXp`'sini,
  makul üst sınır (≤100000) ve server timestamp ile güncelleyebilir.
- Küme yapısı yalnızca Cloud Functions (admin) tarafından yazılır.
