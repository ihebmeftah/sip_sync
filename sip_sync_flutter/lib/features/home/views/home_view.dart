import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/error_mapper.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../auth/view_models/auth_view_model.dart';
import '../../discover/venue_distance.dart';
import '../../discover/view_models/discover_view_model.dart';
import '../../../core/paging/list_paging.dart';
import '../../venue/view_models/customer_order_view_model.dart';
import '../widgets/venue_card.dart';
import '../widgets/venue_map.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final _address = TextEditingController();
  final _searchKey = GlobalKey();
  var _suppressQuery = false;

  @override
  void dispose() {
    _address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final open = ref.watch(openCustomerOrderProvider).asData?.value;

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
            final wide = constraints.maxWidth >= AppBreakpoints.expanded;
            final tight = constraints.maxHeight < 560;
            final pane = _DiscoverPane(
              address: _address,
              searchKey: _searchKey,
              tight: tight,
              showMap: !wide,
              onQueryChanged: (value) {
                if (_suppressQuery) {
                  return;
                }
                ref
                    .read(discoverViewModelProvider.notifier)
                    .onQueryChanged(value);
              },
            );
            return Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: AppBreakpoints.pageMax,
                ),
                child: wide
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(flex: 5, child: pane),
                          VerticalDivider(
                            width: 1,
                            color: Theme.of(
                              context,
                            ).colorScheme.outlineVariant,
                          ),
                          const Expanded(flex: 6, child: _MapPane()),
                        ],
                      )
                    : pane,
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Material(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.sm,
            AppSpacing.lg,
            AppSpacing.md,
          ),
          child: Align(
            alignment: Alignment.topCenter,
            heightFactor: 1,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppBreakpoints.pageMax,
              ),
              child: AppFilledButton(
                label: l10n.scanTable,
                icon: AppIcons.qrScan,
                onPressed: open == null
                    ? () => const TableScanRoute().go(context)
                    : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DiscoverPane extends ConsumerWidget {
  const _DiscoverPane({
    required this.address,
    required this.searchKey,
    required this.tight,
    required this.showMap,
    required this.onQueryChanged,
  });

  final TextEditingController address;
  final Key searchKey;
  final bool tight;
  final bool showMap;
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
        discover.venues.isEmpty &&
        !discover.loadingVenues &&
        discover.errorKey == null;
    final banner = discover.errorKey == null
        ? null
        : lookupError(l10n, discover.errorKey!);

    final header = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.welcome(name),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: text.headlineSmall,
                  ),
                  Text(
                    l10n.discoverLead,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: text.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: l10n.orderHistory,
              onPressed: () => const OrderHistoryRoute().push(context),
              icon: const Icon(AppIcons.receipt),
            ),
            const LocaleMenuButton(),
            IconButton(
              tooltip: l10n.signOut,
              onPressed: () =>
                  ref.read(authViewModelProvider.notifier).signOut(),
              icon: const Icon(AppIcons.logout),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        TextField(
          key: searchKey,
          controller: address,
          textInputAction: TextInputAction.search,
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          decoration: InputDecoration(
            labelText: l10n.placeHint,
            prefixIcon: const Icon(AppIcons.search),
            suffixIcon: discover.searching || discover.locating
                ? const Padding(
                    padding: EdgeInsets.all(14),
                    child: SizedBox(
                      width: 18,
                      height: 18,
                      child: AppBusyIndicator(),
                    ),
                  )
                : IconButton(
                    tooltip: l10n.useMyLocation,
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      ref
                          .read(discoverViewModelProvider.notifier)
                          .useCurrentLocation();
                    },
                    icon: const Icon(AppIcons.myLocation),
                  ),
          ),
          onChanged: onQueryChanged,
        ),
        if (discover.suggestions.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.sm),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: tight ? 140 : 220),
            child: Material(
              color: scheme.surfaceContainerLowest,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadii.md),
                side: BorderSide(color: scheme.outlineVariant),
              ),
              clipBehavior: Clip.antiAlias,
              child: ListView.builder(
                itemCount: discover.suggestions.length,
                itemBuilder: (context, index) {
                  final hit = discover.suggestions[index];
                  return ListTile(
                    dense: true,
                    leading: Icon(AppIcons.place, color: scheme.primary),
                    title: Text(
                      hit.label,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      ref
                          .read(discoverViewModelProvider.notifier)
                          .selectSuggestion(hit);
                    },
                  );
                },
              ),
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.sm),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              if (showMap)
                SegmentedButton<DiscoverViewMode>(
                  segments: [
                    ButtonSegment(
                      value: DiscoverViewMode.list,
                      label: Text(l10n.listMode),
                      icon: const Icon(AppIcons.list),
                    ),
                    ButtonSegment(
                      value: DiscoverViewMode.map,
                      label: Text(l10n.mapMode),
                      icon: const Icon(AppIcons.map),
                    ),
                  ],
                  selected: {discover.mode},
                  onSelectionChanged: (selection) {
                    ref
                        .read(discoverViewModelProvider.notifier)
                        .setMode(selection.first);
                  },
                ),
              if (showMap) const SizedBox(width: AppSpacing.sm),
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
          Text(
            l10n.setPlacePrompt,
            style: text.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
          ),
        ],
        if (banner != null) ...[
          const SizedBox(height: AppSpacing.md),
          AppFormMessage(
            message: banner,
            onDismiss: () =>
                ref.read(discoverViewModelProvider.notifier).clearError(),
          ),
        ],
      ],
    );

    final results = _Results(
      loading: discover.loadingVenues,
      empty: discover.venues.isEmpty,
      nearbyEmpty: showNearbyEmpty,
      mapMode: showMap && discover.mode == DiscoverViewMode.map,
      ranked: ranked,
      place: discover.place,
      selectedId: discover.selectedId?.uuid,
    );

    final padding = const EdgeInsets.fromLTRB(
      AppSpacing.lg,
      AppSpacing.md,
      AppSpacing.lg,
      AppSpacing.md,
    );

    if (tight) {
      return ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: padding,
        children: [
          header,
          const SizedBox(height: AppSpacing.md),
          SizedBox(height: 420, child: results),
        ],
      );
    }

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          header,
          const SizedBox(height: AppSpacing.md),
          Expanded(child: results),
        ],
      ),
    );
  }
}

class _MapPane extends ConsumerWidget {
  const _MapPane();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final discover = ref.watch(discoverViewModelProvider);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      child: VenueMap(
        ranked: discover.ranked,
        place: discover.place,
        selectedId: discover.selectedId?.uuid,
      ),
    );
  }
}

class _Results extends ConsumerWidget {
  const _Results({
    required this.loading,
    required this.empty,
    required this.nearbyEmpty,
    required this.mapMode,
    required this.ranked,
    required this.place,
    required this.selectedId,
  });

  final bool loading;
  final bool empty;
  final bool nearbyEmpty;
  final bool mapMode;
  final List<RankedVenue> ranked;
  final DiscoverPlace? place;
  final String? selectedId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    if (loading) {
      return const AppScreenLoader();
    }
    if (nearbyEmpty) {
      return _EmptyPane(
        message: l10n.nearbyEmpty,
        retryLabel: l10n.showAllVenues,
        onRetry: () =>
            ref.read(discoverViewModelProvider.notifier).setNearbyOnly(false),
      );
    }
    if (empty) {
      return _EmptyPane(
        message: l10n.noVenues,
        retryLabel: l10n.retry,
        onRetry: () =>
            ref.read(discoverViewModelProvider.notifier).loadVenues(),
      );
    }
    if (mapMode) {
      return VenueMap(ranked: ranked, place: place, selectedId: selectedId);
    }
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (nearListEnd(notification)) {
          ref.read(discoverViewModelProvider.notifier).loadMoreVenues();
        }
        return false;
      },
      child: ListView.separated(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemCount: ranked.length + 1,
        separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
        itemBuilder: (context, index) {
          if (index >= ranked.length) {
            final loadingMore = ref
                .watch(discoverViewModelProvider)
                .loadingMore;
            if (!loadingMore) {
              return const SizedBox(height: AppSpacing.md);
            }
            return const AppScreenLoader(compact: true);
          }
          final row = ranked[index];
          return VenueCard(
            row: row,
            selected: selectedId == row.venue.id.uuid,
            onTap: () => VenueRoute(id: row.venue.id.uuid).go(context),
          );
        },
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
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(AppIcons.storefront, size: 36, color: scheme.primary),
              const SizedBox(height: AppSpacing.md),
              Text(
                message,
                textAlign: TextAlign.center,
                style: text.bodyLarge,
              ),
              const SizedBox(height: AppSpacing.lg),
              AppFilledButton(
                expand: false,
                icon: AppIcons.refresh,
                label: retryLabel,
                onPressed: onRetry,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
