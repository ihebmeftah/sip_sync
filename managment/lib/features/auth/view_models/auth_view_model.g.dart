// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(signedInActorId)
const signedInActorIdProvider = SignedInActorIdProvider._();

final class SignedInActorIdProvider
    extends $FunctionalProvider<UuidValue?, UuidValue?, UuidValue?>
    with $Provider<UuidValue?> {
  const SignedInActorIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signedInActorIdProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signedInActorIdHash();

  @$internal
  @override
  $ProviderElement<UuidValue?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UuidValue? create(Ref ref) {
    return signedInActorId(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UuidValue? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UuidValue?>(value),
    );
  }
}

String _$signedInActorIdHash() => r'6c6efc7f8b0c379fbec4462e8c06204b437079a1';

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

String _$authViewModelHash() => r'ae3f0ff3e2963e5bc2bdca51dc390e86e055c4f3';

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
