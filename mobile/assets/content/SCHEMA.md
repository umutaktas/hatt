# İçerik Şeması (Content Schema)

Bu klasördeki JSON dosyaları uygulama paketiyle gelir ve ilk açılışta yerel
veritabanına (Drift/SQLite) seed edilir (CLAUDE.md §2, §5). Şema **stabildir**;
alan adlarını değiştirmeyin, yalnızca içerik ekleyin.

Tüm metin alanları UTF-8'dir. Osmanlıca alanlar Arap harfleriyle yazılır ve
uygulamada yalnızca `OttomanText` widget'ı üzerinden, minimum 28sp ile gösterilir
(CLAUDE.md §3).

---

## `letters.json` — Harfler

`LetterDto` dizisi. Harf formları ZWJ (U+200D) birleştirmesiyle üretilir; böylece
herhangi bir fontta doğru bağlanma (initial/medial/final) görünür.

| Alan | Tip | Zorunlu | Açıklama |
|------|-----|:------:|----------|
| `id` | string | ✓ | Benzersiz anahtar (curriculum `contentRefs` buna referans verir) |
| `name` | string | ✓ | Türkçe harf adı (ör. "Be") |
| `isolated` | string | ✓ | İzole form |
| `initial` | string | ✓ | Başta form |
| `medial` | string | ✓ | Ortada form |
| `final` | string | ✓ | Sonda form |
| `soundValue` | string | ✓ | Ses değeri (ör. "b", "s (peltek)") |
| `similarGroup` | string? | | Benzer harf grubu anahtarı (ör. "be-te-se") — ayrım egzersizleri için |
| `exampleWord` | string? | | Örnek kelime (Osmanlıca) |

## `words.json` — Kelimeler

`WordDto` dizisi.

| Alan | Tip | Zorunlu | Açıklama |
|------|-----|:------:|----------|
| `id` | string | ✓ | Benzersiz anahtar |
| `ottoman` | string | ✓ | Osmanlıca yazım |
| `transliteration` | string | ✓ | Latin transliterasyon (â/î/û uzunluklarıyla) |
| `meaningTr` | string | ✓ | Türkçe anlam |
| `root` | string? | | Köken (Ar./Fars./Türk.) |
| `frequencyRank` | int | ✓ | Sıklık sırası (küçük = daha sık) |
| `level` | int | ✓ | Zorluk seviyesi (1..) |
| `exampleSentence` | string? | | Örnek cümle (Osmanlıca) |

## `passages.json` — Okuma Parçaları

`PassageDto` dizisi; her biri satır (`PassageLineDto`) içerir.

| Alan | Tip | Zorunlu | Açıklama |
|------|-----|:------:|----------|
| `id` | string | ✓ | Benzersiz anahtar |
| `title` | string | ✓ | Başlık |
| `level` | int | ✓ | Seviye |
| `genre` | string | ✓ | Tür (kitabe/edebi/siir/matbu ...) |
| `imageAssetPath` | string? | | Kitabe/matbu görsel yolu (asset) |
| `lines[]` | array | ✓ | Satırlar |
| `lines[].id` | string | ✓ | Satır anahtarı |
| `lines[].ordinal` | int | ✓ | Satır sırası (0'dan) |
| `lines[].ottoman` | string | ✓ | Osmanlıca satır |
| `lines[].transliteration` | string | ✓ | Transliterasyon |
| `lines[].simplifiedTr` | string | ✓ | Sadeleştirilmiş Türkçe |

## `curriculum.json` — Müfredat

Tek doğrusal yol: ünite → ders (node). Düğüm sırası, dosyadaki sıradır.

| Alan | Tip | Zorunlu | Açıklama |
|------|-----|:------:|----------|
| `version` | int | ✓ | Şema sürümü |
| `units[]` | array | ✓ | Üniteler |
| `units[].id` | string | ✓ | Ünite anahtarı |
| `units[].title` | string | ✓ | Ünite başlığı |
| `units[].nodes[]` | array | ✓ | Düğümler |
| `nodes[].id` | string | ✓ | Düğüm anahtarı |
| `nodes[].type` | enum | ✓ | `letter` \| `vocab` \| `reading` \| `review` \| `checkpoint` |
| `nodes[].title` | string | ✓ | Düğüm başlığı |
| `nodes[].contentRefs` | string[] | ✓ | İçerik anahtarları (aşağıya bakın) |

### `contentRefs` tipe göre anlamı

- `letter` → `letters.json` id'leri
- `vocab` → `words.json` id'leri
- `reading` → `passages.json` id'leri
- `review` → **boş** (`[]`). İçerik FSRS kuyruğundan dinamik üretilir
  (CLAUDE.md §4.1). Kuyruk boşsa zayıf harf/kelimelerden karma pratik üretilir.
- `checkpoint` → o ünitede test edilecek `letters`/`words` id'lerinin karışımı.

### İlk kilit durumu

Seed sırasında yalnızca ilk düğüm `available`, diğerleri `locked` yapılır. Bir
düğüm tamamlandığında bir sonraki açılır (`lib/features/path`).
