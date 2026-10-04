import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/errors/error_mapper.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../console/views/console_shell.dart';
import '../view_models/country_stats_view_model.dart';

/// Country venue counts and an OpenStreetMap of those countries.
class CountriesView extends ConsumerStatefulWidget {
  const CountriesView({super.key});

  @override
  ConsumerState<CountriesView> createState() => _CountriesViewState();
}

class _CountriesViewState extends ConsumerState<CountriesView> {
  final _map = MapController();
  var _ready = false;
  String? _selected;

  @override
  void dispose() {
    _map.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final stats = ref.watch(countryStatsViewModelProvider);
    return ConsolePage(
      title: l10n.countriesTitle,
      subtitle: l10n.countriesSubtitle,
      child: stats.when(
        loading: () => const AppScreenLoader(),
        error: (error, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppErrorBanner(message: lookupError(l10n, mapError(error).l10nKey)),
            ShadButton.outline(
              onPressed: () =>
                  ref.read(countryStatsViewModelProvider.notifier).refresh(),
              child: Text(l10n.retry),
            ),
          ],
        ),
        data: (rows) {
          if (rows.isEmpty) {
            return Text(
              l10n.empty,
              style: ShadTheme.of(context).textTheme.muted,
            );
          }
          return LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 800;
              final map = _CountryMap(
                rows: rows,
                selected: _selected,
                controller: _map,
                onReady: () {
                  _ready = true;
                  _fit(rows);
                },
                onSelect: _select,
              );
              final list = _CountryList(
                rows: rows,
                selected: _selected,
                onSelect: _select,
              );
              if (!wide) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 360, child: map),
                    const SizedBox(height: AppSpacing.lg),
                    list,
                  ],
                );
              }
              return SizedBox(
                height: 560,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(width: 300, child: list),
                    const SizedBox(width: AppSpacing.lg),
                    Expanded(child: map),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _select(CountryBuildingStat row) {
    setState(() => _selected = row.countryCode);
    if (!_ready) {
      return;
    }
    _map.move(LatLng(row.latitude, row.longitude), 6);
  }

  void _fit(List<CountryBuildingStat> rows) {
    if (!_ready || rows.isEmpty) {
      return;
    }
    if (rows.length == 1) {
      _map.move(LatLng(rows.single.latitude, rows.single.longitude), 6);
      return;
    }
    _map.fitCamera(
      CameraFit.coordinates(
        coordinates: [
          for (final row in rows) LatLng(row.latitude, row.longitude),
        ],
        padding: const EdgeInsets.all(56),
        maxZoom: 5,
      ),
    );
  }
}

class _CountryList extends StatelessWidget {
  const _CountryList({
    required this.rows,
    required this.selected,
    required this.onSelect,
  });

  final List<CountryBuildingStat> rows;
  final String? selected;
  final ValueChanged<CountryBuildingStat> onSelect;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return ListView.separated(
      itemCount: rows.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.sm),
      itemBuilder: (context, index) {
        final row = rows[index];
        final active = row.countryCode == selected;
        final theme = ShadTheme.of(context);
        return Material(
          color: active ? theme.colorScheme.accent : theme.colorScheme.card,
          borderRadius: theme.radius,
          child: InkWell(
            borderRadius: theme.radius,
            onTap: () => onSelect(row),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(row.countryName),
                        Text(row.countryCode, style: theme.textTheme.muted),
                      ],
                    ),
                  ),
                  Text(l10n.countryVenueCount(row.buildingCount)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CountryMap extends StatelessWidget {
  const _CountryMap({
    required this.rows,
    required this.selected,
    required this.controller,
    required this.onReady,
    required this.onSelect,
  });

  final List<CountryBuildingStat> rows;
  final String? selected;
  final MapController controller;
  final VoidCallback onReady;
  final ValueChanged<CountryBuildingStat> onSelect;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = ShadTheme.of(context);
    return ClipRRect(
      borderRadius: theme.radius,
      child: Stack(
        fit: StackFit.expand,
        children: [
          FlutterMap(
            mapController: controller,
            options: MapOptions(
              initialCenter: LatLng(rows.first.latitude, rows.first.longitude),
              initialZoom: 4,
              onMapReady: onReady,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'dev.sip_sync.backoffice',
              ),
              MarkerLayer(
                markers: [
                  for (final row in rows)
                    Marker(
                      point: LatLng(row.latitude, row.longitude),
                      width: 72,
                      height: 40,
                      child: GestureDetector(
                        onTap: () => onSelect(row),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: row.countryCode == selected
                                ? theme.colorScheme.primary
                                : theme.colorScheme.card,
                            borderRadius: theme.radius,
                            border: Border.all(color: theme.colorScheme.border),
                          ),
                          child: Center(
                            child: Text(
                              '${row.buildingCount}',
                              style: theme.textTheme.small.copyWith(
                                color: row.countryCode == selected
                                    ? theme.colorScheme.primaryForeground
                                    : null,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          PositionedDirectional(
            start: AppSpacing.sm,
            bottom: AppSpacing.sm,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: theme.colorScheme.card.withValues(alpha: 0.9),
                borderRadius: theme.radius,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                child: Text(l10n.osmAttribution, style: theme.textTheme.muted),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
