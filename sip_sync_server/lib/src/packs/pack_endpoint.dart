import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'pack_service.dart';

/// Catalog of commercial packs. Writes are super-admin only.
class PackEndpoint extends Endpoint {
  final _packs = PackService();

  @override
  bool get requireLogin => true;

  /// Packs, including private and disabled, sort order then name.
  ///
  /// Super admin only. [limit] defaults to 20 and is capped at 100.
  Future<PackPage> list(
    Session session, {
    int? limit,
    int? offset,
  }) {
    return _packs.list(session, limit: limit, offset: offset);
  }

  /// Enabled public packs for the apps. Any signed-in actor.
  Future<List<PackPublicView>> listPublic(Session session) {
    return _packs.listPublic(session);
  }

  /// Creates a pack. [PackCreate.code] is stored lowercase and must be unique.
  Future<PackView> create(Session session, PackCreate request) {
    return _packs.create(session, request);
  }

  /// Updates prices, flags, and capabilities.
  Future<PackView> update(Session session, PackUpdate request) {
    return _packs.update(session, request);
  }

  /// Deletes a pack that is not the system free plan and that no venue uses.
  Future<void> delete(Session session, UuidValue id) {
    return _packs.delete(session, id);
  }
}
