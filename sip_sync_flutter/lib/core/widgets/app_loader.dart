import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../theme/app_tokens.dart';

/// Centered spinner for a screen, dialog, or the next page of a list.
class AppScreenLoader extends StatelessWidget {
  const AppScreenLoader({super.key, this.compact = false});

  /// Smaller spinner for a row at the bottom of a list.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: compact ? AppSpacing.lg : AppSpacing.xxl,
      ),
      child: Center(
        child: SpinKitFadingCircle(
          color: color,
          size: compact ? 28 : 52,
        ),
      ),
    );
  }
}

/// Spinner that fills the box a button or field already gave it.
class AppBusyIndicator extends StatelessWidget {
  const AppBusyIndicator({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    final ink = color ?? Theme.of(context).colorScheme.primary;
    return LayoutBuilder(
      builder: (context, constraints) {
        final side = constraints.biggest.shortestSide;
        final size = side.isFinite && side > 0 ? side : 18.0;
        return Center(
          child: SpinKitFadingCircle(color: ink, size: size),
        );
      },
    );
  }
}
