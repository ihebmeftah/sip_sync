import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';

part 'venue_menu_view_model.g.dart';

/// Full customer menu for one building, in catalog order.
@riverpod
class VenueMenuViewModel extends _$VenueMenuViewModel {
  @override
  Future<CustomerMenu> build(String buildingId) {
    return ref
        .read(customerDiscoveryRepositoryProvider)
        .venueMenu(UuidValue.fromString(buildingId));
  }
}
