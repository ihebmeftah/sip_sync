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
import '../../orders/dtos/customer_order_view.dart' as _i19cdsok;

/// Pushed to the customer who launched an order when that ticket changes.
abstract class CustomerOrderLive
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CustomerOrderLive._({
    this.open,
    this.changed,
  });

  factory CustomerOrderLive({
    _i19cdsok.CustomerOrderView? open,
    _i19cdsok.CustomerOrderView? changed,
  }) = _CustomerOrderLiveImpl;

  factory CustomerOrderLive.fromJson(Map<String, dynamic> jsonSerialization) {
    return CustomerOrderLive(
      open: jsonSerialization['open'] == null
          ? null
          : _iozg9o5r.Protocol().deserialize<_i19cdsok.CustomerOrderView>(
              jsonSerialization['open'],
            ),
      changed: jsonSerialization['changed'] == null
          ? null
          : _iozg9o5r.Protocol().deserialize<_i19cdsok.CustomerOrderView>(
              jsonSerialization['changed'],
            ),
    );
  }

  /// Newest in-progress visit. Empty once that visit is paid or cancelled.
  _i19cdsok.CustomerOrderView? open;

  /// Receipt that just changed, including a paid or cancelled order.
  _i19cdsok.CustomerOrderView? changed;

  /// Returns a shallow copy of this [CustomerOrderLive]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CustomerOrderLive copyWith({
    _i19cdsok.CustomerOrderView? open,
    _i19cdsok.CustomerOrderView? changed,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CustomerOrderLive',
      if (open != null) 'open': open?.toJson(),
      if (changed != null) 'changed': changed?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CustomerOrderLive',
      if (open != null) 'open': open?.toJsonForProtocol(),
      if (changed != null) 'changed': changed?.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CustomerOrderLiveImpl extends CustomerOrderLive {
  _CustomerOrderLiveImpl({
    _i19cdsok.CustomerOrderView? open,
    _i19cdsok.CustomerOrderView? changed,
  }) : super._(
         open: open,
         changed: changed,
       );

  /// Returns a shallow copy of this [CustomerOrderLive]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CustomerOrderLive copyWith({
    Object? open = _Undefined,
    Object? changed = _Undefined,
  }) {
    return CustomerOrderLive(
      open: open is _i19cdsok.CustomerOrderView? ? open : this.open?.copyWith(),
      changed: changed is _i19cdsok.CustomerOrderView?
          ? changed
          : this.changed?.copyWith(),
    );
  }
}
