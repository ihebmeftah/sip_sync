// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Stable identity for dependents that must not rebuild on loading/error flips.

@ProviderFor(signedInAuthUserId)
const signedInAuthUserIdProvider = SignedInAuthUserIdProvider._();

/// Stable identity for dependents that must not rebuild on loading/error flips.

final class SignedInAuthUserIdProvider
    extends $FunctionalProvider<UuidValue?, UuidValue?, UuidValue?>
    with $Provider<UuidValue?> {
  /// Stable identity for dependents that must not rebuild on loading/error flips.
  const SignedInAuthUserIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signedInAuthUserIdProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signedInAuthUserIdHash();

  @$internal
  @override
  $ProviderElement<UuidValue?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UuidValue? create(Ref ref) {
    return signedInAuthUserId(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UuidValue? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UuidValue?>(value),
    );
  }
}

String _$signedInAuthUserIdHash() =>
    r'300387fd303a4ac7b5d484b207ba9d79c442f1d0';

@ProviderFor(AuthViewModel)
const authViewModelProvider = AuthViewModelProvider._();

final class AuthViewModelProvider
    extends $NotifierProvider<AuthViewModel, AuthState> {
  const AuthViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authViewModelHash();

  @$internal
  @override
  AuthViewModel create() => AuthViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthState>(value),
    );
  }
}

String _$authViewModelHash() => r'3ba2610ba622bf8c92bf9a447c45c6604578033b';

abstract class _$AuthViewModel extends $Notifier<AuthState> {
  AuthState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AuthState, AuthState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AuthState, AuthState>,
              AuthState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
