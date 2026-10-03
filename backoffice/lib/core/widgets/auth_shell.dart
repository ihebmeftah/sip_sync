import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../l10n/generated/app_localizations.dart';
import '../theme/app_tokens.dart';
import 'app_controls.dart';

/// Light split for wide windows: quiet type on the left, the form on the right.
class AuthShell extends StatelessWidget {
  const AuthShell({super.key, required this.form});

  final Widget form;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = ShadTheme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= AppBreakpoints.expanded;
          if (!wide) {
            return SafeArea(child: _FormColumn(form: form, showBrand: true));
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 5,
                child: ColoredBox(
                  color: theme.colorScheme.card,
                  child: _Atmosphere(l10n: l10n),
                ),
              ),
              Expanded(
                flex: 4,
                child: ColoredBox(
                  color: theme.colorScheme.background,
                  child: SafeArea(child: _FormColumn(form: form)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _FormColumn extends StatelessWidget {
  const _FormColumn({required this.form, this.showBrand = false});

  final Widget form;
  final bool showBrand;

  @override
  Widget build(BuildContext context) {
    return ListView(
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
        const SizedBox(height: AppSpacing.xl),
        if (showBrand) ...[
          const _BrandMark(),
          const SizedBox(height: AppSpacing.xl),
        ],
        Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: AppBreakpoints.formMax),
            child: form,
          ),
        ),
      ],
    );
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(AppRadii.sm),
          ),
          child: SizedBox(
            width: 36,
            height: 36,
            child: Center(
              child: Text(
                'S',
                style: theme.textTheme.large.copyWith(
                  color: theme.colorScheme.primaryForeground,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Flexible(child: Text(l10n.appTitle, style: theme.textTheme.large)),
      ],
    );
  }
}

class _Atmosphere extends StatelessWidget {
  const _Atmosphere({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _BrandMark(),
            const SizedBox(height: 72),
            Text(
              l10n.atmosphereTitle,
              style: theme.textTheme.h1.copyWith(
                color: theme.colorScheme.foreground,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              l10n.atmosphereBody,
              style: theme.textTheme.lead.copyWith(
                color: theme.colorScheme.mutedForeground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
