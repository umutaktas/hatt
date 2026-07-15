/**
 * Hatt backend — Firebase Cloud Functions entry point (CLAUDE.md §2, §5).
 *
 * Scope is deliberately small: the app is local-first. The backend only powers
 * the weekly league and account/data deletion.
 */
import { initializeApp } from "firebase-admin/app";

initializeApp();

export { rolloverLeagues } from "./league";
export { deleteAccount } from "./account";
