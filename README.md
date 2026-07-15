# Hatt — Backend (.NET 9 + PostgreSQL)

Osmanlıca okuma antrenörü **Hatt**'ın backend'i. Kapsam bilinçli olarak küçüktür:
uygulama **local-first**'tür; backend yalnızca kimlik, (ileride) haftalık lig,
ilerleme yedeği ve KVKK hesap silme işlevlerini üstlenir.

> Mobil uygulama ayrı depoda: [`umutaktas/hatt.mobile`](https://github.com/umutaktas/hatt.mobile).
> Mimari karar analizi: `hatt.mobile/docs/ANALIZ-BACKEND-2026-07-16.md`
> (Firebase bırakıldı; eski içerik `legacy-firebase/` altında arşivdedir).

## Yığın

ASP.NET Core 9 minimal API · EF Core + PostgreSQL · Serilog (structured JSON) ·
JWT (HS256, 15 dk access) + **rotating refresh token** (yalnız SHA-256 hash
saklanır, reuse tespitinde token ailesi iptal edilir) · built-in rate limiting ·
Hangfire (P1'de lig rollover için eklenecek).

## Endpoint'ler (P0)

```
POST   /v1/auth/anonymous    { installationId, platform }  → access+refresh
POST   /v1/auth/refresh      { refreshToken }               → rotasyonlu yeni çift
GET    /v1/me                                               → profil
PATCH  /v1/me                { nickname }                   → yalnız istemci alanları
DELETE /v1/account                                          → KVKK tam silme (cascade)
POST   /v1/lessons/complete  (Idempotency-Key başlığı)      → server-calculated lig XP
GET    /v1/leagues/current                                  → kohort sıralaması
GET    /v1/leagues/last-result                              → geçen haftanın sonucu
GET    /health/live | /health/ready
```

Sunucu sahipli alanlar (tier, XP) istek DTO'larında **yoktur** —
server-authoritative tasarım (bkz. analiz raporu §5). Lig XP'si P1'de yalnız
doğrulanmış ders tamamlama olaylarından üretilecek; istemciden toplam kabul eden
bir endpoint olmayacak.

## Geliştirme

```bash
createdb hatt_dev
cd src/Hatt.Api
ASPNETCORE_ENVIRONMENT=Development dotnet run   # migration'lar otomatik uygulanır
dotnet test                                     # kökten: birim testleri

# Yeni migration
dotnet ef migrations add <Name> -o Data/Migrations
```

Dev bağlantı dizesi ve imzalama anahtarı `appsettings.Development.json`'da;
**production'da** `ConnectionStrings__Hatt` ve `Jwt__SigningKey` ortam
değişkenlerinden verilir, repoya asla girmez.

## Yol haritası

- **P0 ✅** — iskelet, anonim auth + rotating refresh, nickname, KVKK silme,
  rate limit, health, structured log.
- **P1 ✅** — güvenli lig: hafta/cohort/üye şeması, server-calculated XP
  (idempotent `xp_events` ledger'ı, günlük tavan), Hangfire rollover (Pzt 00:00
  UTC, advisory lock + durum makinesiyle idempotent), lazy cohort (hafta ortası
  katılım otomatik; rollover maliyeti yalnız aktif oyuncularla ölçeklenir).
- **P2** — ilerleme yedeği (versiyonlu jsonb snapshot) + account linking
  (e-posta/Apple/Google, aynı user_id).
- **P3** — rızalı minimal telemetri.
