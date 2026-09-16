import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../data/repositories/account_repository.dart';
import '../../data/repositories/building_repository.dart';
import 'building_session.dart';
import 'service_locator.dart';

part 'app_providers.g.dart';

@Riverpod(keepAlive: true)
Client client(Ref ref) => getIt<Client>();

@Riverpod(keepAlive: true)
AccountRepository accountRepository(Ref ref) => getIt<AccountRepository>();

@Riverpod(keepAlive: true)
BuildingRepository buildingRepository(Ref ref) => getIt<BuildingRepository>();

/// Mirrors [BuildingSession.selected] so widgets rebuild when a venue is picked.
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
