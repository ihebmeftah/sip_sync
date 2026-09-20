import 'package:sip_sync_client/sip_sync_client.dart';

class BuildingRepository {
  BuildingRepository(this._client);

  final Client _client;

  Future<List<BuildingView>> listMine() => _client.building.listMine();

  Future<BuildingView> get(UuidValue id) => _client.building.get(id);

  Future<BuildingView> create({
    required String name,
    required String type,
    required String address,
    required double latitude,
    required double longitude,
    required int openingMinutes,
    required int closingMinutes,
    required String currencyCode,
    required bool tableMultiOrder,
    required bool allowAppendingItemsToOrder,
    required bool strictMode,
    required List<StrictModeStep> strictModeSteps,
  }) {
    return _client.building.create(
      BuildingCreate(
        name: name,
        type: type,
        address: address,
        latitude: latitude,
        longitude: longitude,
        openingMinutes: openingMinutes,
        closingMinutes: closingMinutes,
        currencyCode: currencyCode,
        tableMultiOrder: tableMultiOrder,
        allowAppendingItemsToOrder: allowAppendingItemsToOrder,
        strictMode: strictMode,
        strictModeSteps: strictModeSteps,
      ),
    );
  }

  Future<BuildingView> update({
    required UuidValue id,
    required String name,
    required String type,
    required String address,
    required double latitude,
    required double longitude,
    required int openingMinutes,
    required int closingMinutes,
    required String currencyCode,
    required bool tableMultiOrder,
    required bool allowAppendingItemsToOrder,
    required bool strictMode,
    required List<StrictModeStep> strictModeSteps,
  }) {
    return _client.building.update(
      BuildingUpdate(
        id: id,
        name: name,
        type: type,
        address: address,
        latitude: latitude,
        longitude: longitude,
        openingMinutes: openingMinutes,
        closingMinutes: closingMinutes,
        currencyCode: currencyCode,
        tableMultiOrder: tableMultiOrder,
        allowAppendingItemsToOrder: allowAppendingItemsToOrder,
        strictMode: strictMode,
        strictModeSteps: strictModeSteps,
      ),
    );
  }

  Future<List<EmployeeView>> listEmployees(UuidValue buildingId) {
    return _client.building.listEmployees(buildingId);
  }
}
