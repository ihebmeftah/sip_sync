import 'package:flutter/foundation.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../core/di/app_session_store.dart';
import '../../core/di/service_locator.dart';

/// Resolves the API base URL for this platform.
///
/// Prefer `--dart-define=SERVER_URL=http://<lan-ip>:8080` when running on a
/// **physical** phone/tablet (bundled `localhost` only works on simulators /
/// the machine that hosts the server).
Future<String> resolveServerUrl() async {
  const fromEnv = String.fromEnvironment('SERVER_URL');
  if (fromEnv.isNotEmpty) {
    return fromEnv.endsWith('/') ? fromEnv : '$fromEnv/';
  }

  final raw = await getServerUrl();
  final uri = Uri.parse(raw);
  if ((uri.host == 'localhost' || uri.host == '127.0.0.1') &&
      !kIsWeb &&
      defaultTargetPlatform == TargetPlatform.android) {
    // Android emulator loopback to the host machine.
    return uri.replace(host: '10.0.2.2').toString();
  }
  return raw.endsWith('/') ? raw : '$raw/';
}

Future<Client> createSipSyncClient() async {
  final store = getIt<AppSessionStore>();
  await store.load();
  final client = Client(await resolveServerUrl())
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authKeyProvider = store;
  return client;
}
