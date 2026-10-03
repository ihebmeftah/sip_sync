import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

part 'seated_table_view_model.g.dart';

/// The table this customer confirmed by scanning a sticker.
///
/// Kept for the session so the venue page can mark the seat after navigation.
class SeatedTableNotice {
  const SeatedTableNotice({required this.table, this.announce = false});

  final CustomerSeatedTable table;

  /// Set after a scan that changes the seat, so the venue page shows a
  /// success snackbar once.
  final bool announce;
}

/// Session seat. Cleared when the app process restarts.
@Riverpod(keepAlive: true)
class SeatedTable extends _$SeatedTable {
  @override
  SeatedTableNotice? build() => null;

  /// Remembers [table]. [announce] asks the venue page for a snackbar.
  void sit(CustomerSeatedTable table, {required bool announce}) {
    state = SeatedTableNotice(table: table, announce: announce);
  }

  /// Drops the one-shot snackbar flag after it has been shown.
  void clearAnnouncement() {
    final current = state;
    if (current == null || !current.announce) {
      return;
    }
    state = SeatedTableNotice(table: current.table);
  }
}
