import 'package:flutter/material.dart';

/// Ops palette: steam linen, slate command surfaces, brass actions.
abstract final class AppColors {
  static const slate = Color(0xFF12151C);
  static const brass = Color(0xFFC6A15B);
  static const steam = Color(0xFFF3EEE4);
  static const ink = Color(0xFF1B1E24);
  static const copper = Color(0xFFB85A2A);
  static const field = Color(0xFFFFFCF7);
  static const mist = Color(0xFFD8D2C6);
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
