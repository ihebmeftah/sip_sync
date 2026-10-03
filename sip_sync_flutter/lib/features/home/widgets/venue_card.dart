import 'package:flutter/material.dart';

import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../discover/venue_distance.dart';

/// Public venue row: type, distance, address, and hours without ops fields.
class VenueCard extends StatelessWidget {
  const VenueCard({
    super.key,
    required this.row,
    required this.selected,
    this.onTap,
    this.trailing,
    this.compact = false,
    this.overlay = false,
  });

  final RankedVenue row;
  final bool selected;
  final VoidCallback? onTap;
  final Widget? trailing;

  /// Tighter padding for a selected row.
  final bool compact;

  /// Bottom-of-map sheet: one address line, no hours or walk chip.
  final bool overlay;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final venue = row.venue;
    final radius = BorderRadius.circular(AppRadii.lg);
    return Material(
      color: selected ? scheme.primaryContainer : scheme.surfaceContainerLowest,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: BorderSide(
          color: selected ? scheme.primary : scheme.outlineVariant,
          width: selected ? 1.5 : 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(
            overlay || compact ? AppSpacing.md : AppSpacing.lg,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TypeMedallion(type: venue.type),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          venue.name,
                          maxLines: overlay ? 1 : 2,
                          overflow: TextOverflow.ellipsis,
                          style: text.titleMedium,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          venueTypeLabel(l10n, venue.type),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: text.labelLarge?.copyWith(
                            color: scheme.onPrimaryContainer,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (row.distanceKm != null) ...[
                    const SizedBox(width: AppSpacing.sm),
                    _DistancePill(
                      label: l10n.distanceKm(
                        formatDistanceValue(row.distanceKm!),
                      ),
                    ),
                  ],
                  if (trailing != null) ...[
                    const SizedBox(width: AppSpacing.xs),
                    trailing!,
                  ],
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              _MetaLine(
                icon: AppIcons.place,
                label: venue.address,
                lines: overlay ? 1 : 2,
              ),
              if (!overlay) ...[
                const SizedBox(height: AppSpacing.xs),
                _MetaLine(
                  icon: AppIcons.schedule,
                  label: l10n.hoursRange(
                    formatClock(venue.openingMinutes),
                    formatClock(venue.closingMinutes),
                  ),
                  lines: 1,
                ),
                if (row.walkMinutes != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  _WalkChip(label: l10n.walkAway(row.walkMinutes!)),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}

IconData venueTypeIcon(String type) {
  return switch (type.toLowerCase()) {
    'cafe' => AppIcons.coffee,
    'restaurant' => AppIcons.restaurant,
    'lounge' => AppIcons.lounge,
    'bar' => AppIcons.bar,
    _ => AppIcons.storefront,
  };
}

String venueTypeLabel(AppLocalizations l10n, String type) {
  return switch (type.toLowerCase()) {
    'cafe' => l10n.venueTypeCafe,
    'restaurant' => l10n.venueTypeRestaurant,
    'lounge' => l10n.venueTypeLounge,
    'bar' => l10n.venueTypeBar,
    _ => type,
  };
}

class _TypeMedallion extends StatelessWidget {
  const _TypeMedallion({required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: 44,
      height: 44,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.secondaryContainer,
          borderRadius: BorderRadius.circular(AppRadii.sm),
        ),
        child: Icon(
          venueTypeIcon(type),
          size: 22,
          color: scheme.onSecondaryContainer,
        ),
      ),
    );
  }
}

class _DistancePill extends StatelessWidget {
  const _DistancePill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Text(
          label,
          maxLines: 1,
          style: text.labelLarge?.copyWith(
            color: scheme.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _MetaLine extends StatelessWidget {
  const _MetaLine({
    required this.icon,
    required this.label,
    required this.lines,
  });

  final IconData icon;
  final String label;
  final int lines;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: scheme.onSurfaceVariant),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            label,
            maxLines: lines,
            overflow: TextOverflow.ellipsis,
            style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
          ),
        ),
      ],
    );
  }
}

class _WalkChip extends StatelessWidget {
  const _WalkChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.secondaryContainer,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(AppIcons.walk, size: 16, color: scheme.onSecondaryContainer),
            const SizedBox(width: AppSpacing.xs),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: text.labelLarge?.copyWith(
                color: scheme.onSecondaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
