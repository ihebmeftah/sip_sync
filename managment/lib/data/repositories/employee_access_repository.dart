import 'package:sip_sync_client/sip_sync_client.dart';

/// Owner CRUD for building-scoped employee access profiles.
class EmployeeAccessRepository {
  EmployeeAccessRepository(this._client);

  final Client _client;

  Future<List<EmployeeAccessView>> list(UuidValue buildingId) =>
      _client.employeeAccess.list(buildingId);

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
      ),
    );
  }

  Future<void> delete(UuidValue id) => _client.employeeAccess.delete(id);
}
