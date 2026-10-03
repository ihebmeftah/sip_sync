import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'auth_guard.dart';

/// Read-only owner and customer directory for super admins.
class PlatformDirectoryService {
  /// Every owner account, newest first. Password hashes stay on the table.
  Future<List<PlatformPersonView>> listOwners(Session session) async {
    AuthGuard.requireSuperAdmin(session);
    final rows = await Owner.db.find(
      session,
      orderBy: (t) => t.createdAt.desc(),
    );
    return rows.map(_owner).toList();
  }

  /// Every customer account, newest first. Password hashes stay on the table.
  Future<List<PlatformPersonView>> listCustomers(Session session) async {
    AuthGuard.requireSuperAdmin(session);
    final rows = await Customer.db.find(
      session,
      orderBy: (t) => t.createdAt.desc(),
    );
    return rows.map(_customer).toList();
  }

  PlatformPersonView _owner(Owner row) {
    return PlatformPersonView(
      id: row.id!,
      email: row.email,
      phoneNumber: row.phoneNumber,
      firstName: row.firstName,
      lastName: row.lastName,
      createdAt: row.createdAt,
    );
  }

  PlatformPersonView _customer(Customer row) {
    return PlatformPersonView(
      id: row.id!,
      email: row.email,
      phoneNumber: row.phoneNumber,
      firstName: row.firstName,
      lastName: row.lastName,
      createdAt: row.createdAt,
    );
  }
}
