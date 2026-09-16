import 'package:flutter/material.dart';

/// Shared ops hues: olive leaf, warm sand, clay. Light and dark only change value.
abstract final class AppColors {
  static const olive = Color(0xFF53624C);
  static const sage = Color(0xFFB7C4AE);
  static const sand = Color(0xFFA9845C);
  static const wheat = Color(0xFFD2C0A4);
  static const clay = Color(0xFFB57A5C);
  static const parchment = Color(0xFFF3F1EA);
  static const paper = Color(0xFFFAF8F3);
  static const ink = Color(0xFF2B2F2A);
  static const dusk = Color(0xFF171916);
  static const moss = Color(0xFF3E4A3A);

  /// Kept for call sites that still name the old brass/slate pair.
  static const brass = sand;
  static const slate = dusk;
  static const steam = parchment;
  static const field = paper;
  static const mist = Color(0xFFD4D0C6);
  static const copper = clay;
}

abstract final class AppSpacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 24.0;
  static const xxl = 32.0;
}

abstract final class AppRadii {
  static const sm = 10.0;
  static const md = 14.0;
  static const lg = 20.0;
  static const xl = 28.0;
}

abstract final class AppBreakpoints {
  static const expanded = 840.0;
  static const formMax = 440.0;
  static const pageMax = 1120.0;
}
