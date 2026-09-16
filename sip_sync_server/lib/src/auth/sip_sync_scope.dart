import 'package:serverpod/serverpod.dart';

/// Serverpod scopes that mirror [AppRole] plus the backoffice admin flag.
///
/// Membership tables are the source of truth; these names are copied onto
/// [AuthUser.scopeNames] so JWT and `requiredScopes` stay in sync.
class SipSyncScope {
  SipSyncScope._();

  static const customer = Scope('sip.customer');
  static const owner = Scope('sip.owner');
  static const employee = Scope('sip.employee');
  static const backoffice = Scope('sip.backoffice');
  static const backofficeAdmin = Scope('sip.backoffice.admin');
}
