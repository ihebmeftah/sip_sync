import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_tokens.dart';

abstract final class AppTheme {
  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.cyan,
      brightness: Brightness.light,
      primary: AppColors.graphite,
      secondary: AppColors.cyan,
      surface: AppColors.paper,
    );
    return ThemeData(
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.paper,
      textTheme: GoogleFonts.ibmPlexMonoTextTheme().apply(
        bodyColor: AppColors.graphite,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.graphite,
        foregroundColor: AppColors.cyan,
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.cyan,
        brightness: Brightness.dark,
      ),
      textTheme: GoogleFonts.ibmPlexMonoTextTheme(ThemeData.dark().textTheme),
    );
  }
}
