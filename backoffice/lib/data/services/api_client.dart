import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../core/di/app_session_store.dart';
import '../../core/di/service_locator.dart';

final serverUrl = getServerUrl();

Future<Client> createSipSyncClient() async {
  final store = getIt<AppSessionStore>();
  await store.load();
  final client = Client(await serverUrl)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authKeyProvider = store;
  return client;
}
