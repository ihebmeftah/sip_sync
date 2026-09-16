/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;
import 'package:sip_sync_server/src/generated/protocol.dart' as _iaib1p48;
import '../auth/profile_view.dart' as _ihlmgtq9;

abstract class AccountSessionView
    implements _is.SerializableModel, _is.ProtocolSerialization {
  AccountSessionView._({
    required this.profile,
    required this.isBackofficeAdmin,
    required this.isSystemDefaultAdmin,
  });

  factory AccountSessionView({
    required _ihlmgtq9.ProfileView profile,
    required bool isBackofficeAdmin,
    required bool isSystemDefaultAdmin,
  }) = _AccountSessionViewImpl;

  factory AccountSessionView.fromJson(Map<String, dynamic> jsonSerialization) {
    return AccountSessionView(
      profile: _iaib1p48.Protocol().deserialize<_ihlmgtq9.ProfileView>(
        jsonSerialization['profile'],
      ),
      isBackofficeAdmin: _is.BoolJsonExtension.fromJson(
        jsonSerialization['isBackofficeAdmin'],
      ),
      isSystemDefaultAdmin: _is.BoolJsonExtension.fromJson(
        jsonSerialization['isSystemDefaultAdmin'],
      ),
    );
  }

  _ihlmgtq9.ProfileView profile;

  bool isBackofficeAdmin;

  bool isSystemDefaultAdmin;

  /// Returns a shallow copy of this [AccountSessionView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AccountSessionView copyWith({
    _ihlmgtq9.ProfileView? profile,
    bool? isBackofficeAdmin,
    bool? isSystemDefaultAdmin,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AccountSessionView',
      'profile': profile.toJson(),
      'isBackofficeAdmin': isBackofficeAdmin,
      'isSystemDefaultAdmin': isSystemDefaultAdmin,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AccountSessionView',
      'profile': profile.toJsonForProtocol(),
      'isBackofficeAdmin': isBackofficeAdmin,
      'isSystemDefaultAdmin': isSystemDefaultAdmin,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _AccountSessionViewImpl extends AccountSessionView {
  _AccountSessionViewImpl({
    required _ihlmgtq9.ProfileView profile,
    required bool isBackofficeAdmin,
    required bool isSystemDefaultAdmin,
  }) : super._(
         profile: profile,
         isBackofficeAdmin: isBackofficeAdmin,
         isSystemDefaultAdmin: isSystemDefaultAdmin,
       );

  /// Returns a shallow copy of this [AccountSessionView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AccountSessionView copyWith({
    _ihlmgtq9.ProfileView? profile,
    bool? isBackofficeAdmin,
    bool? isSystemDefaultAdmin,
  }) {
    return AccountSessionView(
      profile: profile ?? this.profile.copyWith(),
      isBackofficeAdmin: isBackofficeAdmin ?? this.isBackofficeAdmin,
      isSystemDefaultAdmin: isSystemDefaultAdmin ?? this.isSystemDefaultAdmin,
    );
  }
}
