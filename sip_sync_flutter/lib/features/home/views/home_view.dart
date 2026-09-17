import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../auth/view_models/auth_view_model.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final session = ref.watch(authViewModelProvider).session;
    final name = session?.firstName ?? '';
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: const [
          LocaleMenuButton(),
        ],
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppBreakpoints.pageMax),
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  final wide = constraints.maxWidth >= AppBreakpoints.expanded;
                  final welcome = AppSurfaceCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.welcome(name), style: text.headlineMedium),
                        const SizedBox(height: AppSpacing.md),
                        Text(l10n.homeHint, style: text.bodyLarge),
                        if (session != null) ...[
                          const SizedBox(height: AppSpacing.md),
                          Text(session.email, style: text.bodyMedium),
                        ],
                        const SizedBox(height: AppSpacing.xl),
                        AppFilledButton(
                          label: l10n.signOut,
                          onPressed: () => ref
                              .read(authViewModelProvider.notifier)
                              .signOut(),
                        ),
                      ],
                    ),
                  );
                  final account = AppSurfaceCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.rolesLabel, style: text.titleLarge),
                        const SizedBox(height: AppSpacing.md),
                        Chip(
                          avatar: Icon(
                            Icons.local_cafe_outlined,
                            size: 18,
                            color: scheme.onSecondaryContainer,
                          ),
                          label: Text(l10n.appTitle),
                        ),
                      ],
                    ),
                  );
                  if (wide) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 5, child: welcome),
                        const SizedBox(width: AppSpacing.lg),
                        Expanded(flex: 4, child: account),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      welcome,
                      const SizedBox(height: AppSpacing.lg),
                      account,
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
