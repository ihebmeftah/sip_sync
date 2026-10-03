// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discover_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Nearby venues for the signed-in customer: place, list or map, and distance.

@ProviderFor(DiscoverViewModel)
const discoverViewModelProvider = DiscoverViewModelProvider._();

/// Nearby venues for the signed-in customer: place, list or map, and distance.
final class DiscoverViewModelProvider
    extends $NotifierProvider<DiscoverViewModel, DiscoverState> {
  /// Nearby venues for the signed-in customer: place, list or map, and distance.
  const DiscoverViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'discoverViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$discoverViewModelHash();

  @$internal
  @override
  DiscoverViewModel create() => DiscoverViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DiscoverState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DiscoverState>(value),
    );
  }
}

String _$discoverViewModelHash() => r'5d5706c4dfeaa7c5fc605711ee0b7fd103f3212d';

/// Nearby venues for the signed-in customer: place, list or map, and distance.

abstract class _$DiscoverViewModel extends $Notifier<DiscoverState> {
  DiscoverState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<DiscoverState, DiscoverState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DiscoverState, DiscoverState>,
              DiscoverState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
