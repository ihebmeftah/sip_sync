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
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'package:sip_sync_client/src/protocol/protocol.dart' as _iozg9o5r;
import '../../discovery/dtos/customer_menu_section.dart' as _i5wjhh7t;

/// Full customer menu for one venue. No ingredients or composition.
abstract class CustomerMenu
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CustomerMenu._({
    required this.currencyCode,
    required this.sections,
  });

  factory CustomerMenu({
    required String currencyCode,
    required List<_i5wjhh7t.CustomerMenuSection> sections,
  }) = _CustomerMenuImpl;

  factory CustomerMenu.fromJson(Map<String, dynamic> jsonSerialization) {
    return CustomerMenu(
      currencyCode: jsonSerialization['currencyCode'] as String,
      sections: _iozg9o5r.Protocol()
          .deserialize<List<_i5wjhh7t.CustomerMenuSection>>(
            jsonSerialization['sections'],
          ),
    );
  }

  String currencyCode;

  List<_i5wjhh7t.CustomerMenuSection> sections;

  /// Returns a shallow copy of this [CustomerMenu]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CustomerMenu copyWith({
    String? currencyCode,
    List<_i5wjhh7t.CustomerMenuSection>? sections,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CustomerMenu',
      'currencyCode': currencyCode,
      'sections': sections.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CustomerMenu',
      'currencyCode': currencyCode,
      'sections': sections.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _CustomerMenuImpl extends CustomerMenu {
  _CustomerMenuImpl({
    required String currencyCode,
    required List<_i5wjhh7t.CustomerMenuSection> sections,
  }) : super._(
         currencyCode: currencyCode,
         sections: sections,
       );

  /// Returns a shallow copy of this [CustomerMenu]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CustomerMenu copyWith({
    String? currencyCode,
    List<_i5wjhh7t.CustomerMenuSection>? sections,
  }) {
    return CustomerMenu(
      currencyCode: currencyCode ?? this.currencyCode,
      sections: sections ?? this.sections.map((e0) => e0.copyWith()).toList(),
    );
  }
}
