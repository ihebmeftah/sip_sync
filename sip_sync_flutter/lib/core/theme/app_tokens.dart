import 'package:flutter/material.dart';

/// Customer hospitality palette: cream paper, espresso type, terracotta action.
abstract final class AppColors {
  static const espresso = Color(0xFF1A0F0A);
  static const foam = Color(0xFFF7EFE4);
  static const terracotta = Color(0xFFC45C26);
  static const pistachio = Color(0xFF5C7340);
  static const ink = Color(0xFF2B2118);
  static const champagne = Color(0xFFE8C9A8);
  static const wine = Color(0xFF8B2E2E);
  static const field = Color(0xFFFFFBF6);
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
  static const sm = 12.0;
  static const md = 18.0;
  static const lg = 24.0;
  static const xl = 32.0;
}

abstract final class AppBreakpoints {
  /// Side-by-side auth / dashboard from this width up.
  static const expanded = 840.0;
  static const formMax = 440.0;
  static const pageMax = 1080.0;
}
