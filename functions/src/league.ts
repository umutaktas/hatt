/**
 * Weekly league rollover (CLAUDE.md §4.3, §5).
 *
 * Scheduled Monday 00:00 UTC. For the week that just ended it:
 *   1. Ranks each cohort by weeklyXp.
 *   2. Promotes the top N and relegates the bottom N (5 tiers: Bronz→Elmas).
 *   3. Writes each user's new tier onto `users/{uid}`.
 *   4. Builds fresh cohorts for the new week, grouped by tier, ~25 per cohort.
 *
 * Firestore layout:
 *   users/{uid}                                → { nickname, totalXp, streak, tier }
 *   leagues/{weekId}/cohorts/{cohortId}        → { tier, memberCount }
 *   leagues/{weekId}/cohorts/{cohortId}/members/{uid} → { nickname, weeklyXp, tier }
 */
import { getFirestore } from "firebase-admin/firestore";
import { logger } from "firebase-functions/v2";
import { onSchedule } from "firebase-functions/v2/scheduler";

import { previousWeekId, weekId } from "./week";

const TIERS = ["bronze", "silver", "gold", "platinum", "diamond"] as const;
type Tier = (typeof TIERS)[number];

const COHORT_SIZE = 25;
const PROMOTE = 5;
const RELEGATE = 5;

function promoted(tier: Tier): Tier {
  const i = TIERS.indexOf(tier);
  return TIERS[Math.min(i + 1, TIERS.length - 1)];
}

function relegated(tier: Tier): Tier {
  const i = TIERS.indexOf(tier);
  return TIERS[Math.max(i - 1, 0)];
}

interface Member {
  uid: string;
  nickname: string;
  weeklyXp: number;
  tier: Tier;
}

/**
 * Cron: `0 0 * * 1` — every Monday at 00:00 UTC (CLAUDE.md §4.3).
 */
export const rolloverLeagues = onSchedule(
  { schedule: "0 0 * * 1", timeZone: "UTC" },
  async () => {
    const db = getFirestore();
    const now = new Date();
    const endedWeek = previousWeekId(now);
    const newWeek = weekId(now);

    logger.info(`League rollover: settling ${endedWeek}, opening ${newWeek}`);

    // 1–3: settle the ended week, collecting each user's next tier.
    const nextTierByUid = new Map<string, Tier>();
    const cohorts = await db
      .collection(`leagues/${endedWeek}/cohorts`)
      .listDocuments();

    for (const cohortRef of cohorts) {
      const membersSnap = await cohortRef.collection("members").get();
      const members: Member[] = membersSnap.docs.map((d) => {
        const data = d.data();
        return {
          uid: d.id,
          nickname: data.nickname ?? "Öğrenci",
          weeklyXp: data.weeklyXp ?? 0,
          tier: (data.tier ?? "bronze") as Tier,
        };
      });

      members.sort((a, b) =>
        b.weeklyXp !== a.weeklyXp
          ? b.weeklyXp - a.weeklyXp
          : a.uid.localeCompare(b.uid)
      );

      members.forEach((m, idx) => {
        const rank = idx + 1;
        let tier = m.tier;
        if (rank <= PROMOTE) tier = promoted(m.tier);
        else if (rank > members.length - RELEGATE && members.length > PROMOTE) {
          tier = relegated(m.tier);
        }
        nextTierByUid.set(m.uid, tier);
      });
    }

    // Persist new tiers on user docs.
    let batch = db.batch();
    let ops = 0;
    for (const [uid, tier] of nextTierByUid) {
      batch.set(db.doc(`users/${uid}`), { tier }, { merge: true });
      if (++ops >= 400) {
        await batch.commit();
        batch = db.batch();
        ops = 0;
      }
    }
    if (ops > 0) await batch.commit();

    // 4: build fresh cohorts for the new week, grouped by tier.
    await buildCohorts(db, newWeek);
    logger.info(`League rollover complete for ${newWeek}.`);
  }
);

async function buildCohorts(
  db: FirebaseFirestore.Firestore,
  newWeek: string
): Promise<void> {
  const usersSnap = await db.collection("users").get();
  const byTier = new Map<Tier, Member[]>();
  for (const doc of usersSnap.docs) {
    const data = doc.data();
    const tier = (data.tier ?? "bronze") as Tier;
    const member: Member = {
      uid: doc.id,
      nickname: data.nickname ?? "Öğrenci",
      weeklyXp: 0,
      tier,
    };
    (byTier.get(tier) ?? byTier.set(tier, []).get(tier)!).push(member);
  }

  let batch = db.batch();
  let ops = 0;
  for (const tier of TIERS) {
    const members = byTier.get(tier) ?? [];
    for (let i = 0; i < members.length; i += COHORT_SIZE) {
      const slice = members.slice(i, i + COHORT_SIZE);
      const cohortId = `${tier}-${i / COHORT_SIZE}`;
      const cohortRef = db.doc(`leagues/${newWeek}/cohorts/${cohortId}`);
      batch.set(cohortRef, { tier, memberCount: slice.length });
      ops++;
      for (const m of slice) {
        batch.set(cohortRef.collection("members").doc(m.uid), {
          nickname: m.nickname,
          weeklyXp: 0,
          tier,
        });
        if (++ops >= 400) {
          await batch.commit();
          batch = db.batch();
          ops = 0;
        }
      }
    }
  }
  if (ops > 0) await batch.commit();
}
