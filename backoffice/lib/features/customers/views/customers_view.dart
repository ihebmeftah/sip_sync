import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/errors/error_mapper.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../console/views/console_shell.dart';
import '../view_models/customers_view_model.dart';
import 'person_detail_dialog.dart';

/// Owners and customers on the platform, with contact details and created time.
class CustomersView extends ConsumerStatefulWidget {
  const CustomersView({super.key});

  @override
  ConsumerState<CustomersView> createState() => _CustomersViewState();
}

enum _DirectoryTab { owners, customers }

class _CustomersViewState extends ConsumerState<CustomersView> {
  _DirectoryTab _tab = _DirectoryTab.owners;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final directory = ref.watch(customersViewModelProvider);
    final theme = ShadTheme.of(context);
    return ConsolePage(
      title: l10n.customersTitle,
      subtitle: l10n.customersSubtitle,
      child: directory.when(
        loading: () => const LinearProgressIndicator(),
        error: (error, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppErrorBanner(message: lookupError(l10n, mapError(error).l10nKey)),
            ShadButton.outline(
              onPressed: () =>
                  ref.read(customersViewModelProvider.notifier).refresh(),
              child: Text(l10n.retry),
            ),
          ],
        ),
        data: (state) => ShadTabs<_DirectoryTab>(
          value: _tab,
          onChanged: (value) => setState(() => _tab = value),
          tabs: [
            ShadTab(
              value: _DirectoryTab.owners,
              content: _PeopleList(
                people: state.owners,
                empty: l10n.empty,
                theme: theme,
              ),
              child: Text(l10n.tabOwners),
            ),
            ShadTab(
              value: _DirectoryTab.customers,
              content: _PeopleList(
                people: state.customers,
                empty: l10n.empty,
                theme: theme,
              ),
              child: Text(l10n.tabCustomers),
            ),
          ],
        ),
      ),
    );
  }
}

class _PeopleList extends StatelessWidget {
  const _PeopleList({
    required this.people,
    required this.empty,
    required this.theme,
  });

  final List<PlatformPersonView> people;
  final String empty;
  final ShadThemeData theme;

  @override
  Widget build(BuildContext context) {
    if (people.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: AppSpacing.lg),
        child: Text(empty, style: theme.textTheme.muted),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.lg),
      child: Column(
        children: [
          for (final person in people) ...[
            _PersonCard(person: person),
            const SizedBox(height: AppSpacing.md),
          ],
        ],
      ),
    );
  }
}

class _PersonCard extends StatelessWidget {
  const _PersonCard({required this.person});

  final PlatformPersonView person;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = ShadTheme.of(context);
    final name = '${person.firstName} ${person.lastName}'.trim();
    return ShadCard(
      width: double.infinity,
      rowMainAxisSize: MainAxisSize.max,
      columnCrossAxisAlignment: CrossAxisAlignment.stretch,
      title: Text(name),
      description: Text('${person.email} · ${person.phoneNumber}'),
      trailing: ShadButton.outline(
        size: ShadButtonSize.sm,
        onPressed: () => showShadDialog<void>(
          context: context,
          builder: (_) => PersonDetailDialog(person: person),
        ),
        child: Text(l10n.viewDetails),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: AppSpacing.lg),
        child: Text(
          l10n.accountCreated(formatAccountCreated(context, person.createdAt)),
          style: theme.textTheme.muted,
        ),
      ),
    );
  }
}
