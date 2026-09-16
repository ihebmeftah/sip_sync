import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

/// Shared Serverpod auth wiring used by [run] and by integration tests.
void configureSipSyncAuth() {
  Serverpod.instance.initializeAuthServices(
    tokenManagerBuilders: [
      JwtConfigFromPasswords(),
    ],
    identityProviderBuilders: [
      ServerpodCloudEmailIdpConfig(
        appDisplayName: 'sip_sync',
      ),
    ],
  );
}
