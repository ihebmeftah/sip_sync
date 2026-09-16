import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_tokens.dart';

abstract final class AppTheme {
  static ThemeData light() {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.terracotta,
      brightness: Brightness.light,
      primary: AppColors.terracotta,
      surface: AppColors.foam,
      onSurface: AppColors.ink,
    );
    final display = GoogleFonts.playfairDisplayTextTheme();
    final body = GoogleFonts.sourceSans3TextTheme();
    return ThemeData(
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.foam,
      textTheme: body
          .merge(display)
          .apply(
            bodyColor: AppColors.ink,
            displayColor: AppColors.espresso,
          ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.7),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: const StadiumBorder(),
        ),
      ),
    );
  }

  static ThemeData dark() {
    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.terracotta,
      brightness: Brightness.dark,
    );
    return ThemeData(
      colorScheme: scheme,
      textTheme: GoogleFonts.sourceSans3TextTheme(ThemeData.dark().textTheme),
    );
  }
}
