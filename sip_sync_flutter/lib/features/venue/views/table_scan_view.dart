import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../table_qr_payload.dart';
import '../view_models/seated_table_view_model.dart';
import '../widgets/venue_chrome.dart';

/// Camera screen that reads a table sticker and seats the customer there.
class TableScanView extends ConsumerStatefulWidget {
  const TableScanView({super.key, this.changing = false, this.buildingId});

  /// True when opened from a venue page, so a successful scan announces
  /// the change with a snackbar.
  final bool changing;

  /// Venue the customer was viewing. A scan of that same venue returns
  /// there; any other venue opens its own page.
  final String? buildingId;

  @override
  ConsumerState<TableScanView> createState() => _TableScanViewState();
}

class _TableScanViewState extends ConsumerState<TableScanView> {
  final _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
  );
  var _handling = false;
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_handling) {
      return;
    }
    String? raw;
    for (final barcode in capture.barcodes) {
      final value = barcode.rawValue;
      if (value != null && value.isNotEmpty) {
        raw = value;
        break;
      }
    }
    if (raw == null) {
      return;
    }

    _handling = true;
    final l10n = AppLocalizations.of(context)!;
    await _controller.stop();

    final payload = TableQrPayload.tryParse(raw);
    if (payload == null) {
      await _fail(l10n.tableScanInvalid);
      return;
    }

    try {
      final seated = await ref
          .read(customerDiscoveryRepositoryProvider)
          .resolveTable(
            buildingId: payload.buildingId,
            tableId: payload.tableId,
            number: payload.number,
          );
      if (!mounted) {
        return;
      }
      ref
          .read(seatedTableProvider.notifier)
          .sit(seated, announce: widget.changing);
      final sameVenue =
          widget.buildingId != null &&
          widget.buildingId == seated.buildingId.uuid;
      if (sameVenue && context.canPop()) {
        context.pop();
        return;
      }
      VenueRoute(id: seated.buildingId.uuid).go(context);
    } catch (error) {
      if (!mounted) {
        return;
      }
      await _fail(_message(l10n, error));
    }
  }

  String _message(AppLocalizations l10n, Object error) {
    if (error is BuildingException &&
        error.code == BuildingErrorCode.notFound) {
      return l10n.tableScanUnknown;
    }
    return lookupError(l10n, mapError(error).l10nKey);
  }

  Future<void> _fail(String message) async {
    if (!mounted) {
      return;
    }
    setState(() => _error = message);
    _handling = false;
    await _controller.start();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.ink,
      body: Stack(
        fit: StackFit.expand,
        children: [
          MobileScanner(
            controller: _controller,
            onDetect: _onDetect,
            errorBuilder: (context, error) {
              return ColoredBox(
                color: AppColors.ink,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    child: Text(
                      l10n.tableScanCamera,
                      textAlign: TextAlign.center,
                      style: text.bodyLarge?.copyWith(color: AppColors.paper),
                    ),
                  ),
                ),
              );
            },
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: AppBreakpoints.pageMax,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Row(
                    children: [
                      const IconTheme(
                        data: IconThemeData(color: AppColors.paper),
                        child: VenueBackButton(),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Text(
                          widget.changing ? l10n.changeTable : l10n.scanTable,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: text.titleLarge?.copyWith(
                            color: AppColors.paper,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: AppBreakpoints.formMax,
                  ),
                  child: Material(
                    color: AppColors.paper,
                    borderRadius: BorderRadius.circular(AppRadii.lg),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(AppIcons.qrScan, color: AppColors.apricot),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            l10n.scanTableHint,
                            textAlign: TextAlign.center,
                            style: text.bodyMedium,
                          ),
                          if (_error != null) ...[
                            const SizedBox(height: AppSpacing.md),
                            Text(
                              _error!,
                              textAlign: TextAlign.center,
                              style: text.bodyMedium?.copyWith(
                                color: AppColors.rose,
                              ),
                            ),
                          ],
                        ],
                      ),
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
