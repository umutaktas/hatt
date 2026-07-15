import 'package:flutter/material.dart';

/// Brand palette (CLAUDE.md §1: yetişkinlere hitap eden, ciddi ama motive edici;
/// hat sanatından esinlenen). Deep ink + gold, not childish.
abstract final class AppColors {
  static const ink = Color(0xFF1B2430); // primary dark (mürekkep)
  static const inkSoft = Color(0xFF2C3A4B);
  static const parchment = Color(0xFFF6EFE2); // background (kağıt)
  static const parchmentDark = Color(0xFF12171E);
  static const gold = Color(0xFFB8892B); // accent (tezhip altını)
  static const goldLight = Color(0xFFD8B15A);
  static const teal = Color(0xFF2E7D74); // secondary (çini)
  static const success = Color(0xFF3E8E5A);
  static const error = Color(0xFFB3452F);
  static const heart = Color(0xFFD64545);
  static const locked = Color(0xFF9AA5B1);
}
