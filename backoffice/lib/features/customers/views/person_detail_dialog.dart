import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../l10n/generated/app_localizations.dart';

/// Contact and created time for one owner or customer.
class PersonDetailDialog extends StatelessWidget {
  const PersonDetailDialog({super.key, required this.person});

  final PlatformPersonView person;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final name = '${person.firstName} ${person.lastName}'.trim();
    return ShadDialog(
      title: Text(name),
      constraints: const BoxConstraints(maxWidth: AppBreakpoints.formMax),
      actions: [
        ShadButton.outline(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.close),
        ),
      ],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Line(label: l10n.email, value: person.email),
          _Line(label: l10n.phone, value: person.phoneNumber),
          _Line(
            label: l10n.createdAt,
            value: formatAccountCreated(context, person.createdAt),
          ),
        ],
      ),
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: theme.textTheme.muted),
          const SizedBox(height: AppSpacing.xs),
          Text(value, style: theme.textTheme.small),
        ],
      ),
    );
  }
}

/// Locale-aware date and time for an account [createdAt].
String formatAccountCreated(BuildContext context, DateTime createdAt) {
  final locale = Localizations.localeOf(context).toString();
  return DateFormat.yMMMd(locale).add_jm().format(createdAt.toLocal());
}
