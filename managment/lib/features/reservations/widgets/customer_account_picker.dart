import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/di/app_providers.dart';
import '../../../core/errors/app_notice.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../l10n/generated/app_localizations.dart';

/// Searchable dropdown of customer accounts for a staff booking.
///
/// Matches name, phone, or email after typing pauses. A query shorter than
/// two characters is not sent.
class CustomerAccountPicker extends ConsumerStatefulWidget {
  const CustomerAccountPicker({
    super.key,
    required this.buildingId,
    required this.customer,
    required this.onChanged,
  });

  final String buildingId;
  final ReservationCustomerMatch? customer;
  final ValueChanged<ReservationCustomerMatch?> onChanged;

  @override
  ConsumerState<CustomerAccountPicker> createState() =>
      _CustomerAccountPickerState();
}

class _CustomerAccountPickerState extends ConsumerState<CustomerAccountPicker> {
  final _search = TextEditingController();
  final _searchFocus = FocusNode();
  final _link = LayerLink();
  final _menu = OverlayPortalController();
  Timer? _searchTimer;
  var _lookingUp = false;
  var _searched = false;
  var _width = 360.0;
  List<ReservationCustomerMatch> _matches = [];

  @override
  void dispose() {
    _searchTimer?.cancel();
    _search.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final customer = widget.customer;
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final label = customer == null
        ? l10n.reservationSearchHint
        : '${customer.firstName} ${customer.lastName}';
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: OverlayPortal(
        controller: _menu,
        overlayChildBuilder: (context) => _menuPanel(l10n),
        child: CompositedTransformTarget(
          link: _link,
          child: LayoutBuilder(
            builder: (context, constraints) {
              _width = constraints.maxWidth;
              return InkWell(
                onTap: _toggle,
                borderRadius: BorderRadius.circular(AppRadii.md),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: l10n.reservationCustomerAccount,
                    helperText: customer == null
                        ? null
                        : '${customer.phoneNumber} · ${customer.email}',
                    suffixIcon: customer == null
                        ? const Icon(Icons.arrow_drop_down)
                        : IconButton(
                            tooltip: l10n.close,
                            onPressed: () {
                              _close();
                              widget.onChanged(null);
                            },
                            icon: const Icon(Icons.close),
                          ),
                  ),
                  child: Text(
                    label,
                    style: text.bodyLarge?.copyWith(
                      color: customer == null
                          ? scheme.onSurfaceVariant
                          : scheme.onSurface,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _menuPanel(AppLocalizations l10n) {
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: _close,
          ),
        ),
        CompositedTransformFollower(
          link: _link,
          targetAnchor: Alignment.bottomLeft,
          followerAnchor: Alignment.topLeft,
          showWhenUnlinked: false,
          offset: const Offset(0, 4),
          child: Align(
            alignment: AlignmentDirectional.topStart,
            child: SizedBox(
              width: _width,
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(AppRadii.md),
                clipBehavior: Clip.antiAlias,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 320),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        child: TextField(
                          controller: _search,
                          focusNode: _searchFocus,
                          textInputAction: TextInputAction.search,
                          onChanged: _onSearchChanged,
                          decoration: InputDecoration(
                            hintText: l10n.reservationSearchHint,
                            prefixIcon: const Icon(Icons.search),
                            isDense: true,
                          ),
                        ),
                      ),
                      if (_lookingUp)
                        const Padding(
                          padding: EdgeInsets.all(AppSpacing.lg),
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        )
                      else if (_searched && _matches.isEmpty)
                        Padding(
                          padding: const EdgeInsets.all(AppSpacing.lg),
                          child: Text(l10n.reservationSearchEmpty),
                        )
                      else
                        Flexible(
                          child: ListView(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            children: [
                              for (final match in _matches)
                                ListTile(
                                  title: Text(
                                    '${match.firstName} ${match.lastName}',
                                  ),
                                  subtitle: Text(
                                    '${match.phoneNumber}\n${match.email}',
                                  ),
                                  isThreeLine: true,
                                  onTap: () => _select(match),
                                ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _toggle() {
    if (_menu.isShowing) {
      _close();
      return;
    }
    _menu.show();
    _searchFocus.requestFocus();
  }

  void _close() {
    _searchTimer?.cancel();
    _menu.hide();
  }

  void _select(ReservationCustomerMatch match) {
    _searchTimer?.cancel();
    _search.clear();
    setState(() {
      _matches = [];
      _searched = false;
      _lookingUp = false;
    });
    _menu.hide();
    widget.onChanged(match);
  }

  void _onSearchChanged(String value) {
    _searchTimer?.cancel();
    final query = value.trim();
    if (query.length < 2) {
      setState(() {
        _matches = [];
        _searched = false;
        _lookingUp = false;
      });
      return;
    }
    _searchTimer = Timer(
      const Duration(seconds: 1),
      () => _searchCustomers(query),
    );
  }

  Future<void> _searchCustomers(String query) async {
    setState(() {
      _lookingUp = true;
      _searched = false;
    });
    try {
      final rows = await ref
          .read(reservationRepositoryProvider)
          .searchCustomers(UuidValue.fromString(widget.buildingId), query);
      if (!mounted || _search.text.trim() != query) {
        return;
      }
      setState(() {
        _matches = rows;
        _searched = true;
        _lookingUp = false;
      });
    } catch (error) {
      if (!mounted || _search.text.trim() != query) {
        return;
      }
      setState(() => _lookingUp = false);
      final l10n = AppLocalizations.of(context)!;
      showAppSnackBar(context, lookupError(l10n, mapError(error).l10nKey));
    }
  }
}
