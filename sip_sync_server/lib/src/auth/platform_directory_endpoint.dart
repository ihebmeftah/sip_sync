import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'platform_directory_service.dart';

/// Super-admin directory of owners and customers. No writes.
class PlatformDirectoryEndpoint extends Endpoint {
  final _directory = PlatformDirectoryService();

  @override
  bool get requireLogin => true;

  /// Owners on the platform, newest first. Super admin only.
  Future<List<PlatformPersonView>> listOwners(Session session) {
    return _directory.listOwners(session);
  }

  /// Customers on the platform, newest first. Super admin only.
  Future<List<PlatformPersonView>> listCustomers(Session session) {
    return _directory.listCustomers(session);
  }
}
