import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../di/building_session.dart';
import '../di/service_locator.dart';
import 'app_routes.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final buildingSession = getIt<BuildingSession>();
  return GoRouter(
    initialLocation: const SignInRoute().location,
    refreshListenable: Listenable.merge([
      getIt<Client>().auth.authInfoListenable,
      buildingSession,
    ]),
    redirect: (context, state) {
      final signedIn = getIt<Client>().auth.isAuthenticated;
      final location = state.matchedLocation;
      final onAuth =
          location == const SignInRoute().location ||
          location == const RegisterRoute().location;
      final onBuildings = location.startsWith('/buildings');
      if (!signedIn && !onAuth) {
        return const SignInRoute().location;
      }
      if (signedIn && onAuth) {
        return const BuildingsRoute().location;
      }
      if (signedIn && location == '/') {
        return const BuildingsRoute().location;
      }
      if (signedIn && !onBuildings && buildingSession.selectedId == null) {
        return const BuildingsRoute().location;
      }
      return null;
    },
    routes: $appRoutes,
  );
}
