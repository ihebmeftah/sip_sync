import 'package:flutter/material.dart';

import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../l10n/generated/app_localizations.dart';

/// Which pane of a venue visit is on screen. Scan is an action, not a pane.
enum VenueVisitTab { overview, menu, orders, profile }

/// Bottom bar for a venue visit: overview, menu, a raised scan control, orders, profile.
class VenueVisitBar extends StatelessWidget {
  const VenueVisitBar({
    super.key,
    required this.tab,
    required this.onSelect,
    required this.onScan,
  });

  final VenueVisitTab tab;
  final ValueChanged<VenueVisitTab> onSelect;
  final VoidCallback onScan;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    return SafeArea(
      top: false,
      child: SizedBox(
        height: 78,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.surface,
                border: Border(top: BorderSide(color: scheme.outlineVariant)),
              ),
              child: SizedBox(
                height: 62,
                child: Row(
                  children: [
                    _VisitTab(
                      icon: AppIcons.explore,
                      label: l10n.venueOverview,
                      selected: tab == VenueVisitTab.overview,
                      onTap: () => onSelect(VenueVisitTab.overview),
                    ),
                    _VisitTab(
                      icon: AppIcons.menuBook,
                      label: l10n.menu,
                      selected: tab == VenueVisitTab.menu,
                      onTap: () => onSelect(VenueVisitTab.menu),
                    ),
                    const SizedBox(width: 72),
                    _VisitTab(
                      icon: AppIcons.receipt,
                      label: l10n.ordersTab,
                      selected: tab == VenueVisitTab.orders,
                      onTap: () => onSelect(VenueVisitTab.orders),
                    ),
                    _VisitTab(
                      icon: AppIcons.person,
                      label: l10n.venueProfile,
                      selected: tab == VenueVisitTab.profile,
                      onTap: () => onSelect(VenueVisitTab.profile),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              child: _ScanKnob(label: l10n.venueScan, onPressed: onScan),
            ),
          ],
        ),
      ),
    );
  }
}

class _VisitTab extends StatelessWidget {
  const _VisitTab({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final color = selected ? AppColors.apricotDeep : AppColors.muted;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 22, color: color),
              const SizedBox(height: 2),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: text.labelSmall?.copyWith(
                  color: color,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScanKnob extends StatelessWidget {
  const _ScanKnob({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: AppColors.apricot,
          elevation: 6,
          shadowColor: AppColors.apricotDeep.withValues(alpha: 0.45),
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onPressed,
            child: const SizedBox(
              width: 56,
              height: 56,
              child: Icon(AppIcons.qrScan, color: AppColors.paper, size: 28),
            ),
          ),
        ),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: text.labelSmall?.copyWith(
            color: AppColors.apricotDeep,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
