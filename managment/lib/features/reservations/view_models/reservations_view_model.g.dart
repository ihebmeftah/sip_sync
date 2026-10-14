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
    r'dd8b19a898db4c67a6040e82861d0379ff8a7d16';

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

/// Open customer requests for one venue. Owners and reservation staff only.

@ProviderFor(PendingReservationCount)
const pendingReservationCountProvider = PendingReservationCountFamily._();

/// Open customer requests for one venue. Owners and reservation staff only.
final class PendingReservationCountProvider
    extends $AsyncNotifierProvider<PendingReservationCount, int> {
  /// Open customer requests for one venue. Owners and reservation staff only.
  const PendingReservationCountProvider._({
    required PendingReservationCountFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'pendingReservationCountProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$pendingReservationCountHash();

  @override
  String toString() {
    return r'pendingReservationCountProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  PendingReservationCount create() => PendingReservationCount();

  @override
  bool operator ==(Object other) {
    return other is PendingReservationCountProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$pendingReservationCountHash() =>
    r'6fe259a65e18888acb0d2953ac934f05e11be231';

/// Open customer requests for one venue. Owners and reservation staff only.

final class PendingReservationCountFamily extends $Family
    with
        $ClassFamilyOverride<
          PendingReservationCount,
          AsyncValue<int>,
          int,
          FutureOr<int>,
          String
        > {
  const PendingReservationCountFamily._()
    : super(
        retry: null,
        name: r'pendingReservationCountProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Open customer requests for one venue. Owners and reservation staff only.

  PendingReservationCountProvider call(String buildingId) =>
      PendingReservationCountProvider._(argument: buildingId, from: this);

  @override
  String toString() => r'pendingReservationCountProvider';
}

/// Open customer requests for one venue. Owners and reservation staff only.

abstract class _$PendingReservationCount extends $AsyncNotifier<int> {
  late final _$args = ref.$arg as String;
  String get buildingId => _$args;

  FutureOr<int> build(String buildingId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<int>, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<int>, int>,
              AsyncValue<int>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
