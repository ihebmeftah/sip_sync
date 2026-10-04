import 'package:serverpod/serverpod.dart';
import 'package:sip_sync_server/src/generated/protocol.dart';
import 'package:sip_sync_server/src/packs/pack_catalog.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given employee access', (sessionBuilder, endpoints) {
    Future<({dynamic ownerSession, BuildingView building})> setupOwner() async {
      final auth = await endpoints.ownerAuth.register(
        sessionBuilder,
        EmailRegisterCreate(
          email: 'access-owner@example.com',
          password: 'password1',
          phoneNumber: '+21621120001',
          firstName: 'Access',
          lastName: 'Owner',
        ),
      );
      final ownerSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          auth.owner!.id.uuid,
          {Scope('sip.owner')},
          authId: UuidValue.fromString(
            '00000000-0000-7000-8000-0000000000a1',
          ).uuid,
        ),
      );
      final building = await endpoints.building.create(
        ownerSession,
        BuildingCreate(
          name: 'Access House',
          type: 'cafe',
          address: '1 Access St',
          latitude: 36.8,
          longitude: 10.1,
          openingMinutes: 480,
          closingMinutes: 1380,
          phoneNumber: '+21671100001',
          otherLinks: const [],
          currencyCode: 'TND',
          strictModeSteps: [],
        ),
      );
      await PackCatalog.assignCode(
        sessionBuilder.build(),
        building.id,
        'floor',
      );
      final defaults = (await endpoints.employeeAccess.list(
        ownerSession,
        building.id,
      )).items;
      expect(
        defaults.map((a) => a.name).toSet(),
        containsAll(['Waiter', 'Gerant', 'Barista']),
      );
      return (ownerSession: ownerSession, building: building);
    }

    test('owner creates access and assigns to employee', () async {
      final setup = await setupOwner();
      final access = await endpoints.employeeAccess.create(
        setup.ownerSession,
        EmployeeAccessCreate(
          buildingId: setup.building.id,
          name: 'Cashier',
          orderCreation: true,
          orderPayment: true,
          cancelOrder: false,
          preparation: false,
          serving: false,
          consultAllOrders: true,
        ),
      );
      expect(access.name, 'Cashier');
      expect(access.orderPayment, isTrue);

      final listed = (await endpoints.employeeAccess.list(
        setup.ownerSession,
        setup.building.id,
      )).items;
      expect(listed.map((a) => a.id), contains(access.id));

      final employee = await endpoints.employee.add(
        setup.ownerSession,
        EmployeeCreate(
          password: 'password1',
          phoneNumber: '+21621120002',
          firstName: 'Cash',
          lastName: 'Ier',
          buildingId: setup.building.id,
          accessId: access.id,
        ),
      );
      expect(employee.accessId, access.id);
      expect(employee.accessName, 'Cashier');

      await expectLater(
        endpoints.employeeAccess.delete(setup.ownerSession, access.id),
        throwsA(
          isA<EmployeeAccessException>().having(
            (e) => e.code,
            'code',
            EmployeeAccessErrorCode.inUse,
          ),
        ),
      );
    });

    test('duplicate access name is rejected', () async {
      final setup = await setupOwner();
      await endpoints.employeeAccess.create(
        setup.ownerSession,
        EmployeeAccessCreate(
          buildingId: setup.building.id,
          name: 'Kitchen',
          orderCreation: false,
          orderPayment: false,
          cancelOrder: false,
          preparation: true,
          serving: false,
          consultAllOrders: false,
        ),
      );
      await expectLater(
        endpoints.employeeAccess.create(
          setup.ownerSession,
          EmployeeAccessCreate(
            buildingId: setup.building.id,
            name: 'kitchen',
            orderCreation: true,
            orderPayment: false,
            cancelOrder: false,
            preparation: false,
            serving: false,
            consultAllOrders: false,
          ),
        ),
        throwsA(
          isA<EmployeeAccessException>().having(
            (e) => e.code,
            'code',
            EmployeeAccessErrorCode.nameTaken,
          ),
        ),
      );
    });

    test('employee without orderCreation cannot create orders', () async {
      final setup = await setupOwner();
      final access = await endpoints.employeeAccess.create(
        setup.ownerSession,
        EmployeeAccessCreate(
          buildingId: setup.building.id,
          name: 'Viewer',
          orderCreation: false,
          orderPayment: false,
          cancelOrder: false,
          preparation: false,
          serving: false,
          consultAllOrders: true,
        ),
      );
      final employee = await endpoints.employee.add(
        setup.ownerSession,
        EmployeeCreate(
          password: 'password1',
          phoneNumber: '+21621120003',
          firstName: 'View',
          lastName: 'Only',
          buildingId: setup.building.id,
          accessId: access.id,
        ),
      );
      final staffSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          employee.id.uuid,
          {Scope('sip.employee')},
          authId: UuidValue.fromString(
            '00000000-0000-7000-8000-0000000000a2',
          ).uuid,
        ),
      );
      final category = await endpoints.menuCategory.create(
        setup.ownerSession,
        MenuCategoryCreate(
          buildingId: setup.building.id,
          name: 'Drinks',
          description: null,
        ),
      );
      final article = await endpoints.menuArticle.create(
        setup.ownerSession,
        MenuArticleCreate(
          buildingId: setup.building.id,
          categoryId: category.id,
          name: 'Tea',
          description: null,
          price: 2.0,
        ),
      );
      await expectLater(
        endpoints.order.create(
          staffSession,
          OrderCreate(
            buildingId: setup.building.id,
            venueTableId: null,
            items: [OrderItemCreateLine(articleId: article.id)],
          ),
        ),
        throwsA(
          isA<OrderException>().having(
            (e) => e.code,
            'code',
            OrderErrorCode.permissionDenied,
          ),
        ),
      );
    });
  });
}
