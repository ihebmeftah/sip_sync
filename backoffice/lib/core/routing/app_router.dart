import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../di/service_locator.dart';
import 'app_routes.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: const SignInRoute().location,
    refreshListenable: getIt<Client>().auth.authInfoListenable,
    redirect: (context, state) {
      final signedIn = getIt<Client>().auth.isAuthenticated;
      final onAuth =
          state.matchedLocation == const SignInRoute().location ||
          state.matchedLocation == const RegisterRoute().location;
      if (!signedIn && !onAuth) {
        return const SignInRoute().location;
      }
      if (signedIn && onAuth) {
        return const HomeRoute().location;
      }
      return null;
    },
    routes: $appRoutes,
  );
}
