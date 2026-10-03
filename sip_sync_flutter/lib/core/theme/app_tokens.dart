import 'package:flutter/material.dart';

/// Daylight café palette for the customer app.
///
/// Light paper and apricot stay distinct from the olive ops console and the
/// cyan admin console. A dark scheme exists for a later switch; the app
/// ships on the light scheme until then.
abstract final class AppColors {
  static const ink = Color(0xFF241C18);
  static const paper = Color(0xFFFFF8F3);
  static const field = Color(0xFFFFFFFF);
  static const apricot = Color(0xFFC45C38);
  static const apricotDeep = Color(0xFF8C3A22);
  static const clay = Color(0xFFF6DDD2);
  static const moss = Color(0xFF2F6B56);
  static const mist = Color(0xFFDCEBE4);
  static const rose = Color(0xFFB42318);
  static const line = Color(0xFFE8D9CF);
  static const muted = Color(0xFF7A685C);
  static const sand = Color(0xFFF3E6D8);
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
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
}

abstract final class AppBreakpoints {
  /// Side-by-side auth / discovery from this width up.
  static const expanded = 840.0;
  static const formMax = 440.0;
  static const pageMax = 1080.0;
}
