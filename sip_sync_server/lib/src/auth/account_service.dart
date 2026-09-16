import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import '../generated/protocol.dart';
import 'sip_sync_scope.dart';

/// Creates identities, attaches additive roles, and issues sessions.
///
/// One [AuthUser] per email. Additional apps add [UserRoleMembership] rows
/// instead of a second login. See `Docs/features/authentication.md`.
class AccountService {
  /// Registers a customer (customer app) or owner (management app).
  ///
  /// If the email already exists, the password is checked and the role for
  /// [SelfRegisterCreate.app] is attached to that user.
  Future<AuthSessionResult> register(
    Session session,
    SelfRegisterCreate request,
  ) async {
    if (request.app == SipApp.backoffice) {
      throw AccountException(
        message: 'Backoffice accounts cannot self-register.',
        code: AccountErrorCode.notAuthorized,
      );
    }

    _validatePassword(request.password);
    final email = _normalizeEmail(request.email);
    _validateEmail(email);

    final existing = await AuthServices.instance.emailIdp.admin.findAccount(
      session,
      email: email,
    );

    late final UuidValue authUserId;
    if (existing != null) {
      authUserId = await _authenticate(session, email, request.password);
      await _ensureProfile(
        session,
        authUserId: authUserId,
        email: email,
        username: request.username,
        phoneNumber: request.phoneNumber,
        firstName: request.firstName,
        lastName: request.lastName,
      );
    } else {
      authUserId = await _createIdentity(
        session,
        email: email,
        password: request.password,
        username: request.username,
        phoneNumber: request.phoneNumber,
        firstName: request.firstName,
        lastName: request.lastName,
      );
    }

    await _grantRole(
      session,
      authUserId,
      request.app == SipApp.management ? AppRole.owner : AppRole.customer,
    );

    return _issueSession(session, authUserId);
  }

  /// Authenticates and checks that [request.app] is allowed for this user.
  ///
  /// Customer app logins grant the customer role if it is missing so owners
  /// and employees can order as guests with the same email.
  Future<AuthSessionResult> login(
    Session session,
    LoginRequest request,
  ) async {
    final email = _normalizeEmail(request.email);
    _validateEmail(email);
    final authUserId = await _authenticate(session, email, request.password);

    final profile = await SipSyncProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    if (profile == null) {
      throw AccountException(
        message: 'Complete registration with username and phone number.',
        code: AccountErrorCode.profileIncomplete,
      );
    }

    switch (request.app) {
      case SipApp.customer:
        await _grantRole(session, authUserId, AppRole.customer);
      case SipApp.management:
        if (!await _hasAnyRole(session, authUserId, {
          AppRole.owner,
          AppRole.employee,
        })) {
          throw AccountException(
            message: 'This account is not an owner or employee.',
            code: AccountErrorCode.appAccessDenied,
          );
        }
      case SipApp.backoffice:
        if (!await _hasAnyRole(session, authUserId, {AppRole.backoffice})) {
          throw AccountException(
            message: 'This account is not a backoffice user.',
            code: AccountErrorCode.appAccessDenied,
          );
        }
    }

    return _issueSession(session, authUserId);
  }

  /// Profile and roles for the signed-in user.
  Future<AccountSessionView> me(Session session, UuidValue authUserId) async {
    return _sessionView(session, authUserId);
  }

  /// Owner-only: create or attach an employee identity.
  Future<ProfileView> addEmployee(
    Session session, {
    required UuidValue ownerAuthUserId,
    required EmployeeCreate request,
  }) async {
    if (!await _hasAnyRole(session, ownerAuthUserId, {AppRole.owner})) {
      throw AccountException(
        message: 'Only owners can add employees.',
        code: AccountErrorCode.notAuthorized,
      );
    }

    final email = _normalizeEmail(request.email);
    _validateEmail(email);

    final existing = await AuthServices.instance.emailIdp.admin.findAccount(
      session,
      email: email,
    );

    late final UuidValue employeeId;
    if (existing != null) {
      employeeId = existing.authUserId;
      await _ensureProfile(
        session,
        authUserId: employeeId,
        email: email,
        username: request.username,
        phoneNumber: request.phoneNumber,
        firstName: request.firstName,
        lastName: request.lastName,
      );
    } else {
      _validatePassword(request.password);
      employeeId = await _createIdentity(
        session,
        email: email,
        password: request.password,
        username: request.username,
        phoneNumber: request.phoneNumber,
        firstName: request.firstName,
        lastName: request.lastName,
      );
    }

    await _grantRole(session, employeeId, AppRole.employee);

    final record = await EmployeeRecord.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(employeeId),
    );
    if (record == null) {
      await EmployeeRecord.db.insertRow(
        session,
        EmployeeRecord(
          authUserId: employeeId,
          ownerAuthUserId: ownerAuthUserId,
        ),
      );
    }

    return _profileView(session, employeeId);
  }

  /// Employees this owner added.
  Future<List<ProfileView>> listEmployees(
    Session session,
    UuidValue ownerAuthUserId,
  ) async {
    if (!await _hasAnyRole(session, ownerAuthUserId, {AppRole.owner})) {
      throw AccountException(
        message: 'Only owners can list employees.',
        code: AccountErrorCode.notAuthorized,
      );
    }

    final records = await EmployeeRecord.db.find(
      session,
      where: (t) => t.ownerAuthUserId.equals(ownerAuthUserId),
    );
    final views = <ProfileView>[];
    for (final record in records) {
      views.add(await _profileView(session, record.authUserId));
    }
    return views;
  }

  /// Backoffice admin: create or attach a non-admin backoffice user.
  Future<BackofficeUserView> addBackofficeUser(
    Session session, {
    required UuidValue actorId,
    required BackofficeUserCreate request,
  }) async {
    await _requireBackofficeAdmin(session, actorId);

    final email = _normalizeEmail(request.email);
    _validateEmail(email);

    final existing = await AuthServices.instance.emailIdp.admin.findAccount(
      session,
      email: email,
    );

    late final UuidValue userId;
    if (existing != null) {
      userId = existing.authUserId;
      await _ensureProfile(
        session,
        authUserId: userId,
        email: email,
        username: request.username,
        phoneNumber: request.phoneNumber,
        firstName: request.firstName,
        lastName: request.lastName,
      );
    } else {
      _validatePassword(request.password);
      userId = await _createIdentity(
        session,
        email: email,
        password: request.password,
        username: request.username,
        phoneNumber: request.phoneNumber,
        firstName: request.firstName,
        lastName: request.lastName,
      );
    }

    await _grantRole(session, userId, AppRole.backoffice);
    await _ensureBackofficeStaff(
      session,
      userId,
      isAdmin: false,
      isSystemDefault: false,
    );

    return _backofficeView(session, userId);
  }

  /// All backoffice identities.
  Future<List<BackofficeUserView>> listBackofficeUsers(
    Session session,
    UuidValue actorId,
  ) async {
    if (!await _hasAnyRole(session, actorId, {AppRole.backoffice})) {
      throw AccountException(
        message: 'Backoffice access required.',
        code: AccountErrorCode.notAuthorized,
      );
    }

    final staff = await BackofficeStaff.db.find(session);
    final views = <BackofficeUserView>[];
    for (final row in staff) {
      views.add(await _backofficeView(session, row.authUserId));
    }
    return views;
  }

  /// Removes backoffice membership. The seeded default admin is protected.
  Future<void> deleteBackofficeUser(
    Session session, {
    required UuidValue actorId,
    required UuidValue targetId,
  }) async {
    await _requireBackofficeAdmin(session, actorId);

    final staff = await BackofficeStaff.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(targetId),
    );
    if (staff == null) {
      throw AccountException(
        message: 'Backoffice user not found.',
        code: AccountErrorCode.notFound,
      );
    }
    if (staff.isSystemDefault) {
      throw AccountException(
        message: 'The default admin account cannot be deleted.',
        code: AccountErrorCode.cannotDeleteDefaultAdmin,
      );
    }

    await BackofficeStaff.db.deleteRow(session, staff);
    await UserRoleMembership.db.deleteWhere(
      session,
      where: (t) =>
          t.authUserId.equals(targetId) & t.role.equals(AppRole.backoffice),
    );
    await _syncScopes(session, targetId);
  }

  /// Idempotent seed used at process start.
  Future<void> ensureDefaultAdmin(Session session) async {
    final existing = await BackofficeStaff.db.findFirstRow(
      session,
      where: (t) => t.isSystemDefault.equals(true),
    );
    if (existing != null) {
      return;
    }

    final email = _normalizeEmail(
      session.passwords['sipSyncDefaultAdminEmail'] ?? 'admin@sipsync.local',
    );
    final password =
        session.passwords['sipSyncDefaultAdminPassword'] ?? 'SipSyncAdmin8!';

    final emailAccount = await AuthServices.instance.emailIdp.admin.findAccount(
      session,
      email: email,
    );

    late final UuidValue authUserId;
    if (emailAccount != null) {
      authUserId = emailAccount.authUserId;
      await _ensureProfile(
        session,
        authUserId: authUserId,
        email: email,
        username: 'superadmin',
        phoneNumber: '+0000000000',
        firstName: 'Super',
        lastName: 'Admin',
      );
    } else {
      authUserId = await _createIdentity(
        session,
        email: email,
        password: password,
        username: 'superadmin',
        phoneNumber: '+0000000000',
        firstName: 'Super',
        lastName: 'Admin',
      );
    }

    await _grantRole(session, authUserId, AppRole.backoffice);
    await _ensureBackofficeStaff(
      session,
      authUserId,
      isAdmin: true,
      isSystemDefault: true,
    );
    await _syncScopes(session, authUserId);
  }

  Future<UuidValue> _createIdentity(
    Session session, {
    required String email,
    required String password,
    required String username,
    required String phoneNumber,
    required String firstName,
    required String lastName,
  }) async {
    final normalizedUser = _normalizeUsername(username);
    final normalizedPhone = _normalizePhone(phoneNumber);
    _validateName(firstName, lastName);
    await _assertUniqueProfile(
      session,
      username: normalizedUser,
      email: email,
      phoneNumber: normalizedPhone,
    );

    final authUser = await AuthServices.instance.authUsers.create(session);
    final authUserId = authUser.id;

    await AuthServices.instance.emailIdp.admin.createEmailAuthentication(
      session,
      authUserId: authUserId,
      email: email,
      password: password,
    );

    await AuthServices.instance.userProfiles.createUserProfile(
      session,
      authUserId,
      UserProfileData(
        userName: normalizedUser,
        fullName: '$firstName $lastName'.trim(),
        email: email,
      ),
    );

    await SipSyncProfile.db.insertRow(
      session,
      SipSyncProfile(
        authUserId: authUserId,
        username: normalizedUser,
        email: email,
        phoneNumber: normalizedPhone,
        firstName: firstName.trim(),
        lastName: lastName.trim(),
      ),
    );

    return authUserId;
  }

  Future<void> _ensureProfile(
    Session session, {
    required UuidValue authUserId,
    required String email,
    required String username,
    required String phoneNumber,
    required String firstName,
    required String lastName,
  }) async {
    final existing = await SipSyncProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    if (existing != null) {
      return;
    }

    final normalizedUser = _normalizeUsername(username);
    final normalizedPhone = _normalizePhone(phoneNumber);
    _validateName(firstName, lastName);
    await _assertUniqueProfile(
      session,
      username: normalizedUser,
      email: email,
      phoneNumber: normalizedPhone,
    );

    await SipSyncProfile.db.insertRow(
      session,
      SipSyncProfile(
        authUserId: authUserId,
        username: normalizedUser,
        email: email,
        phoneNumber: normalizedPhone,
        firstName: firstName.trim(),
        lastName: lastName.trim(),
      ),
    );
  }

  Future<void> _grantRole(
    Session session,
    UuidValue authUserId,
    AppRole role,
  ) async {
    final existing = await UserRoleMembership.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId) & t.role.equals(role),
    );
    if (existing == null) {
      await UserRoleMembership.db.insertRow(
        session,
        UserRoleMembership(authUserId: authUserId, role: role),
      );
    }
    if (role == AppRole.backoffice) {
      await _ensureBackofficeStaff(
        session,
        authUserId,
        isAdmin: false,
        isSystemDefault: false,
      );
    }
    await _syncScopes(session, authUserId);
  }

  Future<void> _ensureBackofficeStaff(
    Session session,
    UuidValue authUserId, {
    required bool isAdmin,
    required bool isSystemDefault,
  }) async {
    final existing = await BackofficeStaff.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    if (existing != null) {
      if ((isAdmin && !existing.isAdmin) ||
          (isSystemDefault && !existing.isSystemDefault)) {
        await BackofficeStaff.db.updateRow(
          session,
          existing.copyWith(
            isAdmin: existing.isAdmin || isAdmin,
            isSystemDefault: existing.isSystemDefault || isSystemDefault,
          ),
        );
      }
      return;
    }
    await BackofficeStaff.db.insertRow(
      session,
      BackofficeStaff(
        authUserId: authUserId,
        isAdmin: isAdmin,
        isSystemDefault: isSystemDefault,
      ),
    );
  }

  Future<void> _syncScopes(Session session, UuidValue authUserId) async {
    final roles = await UserRoleMembership.db.find(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    final scopes = <Scope>{};
    for (final membership in roles) {
      switch (membership.role) {
        case AppRole.customer:
          scopes.add(SipSyncScope.customer);
        case AppRole.owner:
          scopes.add(SipSyncScope.owner);
        case AppRole.employee:
          scopes.add(SipSyncScope.employee);
        case AppRole.backoffice:
          scopes.add(SipSyncScope.backoffice);
      }
    }
    final staff = await BackofficeStaff.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    if (staff?.isAdmin ?? false) {
      scopes.add(SipSyncScope.backofficeAdmin);
      scopes.add(Scope.admin);
    }
    await AuthServices.instance.authUsers.update(
      session,
      authUserId: authUserId,
      scopes: scopes,
    );
  }

  Future<bool> _hasAnyRole(
    Session session,
    UuidValue authUserId,
    Set<AppRole> roles,
  ) async {
    final memberships = await UserRoleMembership.db.find(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    return memberships.any((m) => roles.contains(m.role));
  }

  Future<void> _requireBackofficeAdmin(
    Session session,
    UuidValue actorId,
  ) async {
    final staff = await BackofficeStaff.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(actorId),
    );
    if (staff == null || !staff.isAdmin) {
      throw AccountException(
        message: 'Only a backoffice admin can manage staff.',
        code: AccountErrorCode.notAuthorized,
      );
    }
  }

  Future<UuidValue> _authenticate(
    Session session,
    String email,
    String password,
  ) async {
    try {
      return await EmailIdpUtils.withReplacedServerEmailException(
        () => AuthServices.instance.emailIdp.utils.authentication.authenticate(
          session,
          email: email,
          password: password,
          transaction: null,
        ),
      );
    } on EmailAccountLoginException {
      throw AccountException(
        message: 'Invalid email or password.',
        code: AccountErrorCode.invalidCredentials,
      );
    }
  }

  Future<AuthSessionResult> _issueSession(
    Session session,
    UuidValue authUserId,
  ) async {
    final authUser = await AuthServices.instance.authUsers.get(
      session,
      authUserId: authUserId,
    );
    final authSuccess = await AuthServices.instance.tokenManager.issueToken(
      session,
      authUserId: authUserId,
      method: 'email',
      scopes: authUser.scopes,
    );
    return AuthSessionResult(
      authSuccess: authSuccess,
      session: await _sessionView(session, authUserId),
    );
  }

  Future<AccountSessionView> _sessionView(
    Session session,
    UuidValue authUserId,
  ) async {
    final profile = await _profileView(session, authUserId);
    final staff = await BackofficeStaff.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    return AccountSessionView(
      profile: profile,
      isBackofficeAdmin: staff?.isAdmin ?? false,
      isSystemDefaultAdmin: staff?.isSystemDefault ?? false,
    );
  }

  Future<BackofficeUserView> _backofficeView(
    Session session,
    UuidValue authUserId,
  ) async {
    final profile = await _profileView(session, authUserId);
    final staff = await BackofficeStaff.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    return BackofficeUserView(
      profile: profile,
      isAdmin: staff?.isAdmin ?? false,
      isSystemDefault: staff?.isSystemDefault ?? false,
    );
  }

  Future<ProfileView> _profileView(
    Session session,
    UuidValue authUserId,
  ) async {
    final profile = await SipSyncProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    if (profile == null) {
      throw AccountException(
        message: 'Profile not found.',
        code: AccountErrorCode.profileIncomplete,
      );
    }
    final roles = await UserRoleMembership.db.find(
      session,
      where: (t) => t.authUserId.equals(authUserId),
    );
    return ProfileView(
      authUserId: authUserId,
      username: profile.username,
      email: profile.email,
      phoneNumber: profile.phoneNumber,
      firstName: profile.firstName,
      lastName: profile.lastName,
      roles: roles.map(_roleWireName).toList(),
    );
  }

  Future<void> _assertUniqueProfile(
    Session session, {
    required String username,
    required String email,
    required String phoneNumber,
  }) async {
    if (await SipSyncProfile.db.findFirstRow(
          session,
          where: (t) => t.username.equals(username),
        ) !=
        null) {
      throw AccountException(
        message: 'Username is already taken.',
        code: AccountErrorCode.usernameTaken,
      );
    }
    if (await SipSyncProfile.db.findFirstRow(
          session,
          where: (t) => t.email.equals(email),
        ) !=
        null) {
      throw AccountException(
        message: 'Email is already registered.',
        code: AccountErrorCode.emailTaken,
      );
    }
    if (await SipSyncProfile.db.findFirstRow(
          session,
          where: (t) => t.phoneNumber.equals(phoneNumber),
        ) !=
        null) {
      throw AccountException(
        message: 'Phone number is already registered.',
        code: AccountErrorCode.phoneTaken,
      );
    }
  }

  void _validatePassword(String password) {
    if (password.trim() != password || password.length < 8) {
      throw AccountException(
        message: 'Password must be at least 8 characters with no outer spaces.',
        code: AccountErrorCode.passwordTooWeak,
      );
    }
  }

  void _validateEmail(String email) {
    if (!email.contains('@') || email.length < 5) {
      throw AccountException(
        message: 'Enter a valid email address.',
        code: AccountErrorCode.invalidInput,
      );
    }
  }

  void _validateName(String firstName, String lastName) {
    if (firstName.trim().isEmpty || lastName.trim().isEmpty) {
      throw AccountException(
        message: 'First and last name are required.',
        code: AccountErrorCode.invalidInput,
      );
    }
  }

  String _normalizeEmail(String email) => email.trim().toLowerCase();

  String _normalizeUsername(String username) {
    final value = username.trim().toLowerCase();
    if (value.length < 3 || !RegExp(r'^[a-z0-9_]+$').hasMatch(value)) {
      throw AccountException(
        message:
            'Username must be at least 3 characters (letters, numbers, underscore).',
        code: AccountErrorCode.invalidInput,
      );
    }
    return value;
  }

  String _normalizePhone(String phone) {
    final value = phone.trim();
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 8) {
      throw AccountException(
        message: 'Enter a valid phone number.',
        code: AccountErrorCode.invalidInput,
      );
    }
    return value;
  }

  /// Wire names for client DTOs. Avoids sending [AppRole] to Flutter web,
  /// where generated `toJson`/`toString` call [Enum.name] and crash.
  String _roleWireName(UserRoleMembership membership) {
    return switch (membership.role) {
      AppRole.customer => 'customer',
      AppRole.owner => 'owner',
      AppRole.employee => 'employee',
      AppRole.backoffice => 'backoffice',
    };
  }
}
