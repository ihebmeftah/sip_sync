import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../di/app_session_store.dart';
import '../di/service_locator.dart';
import 'app_routes.dart';

part 'app_router.g.dart';

String? _employeeHome() {
  final id = getIt<AppSessionStore>().employeeBuildingId;
  if (id == null) {
    return null;
  }
  return TablesRoute(buildingId: id.uuid).location;
}

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final store = getIt<AppSessionStore>();
  return GoRouter(
    initialLocation: const SignInRoute().location,
    refreshListenable: store,
    redirect: (context, state) {
      final signedIn = store.isSignedIn;
      final location = state.matchedLocation;
      final onAuth =
          location == const SignInRoute().location ||
          location == const RegisterRoute().location ||
          location == const ForgotPasswordRoute().location;
      final onBuildings = location.startsWith('/buildings');
      final onOps = location.startsWith('/b/');
      final employeeHome = _employeeHome();

      if (!signedIn && !onAuth) {
        return const SignInRoute().location;
      }
      if (signedIn && onAuth) {
        return employeeHome ?? const BuildingsRoute().location;
      }
      if (signedIn && location == '/') {
        return employeeHome ?? const BuildingsRoute().location;
      }
      if (signedIn && onBuildings && employeeHome != null) {
        return employeeHome;
      }
      if (signedIn && onOps) {
        final buildingId = state.pathParameters['buildingId'];
        if (buildingId == null || buildingId.isEmpty) {
          return employeeHome ?? const BuildingsRoute().location;
        }
        final homeId = store.employeeBuildingId;
        if (homeId != null && buildingId != homeId.uuid) {
          return employeeHome;
        }
        if (store.isEmployee && location.contains('/configuration')) {
          return employeeHome;
        }
      }
      if (signedIn && !onAuth && !onBuildings && !onOps) {
        return employeeHome ?? const BuildingsRoute().location;
      }
      return null;
    },
    routes: $appRoutes,
  );
}
