import 'package:flutter/foundation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

/// Latest management [AccountSessionView] for [GoRouter] redirects (GetIt).
///
/// Riverpod holds the UI auth state; this mirror lets redirects read the
/// employee [buildingId] without a [Ref].
class ManagementSessionCache extends ChangeNotifier {
  AccountSessionView? session;

  void setSession(AccountSessionView? next) {
    session = next;
    notifyListeners();
  }

  void clear() {
    if (session == null) {
      return;
    }
    session = null;
    notifyListeners();
  }

  bool get isEmployeeOnly {
    final roles = session?.profile.roles ?? const <String>[];
    return roles.contains('employee') && !roles.contains('owner');
  }

  UuidValue? get employeeBuildingId {
    if (!isEmployeeOnly) {
      return null;
    }
    return session?.buildingId;
  }
}
