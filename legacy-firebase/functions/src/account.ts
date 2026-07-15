/**
 * KVKK/GDPR "hesabımı ve verilerimi sil" full deletion (CLAUDE.md §2, §6).
 *
 * Callable by the authenticated user only. Deletes the user's Firestore
 * document and their Auth account. League membership rows contain only a
 * self-chosen nickname (no PII) and are rebuilt from scratch on the next weekly
 * rollover, so they are not scanned here. The device also wipes its local Drift
 * database (see the app's UserRepository.deleteAllUserData).
 */
import { getAuth } from "firebase-admin/auth";
import { getFirestore } from "firebase-admin/firestore";
import { logger } from "firebase-functions/v2";
import { HttpsError, onCall } from "firebase-functions/v2/https";

export const deleteAccount = onCall(async (request) => {
  const uid = request.auth?.uid;
  if (!uid) {
    throw new HttpsError("unauthenticated", "Giriş yapılmamış.");
  }

  const db = getFirestore();
  await db.doc(`users/${uid}`).delete();
  await getAuth().deleteUser(uid);

  logger.info(`Deleted account and data for ${uid}.`);
  return { deleted: true };
});
