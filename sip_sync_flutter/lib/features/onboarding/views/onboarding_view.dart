import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/onboarding_store.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_icons.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_controls.dart';
import '../../../l10n/generated/app_localizations.dart';

class OnboardingView extends ConsumerStatefulWidget {
  const OnboardingView({super.key});

  @override
  ConsumerState<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends ConsumerState<OnboardingView> {
  final _pages = const [
    _OnboardPage(
      icon: AppIcons.storefront,
      titleKey: _OnboardCopy.findTitle,
      bodyKey: _OnboardCopy.findBody,
    ),
    _OnboardPage(
      icon: AppIcons.nearMe,
      titleKey: _OnboardCopy.placeTitle,
      bodyKey: _OnboardCopy.placeBody,
    ),
    _OnboardPage(
      icon: AppIcons.map,
      titleKey: _OnboardCopy.walkTitle,
      bodyKey: _OnboardCopy.walkBody,
    ),
  ];

  final _controller = PageController();
  int _index = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    await getIt<OnboardingStore>().complete();
    if (!mounted) {
      return;
    }
    const SignInRoute().go(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final scheme = Theme.of(context).colorScheme;
    final last = _index == _pages.length - 1;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                onPressed: _finish,
                child: Text(l10n.onboardingSkip),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (index) => setState(() => _index = index),
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return ListView(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.xl,
                      AppSpacing.md,
                      AppSpacing.xl,
                      AppSpacing.xl,
                    ),
                    children: [
                      Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 420),
                          child: Column(
                            children: [
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  color: scheme.primaryContainer,
                                  borderRadius: BorderRadius.circular(
                                    AppRadii.xl,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(AppSpacing.lg),
                                  child: Icon(
                                    page.icon,
                                    size: 40,
                                    color: scheme.onPrimaryContainer,
                                  ),
                                ),
                              ),
                              const SizedBox(height: AppSpacing.lg),
                              Text(
                                page.title(l10n),
                                textAlign: TextAlign.center,
                                style: text.headlineMedium,
                              ),
                              const SizedBox(height: AppSpacing.md),
                              Text(
                                page.body(l10n),
                                textAlign: TextAlign.center,
                                style: text.bodyLarge?.copyWith(
                                  color: scheme.onSurfaceVariant,
                                  height: 1.45,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < _pages.length; i++)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: i == _index ? 28 : 8,
                    decoration: BoxDecoration(
                      color: i == _index
                          ? scheme.primary
                          : scheme.outlineVariant,
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xl,
                AppSpacing.md,
                AppSpacing.xl,
                AppSpacing.lg,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: AppFilledButton(
                  label: last ? l10n.onboardingStart : l10n.onboardingNext,
                  onPressed: () {
                    if (last) {
                      _finish();
                      return;
                    }
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 320),
                      curve: Curves.easeOutCubic,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum _OnboardCopy {
  findTitle,
  findBody,
  placeTitle,
  placeBody,
  walkTitle,
  walkBody,
}

class _OnboardPage {
  const _OnboardPage({
    required this.icon,
    required this.titleKey,
    required this.bodyKey,
  });

  final IconData icon;
  final _OnboardCopy titleKey;
  final _OnboardCopy bodyKey;

  String title(AppLocalizations l10n) => switch (titleKey) {
    _OnboardCopy.findTitle => l10n.onboardingFindTitle,
    _OnboardCopy.placeTitle => l10n.onboardingPlaceTitle,
    _OnboardCopy.walkTitle => l10n.onboardingWalkTitle,
    _ => '',
  };

  String body(AppLocalizations l10n) => switch (bodyKey) {
    _OnboardCopy.findBody => l10n.onboardingFindBody,
    _OnboardCopy.placeBody => l10n.onboardingPlaceBody,
    _OnboardCopy.walkBody => l10n.onboardingWalkBody,
    _ => '',
  };
}
