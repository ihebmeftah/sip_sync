import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'venue_table_service.dart';

/// Floor table RPC for a building.
class VenueTableEndpoint extends Endpoint {
  final _tables = VenueTableService();

  @override
  bool get requireLogin => true;

  /// Lists tables for [buildingId] (owner or assigned employee).
  Future<List<VenueTableView>> list(
    Session session,
    UuidValue buildingId,
  ) {
    return _tables.listForBuilding(session, buildingId);
  }

  /// Owner creates one or more tables; numbers are assigned in sequence.
  Future<List<VenueTableView>> create(
    Session session,
    VenueTableCreate request,
  ) {
    return _tables.create(session, request);
  }

  /// Owner updates seats and active only (number cannot change).
  Future<VenueTableView> update(Session session, VenueTableUpdate request) {
    return _tables.update(session, request);
  }
}
