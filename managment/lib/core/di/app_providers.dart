import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../data/repositories/building_repository.dart';
import '../../data/repositories/employee_repository.dart';
import '../../data/repositories/ingredient_repository.dart';
import '../../data/repositories/menu_article_repository.dart';
import '../../data/repositories/menu_category_repository.dart';
import '../../data/repositories/owner_auth_repository.dart';
import '../../data/repositories/venue_table_repository.dart';
import 'app_session_store.dart';
import 'building_session.dart';
import 'service_locator.dart';

part 'app_providers.g.dart';

@Riverpod(keepAlive: true)
Client client(Ref ref) => getIt<Client>();

@Riverpod(keepAlive: true)
OwnerAuthRepository ownerAuthRepository(Ref ref) =>
    getIt<OwnerAuthRepository>();

@Riverpod(keepAlive: true)
BuildingRepository buildingRepository(Ref ref) => getIt<BuildingRepository>();

@Riverpod(keepAlive: true)
EmployeeRepository employeeRepository(Ref ref) => getIt<EmployeeRepository>();

@Riverpod(keepAlive: true)
VenueTableRepository venueTableRepository(Ref ref) =>
    getIt<VenueTableRepository>();

@Riverpod(keepAlive: true)
MenuCategoryRepository menuCategoryRepository(Ref ref) =>
    getIt<MenuCategoryRepository>();

@Riverpod(keepAlive: true)
MenuArticleRepository menuArticleRepository(Ref ref) =>
    getIt<MenuArticleRepository>();

@Riverpod(keepAlive: true)
IngredientRepository ingredientRepository(Ref ref) =>
    getIt<IngredientRepository>();

@Riverpod(keepAlive: true)
AppSessionStore appSessionStore(Ref ref) {
  final store = getIt<AppSessionStore>();
  void listener() => ref.invalidateSelf();
  store.addListener(listener);
  ref.onDispose(() => store.removeListener(listener));
  return store;
}

@Riverpod(keepAlive: true)
class BuildingSelection extends _$BuildingSelection {
  @override
  BuildingView? build() {
    final session = getIt<BuildingSession>();
    void onChange() => state = session.selected;
    session.addListener(onChange);
    ref.onDispose(() => session.removeListener(onChange));
    return session.selected;
  }
}
