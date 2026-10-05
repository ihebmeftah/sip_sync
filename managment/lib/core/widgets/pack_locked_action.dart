import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';
import '../theme/app_tokens.dart';
import 'pack_catalog_sheet.dart';

/// True when [current] has filled a finite pack cap.
bool packCapReached({required int? max, required int current}) =>
    max != null && current >= max;

/// Clay chip labeled Upgrade. Sits on a locked control or the plan banner.
class PackUpgradeChip extends StatelessWidget {
  const PackUpgradeChip({super.key, this.onTap});

  /// When set, the chip itself opens the catalog. A parent tap can own it instead.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final chip = DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.tertiary,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Text(
          l10n.packUpgrade,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: scheme.onTertiary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
    if (onTap == null) {
      return chip;
    }
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: chip,
      ),
    );
  }
}

/// Dims [child] and pins an Upgrade badge when [locked].
///
/// The child's own tap is ignored. A tap anywhere on the control opens the
/// public plan catalog. When [locked] is false, [child] is shown unchanged.
class PackLockedAction extends StatelessWidget {
  const PackLockedAction({
    super.key,
    required this.locked,
    required this.child,
  });

  final bool locked;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (!locked) {
      return child;
    }
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 10, end: 4),
      child: Semantics(
        button: true,
        label: l10n.packUpgrade,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => showPackCatalog(context),
          child: Badge(
            label: Text(l10n.packUpgrade),
            backgroundColor: scheme.tertiary,
            textColor: scheme.onTertiary,
            child: IgnorePointer(child: child),
          ),
        ),
      ),
    );
  }
}

/// A switch the venue pack may refuse to turn on.
///
/// [locked] should be false when the switch is already on, so the owner can
/// still turn a capability off after a downgrade.
class PackLockedSwitch extends StatelessWidget {
  const PackLockedSwitch({
    super.key,
    required this.locked,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final bool locked;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final tile = SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: locked ? null : onChanged,
    );
    if (!locked) {
      return tile;
    }
    return PackLockedAction(locked: true, child: tile);
  }
}
