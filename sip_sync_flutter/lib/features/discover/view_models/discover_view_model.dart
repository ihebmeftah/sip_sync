import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../data/repositories/customer_discovery_repository.dart';
import '../device_location.dart';
import '../venue_distance.dart';

part 'discover_view_model.g.dart';

/// List or map on the discovery home.
enum DiscoverViewMode { list, map }

/// The place the customer typed or picked from the device.
class DiscoverPlace {
  const DiscoverPlace({
    required this.label,
    required this.latitude,
    required this.longitude,
    this.useCurrentLabel = false,
  });

  final String label;
  final double latitude;
  final double longitude;

  /// When reverse geocoding has no street, the UI shows the generic label.
  final bool useCurrentLabel;
}

class DiscoverState {
  const DiscoverState({
    this.venues = const [],
    this.place,
    this.mode = DiscoverViewMode.list,
    this.nearbyOnly = true,
    this.loadingVenues = true,
    this.locating = false,
    this.searching = false,
    this.suggestions = const [],
    this.errorKey,
    this.selectedId,
  });

  final List<CustomerVenueCard> venues;
  final DiscoverPlace? place;
  final DiscoverViewMode mode;
  final bool nearbyOnly;
  final bool loadingVenues;
  final bool locating;
  final bool searching;
  final List<PlaceHit> suggestions;
  final String? errorKey;
  final UuidValue? selectedId;

  List<RankedVenue> get ranked => rankVenues(
    venues: venues,
    originLat: place?.latitude,
    originLon: place?.longitude,
    nearbyOnly: nearbyOnly && place != null,
  );

  DiscoverState copyWith({
    List<CustomerVenueCard>? venues,
    DiscoverPlace? place,
    DiscoverViewMode? mode,
    bool? nearbyOnly,
    bool? loadingVenues,
    bool? locating,
    bool? searching,
    List<PlaceHit>? suggestions,
    String? errorKey,
    UuidValue? selectedId,
    bool clearError = false,
    bool clearPlace = false,
    bool clearSelection = false,
  }) {
    return DiscoverState(
      venues: venues ?? this.venues,
      place: clearPlace ? null : (place ?? this.place),
      mode: mode ?? this.mode,
      nearbyOnly: nearbyOnly ?? this.nearbyOnly,
      loadingVenues: loadingVenues ?? this.loadingVenues,
      locating: locating ?? this.locating,
      searching: searching ?? this.searching,
      suggestions: suggestions ?? this.suggestions,
      errorKey: clearError ? null : (errorKey ?? this.errorKey),
      selectedId: clearSelection ? null : (selectedId ?? this.selectedId),
    );
  }
}

/// Nearby venues for the signed-in customer: place, list or map, and distance.
@Riverpod(keepAlive: true)
class DiscoverViewModel extends _$DiscoverViewModel {
  CustomerDiscoveryRepository get _repository =>
      ref.read(customerDiscoveryRepositoryProvider);

  final _location = DeviceLocationReader();
  Timer? _searchDebounce;

  @override
  DiscoverState build() {
    ref.onDispose(() => _searchDebounce?.cancel());
    Future<void>.microtask(loadVenues);
    return const DiscoverState();
  }

  Future<void> loadVenues() async {
    state = state.copyWith(loadingVenues: true, clearError: true);
    try {
      final venues = await _repository.listVenues();
      state = state.copyWith(venues: venues, loadingVenues: false);
    } catch (error) {
      state = state.copyWith(
        loadingVenues: false,
        errorKey: mapError(error).l10nKey,
      );
    }
  }

  void setMode(DiscoverViewMode mode) {
    state = state.copyWith(mode: mode);
  }

  void setNearbyOnly(bool nearbyOnly) {
    state = state.copyWith(nearbyOnly: nearbyOnly);
  }

  void selectVenue(UuidValue? id) {
    state = state.copyWith(
      selectedId: id,
      clearSelection: id == null,
    );
  }

  /// Debounced address search. Clears suggestions under 3 characters.
  void onQueryChanged(String query) {
    _searchDebounce?.cancel();
    final trimmed = query.trim();
    if (trimmed.length < 3) {
      state = state.copyWith(suggestions: const [], searching: false);
      return;
    }
    _searchDebounce = Timer(const Duration(milliseconds: 500), () {
      _search(trimmed);
    });
  }

  Future<void> _search(String query) async {
    state = state.copyWith(searching: true, clearError: true);
    try {
      final hits = await _repository.searchPlaces(query);
      state = state.copyWith(suggestions: hits, searching: false);
    } catch (error) {
      state = state.copyWith(
        searching: false,
        suggestions: const [],
        errorKey: mapError(error).l10nKey,
      );
    }
  }

  void selectSuggestion(PlaceHit hit) {
    _searchDebounce?.cancel();
    state = state.copyWith(
      place: DiscoverPlace(
        label: hit.label,
        latitude: hit.latitude,
        longitude: hit.longitude,
      ),
      suggestions: const [],
      searching: false,
      clearError: true,
    );
  }

  /// Device position, then a reverse-geocoded label when Nominatim has one.
  Future<void> useCurrentLocation() async {
    state = state.copyWith(
      locating: true,
      clearError: true,
      suggestions: const [],
    );
    try {
      final position = await _location.current();
      PlaceHit? hit;
      try {
        hit = await _repository.reversePlace(
          latitude: position.latitude,
          longitude: position.longitude,
        );
      } catch (error) {
        final failure = mapError(error);
        if (failure.l10nKey != 'errorNotFound') {
          state = state.copyWith(
            locating: false,
            errorKey: failure.l10nKey,
          );
          return;
        }
      }
      state = state.copyWith(
        locating: false,
        place: DiscoverPlace(
          label: hit?.label ?? '',
          latitude: hit?.latitude ?? position.latitude,
          longitude: hit?.longitude ?? position.longitude,
          useCurrentLabel: hit == null,
        ),
      );
    } on DeviceLocationException catch (error) {
      state = state.copyWith(locating: false, errorKey: error.l10nKey);
    } catch (error) {
      state = state.copyWith(
        locating: false,
        errorKey: mapError(error).l10nKey,
      );
    }
  }
}
