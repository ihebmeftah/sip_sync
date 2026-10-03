// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_detail_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Public venue page: free tables and the busiest categories and articles.

@ProviderFor(VenueDetailViewModel)
const venueDetailViewModelProvider = VenueDetailViewModelFamily._();

/// Public venue page: free tables and the busiest categories and articles.
final class VenueDetailViewModelProvider
    extends $AsyncNotifierProvider<VenueDetailViewModel, CustomerVenueDetail> {
  /// Public venue page: free tables and the busiest categories and articles.
  const VenueDetailViewModelProvider._({
    required VenueDetailViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'venueDetailViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$venueDetailViewModelHash();

  @override
  String toString() {
    return r'venueDetailViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  VenueDetailViewModel create() => VenueDetailViewModel();

  @override
  bool operator ==(Object other) {
    return other is VenueDetailViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$venueDetailViewModelHash() =>
    r'8eadf63f7b13cf170c337861d5ae9cb891855dff';

/// Public venue page: free tables and the busiest categories and articles.

final class VenueDetailViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          VenueDetailViewModel,
          AsyncValue<CustomerVenueDetail>,
          CustomerVenueDetail,
          FutureOr<CustomerVenueDetail>,
          String
        > {
  const VenueDetailViewModelFamily._()
    : super(
        retry: null,
        name: r'venueDetailViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Public venue page: free tables and the busiest categories and articles.

  VenueDetailViewModelProvider call(String buildingId) =>
      VenueDetailViewModelProvider._(argument: buildingId, from: this);

  @override
  String toString() => r'venueDetailViewModelProvider';
}

/// Public venue page: free tables and the busiest categories and articles.

abstract class _$VenueDetailViewModel
    extends $AsyncNotifier<CustomerVenueDetail> {
  late final _$args = ref.$arg as String;
  String get buildingId => _$args;

  FutureOr<CustomerVenueDetail> build(String buildingId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref as $Ref<AsyncValue<CustomerVenueDetail>, CustomerVenueDetail>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CustomerVenueDetail>, CustomerVenueDetail>,
              AsyncValue<CustomerVenueDetail>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
