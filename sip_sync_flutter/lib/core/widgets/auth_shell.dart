import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';
import '../theme/app_tokens.dart';
import 'app_controls.dart';

/// Split daylight panel + form on wide windows; stacked hero + form on compact.
class AuthShell extends StatelessWidget {
  const AuthShell({super.key, required this.form});

  final Widget form;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            final wide = constraints.maxWidth >= AppBreakpoints.expanded;
            final l10n = AppLocalizations.of(context)!;
            if (wide) {
              return Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: _HeroPanel(l10n: l10n, expanded: true),
                  ),
                  Expanded(
                    flex: 4,
                    child: ColoredBox(
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerLowest,
                      child: _FormPane(form: form),
                    ),
                  ),
                ],
              );
            }
            return Column(
              children: [
                SizedBox(
                  height: math.min(220, constraints.maxHeight * 0.28),
                  width: double.infinity,
                  child: _HeroPanel(l10n: l10n, expanded: false),
                ),
                Expanded(
                  child: ColoredBox(
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerLowest,
                    child: _FormPane(form: form),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _FormPane extends StatelessWidget {
  const _FormPane({required this.form});

  final Widget form;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppBreakpoints.formMax),
          child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xl,
              AppSpacing.lg,
              AppSpacing.xl,
              AppSpacing.xxl,
            ),
            children: [
              const Align(
                alignment: AlignmentDirectional.centerEnd,
                child: LocaleSwitcher(),
              ),
              const SizedBox(height: AppSpacing.lg),
              form,
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroPanel extends StatelessWidget {
  const _HeroPanel({required this.l10n, required this.expanded});

  final AppLocalizations l10n;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Stack(
      fit: StackFit.expand,
      children: [
        const CustomPaint(painter: _DaylightPainter()),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.all(expanded ? AppSpacing.xxl : AppSpacing.xl),
            child: Align(
              alignment: AlignmentDirectional.bottomStart,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 460),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: scheme.surfaceContainerLowest.withValues(
                              alpha: 0.82,
                            ),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(color: scheme.outlineVariant),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.lg,
                              vertical: AppSpacing.sm,
                            ),
                            child: Text(
                              l10n.appTitle,
                              style: text.labelLarge?.copyWith(
                                color: scheme.primary,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      l10n.atmosphereTitle,
                      style: expanded ? text.displaySmall : text.headlineSmall,
                    ),
                    if (expanded) ...[
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        l10n.atmosphereBody,
                        style: text.bodyLarge?.copyWith(
                          color: scheme.onSurfaceVariant,
                          height: 1.45,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DaylightPainter extends CustomPainter {
  const _DaylightPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(rect, Paint()..color = AppColors.paper);
    canvas.drawCircle(
      Offset(size.width * 0.12, size.height * 0.08),
      size.shortestSide * 0.42,
      Paint()..color = AppColors.clay.withValues(alpha: 0.95),
    );
    canvas.drawCircle(
      Offset(size.width * 0.92, size.height * 0.92),
      size.shortestSide * 0.38,
      Paint()..color = AppColors.mist.withValues(alpha: 0.95),
    );
    canvas.drawCircle(
      Offset(size.width * 0.72, size.height * 0.28),
      size.shortestSide * 0.16,
      Paint()..color = AppColors.apricot.withValues(alpha: 0.16),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
