import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';
import '../theme/app_tokens.dart';
import 'app_controls.dart';

/// Split atmosphere + form on wide windows; stacked hero + form on compact.
class AuthShell extends StatelessWidget {
  const AuthShell({super.key, required this.form});

  final Widget form;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= AppBreakpoints.expanded;
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
                    color: Theme.of(context).colorScheme.surface,
                    child: _FormPane(form: form),
                  ),
                ),
              ],
            );
          }
          return Column(
            children: [
              SizedBox(
                height: math.min(260, constraints.maxHeight * 0.32),
                width: double.infinity,
                child: _HeroPanel(l10n: l10n, expanded: false),
              ),
              Expanded(
                child: ColoredBox(
                  color: Theme.of(context).colorScheme.surface,
                  child: _FormPane(form: form),
                ),
              ),
            ],
          );
        },
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
        const CustomPaint(painter: _OpsPainter()),
        Padding(
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
                    borderRadius: BorderRadius.circular(AppRadii.sm),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.brass.withValues(alpha: 0.16),
                          borderRadius: BorderRadius.circular(AppRadii.sm),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.lg,
                            vertical: AppSpacing.sm,
                          ),
                          child: Text(
                            l10n.appTitle,
                            style: text.labelLarge?.copyWith(
                              color: AppColors.brass,
                              letterSpacing: 1.6,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    l10n.atmosphereTitle,
                    style: (expanded ? text.displayMedium : text.headlineSmall)
                        ?.copyWith(color: scheme.onInverseSurface),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    l10n.atmosphereBody,
                    style: text.bodyLarge?.copyWith(
                      color: scheme.onInverseSurface.withValues(alpha: 0.8),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _OpsPainter extends CustomPainter {
  const _OpsPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.slate, Color(0xFF1E2430), Color(0xFF2C2418)],
        ).createShader(rect),
    );
    final line = Paint()
      ..color = AppColors.brass.withValues(alpha: 0.12)
      ..strokeWidth = 1;
    for (var i = -4; i < 18; i++) {
      final x = i * 48.0;
      canvas.drawLine(Offset(x, 0), Offset(x + size.height, size.height), line);
    }
    canvas.drawCircle(
      Offset(size.width * 0.82, size.height * 0.18),
      90,
      Paint()..color = AppColors.brass.withValues(alpha: 0.14),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
