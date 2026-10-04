import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/paging/list_paging.dart';
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
    this.loadingMore = false,
    this.totalVenues = 0,
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
  final bool loadingMore;
  final int totalVenues;
  final bool locating;
  final bool searching;
  final List<PlaceHit> suggestions;
  final String? errorKey;
  final UuidValue? selectedId;

  bool get hasMore => venues.length < totalVenues;

  List<RankedVenue> get ranked => rankVenues(
    venues: venues,
    originLat: place?.latitude,
    originLon: place?.longitude,
    nearbyOnly: false,
  );

  DiscoverState copyWith({
    List<CustomerVenueCard>? venues,
    DiscoverPlace? place,
    DiscoverViewMode? mode,
    bool? nearbyOnly,
    bool? loadingVenues,
    bool? loadingMore,
    int? totalVenues,
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
      loadingMore: loadingMore ?? this.loadingMore,
      totalVenues: totalVenues ?? this.totalVenues,
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
    state = state.copyWith(
      loadingVenues: true,
      venues: const [],
      totalVenues: 0,
      clearError: true,
    );
    try {
      final page = await _page(0);
      state = state.copyWith(
        venues: page.items,
        totalVenues: page.total,
        loadingVenues: false,
        loadingMore: false,
      );
    } catch (error) {
      state = state.copyWith(
        loadingVenues: false,
        errorKey: mapError(error).l10nKey,
      );
    }
  }

  /// Appends the next venues in the current place and nearby filter.
  Future<void> loadMoreVenues() async {
    if (state.loadingVenues || state.loadingMore || !state.hasMore) {
      return;
    }
    state = state.copyWith(loadingMore: true, clearError: true);
    try {
      final page = await _page(state.venues.length);
      final seen = {for (final venue in state.venues) venue.id};
      state = state.copyWith(
        venues: [
          ...state.venues,
          for (final venue in page.items)
            if (!seen.contains(venue.id)) venue,
        ],
        totalVenues: page.total,
        loadingMore: false,
      );
    } catch (error) {
      state = state.copyWith(
        loadingMore: false,
        errorKey: mapError(error).l10nKey,
      );
    }
  }

  Future<CustomerVenuePage> _page(int offset) {
    final place = state.place;
    return _repository.listVenues(
      limit: listPageSize,
      offset: offset,
      latitude: place?.latitude,
      longitude: place?.longitude,
      nearbyOnly: place != null && state.nearbyOnly,
    );
  }

  /// Drops a place or venue failure the customer has dismissed.
  void clearError() {
    if (state.errorKey == null) {
      return;
    }
    state = state.copyWith(clearError: true);
  }

  void setMode(DiscoverViewMode mode) {
    state = state.copyWith(mode: mode);
  }

  void setNearbyOnly(bool nearbyOnly) {
    state = state.copyWith(nearbyOnly: nearbyOnly);
    loadVenues();
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
    loadVenues();
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
      loadVenues();
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
