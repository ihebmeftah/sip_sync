import 'package:sip_sync_client/sip_sync_client.dart';

/// What the assign dialog sends: a pack, and a term when it is not free.
class PackAssignment {
  const PackAssignment({
    required this.packId,
    this.billingPeriod,
    this.expiresAt,
  });

  final UuidValue packId;
  final PackBillingPeriod? billingPeriod;
  final DateTime? expiresAt;
}
