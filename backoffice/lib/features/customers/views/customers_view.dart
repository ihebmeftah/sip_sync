import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:sip_sync_client/sip_sync_client.dart';

import '../../../core/errors/app_notice.dart';
import '../../../core/errors/error_mapper.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../core/widgets/app_loader.dart';
import '../../../core/widgets/list_page_bar.dart';
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
        loading: () => const AppScreenLoader(),
        error: (error, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LoadFailureNotice(error: error),
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
                people: state.owners.items,
                page: state.owners,
                empty: l10n.empty,
                theme: theme,
                onPrevious: () => ref
                    .read(customersViewModelProvider.notifier)
                    .previousOwners(),
                onNext: () =>
                    ref.read(customersViewModelProvider.notifier).nextOwners(),
              ),
              child: Text(l10n.tabOwners),
            ),
            ShadTab(
              value: _DirectoryTab.customers,
              content: _PeopleList(
                people: state.customers.items,
                page: state.customers,
                empty: l10n.empty,
                theme: theme,
                onPrevious: () => ref
                    .read(customersViewModelProvider.notifier)
                    .previousCustomers(),
                onNext: () => ref
                    .read(customersViewModelProvider.notifier)
                    .nextCustomers(),
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
    required this.page,
    required this.empty,
    required this.theme,
    required this.onPrevious,
    required this.onNext,
  });

  final List<PlatformPersonView> people;
  final PlatformPersonPage page;
  final String empty;
  final ShadThemeData theme;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

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
          ListPageBar(
            total: page.total,
            limit: page.limit,
            offset: page.offset,
            onPrevious: onPrevious,
            onNext: onNext,
          ),
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
