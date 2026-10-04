import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../l10n/generated/app_localizations.dart';
import '../theme/app_tokens.dart';

/// Previous / next controls for a server page.
class ListPageBar extends StatelessWidget {
  const ListPageBar({
    super.key,
    required this.total,
    required this.limit,
    required this.offset,
    required this.onPrevious,
    required this.onNext,
  });

  final int total;
  final int limit;
  final int offset;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    if (limit <= 0 || total <= limit) {
      return const SizedBox.shrink();
    }
    final l10n = AppLocalizations.of(context)!;
    final pages = (total + limit - 1) ~/ limit;
    final current = offset ~/ limit + 1;
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.lg),
      child: Row(
        children: [
          ShadButton.outline(
            onPressed: offset > 0 ? onPrevious : null,
            child: Text(l10n.previousPage),
          ),
          const SizedBox(width: AppSpacing.md),
          Text(l10n.pageOf(current, pages)),
          const SizedBox(width: AppSpacing.md),
          ShadButton.outline(
            onPressed: offset + limit < total ? onNext : null,
            child: Text(l10n.nextPage),
          ),
        ],
      ),
    );
  }
}
