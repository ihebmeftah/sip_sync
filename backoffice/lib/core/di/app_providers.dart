import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../data/repositories/super_admin_auth_repository.dart';
import 'app_session_store.dart';
import 'service_locator.dart';

part 'app_providers.g.dart';

@Riverpod(keepAlive: true)
Client client(Ref ref) => getIt<Client>();

@Riverpod(keepAlive: true)
SuperAdminAuthRepository superAdminAuthRepository(Ref ref) =>
    getIt<SuperAdminAuthRepository>();

@Riverpod(keepAlive: true)
AppSessionStore appSessionStore(Ref ref) {
  final store = getIt<AppSessionStore>();
  void listener() => ref.invalidateSelf();
  store.addListener(listener);
  ref.onDispose(() => store.removeListener(listener));
  return store;
}
