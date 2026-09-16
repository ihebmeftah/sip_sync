import 'package:get_it/get_it.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../data/repositories/account_repository.dart';
import '../../data/services/api_client.dart';

/// Imperative locator for the Serverpod [Client] and repositories.
///
/// Prefer Riverpod in widgets. Use GetIt from [GoRouter] redirects and other
/// non-widget code that cannot hold a [Ref].
final GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  if (getIt.isRegistered<Client>()) {
    return;
  }
  final client = await createSipSyncClient();
  getIt.registerSingleton<Client>(client);
  getIt.registerLazySingleton<AccountRepository>(
    () => AccountRepository(client),
  );
}
