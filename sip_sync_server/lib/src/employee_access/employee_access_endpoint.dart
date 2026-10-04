import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'employee_access_service.dart';

/// Owner-only RPC for building-scoped employee access profiles.
class EmployeeAccessEndpoint extends Endpoint {
  final _access = EmployeeAccessService();

  @override
  bool get requireLogin => true;

  /// Access profiles for [buildingId], name order. Owner only.
  ///
  /// [limit] defaults to 20 and is capped at 100.
  Future<EmployeeAccessPage> list(
    Session session,
    UuidValue buildingId, {
    int? limit,
    int? offset,
  }) {
    return _access.listForBuilding(
      session,
      buildingId,
      limit: limit,
      offset: offset,
    );
  }

  /// Loads one access profile.
  Future<EmployeeAccessView> get(Session session, UuidValue id) {
    return _access.get(session, id);
  }

  /// Creates a named profile with permission flags.
  Future<EmployeeAccessView> create(
    Session session,
    EmployeeAccessCreate request,
  ) {
    return _access.create(session, request);
  }

  /// Updates name and flags.
  Future<EmployeeAccessView> update(
    Session session,
    EmployeeAccessUpdate request,
  ) {
    return _access.update(session, request);
  }

  /// Deletes a profile that is not assigned to staff.
  Future<void> delete(Session session, UuidValue id) {
    return _access.delete(session, id);
  }
}
