import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_tokens.dart';

abstract final class AppTheme {
  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.brass,
      brightness: Brightness.light,
      primary: AppColors.slate,
      secondary: AppColors.brass,
      surface: AppColors.steam,
    );
    return ThemeData(
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.steam,
      textTheme: GoogleFonts.ibmPlexSansTextTheme().apply(
        bodyColor: AppColors.ink,
        displayColor: AppColors.slate,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.slate,
        foregroundColor: AppColors.steam,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.slate,
          foregroundColor: AppColors.brass,
        ),
      ),
    );
  }

  static ThemeData dark() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.brass,
        brightness: Brightness.dark,
      ),
      textTheme: GoogleFonts.ibmPlexSansTextTheme(ThemeData.dark().textTheme),
    );
  }
}
