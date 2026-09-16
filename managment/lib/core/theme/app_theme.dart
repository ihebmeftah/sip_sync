import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_tokens.dart';

abstract final class AppTheme {
  static ThemeData light() => _build(
    brightness: Brightness.light,
    scheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.olive,
      onPrimary: AppColors.paper,
      secondary: AppColors.sand,
      onSecondary: AppColors.paper,
      tertiary: AppColors.clay,
      onTertiary: AppColors.paper,
      error: Color(0xFF9C4A3C),
      onError: AppColors.paper,
      surface: AppColors.parchment,
      onSurface: AppColors.ink,
      onSurfaceVariant: Color(0xFF5C6158),
      outline: Color(0xFFD2CEC4),
      outlineVariant: Color(0xFFE6E2D8),
      inverseSurface: AppColors.moss,
      onInverseSurface: AppColors.parchment,
      inversePrimary: AppColors.sage,
      primaryContainer: Color(0xFFDCE4D6),
      onPrimaryContainer: AppColors.moss,
      secondaryContainer: Color(0xFFF0E6D8),
      onSecondaryContainer: Color(0xFF4A3A2A),
      tertiaryContainer: Color(0xFFF0DDD4),
      onTertiaryContainer: Color(0xFF4A3228),
      surfaceContainerLowest: AppColors.paper,
      surfaceContainerLow: Color(0xFFEEEBE3),
      surfaceContainer: Color(0xFFE8E4DB),
      surfaceContainerHigh: Color(0xFFE2DED4),
      surfaceContainerHighest: Color(0xFFDCD8CE),
      surfaceBright: AppColors.paper,
      surfaceDim: Color(0xFFE6E2D8),
    ),
    scaffold: AppColors.parchment,
  );

  static ThemeData dark() => _build(
    brightness: Brightness.dark,
    scheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.sage,
      onPrimary: AppColors.dusk,
      secondary: AppColors.wheat,
      onSecondary: AppColors.dusk,
      tertiary: Color(0xFFD4A890),
      onTertiary: AppColors.dusk,
      error: Color(0xFFE8B4A8),
      onError: Color(0xFF3A1C18),
      surface: Color(0xFF1C1E1A),
      onSurface: Color(0xFFE6E2D8),
      onSurfaceVariant: Color(0xFFB0ACA2),
      outline: Color(0xFF3E423A),
      outlineVariant: Color(0xFF2C302A),
      inverseSurface: Color(0xFFE6E2D8),
      onInverseSurface: AppColors.dusk,
      inversePrimary: AppColors.olive,
      primaryContainer: Color(0xFF3A4536),
      onPrimaryContainer: Color(0xFFD8E2D0),
      secondaryContainer: Color(0xFF3A3228),
      onSecondaryContainer: Color(0xFFE8DCC8),
      tertiaryContainer: Color(0xFF3A2C26),
      onTertiaryContainer: Color(0xFFF0D8CC),
      surfaceContainerLowest: Color(0xFF141612),
      surfaceContainerLow: Color(0xFF22251F),
      surfaceContainer: Color(0xFF272A24),
      surfaceContainerHigh: Color(0xFF2C2F28),
      surfaceContainerHighest: Color(0xFF343830),
      surfaceBright: Color(0xFF2C2F28),
      surfaceDim: Color(0xFF161814),
    ),
    scaffold: const Color(0xFF1C1E1A),
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
        backgroundColor: scheme.surfaceContainerHigh,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: text.titleLarge?.copyWith(color: scheme.onSurface),
        iconTheme: IconThemeData(color: scheme.onSurface),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: scheme.surfaceContainerHigh,
        surfaceTintColor: Colors.transparent,
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
          borderSide: BorderSide(color: scheme.primary, width: 1.6),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: scheme.error),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
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
        labelStyle: text.labelLarge?.copyWith(
          color: scheme.onSecondaryContainer,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm),
        ),
      ),
      cardTheme: CardThemeData(
        color: scheme.surfaceContainerLowest,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.lg),
          side: BorderSide(color: scheme.outline.withValues(alpha: 0.7)),
        ),
      ),
    );
  }
}
