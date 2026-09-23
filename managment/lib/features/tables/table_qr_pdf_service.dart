import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import 'table_qr_payload.dart';

/// Builds a printable PDF of table QR stickers for a venue floor.
class TableQrPdfService {
  /// Opens the platform print / share sheet for [tables].
  Future<void> exportStickers({
    required String buildingName,
    required UuidValue buildingId,
    required List<VenueTableView> tables,
  }) {
    final sorted = [...tables]..sort((a, b) => a.number.compareTo(b.number));
    return Printing.layoutPdf(
      name: 'Sip Sync — $buildingName tables',
      onLayout: (format) => _buildPdf(
        format: format,
        buildingName: buildingName,
        buildingId: buildingId,
        tables: sorted,
      ),
    );
  }

  Future<Uint8List> _buildPdf({
    required PdfPageFormat format,
    required String buildingName,
    required UuidValue buildingId,
    required List<VenueTableView> tables,
  }) async {
    final doc = pw.Document();
    const columns = 2;
    const rows = 3;
    final perPage = columns * rows;

    if (tables.isEmpty) {
      doc.addPage(
        pw.Page(
          pageFormat: format,
          build: (context) => pw.Center(child: pw.Text('No tables')),
        ),
      );
      return doc.save();
    }

    for (var offset = 0; offset < tables.length; offset += perPage) {
      final chunk = tables.skip(offset).take(perPage).toList();
      doc.addPage(
        pw.Page(
          pageFormat: format,
          margin: const pw.EdgeInsets.all(28),
          build: (context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                pw.Text(
                  buildingName,
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  'Table QR stickers',
                  style: const pw.TextStyle(
                    fontSize: 11,
                    color: PdfColors.grey700,
                  ),
                ),
                pw.SizedBox(height: 16),
                pw.Expanded(
                  child: pw.GridView(
                    crossAxisCount: columns,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      for (final table in chunk)
                        _sticker(
                          buildingName: buildingName,
                          buildingId: buildingId,
                          table: table,
                        ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      );
    }

    return doc.save();
  }

  pw.Widget _sticker({
    required String buildingName,
    required UuidValue buildingId,
    required VenueTableView table,
  }) {
    final payload = TableQrPayload.fromTable(
      buildingId: buildingId,
      table: table,
    ).encode();
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey400, width: 1),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.center,
        children: [
          pw.BarcodeWidget(
            barcode: pw.Barcode.qrCode(),
            data: payload,
            width: 120,
            height: 120,
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            'Table ${table.number}',
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 2),
          pw.Text(
            buildingName,
            style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
