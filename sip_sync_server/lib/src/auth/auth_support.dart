import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../core/phone_numbers.dart';
import '../generated/protocol.dart';
import 'password_hasher.dart';
import 'session_service.dart';

/// Shared validation and session packaging for actor auth endpoints.
class AuthSupport {
  final passwords = PasswordHasher();
  final sessions = SessionService();

  void validatePassword(String password) {
    if (password.length < 8) {
      throw AccountException(
        message: 'Password must be at least 8 characters.',
        code: AccountErrorCode.passwordTooWeak,
      );
    }
  }

  String normalizeEmail(String email) => email.trim().toLowerCase();

  String normalizePhone(String phone) => PhoneNumbers.normalize(phone);

  void validateEmail(String email) {
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      throw AccountException(
        message: 'Enter a valid email.',
        code: AccountErrorCode.invalidInput,
      );
    }
  }

  void validatePhone(String phone) {
    if (!PhoneNumbers.isValid(phone)) {
      throw AccountException(
        message: 'Enter a phone with country code, e.g. +216…',
        code: AccountErrorCode.invalidInput,
      );
    }
    if (PhoneNumbers.countryCodeFromPhone(phone) == null) {
      throw AccountException(
        message: 'Unsupported phone country code.',
        code: AccountErrorCode.invalidInput,
      );
    }
  }

  void validateName(String firstName, String lastName) {
    if (firstName.trim().isEmpty || lastName.trim().isEmpty) {
      throw AccountException(
        message: 'Enter first and last name.',
        code: AccountErrorCode.invalidInput,
      );
    }
  }

  Future<String> allocateEmployeeUsername(
    Session session,
    String firstName,
    String lastName,
  ) async {
    final base = '${_slug(firstName)}.${_slug(lastName)}';
    final random = Random.secure();
    for (var i = 0; i < 20; i++) {
      final candidate = '$base${1000 + random.nextInt(9000)}';
      final hit = await Employee.db.findFirstRow(
        session,
        where: (t) => t.username.equals(candidate),
      );
      if (hit == null) {
        return candidate;
      }
    }
    throw AccountException(
      message: 'Could not allocate a username.',
      code: AccountErrorCode.usernameTaken,
    );
  }

  String _slug(String value) {
    final cleaned = value.trim().toLowerCase().replaceAll(
      RegExp(r'[^a-z0-9]+'),
      '',
    );
    return cleaned.isEmpty ? 'staff' : cleaned;
  }

  Future<AuthTokenResult> issueOwner(Session session, Owner owner) async {
    final issued = await sessions.create(
      session,
      actorType: ActorType.owner,
      actorId: owner.id!,
    );
    return AuthTokenResult(
      token: issued.token,
      refreshToken: issued.refreshToken,
      expiresAt: issued.expiresAt,
      actorType: ActorType.owner,
      owner: OwnerSessionView(
        id: owner.id!,
        email: owner.email,
        phoneNumber: owner.phoneNumber,
        firstName: owner.firstName,
        lastName: owner.lastName,
      ),
    );
  }

  Future<AuthTokenResult> issueEmployee(
    Session session,
    Employee employee,
  ) async {
    final issued = await sessions.create(
      session,
      actorType: ActorType.employee,
      actorId: employee.id!,
    );
    EmployeeAccessView? accessView;
    if (employee.accessId != null) {
      final access =
          employee.access ??
          await EmployeeAccess.db.findById(session, employee.accessId!);
      if (access != null) {
        accessView = EmployeeAccessView(
          id: access.id!,
          buildingId: access.buildingId,
          name: access.name,
          orderCreation: access.orderCreation,
          orderPayment: access.orderPayment,
          cancelOrder: access.cancelOrder,
          preparation: access.preparation,
          serving: access.serving,
          consultAllOrders: access.consultAllOrders,
          reservations: access.reservations,
          cashRegister: access.cashRegister,
          createdAt: access.createdAt,
        );
      }
    }
    return AuthTokenResult(
      token: issued.token,
      refreshToken: issued.refreshToken,
      expiresAt: issued.expiresAt,
      actorType: ActorType.employee,
      employee: EmployeeSessionView(
        id: employee.id!,
        buildingId: employee.buildingId,
        ownerId: employee.ownerId,
        accessId: employee.accessId,
        access: accessView,
        username: employee.username,
        phoneNumber: employee.phoneNumber,
        firstName: employee.firstName,
        lastName: employee.lastName,
        isEnabled: employee.isEnabled,
      ),
    );
  }

  Future<AuthTokenResult> issueCustomer(
    Session session,
    Customer customer,
  ) async {
    final issued = await sessions.create(
      session,
      actorType: ActorType.customer,
      actorId: customer.id!,
    );
    return AuthTokenResult(
      token: issued.token,
      refreshToken: issued.refreshToken,
      expiresAt: issued.expiresAt,
      actorType: ActorType.customer,
      customer: CustomerSessionView(
        id: customer.id!,
        email: customer.email,
        phoneNumber: customer.phoneNumber,
        firstName: customer.firstName,
        lastName: customer.lastName,
      ),
    );
  }

  Future<AuthTokenResult> issueSuperAdmin(
    Session session,
    SuperAdmin admin,
  ) async {
    final issued = await sessions.create(
      session,
      actorType: ActorType.superAdmin,
      actorId: admin.id!,
    );
    return AuthTokenResult(
      token: issued.token,
      refreshToken: issued.refreshToken,
      expiresAt: issued.expiresAt,
      actorType: ActorType.superAdmin,
      superAdmin: SuperAdminSessionView(
        id: admin.id!,
        email: admin.email,
        phoneNumber: admin.phoneNumber,
        firstName: admin.firstName,
        lastName: admin.lastName,
        isSystemDefault: admin.isSystemDefault,
      ),
    );
  }
}
