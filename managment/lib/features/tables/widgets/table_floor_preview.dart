import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../l10n/generated/app_localizations.dart';

/// Visual floor preview — table top + chairs scale with [maxSeats].
class TableFloorPreview extends StatelessWidget {
  const TableFloorPreview({super.key, required this.table, this.onTap});

  final VenueTableView table;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final colors = _statusColors(scheme, table);
    final seats = table.maxSeats.clamp(1, 12);
    final canvasSize = _canvasSize(seats);

    return SizedBox(
      height: 250,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadii.lg),
          child: Ink(
            decoration: BoxDecoration(
              color: scheme.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(AppRadii.lg),
              border: Border.all(
                color: colors.stroke.withValues(alpha: 0.45),
                width: 1.5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.md,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: canvasSize,
                    height: canvasSize,
                    child: CustomPaint(
                      painter: _DiningTablePainter(
                        seats: seats,
                        fill: colors.fill,
                        stroke: colors.stroke,
                        chair: colors.chair,
                        dimmed: !table.isActive,
                      ),
                      child: Center(
                        child: Text(
                          '${table.number}',
                          style: text.headlineSmall?.copyWith(
                            color: colors.onFill,
                            fontWeight: FontWeight.w800,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    l10n.tableSeatsCount(table.maxSeats),
                    style: text.titleSmall?.copyWith(color: scheme.onSurface),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: colors.stroke.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(AppRadii.sm),
                    ),
                    child: Text(
                      table.isActive
                          ? _statusLabel(l10n, table.status)
                          : l10n.tableFilterInactive,
                      style: text.labelMedium?.copyWith(
                        color: colors.stroke,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static double _canvasSize(int seats) {
    if (seats <= 2) return 108;
    if (seats <= 4) return 120;
    if (seats <= 6) return 132;
    if (seats <= 8) return 144;
    return 156;
  }

  static String _statusLabel(AppLocalizations l10n, TableFloorStatus status) {
    return switch (status) {
      TableFloorStatus.available => l10n.tableStatusAvailable,
      TableFloorStatus.occupied => l10n.tableStatusOccupied,
      TableFloorStatus.reserved => l10n.tableStatusReserved,
    };
  }

  static ({Color fill, Color stroke, Color onFill, Color chair}) _statusColors(
    ColorScheme scheme,
    VenueTableView table,
  ) {
    if (!table.isActive) {
      return (
        fill: scheme.surfaceContainerHighest,
        stroke: scheme.outline,
        onFill: scheme.onSurfaceVariant,
        chair: scheme.outlineVariant,
      );
    }
    return switch (table.status) {
      TableFloorStatus.available => (
        fill: scheme.primaryContainer,
        stroke: scheme.primary,
        onFill: scheme.onPrimaryContainer,
        chair: scheme.primary.withValues(alpha: 0.75),
      ),
      TableFloorStatus.occupied => (
        fill: scheme.tertiaryContainer,
        stroke: scheme.tertiary,
        onFill: scheme.onTertiaryContainer,
        chair: scheme.tertiary.withValues(alpha: 0.75),
      ),
      TableFloorStatus.reserved => (
        fill: scheme.secondaryContainer,
        stroke: scheme.secondary,
        onFill: scheme.onSecondaryContainer,
        chair: scheme.secondary.withValues(alpha: 0.75),
      ),
    };
  }
}

/// Draws a round or oblong tabletop with chairs around the edge.
class _DiningTablePainter extends CustomPainter {
  _DiningTablePainter({
    required this.seats,
    required this.fill,
    required this.stroke,
    required this.chair,
    required this.dimmed,
  });

  final int seats;
  final Color fill;
  final Color stroke;
  final Color chair;
  final bool dimmed;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final alpha = dimmed ? 0.5 : 1.0;
    final tablePaint = Paint()
      ..color = fill.withValues(alpha: alpha)
      ..style = PaintingStyle.fill;
    final borderPaint = Paint()
      ..color = stroke.withValues(alpha: dimmed ? 0.4 : 0.95)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    final chairPaint = Paint()
      ..color = chair.withValues(alpha: dimmed ? 0.35 : 0.9)
      ..style = PaintingStyle.fill;
    final chairStroke = Paint()
      ..color = stroke.withValues(alpha: dimmed ? 0.3 : 0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final round = seats <= 4;
    final tableW = round ? size.width * 0.42 : size.width * 0.52;
    final tableH = round
        ? tableW
        : size.height *
              (seats >= 10
                  ? 0.38
                  : seats >= 8
                  ? 0.34
                  : 0.3);

    // Soft shadow under the top.
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: dimmed ? 0.04 : 0.08)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    if (round) {
      canvas.drawCircle(center.translate(0, 3), tableW / 2, shadowPaint);
      canvas.drawCircle(center, tableW / 2, tablePaint);
      canvas.drawCircle(center, tableW / 2, borderPaint);
    } else {
      final rect = RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: tableW, height: tableH),
        Radius.circular(tableH * 0.35),
      );
      canvas.drawRRect(rect.shift(const Offset(0, 3)), shadowPaint);
      canvas.drawRRect(rect, tablePaint);
      canvas.drawRRect(rect, borderPaint);
    }

    final orbitX = tableW / 2 + size.width * 0.14;
    final orbitY = tableH / 2 + size.height * 0.14;
    final chairR = size.shortestSide * 0.07;

    for (var i = 0; i < seats; i++) {
      final angle = (2 * math.pi * i / seats) - math.pi / 2;
      final seatCenter = Offset(
        center.dx + orbitX * math.cos(angle),
        center.dy + orbitY * math.sin(angle),
      );
      // Chair pad (slightly rounded square oriented toward table).
      canvas.save();
      canvas.translate(seatCenter.dx, seatCenter.dy);
      canvas.rotate(angle + math.pi / 2);
      final seat = RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset.zero,
          width: chairR * 2.1,
          height: chairR * 1.7,
        ),
        Radius.circular(chairR * 0.45),
      );
      canvas.drawRRect(seat, chairPaint);
      canvas.drawRRect(seat, chairStroke);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _DiningTablePainter oldDelegate) {
    return oldDelegate.seats != seats ||
        oldDelegate.fill != fill ||
        oldDelegate.stroke != stroke ||
        oldDelegate.chair != chair ||
        oldDelegate.dimmed != dimmed;
  }
}
