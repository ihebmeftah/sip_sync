import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_tokens.dart';

abstract final class AppTheme {
  static ThemeData light() => _build(
    brightness: Brightness.light,
    scheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.graphite,
      onPrimary: Color(0xFFF4F7FB),
      secondary: AppColors.cyan,
      onSecondary: AppColors.graphite,
      error: Color(0xFFB42318),
      onError: Color(0xFFFFF7EE),
      surface: AppColors.paper,
      onSurface: AppColors.ink,
      onSurfaceVariant: Color(0xFF4A5568),
      outline: AppColors.mist,
      outlineVariant: Color(0xFFE4EAF3),
      inverseSurface: AppColors.graphite,
      onInverseSurface: Color(0xFFE8F8FC),
      inversePrimary: AppColors.cyan,
      primaryContainer: AppColors.grid,
      onPrimaryContainer: AppColors.cyan,
      secondaryContainer: Color(0xFFD7F6FB),
      onSecondaryContainer: AppColors.graphite,
      surfaceContainerLowest: AppColors.field,
      surfaceContainerLow: Color(0xFFE8EEF6),
    ),
    scaffold: AppColors.paper,
  );

  static ThemeData dark() => _build(
    brightness: Brightness.dark,
    scheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.cyan,
      onPrimary: AppColors.graphite,
      secondary: Color(0xFF7AE8F5),
      onSecondary: AppColors.graphite,
      error: Color(0xFFFFB4AB),
      onError: Color(0xFF690005),
      surface: Color(0xFF0A1018),
      onSurface: Color(0xFFE8EEF6),
      onSurfaceVariant: Color(0xFFA8B4C4),
      outline: Color(0xFF3A4658),
      outlineVariant: Color(0xFF1C2740),
      inverseSurface: AppColors.paper,
      onInverseSurface: AppColors.graphite,
      inversePrimary: AppColors.graphite,
      surfaceContainerLowest: Color(0xFF070B12),
      surfaceContainerLow: AppColors.grid,
    ),
    scaffold: const Color(0xFF0A1018),
  );

  static ThemeData _build({
    required Brightness brightness,
    required ColorScheme scheme,
    required Color scaffold,
  }) {
    final base = brightness == Brightness.light
        ? ThemeData.light(useMaterial3: true)
        : ThemeData.dark(useMaterial3: true);
    final body = GoogleFonts.ibmPlexSansTextTheme(base.textTheme);
    final display = GoogleFonts.soraTextTheme(base.textTheme);
    final text = body
        .copyWith(
          displayLarge: display.displayLarge?.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: -1,
          ),
          displayMedium: display.displayMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          headlineLarge: display.headlineLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          headlineMedium: display.headlineMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          headlineSmall: display.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          titleLarge: display.titleLarge?.copyWith(fontWeight: FontWeight.w600),
          labelSmall: GoogleFonts.ibmPlexMonoTextTheme(
            base.textTheme,
          ).labelSmall,
        )
        .apply(bodyColor: scheme.onSurface, displayColor: scheme.onSurface);

    final radius = BorderRadius.circular(AppRadii.md);
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scaffold,
      textTheme: text,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.inverseSurface,
        foregroundColor: scheme.secondary,
        elevation: 0,
        titleTextStyle: text.titleLarge?.copyWith(color: scheme.secondary),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerLowest,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(borderRadius: radius),
        enabledBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: scheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: scheme.secondary, width: 1.6),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: scheme.error),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.secondary,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.sm),
          ),
          textStyle: text.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      chipTheme: ChipThemeData(
        side: BorderSide.none,
        backgroundColor: scheme.secondaryContainer,
        labelStyle: text.labelLarge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm),
        ),
      ),
      cardTheme: CardThemeData(
        color: scheme.surfaceContainerLowest,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.lg),
          side: BorderSide(color: scheme.outlineVariant),
        ),
      ),
    );
  }
}
