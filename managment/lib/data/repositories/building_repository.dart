import 'package:sip_sync_client/sip_sync_client.dart';

class BuildingRepository {
  BuildingRepository(this._client);

  final Client _client;

  /// One page of venues this account can open.
  Future<BuildingPage> listMine({int? limit, int? offset}) =>
      _client.building.listMine(limit: limit, offset: offset);

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
    required String phoneNumber,
    String? whatsapp,
    String? instagram,
    String? facebook,
    required List<String> otherLinks,
    required bool tableMultiOrder,
    required bool allowAppendingItemsToOrder,
    required bool strictMode,
    required List<StrictModeStep> strictModeSteps,
    required double reservationFee,
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
        phoneNumber: phoneNumber,
        whatsapp: whatsapp,
        instagram: instagram,
        facebook: facebook,
        otherLinks: otherLinks,
        tableMultiOrder: tableMultiOrder,
        allowAppendingItemsToOrder: allowAppendingItemsToOrder,
        strictMode: strictMode,
        strictModeSteps: strictModeSteps,
        reservationFee: reservationFee,
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
    required String phoneNumber,
    String? whatsapp,
    String? instagram,
    String? facebook,
    required List<String> otherLinks,
    required bool tableMultiOrder,
    required bool allowAppendingItemsToOrder,
    required bool strictMode,
    required List<StrictModeStep> strictModeSteps,
    required double reservationFee,
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
        phoneNumber: phoneNumber,
        whatsapp: whatsapp,
        instagram: instagram,
        facebook: facebook,
        otherLinks: otherLinks,
        tableMultiOrder: tableMultiOrder,
        allowAppendingItemsToOrder: allowAppendingItemsToOrder,
        strictMode: strictMode,
        strictModeSteps: strictModeSteps,
        reservationFee: reservationFee,
      ),
    );
  }

  /// One page of staff, name order.
  Future<EmployeePage> listEmployees(
    UuidValue buildingId, {
    int? limit,
    int? offset,
  }) {
    return _client.building.listEmployees(
      buildingId,
      limit: limit,
      offset: offset,
    );
  }
}
