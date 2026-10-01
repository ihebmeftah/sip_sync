import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../di/app_session_store.dart';
import '../di/onboarding_store.dart';
import '../di/service_locator.dart';
import 'app_routes.dart';

part 'app_router.g.dart';

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final store = getIt<AppSessionStore>();
  final onboarding = getIt<OnboardingStore>();
  return GoRouter(
    initialLocation: _initialLocation(store, onboarding),
    refreshListenable: Listenable.merge([store, onboarding]),
    redirect: (context, state) => _redirect(store, onboarding, state),
    routes: $appRoutes,
  );
}

String _initialLocation(AppSessionStore store, OnboardingStore onboarding) {
  if (store.isSignedIn) {
    return const HomeRoute().location;
  }
  if (!onboarding.isComplete) {
    return const OnboardingRoute().location;
  }
  return const SignInRoute().location;
}

/// First launch opens onboarding. After that, unsigned users stay on auth.
/// A signed-in customer always lands on home, including if they skipped
/// onboarding on an older session.
String? _redirect(
  AppSessionStore store,
  OnboardingStore onboarding,
  GoRouterState state,
) {
  final signedIn = store.isSignedIn;
  final onboarded = onboarding.isComplete;
  final location = state.matchedLocation;
  final onAuth =
      location == const SignInRoute().location ||
      location == const RegisterRoute().location;
  final onOnboarding = location == const OnboardingRoute().location;

  if (signedIn && (onAuth || onOnboarding)) {
    return const HomeRoute().location;
  }
  if (!signedIn && !onboarded && !onOnboarding) {
    return const OnboardingRoute().location;
  }
  if (!signedIn && onboarded && !onAuth) {
    return const SignInRoute().location;
  }
  return null;
}
