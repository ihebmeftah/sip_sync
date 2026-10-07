import 'package:get_it/get_it.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../data/repositories/article_composition_repository.dart';
import '../../data/repositories/building_repository.dart';
import '../../data/repositories/employee_access_repository.dart';
import '../../data/repositories/employee_repository.dart';
import '../../data/repositories/ingredient_repository.dart';
import '../../data/repositories/menu_article_repository.dart';
import '../../data/repositories/menu_category_repository.dart';
import '../../data/repositories/order_repository.dart';
import '../../data/repositories/owner_auth_repository.dart';
import '../../data/repositories/pack_repository.dart';
import '../../data/repositories/reservation_repository.dart';
import '../../data/repositories/venue_table_repository.dart';
import '../../data/services/api_client.dart';
import 'app_session_store.dart';
import 'building_session.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  if (getIt.isRegistered<AppSessionStore>()) {
    return;
  }
  getIt.registerSingleton<AppSessionStore>(AppSessionStore());
  getIt.registerSingleton<BuildingSession>(BuildingSession());
  final client = await createSipSyncClient();
  getIt.registerSingleton<Client>(client);
  getIt.registerLazySingleton<OwnerAuthRepository>(
    () => OwnerAuthRepository(client, getIt<AppSessionStore>()),
  );
  getIt.registerLazySingleton<BuildingRepository>(
    () => BuildingRepository(client),
  );
  getIt.registerLazySingleton<EmployeeRepository>(
    () => EmployeeRepository(client),
  );
  getIt.registerLazySingleton<EmployeeAccessRepository>(
    () => EmployeeAccessRepository(client),
  );
  getIt.registerLazySingleton<VenueTableRepository>(
    () => VenueTableRepository(client),
  );
  getIt.registerLazySingleton<MenuCategoryRepository>(
    () => MenuCategoryRepository(client),
  );
  getIt.registerLazySingleton<MenuArticleRepository>(
    () => MenuArticleRepository(client),
  );
  getIt.registerLazySingleton<IngredientRepository>(
    () => IngredientRepository(client),
  );
  getIt.registerLazySingleton<ArticleCompositionRepository>(
    () => ArticleCompositionRepository(client),
  );
  getIt.registerLazySingleton<OrderRepository>(() => OrderRepository(client));
  getIt.registerLazySingleton<PackRepository>(() => PackRepository(client));
  getIt.registerLazySingleton<ReservationRepository>(
    () => ReservationRepository(client),
  );
}
