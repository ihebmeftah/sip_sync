import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../data/repositories/customer_auth_repository.dart';
import '../../data/repositories/customer_discovery_repository.dart';
import '../../data/repositories/customer_order_repository.dart';
import '../../data/repositories/customer_reservation_repository.dart';
import 'app_session_store.dart';
import 'service_locator.dart';

part 'app_providers.g.dart';

@Riverpod(keepAlive: true)
Client client(Ref ref) => getIt<Client>();

@Riverpod(keepAlive: true)
CustomerAuthRepository customerAuthRepository(Ref ref) =>
    getIt<CustomerAuthRepository>();

@Riverpod(keepAlive: true)
CustomerDiscoveryRepository customerDiscoveryRepository(Ref ref) =>
    getIt<CustomerDiscoveryRepository>();

@Riverpod(keepAlive: true)
CustomerOrderRepository customerOrderRepository(Ref ref) =>
    getIt<CustomerOrderRepository>();

@Riverpod(keepAlive: true)
CustomerReservationRepository customerReservationRepository(Ref ref) =>
    getIt<CustomerReservationRepository>();

@Riverpod(keepAlive: true)
AppSessionStore appSessionStore(Ref ref) {
  final store = getIt<AppSessionStore>();
  void listener() => ref.invalidateSelf();
  store.addListener(listener);
  ref.onDispose(() => store.removeListener(listener));
  return store;
}
