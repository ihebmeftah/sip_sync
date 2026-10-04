import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'platform_directory_service.dart';

/// Super-admin directory of owners and customers. No writes.
class PlatformDirectoryEndpoint extends Endpoint {
  final _directory = PlatformDirectoryService();

  @override
  bool get requireLogin => true;

  /// Owners on the platform, newest first. Super admin only.
  ///
  /// [limit] defaults to 20 and is capped at 100. [offset] skips that many rows.
  Future<PlatformPersonPage> listOwners(
    Session session, {
    int? limit,
    int? offset,
  }) {
    return _directory.listOwners(session, limit: limit, offset: offset);
  }

  /// Customers on the platform, newest first. Super admin only.
  Future<PlatformPersonPage> listCustomers(
    Session session, {
    int? limit,
    int? offset,
  }) {
    return _directory.listCustomers(session, limit: limit, offset: offset);
  }
}
