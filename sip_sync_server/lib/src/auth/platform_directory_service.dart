import 'package:serverpod/serverpod.dart';

import '../core/page_window.dart';
import '../generated/protocol.dart';
import 'auth_guard.dart';

/// Read-only owner and customer directory for super admins.
class PlatformDirectoryService {
  /// Owners, newest first. Password hashes stay on the table.
  ///
  /// [limit] and [offset] are clamped by [PageWindow].
  Future<PlatformPersonPage> listOwners(
    Session session, {
    int? limit,
    int? offset,
  }) {
    return _page(
      session,
      limit: limit,
      offset: offset,
      count: () => Owner.db.count(session),
      find: (window) => Owner.db.find(
        session,
        orderBy: (t) => t.createdAt.desc(),
        limit: window.limit,
        offset: window.offset,
      ),
      map: _owner,
    );
  }

  /// Customers, newest first. Password hashes stay on the table.
  Future<PlatformPersonPage> listCustomers(
    Session session, {
    int? limit,
    int? offset,
  }) {
    return _page(
      session,
      limit: limit,
      offset: offset,
      count: () => Customer.db.count(session),
      find: (window) => Customer.db.find(
        session,
        orderBy: (t) => t.createdAt.desc(),
        limit: window.limit,
        offset: window.offset,
      ),
      map: _customer,
    );
  }

  Future<PlatformPersonPage> _page<T>(
    Session session, {
    required int? limit,
    required int? offset,
    required Future<int> Function() count,
    required Future<List<T>> Function(PageWindow window) find,
    required PlatformPersonView Function(T row) map,
  }) async {
    AuthGuard.requireSuperAdmin(session);
    final window = PageWindow.from(limit: limit, offset: offset);
    final total = await count();
    final rows = await find(window);
    return PlatformPersonPage(
      items: rows.map(map).toList(),
      total: total,
      limit: window.limit,
      offset: window.offset,
    );
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
