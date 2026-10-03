import 'package:flutter/material.dart';

/// Light zinc tokens aligned with shadcn/ui. Dark values stay defined for a later theme switch.
abstract final class AppColors {
  static const canvas = Color(0xFFF4F4F5);
  static const card = Color(0xFFFFFFFF);
  static const ink = Color(0xFF09090B);
  static const primary = Color(0xFF18181B);
  static const muted = Color(0xFF71717A);
  static const line = Color(0xFFE4E4E7);
  static const destructive = Color(0xFFEF4444);
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
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 24.0;
}

abstract final class AppBreakpoints {
  static const expanded = 960.0;
  static const formMax = 440.0;
  static const pageMax = 1120.0;
  static const sidebar = 260.0;
}
