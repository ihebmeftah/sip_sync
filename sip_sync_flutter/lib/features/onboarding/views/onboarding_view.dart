import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/onboarding_store.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/routing/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../l10n/generated/app_localizations.dart';

class OnboardingView extends ConsumerStatefulWidget {
  const OnboardingView({super.key});

  @override
  ConsumerState<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends ConsumerState<OnboardingView> {
  final _pages = const [
    _OnboardPage(
      icon: Icons.storefront_outlined,
      titleKey: _OnboardCopy.findTitle,
      bodyKey: _OnboardCopy.findBody,
    ),
    _OnboardPage(
      icon: Icons.near_me_outlined,
      titleKey: _OnboardCopy.placeTitle,
      bodyKey: _OnboardCopy.placeBody,
    ),
    _OnboardPage(
      icon: Icons.map_outlined,
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
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.espresso,
              Color(0xFF3B1C12),
              AppColors.terracotta,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: _finish,
                  child: Text(
                    l10n.onboardingSkip,
                    style: text.labelLarge?.copyWith(
                      color: scheme.onInverseSurface,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _pages.length,
                  onPageChanged: (index) => setState(() => _index = index),
                  itemBuilder: (context, index) {
                    final page = _pages[index];
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xl,
                          ),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: constraints.maxHeight,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: scheme.onInverseSurface.withValues(
                                      alpha: 0.12,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                      AppSpacing.xl,
                                    ),
                                    child: Icon(
                                      page.icon,
                                      size: 56,
                                      color: AppColors.champagne,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.xl),
                                Text(
                                  page.title(l10n),
                                  textAlign: TextAlign.center,
                                  style: text.headlineMedium?.copyWith(
                                    color: scheme.onInverseSurface,
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.md),
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 420,
                                  ),
                                  child: Text(
                                    page.body(l10n),
                                    textAlign: TextAlign.center,
                                    style: text.bodyLarge?.copyWith(
                                      color: scheme.onInverseSurface.withValues(
                                        alpha: 0.86,
                                      ),
                                      height: 1.45,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
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
                            ? AppColors.champagne
                            : scheme.onInverseSurface.withValues(alpha: 0.35),
                        borderRadius: BorderRadius.circular(99),
                      ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.xl,
                  AppSpacing.xl,
                  AppSpacing.xl,
                  AppSpacing.lg,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.field,
                      foregroundColor: AppColors.espresso,
                    ),
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
                    child: Text(
                      last ? l10n.onboardingStart : l10n.onboardingNext,
                    ),
                  ),
                ),
              ),
            ],
          ),
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
