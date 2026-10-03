import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';

part 'venue_detail_view_model.g.dart';

/// Public venue page: free tables and the busiest categories and articles.
@riverpod
class VenueDetailViewModel extends _$VenueDetailViewModel {
  @override
  Future<CustomerVenueDetail> build(String buildingId) {
    return ref
        .read(customerDiscoveryRepositoryProvider)
        .venueDetail(UuidValue.fromString(buildingId));
  }
}
