import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../auth/view_models/auth_view_model.dart';

/// Light shadcn rail for the signed-in console. Child routes fill the page.
class ConsoleShell extends ConsumerWidget {
  const ConsoleShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ShadTheme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= AppBreakpoints.expanded;
        if (wide) {
          return Scaffold(
            backgroundColor: theme.colorScheme.background,
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  width: AppBreakpoints.sidebar,
                  child: _ConsoleNav(),
                ),
                Expanded(child: child),
              ],
            ),
          );
        }
        return Scaffold(
          backgroundColor: theme.colorScheme.background,
          drawer: Drawer(
            backgroundColor: theme.colorScheme.card,
            child: Builder(
              builder: (drawerContext) => _ConsoleNav(
                onNavigate: () => Navigator.of(drawerContext).pop(),
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _MobileBar(),
              Expanded(child: child),
            ],
          ),
        );
      },
    );
  }
}

class _MobileBar extends StatelessWidget {
  const _MobileBar();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = ShadTheme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.card,
        border: Border(bottom: BorderSide(color: theme.colorScheme.border)),
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 56,
          child: Row(
            children: [
              Builder(
                builder: (context) => ShadIconButton.ghost(
                  icon: const Icon(LucideIcons.panelLeft, size: 18),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
              Expanded(
                child: Text(l10n.appTitle, style: theme.textTheme.large),
              ),
              const LocaleMenuButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onPressed;
}

class _ConsoleNav extends ConsumerWidget {
  const _ConsoleNav({this.onNavigate});

  final VoidCallback? onNavigate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = ShadTheme.of(context);
    final path = GoRouterState.of(context).uri.path;
    final session = ref.watch(authViewModelProvider).session;
    final name = session == null
        ? ''
        : '${session.firstName} ${session.lastName}'.trim();
    final initial = name.isEmpty ? '?' : name[0];

    void go(void Function() navigate) {
      onNavigate?.call();
      navigate();
    }

    final items = [
      _NavItem(
        icon: LucideIcons.chartColumn,
        label: l10n.navStats,
        selected: path.startsWith('/stats'),
        onPressed: () => go(() => const StatsRoute().go(context)),
      ),
      _NavItem(
        icon: LucideIcons.users,
        label: l10n.navUsers,
        selected: path.startsWith('/users'),
        onPressed: () => go(() => const UsersRoute().go(context)),
      ),
      _NavItem(
        icon: LucideIcons.contact,
        label: l10n.navCustomers,
        selected: path.startsWith('/customers'),
        onPressed: () => go(() => const CustomersRoute().go(context)),
      ),
      _NavItem(
        icon: LucideIcons.building2,
        label: l10n.navBuildings,
        selected: path.startsWith('/buildings'),
        onPressed: () => go(() => const BuildingsRoute().go(context)),
      ),
      _NavItem(
        icon: LucideIcons.package,
        label: l10n.navPacks,
        selected: path.startsWith('/packs'),
        onPressed: () => go(() => const PacksRoute().go(context)),
      ),
    ];

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.card,
        border: BorderDirectional(
          end: BorderSide(color: theme.colorScheme.border),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _Brand(),
              const SizedBox(height: AppSpacing.xl),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Text(l10n.navSection, style: theme.textTheme.muted),
              ),
              const SizedBox(height: AppSpacing.sm),
              for (final item in items)
                _NavButton(
                  icon: item.icon,
                  label: item.label,
                  selected: item.selected,
                  onPressed: item.onPressed,
                ),
              const Spacer(),
              const ShadSeparator.horizontal(),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  _Initials(initial: initial),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.small,
                        ),
                        if (session != null)
                          Text(
                            session.email,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.muted,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              ShadButton.ghost(
                width: double.infinity,
                mainAxisAlignment: MainAxisAlignment.start,
                leading: const Icon(LucideIcons.logOut, size: 16),
                onPressed: () =>
                    ref.read(authViewModelProvider.notifier).signOut(),
                child: Text(l10n.signOut),
              ),
              const SizedBox(height: AppSpacing.sm),
              const LocaleSwitcher(),
            ],
          ),
        ),
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand();

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(AppRadii.sm),
            ),
            child: SizedBox(
              width: 32,
              height: 32,
              child: Center(
                child: Text(
                  'S',
                  style: theme.textTheme.small.copyWith(
                    color: theme.colorScheme.primaryForeground,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              l10n.appTitle,
              maxLines: 2,
              style: theme.textTheme.small.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Initials extends StatelessWidget {
  const _Initials({required this.initial});

  final String initial;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
        shape: BoxShape.circle,
      ),
      child: SizedBox(
        width: 36,
        height: 36,
        child: Center(child: Text(initial, style: theme.textTheme.small)),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: ShadButton.raw(
        variant: selected
            ? ShadButtonVariant.secondary
            : ShadButtonVariant.ghost,
        width: double.infinity,
        mainAxisAlignment: MainAxisAlignment.start,
        leading: Icon(icon, size: 16),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}

/// Shared page frame for console sections.
class ConsolePage extends StatelessWidget {
  const ConsolePage({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.action,
  });

  final String title;
  final String? subtitle;
  final Widget child;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return ColoredBox(
      color: theme.colorScheme.background,
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppBreakpoints.pageMax),
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  final stacked = constraints.maxWidth < 560 && action != null;
                  final heading = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: theme.textTheme.h2),
                      if (subtitle != null) ...[
                        const SizedBox(height: AppSpacing.sm),
                        Text(subtitle!, style: theme.textTheme.muted),
                      ],
                    ],
                  );
                  if (stacked) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        heading,
                        const SizedBox(height: AppSpacing.lg),
                        action!,
                      ],
                    );
                  }
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: heading),
                      if (action != null) ...[
                        const SizedBox(width: AppSpacing.lg),
                        action!,
                      ],
                    ],
                  );
                },
              ),
              const SizedBox(height: AppSpacing.xl),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
