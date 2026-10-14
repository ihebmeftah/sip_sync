import 'package:serverpod/serverpod.dart';

import '../auth/auth_context.dart';
import '../auth/auth_guard.dart';
import '../core/page_window.dart';
import '../generated/protocol.dart';
import '../packs/pack_gate.dart';

/// Building-scoped ingredient create / list / restock / delete.
class IngredientService {
  /// Ingredients for a building the caller can access, name order.
  Future<IngredientPage> listForBuilding(
    Session session,
    UuidValue buildingId, {
    int? limit,
    int? offset,
    bool? outOfStock,
  }) async {
    await _requireBuildingAccess(session, buildingId);
    final window = PageWindow.from(limit: limit, offset: offset);
    Expression where(IngredientTable t) {
      var filter = t.buildingId.equals(buildingId);
      if (outOfStock == true) {
        filter = filter & (t.currentStock <= 0.0);
      }
      return filter;
    }

    final total = await Ingredient.db.count(session, where: where);
    final rows = await Ingredient.db.find(
      session,
      where: where,
      orderBy: (t) => t.name,
      limit: window.limit,
      offset: window.offset,
    );
    return IngredientPage(
      items: rows.map(_view).toList(),
      total: total,
      limit: window.limit,
      offset: window.offset,
    );
  }

  /// Ingredients whose current stock is zero. A positive remainder is not included.
  Future<int> outOfStockCount(Session session, UuidValue buildingId) async {
    await _requireBuildingAccess(session, buildingId);
    return Ingredient.db.count(
      session,
      where: (t) => t.buildingId.equals(buildingId) & (t.currentStock <= 0.0),
    );
  }

  /// Owner-only create.
  Future<IngredientView> create(
    Session session,
    IngredientCreate request,
  ) async {
    final ownerId = AuthGuard.requireOwner(session);
    await _requireOwnedBuilding(session, ownerId, request.buildingId);
    final name = _validateName(request.name);
    final currentStock = _validateStock(request.currentStock, field: 'current');
    final thresholdStock = _validateStock(
      request.thresholdStock,
      field: 'threshold',
    );
    await _assertNameAvailable(session, request.buildingId, name);
    final pack = await PackGate.ofBuilding(session, request.buildingId);
    PackGate.requireFeature(pack.inventory, PackFeature.inventory);
    final current = await Ingredient.db.count(
      session,
      where: (t) => t.buildingId.equals(request.buildingId),
    );
    PackGate.requireRoom(
      max: pack.maxIngredients,
      current: current,
      adding: 1,
      feature: PackFeature.ingredients,
    );

    final row = await Ingredient.db.insertRow(
      session,
      Ingredient(
        buildingId: request.buildingId,
        name: name,
        unit: request.unit,
        initialStock: currentStock,
        currentStock: currentStock,
        thresholdStock: thresholdStock,
      ),
    );
    return _view(row);
  }

  /// Owner or employee adds incoming stock to an ingredient.
  Future<IngredientView> restock(
    Session session,
    IngredientRestock request,
  ) async {
    final ctx = AuthGuard.requireAny(session);
    _requireFloorActor(ctx);
    final existing = await Ingredient.db.findById(session, request.id);
    if (existing == null) {
      throw IngredientException(
        message: 'Ingredient not found.',
        code: IngredientErrorCode.notFound,
      );
    }
    await _requireBuildingAccess(session, existing.buildingId);
    final pack = await PackGate.ofBuilding(session, existing.buildingId);
    PackGate.requireFeature(pack.inventory, PackFeature.inventory);
    if (request.quantity <= 0 || request.quantity > 100000000) {
      throw IngredientException(
        message: 'Restock quantity must be greater than 0.',
        code: IngredientErrorCode.invalidInput,
      );
    }
    final next = existing.currentStock + request.quantity;
    if (next > 100000000) {
      throw IngredientException(
        message: 'Stock would exceed the maximum allowed.',
        code: IngredientErrorCode.invalidInput,
      );
    }
    // Raise capacity when restock exceeds the previous full level.
    final nextInitial = next > existing.initialStock
        ? next
        : existing.initialStock;
    final updated = await Ingredient.db.updateRow(
      session,
      existing.copyWith(currentStock: next, initialStock: nextInitial),
    );
    return _view(updated);
  }

  /// Owner-only delete.
  Future<void> delete(Session session, UuidValue id) async {
    final ownerId = AuthGuard.requireOwner(session);
    final existing = await Ingredient.db.findById(session, id);
    if (existing == null) {
      throw IngredientException(
        message: 'Ingredient not found.',
        code: IngredientErrorCode.notFound,
      );
    }
    await _requireOwnedBuilding(session, ownerId, existing.buildingId);
    final inUse = await ArticleComposition.db.count(
      session,
      where: (t) => t.ingredientId.equals(id),
    );
    if (inUse > 0) {
      throw IngredientException(
        message: 'Ingredient is used in an article composition.',
        code: IngredientErrorCode.inUse,
      );
    }
    await Ingredient.db.deleteRow(session, existing);
  }

  IngredientView _view(Ingredient row) {
    final initial = row.initialStock <= 0 ? row.currentStock : row.initialStock;
    final progress = initial <= 0
        ? (row.currentStock > 0 ? 1.0 : 0.0)
        : (row.currentStock / initial).clamp(0.0, 1.0);
    return IngredientView(
      id: row.id!,
      buildingId: row.buildingId,
      name: row.name,
      unit: row.unit,
      initialStock: row.initialStock,
      currentStock: row.currentStock,
      thresholdStock: row.thresholdStock,
      belowThreshold: row.currentStock <= row.thresholdStock,
      stockProgress: progress,
    );
  }

  String _validateName(String raw) {
    final name = raw.trim();
    if (name.isEmpty || name.length > 80) {
      throw IngredientException(
        message: 'Ingredient name must be 1–80 characters.',
        code: IngredientErrorCode.invalidInput,
      );
    }
    return name;
  }

  double _validateStock(double value, {required String field}) {
    if (value < 0 || value > 100000000) {
      throw IngredientException(
        message: 'Stock $field must be 0 or greater.',
        code: IngredientErrorCode.invalidInput,
      );
    }
    return value;
  }

  void _requireFloorActor(AuthContext ctx) {
    if (ctx.actorType != ActorType.owner &&
        ctx.actorType != ActorType.employee) {
      throw IngredientException(
        message: 'Only owners and employees can restock.',
        code: IngredientErrorCode.notAuthorized,
      );
    }
  }

  Future<void> _assertNameAvailable(
    Session session,
    UuidValue buildingId,
    String name,
  ) async {
    final clash = await Ingredient.db.findFirstRow(
      session,
      where: (t) => t.buildingId.equals(buildingId) & t.name.ilike(name),
    );
    if (clash != null) {
      throw IngredientException(
        message: 'An ingredient with that name already exists here.',
        code: IngredientErrorCode.nameTaken,
      );
    }
  }

  Future<void> _requireBuildingAccess(
    Session session,
    UuidValue buildingId,
  ) async {
    final building = await Building.db.findById(session, buildingId);
    if (building == null) {
      throw IngredientException(
        message: 'Building not found.',
        code: IngredientErrorCode.notFound,
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
    throw IngredientException(
      message: 'Not allowed for this building.',
      code: IngredientErrorCode.notAuthorized,
    );
  }

  Future<void> _requireOwnedBuilding(
    Session session,
    UuidValue ownerId,
    UuidValue buildingId,
  ) async {
    final building = await Building.db.findById(session, buildingId);
    if (building == null || building.ownerId != ownerId) {
      throw IngredientException(
        message: 'Building not found.',
        code: IngredientErrorCode.notFound,
      );
    }
  }
}
