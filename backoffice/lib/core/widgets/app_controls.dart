import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../l10n/generated/app_localizations.dart';
import '../di/locale_controller.dart';
import '../theme/app_tokens.dart';

class AppFilledButton extends StatelessWidget {
  const AppFilledButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.busy = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final foreground = ShadTheme.of(context).colorScheme.primaryForeground;
    return ShadButton(
      width: double.infinity,
      onPressed: busy ? null : onPressed,
      child: busy
          ? SizedBox(
              height: 16,
              width: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: foreground,
              ),
            )
          : Text(label),
    );
  }
}

/// Label above a shadcn input. Forms stay readable when the field has a value.
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    this.obscure = false,
    this.keyboardType,
    this.prefixIcon,
    this.textInputAction,
  });

  final TextEditingController controller;
  final String label;
  final bool obscure;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final TextInputAction? textInputAction;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _hidden = widget.obscure;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = ShadTheme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(widget.label, style: theme.textTheme.small),
          const SizedBox(height: AppSpacing.sm),
          ShadInput(
            controller: widget.controller,
            obscureText: _hidden,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            leading: widget.prefixIcon == null
                ? null
                : Icon(widget.prefixIcon, size: 16),
            trailing: widget.obscure
                ? Tooltip(
                    message: _hidden ? l10n.showPassword : l10n.hidePassword,
                    child: ShadIconButton.ghost(
                      icon: Icon(
                        _hidden ? LucideIcons.eye : LucideIcons.eyeOff,
                        size: 16,
                      ),
                      onPressed: () => setState(() => _hidden = !_hidden),
                    ),
                  )
                : null,
          ),
        ],
      ),
    );
  }
}

class AppErrorBanner extends StatelessWidget {
  const AppErrorBanner({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.colorScheme.destructive.withValues(alpha: 0.08),
          borderRadius: theme.radius,
          border: Border.all(
            color: theme.colorScheme.destructive.withValues(alpha: 0.35),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Text(
            message,
            style: theme.textTheme.small.copyWith(
              color: theme.colorScheme.destructive,
            ),
          ),
        ),
      ),
    );
  }
}

class AppSurfaceCard extends StatelessWidget {
  const AppSurfaceCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.card,
        borderRadius: theme.radius,
        border: Border.all(color: theme.colorScheme.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: child,
      ),
    );
  }
}

class LocaleSwitcher extends ConsumerWidget {
  const LocaleSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(localeControllerProvider);
    const locales = [Locale('en'), Locale('fr'), Locale('ar')];
    return Wrap(
      spacing: AppSpacing.sm,
      children: [
        for (final locale in locales)
          ShadButton.raw(
            variant: current.languageCode == locale.languageCode
                ? ShadButtonVariant.secondary
                : ShadButtonVariant.ghost,
            size: ShadButtonSize.sm,
            onPressed: () =>
                ref.read(localeControllerProvider.notifier).setLocale(locale),
            child: Text(locale.languageCode.toUpperCase()),
          ),
      ],
    );
  }
}

class LocaleMenuButton extends ConsumerWidget {
  const LocaleMenuButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    return PopupMenuButton<Locale>(
      tooltip: l10n.language,
      icon: const Icon(LucideIcons.languages, size: 18),
      onSelected: (locale) =>
          ref.read(localeControllerProvider.notifier).setLocale(locale),
      itemBuilder: (context) => const [
        PopupMenuItem(value: Locale('en'), child: Text('EN')),
        PopupMenuItem(value: Locale('fr'), child: Text('FR')),
        PopupMenuItem(value: Locale('ar'), child: Text('AR')),
      ],
    );
  }
}
