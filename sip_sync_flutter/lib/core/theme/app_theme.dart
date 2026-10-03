import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_tokens.dart';

abstract final class AppTheme {
  static ThemeData light() => _build(
    brightness: Brightness.light,
    scheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.apricot,
      onPrimary: Color(0xFFFFF8F4),
      secondary: AppColors.moss,
      onSecondary: Color(0xFFF3FAF6),
      error: AppColors.rose,
      onError: Color(0xFFFFF8F4),
      surface: AppColors.paper,
      onSurface: AppColors.ink,
      onSurfaceVariant: AppColors.muted,
      outline: AppColors.line,
      outlineVariant: Color(0xFFF0E4DA),
      inverseSurface: AppColors.ink,
      onInverseSurface: AppColors.paper,
      inversePrimary: AppColors.clay,
      primaryContainer: AppColors.clay,
      onPrimaryContainer: AppColors.apricotDeep,
      secondaryContainer: AppColors.mist,
      onSecondaryContainer: Color(0xFF143528),
      surfaceContainerLowest: AppColors.field,
      surfaceContainerLow: AppColors.sand,
      surfaceContainerHighest: AppColors.clay,
    ),
    scaffold: AppColors.paper,
  );

  /// Kept for a later dark-mode switch. The customer app does not select it yet.
  static ThemeData dark() => _build(
    brightness: Brightness.dark,
    scheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFFFB599),
      onPrimary: AppColors.apricotDeep,
      secondary: Color(0xFF9DCFB8),
      onSecondary: Color(0xFF0E241C),
      error: Color(0xFFFFB4AB),
      onError: Color(0xFF690005),
      surface: Color(0xFF1C1512),
      onSurface: AppColors.paper,
      onSurfaceVariant: AppColors.sand,
      outline: Color(0xFF8A7468),
      outlineVariant: Color(0xFF4A3A32),
      inverseSurface: AppColors.paper,
      onInverseSurface: AppColors.ink,
      inversePrimary: AppColors.apricot,
      primaryContainer: Color(0xFF5C2A1C),
      onPrimaryContainer: AppColors.clay,
      secondaryContainer: Color(0xFF1E3A30),
      onSecondaryContainer: AppColors.mist,
      surfaceContainerLowest: Color(0xFF140F0C),
      surfaceContainerLow: Color(0xFF261C17),
      surfaceContainerHighest: Color(0xFF3A2C26),
    ),
    scaffold: const Color(0xFF1C1512),
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
          displaySmall: display.displaySmall?.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: -0.6,
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
          titleMedium: display.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        )
        .apply(bodyColor: scheme.onSurface, displayColor: scheme.onSurface);

    final radius = BorderRadius.circular(AppRadii.md);
    final label = text.labelLarge?.copyWith(fontWeight: FontWeight.w700);
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scaffold,
      textTheme: text,
      splashFactory: InkSparkle.splashFactory,
      progressIndicatorTheme: ProgressIndicatorThemeData(color: scheme.primary),
      appBarTheme: AppBarTheme(
        backgroundColor: scaffold,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: text.titleLarge,
      ),
      iconTheme: IconThemeData(color: scheme.onSurfaceVariant, size: 22),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: scheme.onSurface,
          minimumSize: const Size(44, 44),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainerLowest,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        prefixIconColor: scheme.onSurfaceVariant,
        suffixIconColor: scheme.onSurfaceVariant,
        labelStyle: text.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
        floatingLabelStyle: text.bodyMedium?.copyWith(color: scheme.primary),
        helperStyle: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
        helperMaxLines: 2,
        errorStyle: text.bodySmall?.copyWith(color: scheme.error, height: 1.3),
        errorMaxLines: 3,
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
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: scheme.error, width: 1.6),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(64, 52),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: radius),
          textStyle: label,
          elevation: 0,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.primary,
          minimumSize: const Size(48, 44),
          textStyle: text.labelLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          visualDensity: VisualDensity.compact,
          textStyle: WidgetStatePropertyAll(text.labelLarge),
          side: WidgetStatePropertyAll(
            BorderSide(color: scheme.outline),
          ),
        ),
      ),
      chipTheme: ChipThemeData(
        side: BorderSide(color: scheme.outlineVariant),
        backgroundColor: scheme.surfaceContainerLowest,
        selectedColor: scheme.primaryContainer,
        labelStyle: text.labelLarge?.copyWith(color: scheme.onSurface),
        secondaryLabelStyle: text.labelLarge?.copyWith(
          color: scheme.onPrimaryContainer,
          fontWeight: FontWeight.w700,
        ),
        showCheckmark: false,
        shape: const StadiumBorder(),
      ),
      cardTheme: CardThemeData(
        color: scheme.surfaceContainerLowest,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.lg),
          side: BorderSide(color: scheme.outlineVariant),
        ),
      ),
    );
  }
}
