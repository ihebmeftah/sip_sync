import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
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
        username: username,
        phoneNumber: phone,
        firstName: request.firstName.trim(),
        lastName: request.lastName.trim(),
        passwordHash: _auth.passwords.hash(request.password),
      ),
    );
    return _view(employee);
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
    final phoneHit = await Employee.db.findFirstRow(
      session,
      where: (t) =>
          t.phoneNumber.equals(phone) & t.id.notEquals(request.id),
    );
    if (phoneHit != null) {
      throw AccountException(
        message: 'Phone already registered.',
        code: AccountErrorCode.phoneTaken,
      );
    }
    final updated = await Employee.db.updateRow(
      session,
      employee.copyWith(
        phoneNumber: phone,
        firstName: request.firstName.trim(),
        lastName: request.lastName.trim(),
      ),
    );
    return _view(updated);
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
    final updated = await Employee.db.updateRow(
      session,
      employee.copyWith(isEnabled: isEnabled),
    );
    return _view(updated);
  }

  EmployeeView _view(Employee employee) => EmployeeView(
    id: employee.id!,
    buildingId: employee.buildingId,
    ownerId: employee.ownerId,
    username: employee.username,
    phoneNumber: employee.phoneNumber,
    firstName: employee.firstName,
    lastName: employee.lastName,
    isEnabled: employee.isEnabled,
  );
}
