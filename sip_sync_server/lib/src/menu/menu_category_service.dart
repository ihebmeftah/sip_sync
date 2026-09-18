import 'package:serverpod/serverpod.dart';

import '../auth/auth_guard.dart';
import '../generated/protocol.dart';

/// Building-scoped menu category CRUD.
class MenuCategoryService {
  /// Lists categories for a building the caller can access.
  Future<List<MenuCategoryView>> listForBuilding(
    Session session,
    UuidValue buildingId,
  ) async {
    await _requireBuildingAccess(session, buildingId);
    final rows = await MenuCategory.db.find(
      session,
      where: (t) => t.buildingId.equals(buildingId),
      orderBy: (t) => t.name,
    );
    return rows.map(_view).toList();
  }

  /// Owner-only create.
  Future<MenuCategoryView> create(
    Session session,
    MenuCategoryCreate request,
  ) async {
    final ownerId = AuthGuard.requireOwner(session);
    await _requireOwnedBuilding(session, ownerId, request.buildingId);
    final name = _validateName(request.name);
    final description = _normalizeDescription(request.description);
    await _assertNameAvailable(session, request.buildingId, name);

    final row = await MenuCategory.db.insertRow(
      session,
      MenuCategory(
        buildingId: request.buildingId,
        name: name,
        description: description,
      ),
    );
    return _view(row);
  }

  /// Owner-only update (name uniqueness still enforced per building).
  Future<MenuCategoryView> update(
    Session session,
    MenuCategoryUpdate request,
  ) async {
    final ownerId = AuthGuard.requireOwner(session);
    final existing = await MenuCategory.db.findById(session, request.id);
    if (existing == null) {
      throw MenuCategoryException(
        message: 'Category not found.',
        code: MenuCategoryErrorCode.notFound,
      );
    }
    await _requireOwnedBuilding(session, ownerId, existing.buildingId);
    final name = _validateName(request.name);
    final description = _normalizeDescription(request.description);
    await _assertNameAvailable(
      session,
      existing.buildingId,
      name,
      excludingId: existing.id,
    );

    final updated = await MenuCategory.db.updateRow(
      session,
      existing.copyWith(name: name, description: description),
    );
    return _view(updated);
  }

  MenuCategoryView _view(MenuCategory row) => MenuCategoryView(
    id: row.id!,
    buildingId: row.buildingId,
    name: row.name,
    description: row.description,
  );

  String _validateName(String raw) {
    final name = raw.trim();
    if (name.isEmpty || name.length > 80) {
      throw MenuCategoryException(
        message: 'Category name must be 1–80 characters.',
        code: MenuCategoryErrorCode.invalidInput,
      );
    }
    return name;
  }

  String? _normalizeDescription(String? raw) {
    if (raw == null) {
      return null;
    }
    final text = raw.trim();
    if (text.isEmpty) {
      return null;
    }
    if (text.length > 500) {
      throw MenuCategoryException(
        message: 'Description must be at most 500 characters.',
        code: MenuCategoryErrorCode.invalidInput,
      );
    }
    return text;
  }

  Future<void> _assertNameAvailable(
    Session session,
    UuidValue buildingId,
    String name, {
    UuidValue? excludingId,
  }) async {
    final clash = await MenuCategory.db.findFirstRow(
      session,
      where: (t) {
        var filter = t.buildingId.equals(buildingId) & t.name.ilike(name);
        if (excludingId != null) {
          filter = filter & t.id.notEquals(excludingId);
        }
        return filter;
      },
    );
    if (clash != null) {
      throw MenuCategoryException(
        message: 'A category with that name already exists here.',
        code: MenuCategoryErrorCode.nameTaken,
      );
    }
  }

  Future<void> _requireBuildingAccess(
    Session session,
    UuidValue buildingId,
  ) async {
    final building = await Building.db.findById(session, buildingId);
    if (building == null) {
      throw MenuCategoryException(
        message: 'Building not found.',
        code: MenuCategoryErrorCode.notFound,
      );
    }
    final ctx = AuthGuard.requireAny(session);
    if (ctx.actorType == ActorType.owner && building.ownerId == ctx.actorId) {
      return;
    }
    if (ctx.actorType == ActorType.employee) {
      final employee = await Employee.db.findById(session, ctx.actorId);
      if (employee != null && employee.buildingId == buildingId) {
        return;
      }
    }
    throw MenuCategoryException(
      message: 'Not allowed for this building.',
      code: MenuCategoryErrorCode.notAuthorized,
    );
  }

  Future<void> _requireOwnedBuilding(
    Session session,
    UuidValue ownerId,
    UuidValue buildingId,
  ) async {
    final building = await Building.db.findById(session, buildingId);
    if (building == null || building.ownerId != ownerId) {
      throw MenuCategoryException(
        message: 'Building not found.',
        code: MenuCategoryErrorCode.notFound,
      );
    }
  }
}
