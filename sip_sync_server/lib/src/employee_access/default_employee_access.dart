import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Default access profiles created with every new building.
class DefaultEmployeeAccess {
  DefaultEmployeeAccess._();

  /// Inserts Waiter, Gerant, and Barista for [buildingId] (idempotent by name).
  static Future<void> seedForBuilding(
    Session session,
    UuidValue buildingId,
  ) async {
    for (final profile in _defaults) {
      final existing = await EmployeeAccess.db.findFirstRow(
        session,
        where: (t) =>
            t.buildingId.equals(buildingId) & t.name.equals(profile.name),
      );
      if (existing != null) {
        continue;
      }
      await EmployeeAccess.db.insertRow(
        session,
        EmployeeAccess(
          buildingId: buildingId,
          name: profile.name,
          orderCreation: profile.orderCreation,
          orderPayment: profile.orderPayment,
          cancelOrder: profile.cancelOrder,
          preparation: profile.preparation,
          serving: profile.serving,
          consultAllOrders: profile.consultAllOrders,
        ),
      );
    }
  }

  static const _defaults = <
      ({
        String name,
        bool orderCreation,
        bool orderPayment,
        bool cancelOrder,
        bool preparation,
        bool serving,
        bool consultAllOrders,
      })>[
    (
      name: 'Waiter',
      orderCreation: true,
      orderPayment: true,
      cancelOrder: true,
      preparation: false,
      serving: true,
      consultAllOrders: false,
    ),
    (
      name: 'Gerant',
      orderCreation: true,
      orderPayment: true,
      cancelOrder: true,
      preparation: true,
      serving: true,
      consultAllOrders: true,
    ),
    (
      name: 'Barista',
      orderCreation: true,
      orderPayment: false,
      cancelOrder: false,
      preparation: true,
      serving: false,
      consultAllOrders: false,
    ),
  ];
}
