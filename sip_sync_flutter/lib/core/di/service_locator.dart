import 'package:get_it/get_it.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../data/repositories/customer_auth_repository.dart';
import '../../data/repositories/customer_discovery_repository.dart';
import '../../data/services/api_client.dart';
import 'app_session_store.dart';
import 'onboarding_store.dart';

/// Imperative locator for the Serverpod [Client] and repositories.
final GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  if (getIt.isRegistered<AppSessionStore>()) {
    return;
  }
  getIt.registerSingleton<AppSessionStore>(AppSessionStore());
  final onboarding = OnboardingStore();
  getIt.registerSingleton<OnboardingStore>(onboarding);
  final client = await createSipSyncClient();
  await onboarding.load();
  getIt.registerSingleton<Client>(client);
  getIt.registerLazySingleton<CustomerAuthRepository>(
    () => CustomerAuthRepository(client, getIt<AppSessionStore>()),
  );
  getIt.registerLazySingleton<CustomerDiscoveryRepository>(
    () => CustomerDiscoveryRepository(client),
  );
}
