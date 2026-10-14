import '../di/app_session_store.dart';

/// Floor permission helpers from the signed-in session (UX only; server enforces).
class FloorAccess {
  FloorAccess._(
    this._orderCreation,
    this._orderPayment,
    this._cancelOrder,
    this._preparation,
    this._serving,
    this._consultAllOrders,
    this._reservations,
    this._cashRegister,
  );

  final bool _orderCreation;
  final bool _orderPayment;
  final bool _cancelOrder;
  final bool _preparation;
  final bool _serving;
  final bool _consultAllOrders;
  final bool _reservations;
  final bool _cashRegister;

  /// Owners get full floor powers; employees use their assigned profile.
  factory FloorAccess.fromSession(AppSessionStore session) {
    if (session.isOwner) {
      return FloorAccess._(true, true, true, true, true, true, true, true);
    }
    final access = session.employee?.access;
    if (access == null) {
      return FloorAccess._(false, false, false, false, false, false, false, false);
    }
    return FloorAccess._(
      access.orderCreation,
      access.orderPayment,
      access.cancelOrder,
      access.preparation,
      access.serving,
      access.consultAllOrders,
      access.reservations,
      access.cashRegister,
    );
  }

  bool get canCreateOrders => _orderCreation;
  bool get canPay => _orderPayment;
  bool get canCancel => _cancelOrder;
  bool get canPrepare => _preparation;
  bool get canServe => _serving;
  bool get canConsultAll => _consultAllOrders;

  /// Create, cancel, and confirm reservations. Order access does not imply this.
  bool get canManageReservations => _reservations;

  /// Open and close the cash register. Reading the open shift does not need this.
  bool get canOperateRegister => _cashRegister;
}
