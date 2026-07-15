# Audio placeholders

Short SFX (CLAUDE.md §2, §4.3). Replace these silent/placeholder files with real
assets before release. The app degrades gracefully if a file is missing.

Expected files (referenced by lib/core/audio/sound_service.dart):
- correct.mp3   — short tick on a correct answer
- wrong.mp3     — soft buzz on a wrong answer
- complete.mp3  — lesson-complete fanfare
- levelup.mp3   — level-up sting

Volume / mute is controlled from Settings (user_state.sound_enabled).
