// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_menu_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Full customer menu for one building, in catalog order.

@ProviderFor(VenueMenuViewModel)
const venueMenuViewModelProvider = VenueMenuViewModelFamily._();

/// Full customer menu for one building, in catalog order.
final class VenueMenuViewModelProvider
    extends $AsyncNotifierProvider<VenueMenuViewModel, CustomerMenu> {
  /// Full customer menu for one building, in catalog order.
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
    r'd5dd79f098d41b02edabdf4718587c9f5fac34cc';

/// Full customer menu for one building, in catalog order.

final class VenueMenuViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          VenueMenuViewModel,
          AsyncValue<CustomerMenu>,
          CustomerMenu,
          FutureOr<CustomerMenu>,
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

  /// Full customer menu for one building, in catalog order.

  VenueMenuViewModelProvider call(String buildingId) =>
      VenueMenuViewModelProvider._(argument: buildingId, from: this);

  @override
  String toString() => r'venueMenuViewModelProvider';
}

/// Full customer menu for one building, in catalog order.

abstract class _$VenueMenuViewModel extends $AsyncNotifier<CustomerMenu> {
  late final _$args = ref.$arg as String;
  String get buildingId => _$args;

  FutureOr<CustomerMenu> build(String buildingId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<CustomerMenu>, CustomerMenu>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CustomerMenu>, CustomerMenu>,
              AsyncValue<CustomerMenu>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
