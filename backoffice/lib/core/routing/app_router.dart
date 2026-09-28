import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../di/app_session_store.dart';
import '../di/service_locator.dart';
import 'app_routes.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final store = getIt<AppSessionStore>();
  return GoRouter(
    initialLocation: const SignInRoute().location,
    refreshListenable: store,
    redirect: (context, state) {
      final signedIn = store.isSignedIn;
      final onAuth =
          state.matchedLocation == const SignInRoute().location ||
          state.matchedLocation == const RegisterRoute().location;
      if (!signedIn && !onAuth) {
        return const SignInRoute().location;
      }
      if (signedIn && (onAuth || state.matchedLocation == '/')) {
        return const UsersRoute().location;
      }
      return null;
    },
    routes: $appRoutes,
  );
}
