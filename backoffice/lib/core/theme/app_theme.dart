import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'app_tokens.dart';

/// Light shadcn theme for the console. [shadDark] is ready for a later switch.
abstract final class AppTheme {
  static ShadThemeData shadLight() => ShadThemeData(
    brightness: Brightness.light,
    colorScheme: const ShadZincColorScheme.light(background: AppColors.canvas),
  );

  static ShadThemeData shadDark() => ShadThemeData(
    brightness: Brightness.dark,
    colorScheme: const ShadZincColorScheme.dark(),
  );

  /// Material companion so dialogs, progress, and cards follow the shad canvas.
  static ThemeData material(ThemeData base) {
    return base.copyWith(
      dividerColor: AppColors.line,
      cardTheme: CardThemeData(
        color: AppColors.card,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
          side: const BorderSide(color: AppColors.line),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
          side: const BorderSide(color: AppColors.line),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: base.colorScheme.primary,
        linearTrackColor: AppColors.line,
      ),
    );
  }
}
