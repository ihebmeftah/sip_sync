import 'package:sip_sync_client/sip_sync_client.dart';

/// Talks to [EndpointBuilding] for the management app.
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
    required List<UuidValue> employeeAuthUserIds,
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
        employeeAuthUserIds: employeeAuthUserIds,
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
    required List<UuidValue> employeeAuthUserIds,
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
        employeeAuthUserIds: employeeAuthUserIds,
      ),
    );
  }

  Future<List<EmployeeView>> listEmployees(UuidValue buildingId) {
    return _client.building.listEmployees(buildingId);
  }
}
