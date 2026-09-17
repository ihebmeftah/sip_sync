import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../di/management_session_cache.dart';
import '../di/service_locator.dart';
import 'app_routes.dart';

part 'app_router.g.dart';

String? _employeeHomeLocation() {
  final buildingId = getIt<ManagementSessionCache>().employeeBuildingId;
  if (buildingId == null) {
    return null;
  }
  return DashboardRoute(buildingId: buildingId.uuid).location;
}

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final sessionCache = getIt<ManagementSessionCache>();
  return GoRouter(
    initialLocation: const SignInRoute().location,
    refreshListenable: Listenable.merge([
      getIt<Client>().auth.authInfoListenable,
      sessionCache,
    ]),
    redirect: (context, state) {
      final signedIn = getIt<Client>().auth.isAuthenticated;
      final location = state.matchedLocation;
      final onAuth =
          location == const SignInRoute().location ||
          location == const RegisterRoute().location;
      final onBuildings = location.startsWith('/buildings');
      final onOps = location.startsWith('/b/');
      final employeeHome = _employeeHomeLocation();

      if (!signedIn && !onAuth) {
        return const SignInRoute().location;
      }
      if (signedIn && onAuth) {
        return employeeHome ?? const BuildingsRoute().location;
      }
      if (signedIn && location == '/') {
        return employeeHome ?? const BuildingsRoute().location;
      }
      // Employees belong to one building — never stay on the buildings gate.
      if (signedIn && onBuildings && employeeHome != null) {
        return employeeHome;
      }
      if (signedIn && onOps) {
        final buildingId = state.pathParameters['buildingId'];
        if (buildingId == null || buildingId.isEmpty) {
          return employeeHome ?? const BuildingsRoute().location;
        }
        // Staff may only open their assigned building.
        final homeId = getIt<ManagementSessionCache>().employeeBuildingId;
        if (homeId != null && buildingId != homeId.uuid) {
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
