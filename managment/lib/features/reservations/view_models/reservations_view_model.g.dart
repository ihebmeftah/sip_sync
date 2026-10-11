// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservations_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Staff list of reservations. The server enforces who may open it.

@ProviderFor(ReservationsViewModel)
const reservationsViewModelProvider = ReservationsViewModelFamily._();

/// Staff list of reservations. The server enforces who may open it.
final class ReservationsViewModelProvider
    extends $AsyncNotifierProvider<ReservationsViewModel, ReservationDay> {
  /// Staff list of reservations. The server enforces who may open it.
  const ReservationsViewModelProvider._({
    required ReservationsViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'reservationsViewModelProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$reservationsViewModelHash();

  @override
  String toString() {
    return r'reservationsViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ReservationsViewModel create() => ReservationsViewModel();

  @override
  bool operator ==(Object other) {
    return other is ReservationsViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$reservationsViewModelHash() =>
    r'f93f929f9098d3a7c2f73745174e10c4a32f2761';

/// Staff list of reservations. The server enforces who may open it.

final class ReservationsViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          ReservationsViewModel,
          AsyncValue<ReservationDay>,
          ReservationDay,
          FutureOr<ReservationDay>,
          String
        > {
  const ReservationsViewModelFamily._()
    : super(
        retry: null,
        name: r'reservationsViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Staff list of reservations. The server enforces who may open it.

  ReservationsViewModelProvider call(String buildingId) =>
      ReservationsViewModelProvider._(argument: buildingId, from: this);

  @override
  String toString() => r'reservationsViewModelProvider';
}

/// Staff list of reservations. The server enforces who may open it.

abstract class _$ReservationsViewModel extends $AsyncNotifier<ReservationDay> {
  late final _$args = ref.$arg as String;
  String get buildingId => _$args;

  FutureOr<ReservationDay> build(String buildingId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<ReservationDay>, ReservationDay>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ReservationDay>, ReservationDay>,
              AsyncValue<ReservationDay>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
