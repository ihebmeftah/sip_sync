// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_menu_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Customer menu for one building, loaded in catalog order.

@ProviderFor(VenueMenuViewModel)
const venueMenuViewModelProvider = VenueMenuViewModelFamily._();

/// Customer menu for one building, loaded in catalog order.
final class VenueMenuViewModelProvider
    extends $AsyncNotifierProvider<VenueMenuViewModel, VenueMenuState> {
  /// Customer menu for one building, loaded in catalog order.
  const VenueMenuViewModelProvider._({
    required VenueMenuViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'venueMenuViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$venueMenuViewModelHash();

  @override
  String toString() {
    return r'venueMenuViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  VenueMenuViewModel create() => VenueMenuViewModel();

  @override
  bool operator ==(Object other) {
    return other is VenueMenuViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$venueMenuViewModelHash() =>
    r'bcbf56ce426b6f12077635c32dd4257b2871420d';

/// Customer menu for one building, loaded in catalog order.

final class VenueMenuViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          VenueMenuViewModel,
          AsyncValue<VenueMenuState>,
          VenueMenuState,
          FutureOr<VenueMenuState>,
          String
        > {
  const VenueMenuViewModelFamily._()
    : super(
        retry: null,
        name: r'venueMenuViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Customer menu for one building, loaded in catalog order.

  VenueMenuViewModelProvider call(String buildingId) =>
      VenueMenuViewModelProvider._(argument: buildingId, from: this);

  @override
  String toString() => r'venueMenuViewModelProvider';
}

/// Customer menu for one building, loaded in catalog order.

abstract class _$VenueMenuViewModel extends $AsyncNotifier<VenueMenuState> {
  late final _$args = ref.$arg as String;
  String get buildingId => _$args;

  FutureOr<VenueMenuState> build(String buildingId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<VenueMenuState>, VenueMenuState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<VenueMenuState>, VenueMenuState>,
              AsyncValue<VenueMenuState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
