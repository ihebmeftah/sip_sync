import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../discover/venue_distance.dart';
import '../../discover/view_models/discover_view_model.dart';

/// OpenStreetMap of the customer's place and the ranked venues.
class VenueMap extends ConsumerStatefulWidget {
  const VenueMap({
    super.key,
    required this.ranked,
    required this.place,
    required this.selectedId,
  });

  final List<RankedVenue> ranked;
  final DiscoverPlace? place;
  final String? selectedId;

  @override
  ConsumerState<VenueMap> createState() => _VenueMapState();
}

class _VenueMapState extends ConsumerState<VenueMap> {
  final _controller = MapController();
  var _ready = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(VenueMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_cameraKey(oldWidget) != _cameraKey(widget)) {
      _fit();
    }
  }

  String _cameraKey(VenueMap map) {
    final place = map.place;
    final ids = map.ranked.map((row) => row.venue.id.uuid).join(',');
    return '${place?.latitude},${place?.longitude}|$ids';
  }

  void _fit() {
    if (!_ready) {
      return;
    }
    final points = <LatLng>[
      if (widget.place != null)
        LatLng(widget.place!.latitude, widget.place!.longitude),
      for (final row in widget.ranked)
        LatLng(row.venue.latitude, row.venue.longitude),
    ];
    if (points.isEmpty) {
      return;
    }
    if (points.length == 1) {
      _controller.move(points.single, 14);
      return;
    }
    _controller.fitCamera(
      CameraFit.coordinates(
        coordinates: points,
        padding: const EdgeInsets.all(56),
        maxZoom: 15,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    RankedVenue? selected;
    for (final row in widget.ranked) {
      if (row.venue.id.uuid == widget.selectedId) {
        selected = row;
      }
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadii.lg),
      child: Stack(
        children: [
          FlutterMap(
            mapController: _controller,
            options: MapOptions(
              initialCenter: const LatLng(36.8065, 10.1815),
              initialZoom: 12,
              onMapReady: () {
                _ready = true;
                _fit();
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'dev.sip_sync.customer',
              ),
              MarkerLayer(
                markers: [
                  if (widget.place != null)
                    Marker(
                      point: LatLng(
                        widget.place!.latitude,
                        widget.place!.longitude,
                      ),
                      width: 22,
                      height: 22,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: scheme.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: scheme.onPrimary, width: 3),
                        ),
                      ),
                    ),
                  for (final row in widget.ranked)
                    Marker(
                      point: LatLng(row.venue.latitude, row.venue.longitude),
                      width: 44,
                      height: 44,
                      alignment: Alignment.topCenter,
                      child: GestureDetector(
                        onTap: () => ref
                            .read(discoverViewModelProvider.notifier)
                            .selectVenue(row.venue.id),
                        child: Icon(
                          Icons.location_on,
                          size: 40,
                          color: row.venue.id.uuid == widget.selectedId
                              ? scheme.primary
                              : AppColors.espresso,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          Align(
            alignment: AlignmentDirectional.topStart,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: scheme.surface.withValues(alpha: 0.88),
                  borderRadius: BorderRadius.circular(AppRadii.sm),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs,
                  ),
                  child: Text(l10n.osmAttribution, style: text.labelSmall),
                ),
              ),
            ),
          ),
          if (selected != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md,
                  0,
                  AppSpacing.md,
                  36,
                ),
                child: Material(
                  color: scheme.surfaceContainerLowest,
                  elevation: 2,
                  borderRadius: BorderRadius.circular(AppRadii.md),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                selected.venue.name,
                                style: text.titleMedium,
                              ),
                              Text(
                                selected.venue.address,
                                style: text.bodyMedium,
                              ),
                              if (selected.distanceKm != null)
                                Text(
                                  '${l10n.distanceKm(formatDistanceValue(selected.distanceKm!))} · ${l10n.walkAway(selected.walkMinutes!)}',
                                  style: text.labelLarge?.copyWith(
                                    color: scheme.primary,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => ref
                              .read(discoverViewModelProvider.notifier)
                              .selectVenue(null),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
