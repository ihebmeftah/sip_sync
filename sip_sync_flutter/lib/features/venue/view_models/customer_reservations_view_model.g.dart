// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_reservations_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Upcoming bookings for the signed-in customer.

@ProviderFor(MyReservations)
const myReservationsProvider = MyReservationsProvider._();

/// Upcoming bookings for the signed-in customer.
final class MyReservationsProvider
    extends $AsyncNotifierProvider<MyReservations, List<ReservationView>> {
  /// Upcoming bookings for the signed-in customer.
  const MyReservationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myReservationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myReservationsHash();

  @$internal
  @override
  MyReservations create() => MyReservations();
}

String _$myReservationsHash() => r'461fcb035bc211a3788d67cb3900e84c68279434';

/// Upcoming bookings for the signed-in customer.

abstract class _$MyReservations extends $AsyncNotifier<List<ReservationView>> {
  FutureOr<List<ReservationView>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<List<ReservationView>>, List<ReservationView>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<ReservationView>>,
                List<ReservationView>
              >,
              AsyncValue<List<ReservationView>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
