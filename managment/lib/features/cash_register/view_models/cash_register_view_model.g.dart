// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_register_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The open shift, when the venue requires one.
///
/// Null when the switch is off or the drawer is shut. Orders and the
/// dashboard watch this so a pull, or an open on this device, retargets them.

@ProviderFor(openCashRegister)
const openCashRegisterProvider = OpenCashRegisterFamily._();

/// The open shift, when the venue requires one.
///
/// Null when the switch is off or the drawer is shut. Orders and the
/// dashboard watch this so a pull, or an open on this device, retargets them.

final class OpenCashRegisterProvider
    extends
        $FunctionalProvider<
          AsyncValue<CashRegisterSessionView?>,
          CashRegisterSessionView?,
          FutureOr<CashRegisterSessionView?>
        >
    with
        $FutureModifier<CashRegisterSessionView?>,
        $FutureProvider<CashRegisterSessionView?> {
  /// The open shift, when the venue requires one.
  ///
  /// Null when the switch is off or the drawer is shut. Orders and the
  /// dashboard watch this so a pull, or an open on this device, retargets them.
  const OpenCashRegisterProvider._({
    required OpenCashRegisterFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'openCashRegisterProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$openCashRegisterHash();

  @override
  String toString() {
    return r'openCashRegisterProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<CashRegisterSessionView?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CashRegisterSessionView?> create(Ref ref) {
    final argument = this.argument as String;
    return openCashRegister(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is OpenCashRegisterProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$openCashRegisterHash() => r'2fa11663ebef073572c84f2eccbe2a83e815735a';

/// The open shift, when the venue requires one.
///
/// Null when the switch is off or the drawer is shut. Orders and the
/// dashboard watch this so a pull, or an open on this device, retargets them.

final class OpenCashRegisterFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<CashRegisterSessionView?>, String> {
  const OpenCashRegisterFamily._()
    : super(
        retry: null,
        name: r'openCashRegisterProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The open shift, when the venue requires one.
  ///
  /// Null when the switch is off or the drawer is shut. Orders and the
  /// dashboard watch this so a pull, or an open on this device, retargets them.

  OpenCashRegisterProvider call(String buildingId) =>
      OpenCashRegisterProvider._(argument: buildingId, from: this);

  @override
  String toString() => r'openCashRegisterProvider';
}

/// Open, close, and history for the venue register.

@ProviderFor(CashRegisterViewModel)
const cashRegisterViewModelProvider = CashRegisterViewModelFamily._();

/// Open, close, and history for the venue register.
final class CashRegisterViewModelProvider
    extends
        $AsyncNotifierProvider<CashRegisterViewModel, CashRegisterScreenState> {
  /// Open, close, and history for the venue register.
  const CashRegisterViewModelProvider._({
    required CashRegisterViewModelFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'cashRegisterViewModelProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$cashRegisterViewModelHash();

  @override
  String toString() {
    return r'cashRegisterViewModelProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CashRegisterViewModel create() => CashRegisterViewModel();

  @override
  bool operator ==(Object other) {
    return other is CashRegisterViewModelProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$cashRegisterViewModelHash() =>
    r'5a6f8f354bb47eb2706e8c01e1f236370e709a24';

/// Open, close, and history for the venue register.

final class CashRegisterViewModelFamily extends $Family
    with
        $ClassFamilyOverride<
          CashRegisterViewModel,
          AsyncValue<CashRegisterScreenState>,
          CashRegisterScreenState,
          FutureOr<CashRegisterScreenState>,
          String
        > {
  const CashRegisterViewModelFamily._()
    : super(
        retry: null,
        name: r'cashRegisterViewModelProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Open, close, and history for the venue register.

  CashRegisterViewModelProvider call(String buildingId) =>
      CashRegisterViewModelProvider._(argument: buildingId, from: this);

  @override
  String toString() => r'cashRegisterViewModelProvider';
}

/// Open, close, and history for the venue register.

abstract class _$CashRegisterViewModel
    extends $AsyncNotifier<CashRegisterScreenState> {
  late final _$args = ref.$arg as String;
  String get buildingId => _$args;

  FutureOr<CashRegisterScreenState> build(String buildingId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref
            as $Ref<
              AsyncValue<CashRegisterScreenState>,
              CashRegisterScreenState
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<CashRegisterScreenState>,
                CashRegisterScreenState
              >,
              AsyncValue<CashRegisterScreenState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
