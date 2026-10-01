import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/error_mapper.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../auth/view_models/auth_view_model.dart';
import '../../discover/venue_distance.dart';
import '../../discover/view_models/discover_view_model.dart';
import '../widgets/venue_map.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final _address = TextEditingController();
  var _suppressQuery = false;

  @override
  void dispose() {
    _address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    ref.listen(discoverViewModelProvider, (previous, next) {
      final place = next.place;
      if (place == null || place == previous?.place) {
        return;
      }
      final label = place.useCurrentLabel ? l10n.currentPosition : place.label;
      if (_address.text == label) {
        return;
      }
      _suppressQuery = true;
      _address.text = label;
      _suppressQuery = false;
    });

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final pane = Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              child: _HomeBody(
                address: _address,
                onQueryChanged: (value) {
                  if (_suppressQuery) {
                    return;
                  }
                  ref
                      .read(discoverViewModelProvider.notifier)
                      .onQueryChanged(value);
                },
              ),
            );
            if (constraints.maxHeight >= 640) {
              return pane;
            }
            return SingleChildScrollView(
              child: SizedBox(height: 900, child: pane),
            );
          },
        ),
      ),
    );
  }
}

class _HomeBody extends ConsumerWidget {
  const _HomeBody({required this.address, required this.onQueryChanged});

  final TextEditingController address;
  final ValueChanged<String> onQueryChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final discover = ref.watch(discoverViewModelProvider);
    final session = ref.watch(authViewModelProvider).session;
    final name = session?.firstName ?? '';
    final ranked = discover.ranked;
    final showNearbyEmpty =
        discover.place != null &&
        discover.nearbyOnly &&
        ranked.isEmpty &&
        discover.venues.isNotEmpty &&
        !discover.loadingVenues;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.welcome(name), style: text.headlineSmall),
                  Text(l10n.discoverLead, style: text.bodyLarge),
                ],
              ),
            ),
            const LocaleMenuButton(),
            IconButton(
              tooltip: l10n.signOut,
              onPressed: () =>
                  ref.read(authViewModelProvider.notifier).signOut(),
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        TextField(
          controller: address,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            labelText: l10n.placeHint,
            prefixIcon: const Icon(Icons.search),
            suffixIcon: discover.searching
                ? const Padding(
                    padding: EdgeInsets.all(12),
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : null,
          ),
          onChanged: onQueryChanged,
        ),
        const SizedBox(height: AppSpacing.sm),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: TextButton.icon(
            onPressed: discover.locating
                ? null
                : () => ref
                      .read(discoverViewModelProvider.notifier)
                      .useCurrentLocation(),
            icon: discover.locating
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.my_location),
            label: Text(l10n.useMyLocation),
          ),
        ),
        if (discover.suggestions.isNotEmpty)
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 220),
            child: Material(
              color: scheme.surfaceContainerLowest,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadii.md),
                side: BorderSide(color: scheme.outlineVariant),
              ),
              clipBehavior: Clip.antiAlias,
              child: ListView(
                shrinkWrap: true,
                children: [
                  for (final hit in discover.suggestions)
                    ListTile(
                      dense: true,
                      leading: const Icon(Icons.place_outlined),
                      title: Text(
                        hit.label,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () => ref
                          .read(discoverViewModelProvider.notifier)
                          .selectSuggestion(hit),
                    ),
                ],
              ),
            ),
          ),
        const SizedBox(height: AppSpacing.sm),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SegmentedButton<DiscoverViewMode>(
                segments: [
                  ButtonSegment(
                    value: DiscoverViewMode.list,
                    label: Text(l10n.listMode),
                    icon: const Icon(Icons.view_list_rounded),
                  ),
                  ButtonSegment(
                    value: DiscoverViewMode.map,
                    label: Text(l10n.mapMode),
                    icon: const Icon(Icons.map_outlined),
                  ),
                ],
                selected: {discover.mode},
                onSelectionChanged: (selection) {
                  ref
                      .read(discoverViewModelProvider.notifier)
                      .setMode(selection.first);
                },
              ),
              const SizedBox(width: AppSpacing.sm),
              FilterChip(
                label: Text(
                  discover.nearbyOnly ? l10n.nearbyFilter : l10n.allVenues,
                ),
                selected: discover.place != null && discover.nearbyOnly,
                onSelected: discover.place == null
                    ? null
                    : (selected) => ref
                          .read(discoverViewModelProvider.notifier)
                          .setNearbyOnly(selected),
              ),
            ],
          ),
        ),
        if (discover.place == null) ...[
          const SizedBox(height: AppSpacing.md),
          Text(l10n.setPlacePrompt, style: text.bodyMedium),
        ],
        if (discover.errorKey != null) ...[
          const SizedBox(height: AppSpacing.md),
          AppErrorBanner(message: lookupError(l10n, discover.errorKey!)),
        ],
        const SizedBox(height: AppSpacing.md),
        Expanded(
          child: discover.loadingVenues
              ? const Center(child: CircularProgressIndicator())
              : discover.venues.isEmpty
              ? _EmptyPane(
                  message: l10n.noVenues,
                  onRetry: () =>
                      ref.read(discoverViewModelProvider.notifier).loadVenues(),
                  retryLabel: l10n.retry,
                )
              : showNearbyEmpty
              ? _EmptyPane(
                  message: l10n.nearbyEmpty,
                  onRetry: () => ref
                      .read(discoverViewModelProvider.notifier)
                      .setNearbyOnly(false),
                  retryLabel: l10n.showAllVenues,
                )
              : discover.mode == DiscoverViewMode.map
              ? VenueMap(
                  ranked: ranked,
                  place: discover.place,
                  selectedId: discover.selectedId?.uuid,
                )
              : ListView.separated(
                  itemCount: ranked.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: AppSpacing.md),
                  itemBuilder: (context, index) {
                    final row = ranked[index];
                    return _VenueCard(
                      row: row,
                      selected: discover.selectedId == row.venue.id,
                      onTap: () => ref
                          .read(discoverViewModelProvider.notifier)
                          .selectVenue(row.venue.id),
                    );
                  },
                ),
        ),
      ],
    );
  }
}

class _VenueCard extends StatelessWidget {
  const _VenueCard({
    required this.row,
    required this.selected,
    required this.onTap,
  });

  final RankedVenue row;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final venue = row.venue;
    return Material(
      color: scheme.surfaceContainerLowest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.lg),
        side: BorderSide(
          color: selected ? scheme.primary : scheme.outlineVariant,
          width: selected ? 1.6 : 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadii.lg),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(child: Text(venue.name, style: text.titleLarge)),
                  if (row.distanceKm != null)
                    Text(
                      l10n.distanceKm(formatDistanceValue(row.distanceKm!)),
                      style: text.titleMedium?.copyWith(color: scheme.primary),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  Chip(label: Text(venue.type)),
                  if (row.walkMinutes != null)
                    Chip(
                      avatar: Icon(
                        Icons.directions_walk,
                        size: 18,
                        color: scheme.onSecondaryContainer,
                      ),
                      label: Text(l10n.walkAway(row.walkMinutes!)),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(venue.address, style: text.bodyMedium),
              const SizedBox(height: AppSpacing.xs),
              Text(
                l10n.hoursRange(
                  formatClock(venue.openingMinutes),
                  formatClock(venue.closingMinutes),
                ),
                style: text.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyPane extends StatelessWidget {
  const _EmptyPane({
    required this.message,
    required this.onRetry,
    required this.retryLabel,
  });

  final String message;
  final VoidCallback onRetry;
  final String retryLabel;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, textAlign: TextAlign.center, style: text.bodyLarge),
            const SizedBox(height: AppSpacing.lg),
            FilledButton(onPressed: onRetry, child: Text(retryLabel)),
          ],
        ),
      ),
    );
  }
}
