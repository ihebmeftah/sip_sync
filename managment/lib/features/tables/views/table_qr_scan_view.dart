import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/access/floor_access.dart';
import '../../../core/di/app_providers.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../orders/view_models/order_draft_view_model.dart';
import '../../orders/view_models/orders_view_model.dart';
import '../table_qr_payload.dart';
import '../view_models/tables_view_model.dart';

/// Employee camera screen: scan a table sticker and continue to article pick.
class TableQrScanView extends ConsumerStatefulWidget {
  const TableQrScanView({super.key, required this.buildingId});

  final String buildingId;

  @override
  ConsumerState<TableQrScanView> createState() => _TableQrScanViewState();
}

class _TableQrScanViewState extends ConsumerState<TableQrScanView> {
  final _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
  );
  var _handling = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_handling) {
      return;
    }
    final rawValues = <String>[];
    for (final barcode in capture.barcodes) {
      final value = barcode.rawValue;
      if (value != null && value.isNotEmpty) {
        rawValues.add(value);
      }
    }
    if (rawValues.isEmpty) {
      return;
    }
    final raw = rawValues.first;

    // Lock immediately so a held QR cannot fire snackbars repeatedly.
    _handling = true;
    final l10n = AppLocalizations.of(context)!;
    await _controller.stop();

    final payload = TableQrPayload.tryParse(raw);
    if (payload == null) {
      await _rejectAndClose(l10n.tableQrInvalid);
      return;
    }

    final expectedBuilding = UuidValue.fromString(widget.buildingId);
    if (payload.buildingId != expectedBuilding) {
      await _rejectAndClose(l10n.tableQrWrongBuilding);
      return;
    }

    var tables =
        ref.read(tablesViewModelProvider(widget.buildingId)).asData?.value ??
        const <VenueTableView>[];
    if (tables.isEmpty) {
      try {
        await ref
            .read(tablesViewModelProvider(widget.buildingId).notifier)
            .refresh();
        tables =
            ref
                .read(tablesViewModelProvider(widget.buildingId))
                .asData
                ?.value ??
            const <VenueTableView>[];
      } catch (_) {
        // Fall through to unknown-table message.
      }
    }
    VenueTableView? table;
    for (final candidate in tables) {
      if (candidate.id == payload.tableId) {
        table = candidate;
        break;
      }
    }

    if (table == null) {
      await _rejectAndClose(l10n.tableQrUnknownTable);
      return;
    }

    if (!table.isActive) {
      await _rejectAndClose(l10n.orderTableInactive);
      return;
    }

    if (!FloorAccess.fromSession(
      ref.read(appSessionStoreProvider),
    ).canCreateOrders) {
      await _rejectAndClose(l10n.errorOrderPermissionDenied);
      return;
    }

    final building = ref.read(buildingSelectionProvider);
    final multiOrder = building?.tableMultiOrder ?? false;
    final allowAppend = building?.allowAppendingItemsToOrder ?? true;
    final occupied = table.status == TableFloorStatus.occupied;

    if (occupied && !multiOrder) {
      // Neither a new order nor append is allowed → leave the scanner.
      if (!allowAppend) {
        await _rejectAndClose(l10n.orderAppendArticlesDisabled);
        return;
      }

      final openOrder = await _openOrderForTable(table.id);
      if (openOrder == null) {
        await _rejectAndClose(l10n.orderTableOccupied);
        return;
      }

      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.tableQrScanSuccess(table.number))),
      );
      ref
          .read(orderDraftViewModelProvider(widget.buildingId).notifier)
          .beginAppend(
            orderId: openOrder.id,
            tableId: table.id,
            tableNumber: table.number,
          );
      OrderCreateArticlesRoute(buildingId: widget.buildingId).go(context);
      return;
    }

    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.tableQrScanSuccess(table.number))),
    );
    ref
        .read(orderDraftViewModelProvider(widget.buildingId).notifier)
        .startOnTable(id: table.id, number: table.number);
    OrderCreateArticlesRoute(buildingId: widget.buildingId).go(context);
  }

  /// Progress order already seated on [tableId], if any.
  Future<OrderView?> _openOrderForTable(UuidValue tableId) async {
    var orders =
        ref
            .read(ordersViewModelProvider(widget.buildingId))
            .asData
            ?.value
            .orders ??
        const <OrderView>[];
    if (orders.isEmpty) {
      try {
        await ref
            .read(ordersViewModelProvider(widget.buildingId).notifier)
            .refresh();
        orders =
            ref
                .read(ordersViewModelProvider(widget.buildingId))
                .asData
                ?.value
                .orders ??
            const <OrderView>[];
      } catch (_) {
        return null;
      }
    }
    for (final order in orders) {
      if (order.status == OrderStatus.progress &&
          order.venueTableId == tableId) {
        return order;
      }
    }
    return null;
  }

  /// Show one snackbar and leave the camera so the same QR cannot re-fire.
  Future<void> _rejectAndClose(String message) async {
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
    TablesRoute(buildingId: widget.buildingId).go(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(l10n.tableQrScanTitle),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () =>
              TablesRoute(buildingId: widget.buildingId).go(context),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          MobileScanner(controller: _controller, onDetect: _onDetect),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: scheme.surface.withValues(alpha: 0.92),
                    borderRadius: BorderRadius.circular(AppRadii.lg),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Text(
                      l10n.tableQrScanHint,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
