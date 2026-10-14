import 'dart:async';
import 'dart:io';

import 'package:serverpod_cloud_storage/serverpod_cloud_storage.dart';

import 'src/auth/session_service.dart';
import 'src/auth/super_admin_auth_endpoint.dart';
import 'src/cache_busting.dart';
import 'src/generated/serverpod.dart';
import 'src/packs/pack_catalog.dart';
import 'src/packs/pack_expiry.dart';
import 'src/seed/dev_seed.dart';
import 'src/web/routes/app_config_route.dart';

/// One sweep timer for the process. Replaced if the isolate starts again.
Timer? _packExpiryTimer;

/// The starting point of the Serverpod server.
void run(List<String> args) async {
  final pod = Serverpod(
    args,
    authenticationHandler: sipSyncAuthenticationHandler,
  );

  pod.webServer.addRoute(
    StaticRoute.withCacheBusting(cacheBustingConfig),
    cacheBustingConfig.mountPrefix,
  );

  // More specific prefixes first. The customer app is mounted at `/` and would
  // otherwise answer /managment and /backoffice with its own index.html.
  _mountFlutterWebApp(
    pod,
    directoryPath: 'web/managment',
    mountPath: '/managment',
  );
  _mountFlutterWebApp(
    pod,
    directoryPath: 'web/backoffice',
    mountPath: '/backoffice',
  );
  _mountFlutterWebApp(
    pod,
    directoryPath: 'web/app',
    mountPath: '/',
  );

  final appDir = Directory(Uri(path: 'web/app').toFilePath());
  if (!appDir.existsSync()) {
    final defaultRoute = StaticRoute.file(
      File(
        Uri(path: 'web/pages/build_flutter_app.html').toFilePath(),
      ),
    );

    pod.webServer.addMiddleware(
      FallbackMiddleware(
        fallback: defaultRoute,
        on: (response) => response.statusCode == 404,
      ).call,
      '/',
    );

    pod.webServer.addRoute(
      defaultRoute,
      '/**',
    );
  }

  pod.addCloudStorage(
    await ServerpodCloudProvider.private(
      fallback: () => DatabaseCloudStorage('private'),
    ),
  );
  pod.addCloudStorage(
    await ServerpodCloudProvider.public(
      fallback: () => DatabaseCloudStorage('public'),
    ),
  );

  await pod.start();

  await pod.withSession((session) async {
    await SuperAdminAuthEndpoint().ensureDefaultAdmin(session);
    await PackCatalog.ensure(session);
    await PackExpiry.revertDue(session);
    await DevSeed.ensureDemoData(session);
  });
  _watchPackExpiry(pod);
}

/// Serves one Flutter web build and the live API URL for that build.
///
/// [mountPath] is the public prefix. `/` is the customer app. A subpath such
/// as `/managment` must match the `--base-href` used when that app was built,
/// so the browser loads assets from the prefix and GoRouter still sees `/`.
/// The bundled `config.json` points at localhost; this route replaces it with
/// the server's public API URL.
void _mountFlutterWebApp(
  Serverpod pod, {
  required String directoryPath,
  required String mountPath,
}) {
  final directory = Directory(Uri(path: directoryPath).toFilePath());
  if (!directory.existsSync()) {
    return;
  }
  final prefix = mountPath == '/' ? '' : mountPath;
  pod.webServer.addRoute(
    AppConfigRoute(apiConfig: pod.config.apiServer),
    '$prefix/assets/assets/config.json',
  );
  pod.webServer.addRoute(
    FlutterRoute(
      directory,
      enableWasmHeaders: false,
    ),
    mountPath,
  );
}

/// Checks paid terms every 15 minutes and returns due venues to the free pack.
///
/// Also runs once during startup, before the demo seed.
void _watchPackExpiry(Serverpod pod) {
  _packExpiryTimer?.cancel();
  _packExpiryTimer = Timer.periodic(const Duration(minutes: 15), (_) {
    unawaited(_sweepPacks(pod));
  });
}

Future<void> _sweepPacks(Serverpod pod) async {
  try {
    await pod.withSession((session) => PackExpiry.revertDue(session));
  } catch (error, stackTrace) {
    stderr.writeln('PackExpiry sweep failed: $error\n$stackTrace');
  }
}
