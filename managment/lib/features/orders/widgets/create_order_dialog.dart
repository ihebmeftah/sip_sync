import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/errors/error_mapper.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../products/view_models/articles_view_model.dart';
import '../../tables/view_models/tables_view_model.dart';
import '../view_models/orders_view_model.dart';

/// Create an order with optional table and article lines.
Future<bool> showCreateOrderDialog(
  BuildContext context, {
  required String buildingId,
}) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (context) => _CreateOrderDialog(buildingId: buildingId),
  );
  return result ?? false;
}

class _CreateOrderDialog extends ConsumerStatefulWidget {
  const _CreateOrderDialog({required this.buildingId});

  final String buildingId;

  @override
  ConsumerState<_CreateOrderDialog> createState() => _CreateOrderDialogState();
}

class _CreateOrderDialogState extends ConsumerState<_CreateOrderDialog> {
  UuidValue? _tableId;
  final _qtyByArticle = <UuidValue, int>{};
  var _saving = false;
  String? _errorKey;

  Future<void> _submit() async {
    final lines = [
      for (final entry in _qtyByArticle.entries)
        for (var i = 0; i < entry.value; i++)
          OrderItemCreateLine(articleId: entry.key),
    ];
    if (lines.isEmpty) {
      setState(() => _errorKey = 'validationOrderItems');
      return;
    }
    setState(() {
      _saving = true;
      _errorKey = null;
    });
    try {
      await ref
          .read(ordersViewModelProvider(widget.buildingId).notifier)
          .createOrder(venueTableId: _tableId, items: lines);
      if (!mounted) {
        return;
      }
      Navigator.of(context).pop(true);
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _saving = false;
        _errorKey = mapError(error).l10nKey;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final tables =
        ref.watch(tablesViewModelProvider(widget.buildingId)).asData?.value ??
        const <VenueTableView>[];
    final articles =
        ref.watch(articlesViewModelProvider(widget.buildingId)).asData?.value ??
        const <MenuArticleView>[];
    final activeTables = tables.where((t) => t.isActive).toList();

    return AlertDialog(
      title: Text(l10n.newOrder),
      content: SizedBox(
        width: 440,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.newOrderHint, style: text.bodyMedium),
              const SizedBox(height: AppSpacing.lg),
              DropdownButtonFormField<UuidValue?>(
                initialValue: _tableId,
                decoration: InputDecoration(labelText: l10n.orderTableOptional),
                items: [
                  DropdownMenuItem<UuidValue?>(
                    value: null,
                    child: Text(l10n.orderNoTable),
                  ),
                  for (final table in activeTables)
                    DropdownMenuItem(
                      value: table.id,
                      child: Text(l10n.orderTableNumber(table.number)),
                    ),
                ],
                onChanged: (value) => setState(() => _tableId = value),
              ),
              const SizedBox(height: AppSpacing.lg),
              if (articles.isEmpty)
                AppErrorBanner(message: l10n.orderNeedArticles)
              else
                for (final article in articles)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(article.name),
                    subtitle: Text(
                      '${article.price == article.price.roundToDouble() ? article.price.round() : article.price.toStringAsFixed(2)} · ${article.categoryName}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            final q = _qtyByArticle[article.id] ?? 0;
                            if (q <= 0) {
                              return;
                            }
                            setState(() => _qtyByArticle[article.id] = q - 1);
                          },
                          icon: const Icon(Icons.remove_circle_outline),
                        ),
                        Text('${_qtyByArticle[article.id] ?? 0}'),
                        IconButton(
                          onPressed: () {
                            final q = _qtyByArticle[article.id] ?? 0;
                            setState(() => _qtyByArticle[article.id] = q + 1);
                          },
                          icon: const Icon(Icons.add_circle_outline),
                        ),
                      ],
                    ),
                  ),
              if (_errorKey != null)
                AppErrorBanner(
                  message: _errorKey == 'validationOrderItems'
                      ? l10n.validationOrderItems
                      : lookupError(l10n, _errorKey!),
                ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.of(context).pop(false),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed: _saving || articles.isEmpty ? null : _submit,
          child: _saving
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(l10n.createOrder),
        ),
      ],
    );
  }
}
