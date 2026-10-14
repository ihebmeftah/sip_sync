import 'package:sip_sync_client/sip_sync_client.dart';

/// Open shift and history for one venue.
class CashRegisterRepository {
  CashRegisterRepository(this._client);

  final Client _client;

  /// The shift in progress, or null when the drawer is shut.
  Future<CashRegisterSessionView?> current(UuidValue buildingId) {
    return _client.cashRegister.current(buildingId);
  }

  /// [startCash] is the counted drawer. Omit it when nobody counted.
  Future<CashRegisterSessionView> open(
    UuidValue buildingId, {
    double? startCash,
  }) {
    return _client.cashRegister.open(buildingId, startCash: startCash);
  }

  /// [endCash] is the counted drawer. Required when the shift has opening cash.
  Future<CashRegisterSessionView> close(UuidValue id, {double? endCash}) {
    return _client.cashRegister.close(id, endCash: endCash);
  }

  /// Owner correction of the counted amounts. Null clears a value.
  Future<CashRegisterSessionView> correct(
    UuidValue id, {
    double? startCash,
    double? endCash,
  }) {
    return _client.cashRegister.correct(
      id,
      startCash: startCash,
      endCash: endCash,
    );
  }

  /// [openedFrom] inclusive and [openedTo] exclusive. Omit both for every shift.
  Future<CashRegisterPage> list(
    UuidValue buildingId, {
    DateTime? openedFrom,
    DateTime? openedTo,
    int? limit,
    int? offset,
  }) {
    return _client.cashRegister.list(
      buildingId,
      openedFrom: openedFrom,
      openedTo: openedTo,
      limit: limit,
      offset: offset,
    );
  }
}
