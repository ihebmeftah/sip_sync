import 'dart:math' as math;

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
                // Keep enough room for the badge + title + body on phones;
                // never steal more than ~38% from the form.
                height: math
                    .min(260.0, math.max(168.0, constraints.maxHeight * 0.32))
                    .clamp(0.0, constraints.maxHeight * 0.38)
                    .toDouble(),
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
        CustomPaint(painter: _OpsPainter(scheme: scheme)),
        LayoutBuilder(
          builder: (context, constraints) {
            final tight = !expanded && constraints.maxHeight < 200;
            final pad = expanded
                ? AppSpacing.xxl
                : (tight ? AppSpacing.md : AppSpacing.xl);
            return Padding(
              padding: EdgeInsets.all(pad),
              child: Align(
                alignment: AlignmentDirectional.bottomStart,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: AlignmentDirectional.bottomStart,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: math.min(460, constraints.maxWidth - pad * 2),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/branding/logo.png',
                          height: expanded ? 56 : (tight ? 36 : 44),
                          fit: BoxFit.contain,
                          alignment: AlignmentDirectional.centerStart,
                          semanticLabel: l10n.appTitle,
                        ),
                        SizedBox(height: tight ? AppSpacing.sm : AppSpacing.lg),
                        Text(
                          l10n.atmosphereTitle,
                          maxLines: tight ? 2 : 3,
                          overflow: TextOverflow.ellipsis,
                          style:
                              (expanded
                                      ? text.displayMedium
                                      : text.headlineSmall)
                                  ?.copyWith(color: scheme.onPrimaryContainer),
                        ),
                        SizedBox(height: tight ? AppSpacing.xs : AppSpacing.md),
                        Text(
                          l10n.atmosphereBody,
                          maxLines: tight ? 2 : 4,
                          overflow: TextOverflow.ellipsis,
                          style: text.bodyLarge?.copyWith(
                            color: scheme.onPrimaryContainer.withValues(
                              alpha: 0.82,
                            ),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _OpsPainter extends CustomPainter {
  const _OpsPainter({required this.scheme});

  final ColorScheme scheme;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(
      rect,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            scheme.primaryContainer,
            scheme.surfaceContainerHigh,
            scheme.secondaryContainer,
          ],
        ).createShader(rect),
    );
    final line = Paint()
      ..color = scheme.primary.withValues(alpha: 0.12)
      ..strokeWidth = 1;
    for (var i = -4; i < 18; i++) {
      final x = i * 48.0;
      canvas.drawLine(Offset(x, 0), Offset(x + size.height, size.height), line);
    }
    canvas.drawCircle(
      Offset(size.width * 0.82, size.height * 0.18),
      90,
      Paint()..color = scheme.secondary.withValues(alpha: 0.16),
    );
  }

  @override
  bool shouldRepaint(covariant _OpsPainter oldDelegate) =>
      oldDelegate.scheme != scheme;
}
