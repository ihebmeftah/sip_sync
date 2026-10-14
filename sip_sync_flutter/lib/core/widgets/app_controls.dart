import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../di/locale_controller.dart';
import '../../l10n/generated/app_localizations.dart';
import '../theme/app_icons.dart';
import '../theme/app_tokens.dart';
import 'app_loader.dart';

/// Primary action. Stays full width unless [expand] is false.
///
/// While [busy] is true the control keeps its enabled color and ignores taps,
/// so a server round-trip does not flash a disabled grey button.
class AppFilledButton extends StatelessWidget {
  const AppFilledButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.busy = false,
    this.icon,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool busy;
  final IconData? icon;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final button = _actionButton(
      context,
      tonal: false,
      onPressed: busy ? () {} : onPressed,
      busy: busy,
      icon: icon,
      label: label,
    );
    if (!expand) {
      return button;
    }
    return SizedBox(width: double.infinity, child: button);
  }
}

/// Quieter action for secondary steps such as using the device location.
class AppTonalButton extends StatelessWidget {
  const AppTonalButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.busy = false,
    this.icon,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool busy;
  final IconData? icon;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final button = _actionButton(
      context,
      tonal: true,
      onPressed: busy ? () {} : onPressed,
      busy: busy,
      icon: icon,
      label: label,
    );
    if (!expand) {
      return button;
    }
    return SizedBox(width: double.infinity, child: button);
  }
}

Widget _actionButton(
  BuildContext context, {
  required bool tonal,
  required VoidCallback? onPressed,
  required bool busy,
  required IconData? icon,
  required String label,
}) {
  final scheme = Theme.of(context).colorScheme;
  final spinner = SizedBox(
    height: 20,
    width: 20,
    child: AppBusyIndicator(
      color: tonal ? scheme.onSecondaryContainer : scheme.onPrimary,
    ),
  );
  final text = Text(
    label,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
  );
  if (busy || icon == null) {
    final child = busy ? spinner : text;
    return tonal
        ? FilledButton.tonal(onPressed: onPressed, child: child)
        : FilledButton(onPressed: onPressed, child: child);
  }
  return tonal
      ? FilledButton.tonalIcon(
          onPressed: onPressed,
          icon: Icon(icon, size: 20),
          label: text,
        )
      : FilledButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, size: 20),
          label: text,
        );
}

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    this.obscure = false,
    this.keyboardType,
    this.prefixIcon,
    this.textInputAction,
    this.helperText,
    this.validator,
    this.onChanged,
    this.inputFormatters,
    this.compact = false,
    this.readOnly = false,
  });

  final TextEditingController controller;
  final String label;
  final bool obscure;
  final TextInputType? keyboardType;
  final IconData? prefixIcon;
  final TextInputAction? textInputAction;
  final String? helperText;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final bool compact;
  final bool readOnly;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _hidden = widget.obscure;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.only(bottom: widget.compact ? 0 : AppSpacing.lg),
      child: TextFormField(
        controller: widget.controller,
        obscureText: _hidden,
        readOnly: widget.readOnly,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        onChanged: widget.onChanged,
        inputFormatters: widget.inputFormatters,
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        decoration: InputDecoration(
          labelText: widget.label,
          helperText: widget.helperText,
          errorMaxLines: 3,
          helperMaxLines: 2,
          prefixIcon: widget.prefixIcon == null
              ? null
              : Icon(widget.prefixIcon),
          suffixIcon: widget.obscure
              ? IconButton(
                  tooltip: _hidden ? l10n.showPassword : l10n.hidePassword,
                  onPressed: () => setState(() => _hidden = !_hidden),
                  icon: Icon(
                    _hidden ? AppIcons.visibility : AppIcons.visibilityOff,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

class AppDropdownField<T> extends StatelessWidget {
  const AppDropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.compact = false,
  });

  final String label;
  final T value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: compact ? 0 : AppSpacing.lg),
      child: DropdownButtonFormField<T>(
        key: ValueKey(value),
        initialValue: value,
        isExpanded: true,
        items: items,
        onChanged: onChanged,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}

/// Inline failure from the server or a blocked action.
class AppErrorBanner extends StatelessWidget {
  const AppErrorBanner({super.key, required this.message, this.onDismiss});

  final String message;
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.error.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(AppRadii.md),
          border: Border.all(color: scheme.error.withValues(alpha: 0.28)),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.md,
            AppSpacing.sm,
            AppSpacing.xs,
            AppSpacing.sm,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Icon(AppIcons.error, size: 20, color: scheme.error),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Text(
                    message,
                    style: text.bodyMedium?.copyWith(
                      color: scheme.error,
                      height: 1.35,
                    ),
                  ),
                ),
              ),
              if (onDismiss != null)
                IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: onDismiss,
                  icon: Icon(AppIcons.close, size: 18, color: scheme.error),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Grows and shrinks when a server message appears or clears.
class AppFormMessage extends StatelessWidget {
  const AppFormMessage({super.key, required this.message, this.onDismiss});

  final String? message;
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      alignment: Alignment.topCenter,
      child: message == null
          ? const SizedBox(width: double.infinity)
          : AppErrorBanner(message: message!, onDismiss: onDismiss),
    );
  }
}

class AppSurfaceCard extends StatelessWidget {
  const AppSurfaceCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
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
    const locales = [
      Locale('en'),
      Locale('fr'),
      Locale('ar'),
    ];
    return Wrap(
      spacing: AppSpacing.sm,
      children: [
        for (final locale in locales)
          ChoiceChip(
            label: Text(locale.languageCode.toUpperCase()),
            selected: current.languageCode == locale.languageCode,
            onSelected: (_) =>
                ref.read(localeControllerProvider.notifier).setLocale(locale),
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
      icon: const Icon(AppIcons.language),
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
