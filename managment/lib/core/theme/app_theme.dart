import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_tokens.dart';

abstract final class AppTheme {
  static ThemeData light() => _build(
    brightness: Brightness.light,
    scheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.slate,
      onPrimary: AppColors.steam,
      secondary: AppColors.brass,
      onSecondary: AppColors.slate,
      error: Color(0xFFB42318),
      onError: Color(0xFFFFF7EE),
      surface: AppColors.steam,
      onSurface: AppColors.ink,
      onSurfaceVariant: Color(0xFF5C574E),
      outline: AppColors.mist,
      outlineVariant: Color(0xFFE6E0D4),
      inverseSurface: AppColors.slate,
      onInverseSurface: AppColors.steam,
      inversePrimary: AppColors.brass,
      primaryContainer: Color(0xFF2A303C),
      onPrimaryContainer: AppColors.steam,
      secondaryContainer: Color(0xFFF0E2C4),
      onSecondaryContainer: AppColors.slate,
      surfaceContainerLowest: AppColors.field,
      surfaceContainerLow: Color(0xFFEAE4D8),
    ),
    scaffold: AppColors.steam,
  );

  static ThemeData dark() => _build(
    brightness: Brightness.dark,
    scheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.brass,
      onPrimary: AppColors.slate,
      secondary: Color(0xFFE2C98A),
      onSecondary: AppColors.slate,
      error: Color(0xFFFFB4AB),
      onError: Color(0xFF690005),
      surface: Color(0xFF101318),
      onSurface: AppColors.steam,
      onSurfaceVariant: AppColors.mist,
      outline: Color(0xFF4A4E56),
      outlineVariant: Color(0xFF2A2E36),
      inverseSurface: AppColors.steam,
      onInverseSurface: AppColors.slate,
      inversePrimary: AppColors.slate,
      surfaceContainerLowest: Color(0xFF0C0E12),
      surfaceContainerLow: Color(0xFF1A1E26),
    ),
    scaffold: const Color(0xFF101318),
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
    final display = GoogleFonts.syneTextTheme(base.textTheme);
    final text = body
        .copyWith(
          displayLarge: display.displayLarge?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -1,
          ),
          displayMedium: display.displayMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
          headlineLarge: display.headlineLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
          headlineMedium: display.headlineMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
          headlineSmall: display.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
          titleLarge: display.titleLarge?.copyWith(fontWeight: FontWeight.w700),
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
        foregroundColor: scheme.onInverseSurface,
        elevation: 0,
        titleTextStyle: text.titleLarge?.copyWith(
          color: scheme.onInverseSurface,
        ),
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
          borderSide: const BorderSide(color: AppColors.brass, width: 1.6),
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
          side: BorderSide(color: scheme.outline),
        ),
      ),
    );
  }
}
