import 'package:flutter/material.dart';

/// Console palette: graphite panels, ice paper, cyan instrumentation.
abstract final class AppColors {
  static const graphite = Color(0xFF0B1220);
  static const cyan = Color(0xFF1EC8E0);
  static const paper = Color(0xFFF4F7FB);
  static const grid = Color(0xFF1C2740);
  static const ink = Color(0xFF101828);
  static const field = Color(0xFFFFFFFF);
  static const mist = Color(0xFFD0D7E4);
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
  static const expanded = 840.0;
  static const formMax = 440.0;
  static const pageMax = 1120.0;
}
