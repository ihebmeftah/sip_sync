import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_tokens.dart';

abstract final class AppTheme {
  static ThemeData light() => _build(
    brightness: Brightness.light,
    scheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.terracotta,
      onPrimary: Color(0xFFFFF7EE),
      secondary: AppColors.pistachio,
      onSecondary: Color(0xFFF4F7EC),
      error: AppColors.wine,
      onError: Color(0xFFFFF7EE),
      surface: AppColors.foam,
      onSurface: AppColors.ink,
      onSurfaceVariant: Color(0xFF6B5748),
      outline: Color(0xFFD9C7B3),
      outlineVariant: Color(0xFFE8D5C4),
      inverseSurface: AppColors.espresso,
      onInverseSurface: AppColors.foam,
      inversePrimary: AppColors.champagne,
      primaryContainer: Color(0xFFFFD7C2),
      onPrimaryContainer: AppColors.espresso,
      secondaryContainer: Color(0xFFD7E3BE),
      onSecondaryContainer: Color(0xFF1F2A12),
      surfaceContainerLowest: AppColors.field,
      surfaceContainerLow: Color(0xFFF3E6D6),
      surfaceContainerHighest: AppColors.champagne,
    ),
    scaffold: AppColors.foam,
  );

  static ThemeData dark() => _build(
    brightness: Brightness.dark,
    scheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFE48A58),
      onPrimary: AppColors.espresso,
      secondary: Color(0xFFB5C98A),
      onSecondary: Color(0xFF1A2410),
      error: Color(0xFFFFB4AB),
      onError: Color(0xFF690005),
      surface: Color(0xFF16100C),
      onSurface: AppColors.foam,
      onSurfaceVariant: AppColors.champagne,
      outline: Color(0xFF8A7464),
      outlineVariant: Color(0xFF4A3A30),
      inverseSurface: AppColors.foam,
      onInverseSurface: AppColors.espresso,
      inversePrimary: AppColors.terracotta,
      surfaceContainerLowest: Color(0xFF110C09),
      surfaceContainerLow: Color(0xFF221710),
    ),
    scaffold: const Color(0xFF16100C),
  );

  static ThemeData _build({
    required Brightness brightness,
    required ColorScheme scheme,
    required Color scaffold,
  }) {
    final base = brightness == Brightness.light
        ? ThemeData.light(useMaterial3: true)
        : ThemeData.dark(useMaterial3: true);
    final body = GoogleFonts.figtreeTextTheme(base.textTheme);
    final display = GoogleFonts.frauncesTextTheme(base.textTheme);
    final text = body
        .copyWith(
          displayLarge: display.displayLarge?.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: -1.2,
            height: 1.05,
          ),
          displayMedium: display.displayMedium?.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: -0.8,
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
        )
        .apply(bodyColor: scheme.onSurface, displayColor: scheme.onSurface);

    final radius = BorderRadius.circular(AppRadii.md);
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scaffold,
      textTheme: text,
      appBarTheme: AppBarTheme(
        backgroundColor: scaffold,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: text.titleLarge,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerLowest,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        border: OutlineInputBorder(borderRadius: radius),
        enabledBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: scheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: scheme.primary, width: 1.6),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: scheme.error),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size.fromHeight(54),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.lg),
          ),
          textStyle: text.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.primary,
          textStyle: text.labelLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      chipTheme: ChipThemeData(
        side: BorderSide.none,
        backgroundColor: scheme.secondaryContainer,
        selectedColor: scheme.primary,
        labelStyle: text.labelLarge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
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
