import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/di/locale_controller.dart';
import 'core/di/theme_controller.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/view_models/auth_view_model.dart';
import 'l10n/generated/app_localizations.dart';

class SipSyncApp extends ConsumerWidget {
  const SipSyncApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Keep auth alive so session restore runs after cold start / refresh.
    ref.watch(authViewModelProvider);
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'Sip Sync Management',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ref.watch(themeControllerProvider),
      routerConfig: router,
      locale: ref.watch(localeControllerProvider),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
