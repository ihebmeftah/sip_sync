import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../packs/pack_gate.dart';
import 'auth_guard.dart';
import 'auth_support.dart';

/// Owner-only staff management for a building.
class EmployeeEndpoint extends Endpoint {
  final _auth = AuthSupport();

  @override
  bool get requireLogin => true;

  Future<EmployeeView> get(Session session, UuidValue employeeId) async {
    final ownerId = AuthGuard.requireOwner(session);
    final employee = await Employee.db.findFirstRow(
      session,
      where: (t) => t.id.equals(employeeId) & t.ownerId.equals(ownerId),
      include: Employee.include(access: EmployeeAccess.include()),
    );
    if (employee == null) {
      throw AccountException(
        message: 'Employee not found.',
        code: AccountErrorCode.notFound,
      );
    }
    return _view(employee);
  }

  Future<EmployeeView> add(Session session, EmployeeCreate request) async {
    final ownerId = AuthGuard.requireOwner(session);
    _auth.validatePassword(request.password);
    final phone = _auth.normalizePhone(request.phoneNumber);
    _auth.validatePhone(phone);
    _auth.validateName(request.firstName, request.lastName);

    final building = await Building.db.findById(session, request.buildingId);
    if (building == null || building.ownerId != ownerId) {
      throw AccountException(
        message: 'Building not found.',
        code: AccountErrorCode.notFound,
      );
    }

    await _requireAccessInBuilding(
      session,
      accessId: request.accessId,
      buildingId: request.buildingId,
    );
    final pack = await PackGate.ofBuilding(session, request.buildingId);
    final staff = await Employee.db.count(
      session,
      where: (t) => t.buildingId.equals(request.buildingId),
    );
    PackGate.requireRoom(
      max: pack.maxEmployees,
      current: staff,
      adding: 1,
    );

    final phoneHit = await Employee.db.findFirstRow(
      session,
      where: (t) => t.phoneNumber.equals(phone),
    );
    if (phoneHit != null) {
      throw AccountException(
        message: 'Phone already registered.',
        code: AccountErrorCode.phoneTaken,
      );
    }

    final username = await _auth.allocateEmployeeUsername(
      session,
      request.firstName,
      request.lastName,
    );

    final employee = await Employee.db.insertRow(
      session,
      Employee(
        ownerId: ownerId,
        buildingId: request.buildingId,
        accessId: request.accessId,
        username: username,
        phoneNumber: phone,
        firstName: request.firstName.trim(),
        lastName: request.lastName.trim(),
        passwordHash: _auth.passwords.hash(request.password),
      ),
    );
    return get(session, employee.id!);
  }

  Future<EmployeeView> update(Session session, EmployeeUpdate request) async {
    final ownerId = AuthGuard.requireOwner(session);
    final phone = _auth.normalizePhone(request.phoneNumber);
    _auth.validatePhone(phone);
    _auth.validateName(request.firstName, request.lastName);

    final employee = await Employee.db.findFirstRow(
      session,
      where: (t) => t.id.equals(request.id) & t.ownerId.equals(ownerId),
    );
    if (employee == null) {
      throw AccountException(
        message: 'Employee not found.',
        code: AccountErrorCode.notFound,
      );
    }

    await _requireAccessInBuilding(
      session,
      accessId: request.accessId,
      buildingId: employee.buildingId,
    );

    final phoneHit = await Employee.db.findFirstRow(
      session,
      where: (t) => t.phoneNumber.equals(phone) & t.id.notEquals(request.id),
    );
    if (phoneHit != null) {
      throw AccountException(
        message: 'Phone already registered.',
        code: AccountErrorCode.phoneTaken,
      );
    }
    await Employee.db.updateRow(
      session,
      employee.copyWith(
        phoneNumber: phone,
        firstName: request.firstName.trim(),
        lastName: request.lastName.trim(),
        accessId: request.accessId,
      ),
    );
    return get(session, request.id);
  }

  Future<EmployeeView> setEnabled(
    Session session,
    UuidValue employeeId,
    bool isEnabled,
  ) async {
    final ownerId = AuthGuard.requireOwner(session);
    final employee = await Employee.db.findFirstRow(
      session,
      where: (t) => t.id.equals(employeeId) & t.ownerId.equals(ownerId),
    );
    if (employee == null) {
      throw AccountException(
        message: 'Employee not found.',
        code: AccountErrorCode.notFound,
      );
    }
    await Employee.db.updateRow(
      session,
      employee.copyWith(isEnabled: isEnabled),
    );
    return get(session, employeeId);
  }

  Future<void> _requireAccessInBuilding(
    Session session, {
    required UuidValue accessId,
    required UuidValue buildingId,
  }) async {
    final access = await EmployeeAccess.db.findById(session, accessId);
    if (access == null || access.buildingId != buildingId) {
      throw AccountException(
        message: 'Access profile not found for this building.',
        code: AccountErrorCode.notFound,
      );
    }
  }

  EmployeeView _view(Employee employee) => EmployeeView(
    id: employee.id!,
    buildingId: employee.buildingId,
    ownerId: employee.ownerId,
    accessId: employee.accessId,
    accessName: employee.access?.name,
    username: employee.username,
    phoneNumber: employee.phoneNumber,
    firstName: employee.firstName,
    lastName: employee.lastName,
    isEnabled: employee.isEnabled,
  );
}
