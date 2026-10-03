import 'package:get_it/get_it.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../data/repositories/admin_building_repository.dart';
import '../../data/repositories/platform_directory_repository.dart';
import '../../data/repositories/super_admin_auth_repository.dart';
import '../../data/services/api_client.dart';
import 'app_session_store.dart';

/// Imperative locator for the Serverpod [Client] and repositories.
final GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  if (!getIt.isRegistered<AppSessionStore>()) {
    getIt.registerSingleton<AppSessionStore>(AppSessionStore());
  }
  if (!getIt.isRegistered<Client>()) {
    getIt.registerSingleton<Client>(await createSipSyncClient());
  }
  final client = getIt<Client>();
  if (!getIt.isRegistered<SuperAdminAuthRepository>()) {
    getIt.registerLazySingleton<SuperAdminAuthRepository>(
      () => SuperAdminAuthRepository(client, getIt<AppSessionStore>()),
    );
  }
  if (!getIt.isRegistered<AdminBuildingRepository>()) {
    getIt.registerLazySingleton<AdminBuildingRepository>(
      () => AdminBuildingRepository(client),
    );
  }
  if (!getIt.isRegistered<PlatformDirectoryRepository>()) {
    getIt.registerLazySingleton<PlatformDirectoryRepository>(
      () => PlatformDirectoryRepository(client),
    );
  }
}
