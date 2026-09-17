// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProfileViewModel)
const profileViewModelProvider = ProfileViewModelProvider._();

final class ProfileViewModelProvider
    extends $NotifierProvider<ProfileViewModel, ProfileUiState> {
  const ProfileViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileViewModelHash();

  @$internal
  @override
  ProfileViewModel create() => ProfileViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProfileUiState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProfileUiState>(value),
    );
  }
}

String _$profileViewModelHash() => r'4472b6a04bf9fc0226dc69d0122df632a0bcd068';

abstract class _$ProfileViewModel extends $Notifier<ProfileUiState> {
  ProfileUiState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ProfileUiState, ProfileUiState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ProfileUiState, ProfileUiState>,
              ProfileUiState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
