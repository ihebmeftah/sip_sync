import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'cash_register_service.dart';

/// One cash-register shift per venue.
class CashRegisterEndpoint extends Endpoint {
  final _registers = CashRegisterService();

  @override
  bool get requireLogin => true;

  /// The shift in progress, or null when the drawer is shut.
  ///
  /// Any member of [buildingId] can read it.
  Future<CashRegisterSessionView?> current(
    Session session,
    UuidValue buildingId,
  ) {
    return _registers.current(session, buildingId);
  }

  /// Opens the shift for [buildingId].
  ///
  /// The owner, or an employee with the cash-register flag, can call this.
  /// The pack must include it and the venue switch must be on.
  /// [startCash] is the counted drawer and may be omitted.
  Future<CashRegisterSessionView> open(
    Session session,
    UuidValue buildingId, {
    double? startCash,
  }) {
    return _registers.open(session, buildingId, startCash: startCash);
  }

  /// Closes [id] after its in-progress tickets are paid or cancelled.
  ///
  /// [endCash] is the counted drawer.
  ///
  /// It may be omitted only when the shift was opened without [startCash].
  Future<CashRegisterSessionView> close(
    Session session,
    UuidValue id, {
    double? endCash,
  }) {
    return _registers.close(session, id, endCash: endCash);
  }

  /// Replaces the counted amounts on [id]. The owner of that venue only.
  ///
  /// Pass null to clear an amount. Closing cash stays unset while the
  /// shift is still open. A shift with an opening count must keep a
  /// closing count once it is closed.
  Future<CashRegisterSessionView> correct(
    Session session,
    UuidValue id, {
    double? startCash,
    double? endCash,
  }) {
    return _registers.correct(
      session,
      id,
      startCash: startCash,
      endCash: endCash,
    );
  }

  /// Shifts for [buildingId], newest first. Twenty per page.
  ///
  /// [openedFrom] inclusive and [openedTo] exclusive limit history to the
  /// shifts that started in that window. Omit both to list every shift.
  Future<CashRegisterPage> list(
    Session session,
    UuidValue buildingId, {
    DateTime? openedFrom,
    DateTime? openedTo,
    int? limit,
    int? offset,
  }) {
    return _registers.list(
      session,
      buildingId,
      openedFrom: openedFrom,
      openedTo: openedTo,
      limit: limit,
      offset: offset,
    );
  }
}
