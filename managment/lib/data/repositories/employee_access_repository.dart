import 'package:sip_sync_client/sip_sync_client.dart';

import '../../core/paging/list_paging.dart';

/// Owner CRUD for building-scoped employee access profiles.
class EmployeeAccessRepository {
  EmployeeAccessRepository(this._client);

  final Client _client;

  Future<EmployeeAccessPage> list(
    UuidValue buildingId, {
    int? limit,
    int? offset,
  }) => _client.employeeAccess.list(buildingId, limit: limit, offset: offset);

  /// Every profile, for the employee form and edit screen.
  Future<List<EmployeeAccessView>> listAll(UuidValue buildingId) {
    return collectPages(
      load: (offset) async {
        final page = await list(buildingId, limit: 100, offset: offset);
        return (items: page.items, total: page.total);
      },
    );
  }

  Future<EmployeeAccessView> get(UuidValue id) =>
      _client.employeeAccess.get(id);

  Future<EmployeeAccessView> create({
    required UuidValue buildingId,
    required String name,
    required bool orderCreation,
    required bool orderPayment,
    required bool cancelOrder,
    required bool preparation,
    required bool serving,
    required bool consultAllOrders,
    required bool reservations,
    required bool cashRegister,
  }) {
    return _client.employeeAccess.create(
      EmployeeAccessCreate(
        buildingId: buildingId,
        name: name,
        orderCreation: orderCreation,
        orderPayment: orderPayment,
        cancelOrder: cancelOrder,
        preparation: preparation,
        serving: serving,
        consultAllOrders: consultAllOrders,
        reservations: reservations,
        cashRegister: cashRegister,
      ),
    );
  }

  Future<EmployeeAccessView> update({
    required UuidValue id,
    required String name,
    required bool orderCreation,
    required bool orderPayment,
    required bool cancelOrder,
    required bool preparation,
    required bool serving,
    required bool consultAllOrders,
    required bool reservations,
    required bool cashRegister,
  }) {
    return _client.employeeAccess.update(
      EmployeeAccessUpdate(
        id: id,
        name: name,
        orderCreation: orderCreation,
        orderPayment: orderPayment,
        cancelOrder: cancelOrder,
        preparation: preparation,
        serving: serving,
        consultAllOrders: consultAllOrders,
        reservations: reservations,
        cashRegister: cashRegister,
      ),
    );
  }

  Future<void> delete(UuidValue id) => _client.employeeAccess.delete(id);
}
