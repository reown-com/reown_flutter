// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'json_rpc_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WcPairingDeleteRequest {

 int get code; String get message;
/// Create a copy of WcPairingDeleteRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WcPairingDeleteRequestCopyWith<WcPairingDeleteRequest> get copyWith => _$WcPairingDeleteRequestCopyWithImpl<WcPairingDeleteRequest>(this as WcPairingDeleteRequest, _$identity);

  /// Serializes this WcPairingDeleteRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WcPairingDeleteRequest&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'WcPairingDeleteRequest(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class $WcPairingDeleteRequestCopyWith<$Res>  {
  factory $WcPairingDeleteRequestCopyWith(WcPairingDeleteRequest value, $Res Function(WcPairingDeleteRequest) _then) = _$WcPairingDeleteRequestCopyWithImpl;
@useResult
$Res call({
 int code, String message
});




}
/// @nodoc
class _$WcPairingDeleteRequestCopyWithImpl<$Res>
    implements $WcPairingDeleteRequestCopyWith<$Res> {
  _$WcPairingDeleteRequestCopyWithImpl(this._self, this._then);

  final WcPairingDeleteRequest _self;
  final $Res Function(WcPairingDeleteRequest) _then;

/// Create a copy of WcPairingDeleteRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? message = null,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WcPairingDeleteRequest].
extension WcPairingDeleteRequestPatterns on WcPairingDeleteRequest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WcPairingDeleteRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WcPairingDeleteRequest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WcPairingDeleteRequest value)  $default,){
final _that = this;
switch (_that) {
case _WcPairingDeleteRequest():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WcPairingDeleteRequest value)?  $default,){
final _that = this;
switch (_that) {
case _WcPairingDeleteRequest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int code,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WcPairingDeleteRequest() when $default != null:
return $default(_that.code,_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int code,  String message)  $default,) {final _that = this;
switch (_that) {
case _WcPairingDeleteRequest():
return $default(_that.code,_that.message);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int code,  String message)?  $default,) {final _that = this;
switch (_that) {
case _WcPairingDeleteRequest() when $default != null:
return $default(_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class _WcPairingDeleteRequest implements WcPairingDeleteRequest {
  const _WcPairingDeleteRequest({required this.code, required this.message});
  factory _WcPairingDeleteRequest.fromJson(Map<String, dynamic> json) => _$WcPairingDeleteRequestFromJson(json);

@override final  int code;
@override final  String message;

/// Create a copy of WcPairingDeleteRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WcPairingDeleteRequestCopyWith<_WcPairingDeleteRequest> get copyWith => __$WcPairingDeleteRequestCopyWithImpl<_WcPairingDeleteRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WcPairingDeleteRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WcPairingDeleteRequest&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'WcPairingDeleteRequest(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class _$WcPairingDeleteRequestCopyWith<$Res> implements $WcPairingDeleteRequestCopyWith<$Res> {
  factory _$WcPairingDeleteRequestCopyWith(_WcPairingDeleteRequest value, $Res Function(_WcPairingDeleteRequest) _then) = __$WcPairingDeleteRequestCopyWithImpl;
@override @useResult
$Res call({
 int code, String message
});




}
/// @nodoc
class __$WcPairingDeleteRequestCopyWithImpl<$Res>
    implements _$WcPairingDeleteRequestCopyWith<$Res> {
  __$WcPairingDeleteRequestCopyWithImpl(this._self, this._then);

  final _WcPairingDeleteRequest _self;
  final $Res Function(_WcPairingDeleteRequest) _then;

/// Create a copy of WcPairingDeleteRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = null,}) {
  return _then(_WcPairingDeleteRequest(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$WcPairingPingRequest {

 Map<String, dynamic> get data;
/// Create a copy of WcPairingPingRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WcPairingPingRequestCopyWith<WcPairingPingRequest> get copyWith => _$WcPairingPingRequestCopyWithImpl<WcPairingPingRequest>(this as WcPairingPingRequest, _$identity);

  /// Serializes this WcPairingPingRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WcPairingPingRequest&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'WcPairingPingRequest(data: $data)';
}


}

/// @nodoc
abstract mixin class $WcPairingPingRequestCopyWith<$Res>  {
  factory $WcPairingPingRequestCopyWith(WcPairingPingRequest value, $Res Function(WcPairingPingRequest) _then) = _$WcPairingPingRequestCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> data
});




}
/// @nodoc
class _$WcPairingPingRequestCopyWithImpl<$Res>
    implements $WcPairingPingRequestCopyWith<$Res> {
  _$WcPairingPingRequestCopyWithImpl(this._self, this._then);

  final WcPairingPingRequest _self;
  final $Res Function(WcPairingPingRequest) _then;

/// Create a copy of WcPairingPingRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = null,}) {
  return _then(_self.copyWith(
data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [WcPairingPingRequest].
extension WcPairingPingRequestPatterns on WcPairingPingRequest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WcPairingPingRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WcPairingPingRequest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WcPairingPingRequest value)  $default,){
final _that = this;
switch (_that) {
case _WcPairingPingRequest():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WcPairingPingRequest value)?  $default,){
final _that = this;
switch (_that) {
case _WcPairingPingRequest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, dynamic> data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WcPairingPingRequest() when $default != null:
return $default(_that.data);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, dynamic> data)  $default,) {final _that = this;
switch (_that) {
case _WcPairingPingRequest():
return $default(_that.data);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, dynamic> data)?  $default,) {final _that = this;
switch (_that) {
case _WcPairingPingRequest() when $default != null:
return $default(_that.data);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class _WcPairingPingRequest implements WcPairingPingRequest {
  const _WcPairingPingRequest({required final  Map<String, dynamic> data}): _data = data;
  factory _WcPairingPingRequest.fromJson(Map<String, dynamic> json) => _$WcPairingPingRequestFromJson(json);

 final  Map<String, dynamic> _data;
@override Map<String, dynamic> get data {
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_data);
}


/// Create a copy of WcPairingPingRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WcPairingPingRequestCopyWith<_WcPairingPingRequest> get copyWith => __$WcPairingPingRequestCopyWithImpl<_WcPairingPingRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WcPairingPingRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WcPairingPingRequest&&const DeepCollectionEquality().equals(other._data, _data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'WcPairingPingRequest(data: $data)';
}


}

/// @nodoc
abstract mixin class _$WcPairingPingRequestCopyWith<$Res> implements $WcPairingPingRequestCopyWith<$Res> {
  factory _$WcPairingPingRequestCopyWith(_WcPairingPingRequest value, $Res Function(_WcPairingPingRequest) _then) = __$WcPairingPingRequestCopyWithImpl;
@override @useResult
$Res call({
 Map<String, dynamic> data
});




}
/// @nodoc
class __$WcPairingPingRequestCopyWithImpl<$Res>
    implements _$WcPairingPingRequestCopyWith<$Res> {
  __$WcPairingPingRequestCopyWithImpl(this._self, this._then);

  final _WcPairingPingRequest _self;
  final $Res Function(_WcPairingPingRequest) _then;

/// Create a copy of WcPairingPingRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(_WcPairingPingRequest(
data: null == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}


/// @nodoc
mixin _$WcSessionProposeRequest {

 List<Relay> get relays; Map<String, RequiredNamespace> get requiredNamespaces; Map<String, RequiredNamespace>? get optionalNamespaces; Map<String, String>? get sessionProperties; ConnectionMetadata get proposer; ProposalRequests? get requests; List<SessionAuthPayload>? get authentication;@JsonKey(name: 'wallet_pay') WalletPayRequestParams? get walletPay;
/// Create a copy of WcSessionProposeRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WcSessionProposeRequestCopyWith<WcSessionProposeRequest> get copyWith => _$WcSessionProposeRequestCopyWithImpl<WcSessionProposeRequest>(this as WcSessionProposeRequest, _$identity);

  /// Serializes this WcSessionProposeRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WcSessionProposeRequest&&const DeepCollectionEquality().equals(other.relays, relays)&&const DeepCollectionEquality().equals(other.requiredNamespaces, requiredNamespaces)&&const DeepCollectionEquality().equals(other.optionalNamespaces, optionalNamespaces)&&const DeepCollectionEquality().equals(other.sessionProperties, sessionProperties)&&(identical(other.proposer, proposer) || other.proposer == proposer)&&(identical(other.requests, requests) || other.requests == requests)&&const DeepCollectionEquality().equals(other.authentication, authentication)&&(identical(other.walletPay, walletPay) || other.walletPay == walletPay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(relays),const DeepCollectionEquality().hash(requiredNamespaces),const DeepCollectionEquality().hash(optionalNamespaces),const DeepCollectionEquality().hash(sessionProperties),proposer,requests,const DeepCollectionEquality().hash(authentication),walletPay);

@override
String toString() {
  return 'WcSessionProposeRequest(relays: $relays, requiredNamespaces: $requiredNamespaces, optionalNamespaces: $optionalNamespaces, sessionProperties: $sessionProperties, proposer: $proposer, requests: $requests, authentication: $authentication, walletPay: $walletPay)';
}


}

/// @nodoc
abstract mixin class $WcSessionProposeRequestCopyWith<$Res>  {
  factory $WcSessionProposeRequestCopyWith(WcSessionProposeRequest value, $Res Function(WcSessionProposeRequest) _then) = _$WcSessionProposeRequestCopyWithImpl;
@useResult
$Res call({
 List<Relay> relays, Map<String, RequiredNamespace> requiredNamespaces, Map<String, RequiredNamespace>? optionalNamespaces, Map<String, String>? sessionProperties, ConnectionMetadata proposer, ProposalRequests? requests, List<SessionAuthPayload>? authentication,@JsonKey(name: 'wallet_pay') WalletPayRequestParams? walletPay
});


$ConnectionMetadataCopyWith<$Res> get proposer;$ProposalRequestsCopyWith<$Res>? get requests;$WalletPayRequestParamsCopyWith<$Res>? get walletPay;

}
/// @nodoc
class _$WcSessionProposeRequestCopyWithImpl<$Res>
    implements $WcSessionProposeRequestCopyWith<$Res> {
  _$WcSessionProposeRequestCopyWithImpl(this._self, this._then);

  final WcSessionProposeRequest _self;
  final $Res Function(WcSessionProposeRequest) _then;

/// Create a copy of WcSessionProposeRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? relays = null,Object? requiredNamespaces = null,Object? optionalNamespaces = freezed,Object? sessionProperties = freezed,Object? proposer = null,Object? requests = freezed,Object? authentication = freezed,Object? walletPay = freezed,}) {
  return _then(_self.copyWith(
relays: null == relays ? _self.relays : relays // ignore: cast_nullable_to_non_nullable
as List<Relay>,requiredNamespaces: null == requiredNamespaces ? _self.requiredNamespaces : requiredNamespaces // ignore: cast_nullable_to_non_nullable
as Map<String, RequiredNamespace>,optionalNamespaces: freezed == optionalNamespaces ? _self.optionalNamespaces : optionalNamespaces // ignore: cast_nullable_to_non_nullable
as Map<String, RequiredNamespace>?,sessionProperties: freezed == sessionProperties ? _self.sessionProperties : sessionProperties // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,proposer: null == proposer ? _self.proposer : proposer // ignore: cast_nullable_to_non_nullable
as ConnectionMetadata,requests: freezed == requests ? _self.requests : requests // ignore: cast_nullable_to_non_nullable
as ProposalRequests?,authentication: freezed == authentication ? _self.authentication : authentication // ignore: cast_nullable_to_non_nullable
as List<SessionAuthPayload>?,walletPay: freezed == walletPay ? _self.walletPay : walletPay // ignore: cast_nullable_to_non_nullable
as WalletPayRequestParams?,
  ));
}
/// Create a copy of WcSessionProposeRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConnectionMetadataCopyWith<$Res> get proposer {
  
  return $ConnectionMetadataCopyWith<$Res>(_self.proposer, (value) {
    return _then(_self.copyWith(proposer: value));
  });
}/// Create a copy of WcSessionProposeRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProposalRequestsCopyWith<$Res>? get requests {
    if (_self.requests == null) {
    return null;
  }

  return $ProposalRequestsCopyWith<$Res>(_self.requests!, (value) {
    return _then(_self.copyWith(requests: value));
  });
}/// Create a copy of WcSessionProposeRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WalletPayRequestParamsCopyWith<$Res>? get walletPay {
    if (_self.walletPay == null) {
    return null;
  }

  return $WalletPayRequestParamsCopyWith<$Res>(_self.walletPay!, (value) {
    return _then(_self.copyWith(walletPay: value));
  });
}
}


/// Adds pattern-matching-related methods to [WcSessionProposeRequest].
extension WcSessionProposeRequestPatterns on WcSessionProposeRequest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WcSessionProposeRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WcSessionProposeRequest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WcSessionProposeRequest value)  $default,){
final _that = this;
switch (_that) {
case _WcSessionProposeRequest():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WcSessionProposeRequest value)?  $default,){
final _that = this;
switch (_that) {
case _WcSessionProposeRequest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Relay> relays,  Map<String, RequiredNamespace> requiredNamespaces,  Map<String, RequiredNamespace>? optionalNamespaces,  Map<String, String>? sessionProperties,  ConnectionMetadata proposer,  ProposalRequests? requests,  List<SessionAuthPayload>? authentication, @JsonKey(name: 'wallet_pay')  WalletPayRequestParams? walletPay)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WcSessionProposeRequest() when $default != null:
return $default(_that.relays,_that.requiredNamespaces,_that.optionalNamespaces,_that.sessionProperties,_that.proposer,_that.requests,_that.authentication,_that.walletPay);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Relay> relays,  Map<String, RequiredNamespace> requiredNamespaces,  Map<String, RequiredNamespace>? optionalNamespaces,  Map<String, String>? sessionProperties,  ConnectionMetadata proposer,  ProposalRequests? requests,  List<SessionAuthPayload>? authentication, @JsonKey(name: 'wallet_pay')  WalletPayRequestParams? walletPay)  $default,) {final _that = this;
switch (_that) {
case _WcSessionProposeRequest():
return $default(_that.relays,_that.requiredNamespaces,_that.optionalNamespaces,_that.sessionProperties,_that.proposer,_that.requests,_that.authentication,_that.walletPay);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Relay> relays,  Map<String, RequiredNamespace> requiredNamespaces,  Map<String, RequiredNamespace>? optionalNamespaces,  Map<String, String>? sessionProperties,  ConnectionMetadata proposer,  ProposalRequests? requests,  List<SessionAuthPayload>? authentication, @JsonKey(name: 'wallet_pay')  WalletPayRequestParams? walletPay)?  $default,) {final _that = this;
switch (_that) {
case _WcSessionProposeRequest() when $default != null:
return $default(_that.relays,_that.requiredNamespaces,_that.optionalNamespaces,_that.sessionProperties,_that.proposer,_that.requests,_that.authentication,_that.walletPay);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _WcSessionProposeRequest implements WcSessionProposeRequest {
  const _WcSessionProposeRequest({required final  List<Relay> relays, required final  Map<String, RequiredNamespace> requiredNamespaces, final  Map<String, RequiredNamespace>? optionalNamespaces, final  Map<String, String>? sessionProperties, required this.proposer, this.requests, final  List<SessionAuthPayload>? authentication, @JsonKey(name: 'wallet_pay') this.walletPay}): _relays = relays,_requiredNamespaces = requiredNamespaces,_optionalNamespaces = optionalNamespaces,_sessionProperties = sessionProperties,_authentication = authentication;
  factory _WcSessionProposeRequest.fromJson(Map<String, dynamic> json) => _$WcSessionProposeRequestFromJson(json);

 final  List<Relay> _relays;
@override List<Relay> get relays {
  if (_relays is EqualUnmodifiableListView) return _relays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_relays);
}

 final  Map<String, RequiredNamespace> _requiredNamespaces;
@override Map<String, RequiredNamespace> get requiredNamespaces {
  if (_requiredNamespaces is EqualUnmodifiableMapView) return _requiredNamespaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_requiredNamespaces);
}

 final  Map<String, RequiredNamespace>? _optionalNamespaces;
@override Map<String, RequiredNamespace>? get optionalNamespaces {
  final value = _optionalNamespaces;
  if (value == null) return null;
  if (_optionalNamespaces is EqualUnmodifiableMapView) return _optionalNamespaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, String>? _sessionProperties;
@override Map<String, String>? get sessionProperties {
  final value = _sessionProperties;
  if (value == null) return null;
  if (_sessionProperties is EqualUnmodifiableMapView) return _sessionProperties;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  ConnectionMetadata proposer;
@override final  ProposalRequests? requests;
 final  List<SessionAuthPayload>? _authentication;
@override List<SessionAuthPayload>? get authentication {
  final value = _authentication;
  if (value == null) return null;
  if (_authentication is EqualUnmodifiableListView) return _authentication;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'wallet_pay') final  WalletPayRequestParams? walletPay;

/// Create a copy of WcSessionProposeRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WcSessionProposeRequestCopyWith<_WcSessionProposeRequest> get copyWith => __$WcSessionProposeRequestCopyWithImpl<_WcSessionProposeRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WcSessionProposeRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WcSessionProposeRequest&&const DeepCollectionEquality().equals(other._relays, _relays)&&const DeepCollectionEquality().equals(other._requiredNamespaces, _requiredNamespaces)&&const DeepCollectionEquality().equals(other._optionalNamespaces, _optionalNamespaces)&&const DeepCollectionEquality().equals(other._sessionProperties, _sessionProperties)&&(identical(other.proposer, proposer) || other.proposer == proposer)&&(identical(other.requests, requests) || other.requests == requests)&&const DeepCollectionEquality().equals(other._authentication, _authentication)&&(identical(other.walletPay, walletPay) || other.walletPay == walletPay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_relays),const DeepCollectionEquality().hash(_requiredNamespaces),const DeepCollectionEquality().hash(_optionalNamespaces),const DeepCollectionEquality().hash(_sessionProperties),proposer,requests,const DeepCollectionEquality().hash(_authentication),walletPay);

@override
String toString() {
  return 'WcSessionProposeRequest(relays: $relays, requiredNamespaces: $requiredNamespaces, optionalNamespaces: $optionalNamespaces, sessionProperties: $sessionProperties, proposer: $proposer, requests: $requests, authentication: $authentication, walletPay: $walletPay)';
}


}

/// @nodoc
abstract mixin class _$WcSessionProposeRequestCopyWith<$Res> implements $WcSessionProposeRequestCopyWith<$Res> {
  factory _$WcSessionProposeRequestCopyWith(_WcSessionProposeRequest value, $Res Function(_WcSessionProposeRequest) _then) = __$WcSessionProposeRequestCopyWithImpl;
@override @useResult
$Res call({
 List<Relay> relays, Map<String, RequiredNamespace> requiredNamespaces, Map<String, RequiredNamespace>? optionalNamespaces, Map<String, String>? sessionProperties, ConnectionMetadata proposer, ProposalRequests? requests, List<SessionAuthPayload>? authentication,@JsonKey(name: 'wallet_pay') WalletPayRequestParams? walletPay
});


@override $ConnectionMetadataCopyWith<$Res> get proposer;@override $ProposalRequestsCopyWith<$Res>? get requests;@override $WalletPayRequestParamsCopyWith<$Res>? get walletPay;

}
/// @nodoc
class __$WcSessionProposeRequestCopyWithImpl<$Res>
    implements _$WcSessionProposeRequestCopyWith<$Res> {
  __$WcSessionProposeRequestCopyWithImpl(this._self, this._then);

  final _WcSessionProposeRequest _self;
  final $Res Function(_WcSessionProposeRequest) _then;

/// Create a copy of WcSessionProposeRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? relays = null,Object? requiredNamespaces = null,Object? optionalNamespaces = freezed,Object? sessionProperties = freezed,Object? proposer = null,Object? requests = freezed,Object? authentication = freezed,Object? walletPay = freezed,}) {
  return _then(_WcSessionProposeRequest(
relays: null == relays ? _self._relays : relays // ignore: cast_nullable_to_non_nullable
as List<Relay>,requiredNamespaces: null == requiredNamespaces ? _self._requiredNamespaces : requiredNamespaces // ignore: cast_nullable_to_non_nullable
as Map<String, RequiredNamespace>,optionalNamespaces: freezed == optionalNamespaces ? _self._optionalNamespaces : optionalNamespaces // ignore: cast_nullable_to_non_nullable
as Map<String, RequiredNamespace>?,sessionProperties: freezed == sessionProperties ? _self._sessionProperties : sessionProperties // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,proposer: null == proposer ? _self.proposer : proposer // ignore: cast_nullable_to_non_nullable
as ConnectionMetadata,requests: freezed == requests ? _self.requests : requests // ignore: cast_nullable_to_non_nullable
as ProposalRequests?,authentication: freezed == authentication ? _self._authentication : authentication // ignore: cast_nullable_to_non_nullable
as List<SessionAuthPayload>?,walletPay: freezed == walletPay ? _self.walletPay : walletPay // ignore: cast_nullable_to_non_nullable
as WalletPayRequestParams?,
  ));
}

/// Create a copy of WcSessionProposeRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConnectionMetadataCopyWith<$Res> get proposer {
  
  return $ConnectionMetadataCopyWith<$Res>(_self.proposer, (value) {
    return _then(_self.copyWith(proposer: value));
  });
}/// Create a copy of WcSessionProposeRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProposalRequestsCopyWith<$Res>? get requests {
    if (_self.requests == null) {
    return null;
  }

  return $ProposalRequestsCopyWith<$Res>(_self.requests!, (value) {
    return _then(_self.copyWith(requests: value));
  });
}/// Create a copy of WcSessionProposeRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$WalletPayRequestParamsCopyWith<$Res>? get walletPay {
    if (_self.walletPay == null) {
    return null;
  }

  return $WalletPayRequestParamsCopyWith<$Res>(_self.walletPay!, (value) {
    return _then(_self.copyWith(walletPay: value));
  });
}
}


/// @nodoc
mixin _$WcSessionSettleRequest {

 Relay get relay; Map<String, Namespace> get namespaces; int get expiry; ConnectionMetadata get controller; Map<String, RequiredNamespace>? get requiredNamespaces; Map<String, RequiredNamespace>? get optionalNamespaces; Map<String, String>? get sessionProperties; ProposalRequestsResponses? get proposalRequestsResponses;
/// Create a copy of WcSessionSettleRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WcSessionSettleRequestCopyWith<WcSessionSettleRequest> get copyWith => _$WcSessionSettleRequestCopyWithImpl<WcSessionSettleRequest>(this as WcSessionSettleRequest, _$identity);

  /// Serializes this WcSessionSettleRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WcSessionSettleRequest&&(identical(other.relay, relay) || other.relay == relay)&&const DeepCollectionEquality().equals(other.namespaces, namespaces)&&(identical(other.expiry, expiry) || other.expiry == expiry)&&(identical(other.controller, controller) || other.controller == controller)&&const DeepCollectionEquality().equals(other.requiredNamespaces, requiredNamespaces)&&const DeepCollectionEquality().equals(other.optionalNamespaces, optionalNamespaces)&&const DeepCollectionEquality().equals(other.sessionProperties, sessionProperties)&&(identical(other.proposalRequestsResponses, proposalRequestsResponses) || other.proposalRequestsResponses == proposalRequestsResponses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,relay,const DeepCollectionEquality().hash(namespaces),expiry,controller,const DeepCollectionEquality().hash(requiredNamespaces),const DeepCollectionEquality().hash(optionalNamespaces),const DeepCollectionEquality().hash(sessionProperties),proposalRequestsResponses);

@override
String toString() {
  return 'WcSessionSettleRequest(relay: $relay, namespaces: $namespaces, expiry: $expiry, controller: $controller, requiredNamespaces: $requiredNamespaces, optionalNamespaces: $optionalNamespaces, sessionProperties: $sessionProperties, proposalRequestsResponses: $proposalRequestsResponses)';
}


}

/// @nodoc
abstract mixin class $WcSessionSettleRequestCopyWith<$Res>  {
  factory $WcSessionSettleRequestCopyWith(WcSessionSettleRequest value, $Res Function(WcSessionSettleRequest) _then) = _$WcSessionSettleRequestCopyWithImpl;
@useResult
$Res call({
 Relay relay, Map<String, Namespace> namespaces, int expiry, ConnectionMetadata controller, Map<String, RequiredNamespace>? requiredNamespaces, Map<String, RequiredNamespace>? optionalNamespaces, Map<String, String>? sessionProperties, ProposalRequestsResponses? proposalRequestsResponses
});


$ConnectionMetadataCopyWith<$Res> get controller;$ProposalRequestsResponsesCopyWith<$Res>? get proposalRequestsResponses;

}
/// @nodoc
class _$WcSessionSettleRequestCopyWithImpl<$Res>
    implements $WcSessionSettleRequestCopyWith<$Res> {
  _$WcSessionSettleRequestCopyWithImpl(this._self, this._then);

  final WcSessionSettleRequest _self;
  final $Res Function(WcSessionSettleRequest) _then;

/// Create a copy of WcSessionSettleRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? relay = null,Object? namespaces = null,Object? expiry = null,Object? controller = null,Object? requiredNamespaces = freezed,Object? optionalNamespaces = freezed,Object? sessionProperties = freezed,Object? proposalRequestsResponses = freezed,}) {
  return _then(_self.copyWith(
relay: null == relay ? _self.relay : relay // ignore: cast_nullable_to_non_nullable
as Relay,namespaces: null == namespaces ? _self.namespaces : namespaces // ignore: cast_nullable_to_non_nullable
as Map<String, Namespace>,expiry: null == expiry ? _self.expiry : expiry // ignore: cast_nullable_to_non_nullable
as int,controller: null == controller ? _self.controller : controller // ignore: cast_nullable_to_non_nullable
as ConnectionMetadata,requiredNamespaces: freezed == requiredNamespaces ? _self.requiredNamespaces : requiredNamespaces // ignore: cast_nullable_to_non_nullable
as Map<String, RequiredNamespace>?,optionalNamespaces: freezed == optionalNamespaces ? _self.optionalNamespaces : optionalNamespaces // ignore: cast_nullable_to_non_nullable
as Map<String, RequiredNamespace>?,sessionProperties: freezed == sessionProperties ? _self.sessionProperties : sessionProperties // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,proposalRequestsResponses: freezed == proposalRequestsResponses ? _self.proposalRequestsResponses : proposalRequestsResponses // ignore: cast_nullable_to_non_nullable
as ProposalRequestsResponses?,
  ));
}
/// Create a copy of WcSessionSettleRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConnectionMetadataCopyWith<$Res> get controller {
  
  return $ConnectionMetadataCopyWith<$Res>(_self.controller, (value) {
    return _then(_self.copyWith(controller: value));
  });
}/// Create a copy of WcSessionSettleRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProposalRequestsResponsesCopyWith<$Res>? get proposalRequestsResponses {
    if (_self.proposalRequestsResponses == null) {
    return null;
  }

  return $ProposalRequestsResponsesCopyWith<$Res>(_self.proposalRequestsResponses!, (value) {
    return _then(_self.copyWith(proposalRequestsResponses: value));
  });
}
}


/// Adds pattern-matching-related methods to [WcSessionSettleRequest].
extension WcSessionSettleRequestPatterns on WcSessionSettleRequest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WcSessionSettleRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WcSessionSettleRequest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WcSessionSettleRequest value)  $default,){
final _that = this;
switch (_that) {
case _WcSessionSettleRequest():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WcSessionSettleRequest value)?  $default,){
final _that = this;
switch (_that) {
case _WcSessionSettleRequest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Relay relay,  Map<String, Namespace> namespaces,  int expiry,  ConnectionMetadata controller,  Map<String, RequiredNamespace>? requiredNamespaces,  Map<String, RequiredNamespace>? optionalNamespaces,  Map<String, String>? sessionProperties,  ProposalRequestsResponses? proposalRequestsResponses)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WcSessionSettleRequest() when $default != null:
return $default(_that.relay,_that.namespaces,_that.expiry,_that.controller,_that.requiredNamespaces,_that.optionalNamespaces,_that.sessionProperties,_that.proposalRequestsResponses);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Relay relay,  Map<String, Namespace> namespaces,  int expiry,  ConnectionMetadata controller,  Map<String, RequiredNamespace>? requiredNamespaces,  Map<String, RequiredNamespace>? optionalNamespaces,  Map<String, String>? sessionProperties,  ProposalRequestsResponses? proposalRequestsResponses)  $default,) {final _that = this;
switch (_that) {
case _WcSessionSettleRequest():
return $default(_that.relay,_that.namespaces,_that.expiry,_that.controller,_that.requiredNamespaces,_that.optionalNamespaces,_that.sessionProperties,_that.proposalRequestsResponses);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Relay relay,  Map<String, Namespace> namespaces,  int expiry,  ConnectionMetadata controller,  Map<String, RequiredNamespace>? requiredNamespaces,  Map<String, RequiredNamespace>? optionalNamespaces,  Map<String, String>? sessionProperties,  ProposalRequestsResponses? proposalRequestsResponses)?  $default,) {final _that = this;
switch (_that) {
case _WcSessionSettleRequest() when $default != null:
return $default(_that.relay,_that.namespaces,_that.expiry,_that.controller,_that.requiredNamespaces,_that.optionalNamespaces,_that.sessionProperties,_that.proposalRequestsResponses);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _WcSessionSettleRequest implements WcSessionSettleRequest {
  const _WcSessionSettleRequest({required this.relay, required final  Map<String, Namespace> namespaces, required this.expiry, required this.controller, final  Map<String, RequiredNamespace>? requiredNamespaces, final  Map<String, RequiredNamespace>? optionalNamespaces, final  Map<String, String>? sessionProperties, this.proposalRequestsResponses}): _namespaces = namespaces,_requiredNamespaces = requiredNamespaces,_optionalNamespaces = optionalNamespaces,_sessionProperties = sessionProperties;
  factory _WcSessionSettleRequest.fromJson(Map<String, dynamic> json) => _$WcSessionSettleRequestFromJson(json);

@override final  Relay relay;
 final  Map<String, Namespace> _namespaces;
@override Map<String, Namespace> get namespaces {
  if (_namespaces is EqualUnmodifiableMapView) return _namespaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_namespaces);
}

@override final  int expiry;
@override final  ConnectionMetadata controller;
 final  Map<String, RequiredNamespace>? _requiredNamespaces;
@override Map<String, RequiredNamespace>? get requiredNamespaces {
  final value = _requiredNamespaces;
  if (value == null) return null;
  if (_requiredNamespaces is EqualUnmodifiableMapView) return _requiredNamespaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, RequiredNamespace>? _optionalNamespaces;
@override Map<String, RequiredNamespace>? get optionalNamespaces {
  final value = _optionalNamespaces;
  if (value == null) return null;
  if (_optionalNamespaces is EqualUnmodifiableMapView) return _optionalNamespaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  Map<String, String>? _sessionProperties;
@override Map<String, String>? get sessionProperties {
  final value = _sessionProperties;
  if (value == null) return null;
  if (_sessionProperties is EqualUnmodifiableMapView) return _sessionProperties;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  ProposalRequestsResponses? proposalRequestsResponses;

/// Create a copy of WcSessionSettleRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WcSessionSettleRequestCopyWith<_WcSessionSettleRequest> get copyWith => __$WcSessionSettleRequestCopyWithImpl<_WcSessionSettleRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WcSessionSettleRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WcSessionSettleRequest&&(identical(other.relay, relay) || other.relay == relay)&&const DeepCollectionEquality().equals(other._namespaces, _namespaces)&&(identical(other.expiry, expiry) || other.expiry == expiry)&&(identical(other.controller, controller) || other.controller == controller)&&const DeepCollectionEquality().equals(other._requiredNamespaces, _requiredNamespaces)&&const DeepCollectionEquality().equals(other._optionalNamespaces, _optionalNamespaces)&&const DeepCollectionEquality().equals(other._sessionProperties, _sessionProperties)&&(identical(other.proposalRequestsResponses, proposalRequestsResponses) || other.proposalRequestsResponses == proposalRequestsResponses));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,relay,const DeepCollectionEquality().hash(_namespaces),expiry,controller,const DeepCollectionEquality().hash(_requiredNamespaces),const DeepCollectionEquality().hash(_optionalNamespaces),const DeepCollectionEquality().hash(_sessionProperties),proposalRequestsResponses);

@override
String toString() {
  return 'WcSessionSettleRequest(relay: $relay, namespaces: $namespaces, expiry: $expiry, controller: $controller, requiredNamespaces: $requiredNamespaces, optionalNamespaces: $optionalNamespaces, sessionProperties: $sessionProperties, proposalRequestsResponses: $proposalRequestsResponses)';
}


}

/// @nodoc
abstract mixin class _$WcSessionSettleRequestCopyWith<$Res> implements $WcSessionSettleRequestCopyWith<$Res> {
  factory _$WcSessionSettleRequestCopyWith(_WcSessionSettleRequest value, $Res Function(_WcSessionSettleRequest) _then) = __$WcSessionSettleRequestCopyWithImpl;
@override @useResult
$Res call({
 Relay relay, Map<String, Namespace> namespaces, int expiry, ConnectionMetadata controller, Map<String, RequiredNamespace>? requiredNamespaces, Map<String, RequiredNamespace>? optionalNamespaces, Map<String, String>? sessionProperties, ProposalRequestsResponses? proposalRequestsResponses
});


@override $ConnectionMetadataCopyWith<$Res> get controller;@override $ProposalRequestsResponsesCopyWith<$Res>? get proposalRequestsResponses;

}
/// @nodoc
class __$WcSessionSettleRequestCopyWithImpl<$Res>
    implements _$WcSessionSettleRequestCopyWith<$Res> {
  __$WcSessionSettleRequestCopyWithImpl(this._self, this._then);

  final _WcSessionSettleRequest _self;
  final $Res Function(_WcSessionSettleRequest) _then;

/// Create a copy of WcSessionSettleRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? relay = null,Object? namespaces = null,Object? expiry = null,Object? controller = null,Object? requiredNamespaces = freezed,Object? optionalNamespaces = freezed,Object? sessionProperties = freezed,Object? proposalRequestsResponses = freezed,}) {
  return _then(_WcSessionSettleRequest(
relay: null == relay ? _self.relay : relay // ignore: cast_nullable_to_non_nullable
as Relay,namespaces: null == namespaces ? _self._namespaces : namespaces // ignore: cast_nullable_to_non_nullable
as Map<String, Namespace>,expiry: null == expiry ? _self.expiry : expiry // ignore: cast_nullable_to_non_nullable
as int,controller: null == controller ? _self.controller : controller // ignore: cast_nullable_to_non_nullable
as ConnectionMetadata,requiredNamespaces: freezed == requiredNamespaces ? _self._requiredNamespaces : requiredNamespaces // ignore: cast_nullable_to_non_nullable
as Map<String, RequiredNamespace>?,optionalNamespaces: freezed == optionalNamespaces ? _self._optionalNamespaces : optionalNamespaces // ignore: cast_nullable_to_non_nullable
as Map<String, RequiredNamespace>?,sessionProperties: freezed == sessionProperties ? _self._sessionProperties : sessionProperties // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,proposalRequestsResponses: freezed == proposalRequestsResponses ? _self.proposalRequestsResponses : proposalRequestsResponses // ignore: cast_nullable_to_non_nullable
as ProposalRequestsResponses?,
  ));
}

/// Create a copy of WcSessionSettleRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConnectionMetadataCopyWith<$Res> get controller {
  
  return $ConnectionMetadataCopyWith<$Res>(_self.controller, (value) {
    return _then(_self.copyWith(controller: value));
  });
}/// Create a copy of WcSessionSettleRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProposalRequestsResponsesCopyWith<$Res>? get proposalRequestsResponses {
    if (_self.proposalRequestsResponses == null) {
    return null;
  }

  return $ProposalRequestsResponsesCopyWith<$Res>(_self.proposalRequestsResponses!, (value) {
    return _then(_self.copyWith(proposalRequestsResponses: value));
  });
}
}


/// @nodoc
mixin _$WcSessionProposeResponse {

 Relay get relay; String get responderPublicKey;
/// Create a copy of WcSessionProposeResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WcSessionProposeResponseCopyWith<WcSessionProposeResponse> get copyWith => _$WcSessionProposeResponseCopyWithImpl<WcSessionProposeResponse>(this as WcSessionProposeResponse, _$identity);

  /// Serializes this WcSessionProposeResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WcSessionProposeResponse&&(identical(other.relay, relay) || other.relay == relay)&&(identical(other.responderPublicKey, responderPublicKey) || other.responderPublicKey == responderPublicKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,relay,responderPublicKey);

@override
String toString() {
  return 'WcSessionProposeResponse(relay: $relay, responderPublicKey: $responderPublicKey)';
}


}

/// @nodoc
abstract mixin class $WcSessionProposeResponseCopyWith<$Res>  {
  factory $WcSessionProposeResponseCopyWith(WcSessionProposeResponse value, $Res Function(WcSessionProposeResponse) _then) = _$WcSessionProposeResponseCopyWithImpl;
@useResult
$Res call({
 Relay relay, String responderPublicKey
});




}
/// @nodoc
class _$WcSessionProposeResponseCopyWithImpl<$Res>
    implements $WcSessionProposeResponseCopyWith<$Res> {
  _$WcSessionProposeResponseCopyWithImpl(this._self, this._then);

  final WcSessionProposeResponse _self;
  final $Res Function(WcSessionProposeResponse) _then;

/// Create a copy of WcSessionProposeResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? relay = null,Object? responderPublicKey = null,}) {
  return _then(_self.copyWith(
relay: null == relay ? _self.relay : relay // ignore: cast_nullable_to_non_nullable
as Relay,responderPublicKey: null == responderPublicKey ? _self.responderPublicKey : responderPublicKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WcSessionProposeResponse].
extension WcSessionProposeResponsePatterns on WcSessionProposeResponse {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WcSessionProposeResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WcSessionProposeResponse() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WcSessionProposeResponse value)  $default,){
final _that = this;
switch (_that) {
case _WcSessionProposeResponse():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WcSessionProposeResponse value)?  $default,){
final _that = this;
switch (_that) {
case _WcSessionProposeResponse() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Relay relay,  String responderPublicKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WcSessionProposeResponse() when $default != null:
return $default(_that.relay,_that.responderPublicKey);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Relay relay,  String responderPublicKey)  $default,) {final _that = this;
switch (_that) {
case _WcSessionProposeResponse():
return $default(_that.relay,_that.responderPublicKey);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Relay relay,  String responderPublicKey)?  $default,) {final _that = this;
switch (_that) {
case _WcSessionProposeResponse() when $default != null:
return $default(_that.relay,_that.responderPublicKey);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class _WcSessionProposeResponse implements WcSessionProposeResponse {
  const _WcSessionProposeResponse({required this.relay, required this.responderPublicKey});
  factory _WcSessionProposeResponse.fromJson(Map<String, dynamic> json) => _$WcSessionProposeResponseFromJson(json);

@override final  Relay relay;
@override final  String responderPublicKey;

/// Create a copy of WcSessionProposeResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WcSessionProposeResponseCopyWith<_WcSessionProposeResponse> get copyWith => __$WcSessionProposeResponseCopyWithImpl<_WcSessionProposeResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WcSessionProposeResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WcSessionProposeResponse&&(identical(other.relay, relay) || other.relay == relay)&&(identical(other.responderPublicKey, responderPublicKey) || other.responderPublicKey == responderPublicKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,relay,responderPublicKey);

@override
String toString() {
  return 'WcSessionProposeResponse(relay: $relay, responderPublicKey: $responderPublicKey)';
}


}

/// @nodoc
abstract mixin class _$WcSessionProposeResponseCopyWith<$Res> implements $WcSessionProposeResponseCopyWith<$Res> {
  factory _$WcSessionProposeResponseCopyWith(_WcSessionProposeResponse value, $Res Function(_WcSessionProposeResponse) _then) = __$WcSessionProposeResponseCopyWithImpl;
@override @useResult
$Res call({
 Relay relay, String responderPublicKey
});




}
/// @nodoc
class __$WcSessionProposeResponseCopyWithImpl<$Res>
    implements _$WcSessionProposeResponseCopyWith<$Res> {
  __$WcSessionProposeResponseCopyWithImpl(this._self, this._then);

  final _WcSessionProposeResponse _self;
  final $Res Function(_WcSessionProposeResponse) _then;

/// Create a copy of WcSessionProposeResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? relay = null,Object? responderPublicKey = null,}) {
  return _then(_WcSessionProposeResponse(
relay: null == relay ? _self.relay : relay // ignore: cast_nullable_to_non_nullable
as Relay,responderPublicKey: null == responderPublicKey ? _self.responderPublicKey : responderPublicKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$WcSessionUpdateRequest {

 Map<String, Namespace> get namespaces;
/// Create a copy of WcSessionUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WcSessionUpdateRequestCopyWith<WcSessionUpdateRequest> get copyWith => _$WcSessionUpdateRequestCopyWithImpl<WcSessionUpdateRequest>(this as WcSessionUpdateRequest, _$identity);

  /// Serializes this WcSessionUpdateRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WcSessionUpdateRequest&&const DeepCollectionEquality().equals(other.namespaces, namespaces));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(namespaces));

@override
String toString() {
  return 'WcSessionUpdateRequest(namespaces: $namespaces)';
}


}

/// @nodoc
abstract mixin class $WcSessionUpdateRequestCopyWith<$Res>  {
  factory $WcSessionUpdateRequestCopyWith(WcSessionUpdateRequest value, $Res Function(WcSessionUpdateRequest) _then) = _$WcSessionUpdateRequestCopyWithImpl;
@useResult
$Res call({
 Map<String, Namespace> namespaces
});




}
/// @nodoc
class _$WcSessionUpdateRequestCopyWithImpl<$Res>
    implements $WcSessionUpdateRequestCopyWith<$Res> {
  _$WcSessionUpdateRequestCopyWithImpl(this._self, this._then);

  final WcSessionUpdateRequest _self;
  final $Res Function(WcSessionUpdateRequest) _then;

/// Create a copy of WcSessionUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? namespaces = null,}) {
  return _then(_self.copyWith(
namespaces: null == namespaces ? _self.namespaces : namespaces // ignore: cast_nullable_to_non_nullable
as Map<String, Namespace>,
  ));
}

}


/// Adds pattern-matching-related methods to [WcSessionUpdateRequest].
extension WcSessionUpdateRequestPatterns on WcSessionUpdateRequest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WcSessionUpdateRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WcSessionUpdateRequest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WcSessionUpdateRequest value)  $default,){
final _that = this;
switch (_that) {
case _WcSessionUpdateRequest():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WcSessionUpdateRequest value)?  $default,){
final _that = this;
switch (_that) {
case _WcSessionUpdateRequest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, Namespace> namespaces)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WcSessionUpdateRequest() when $default != null:
return $default(_that.namespaces);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, Namespace> namespaces)  $default,) {final _that = this;
switch (_that) {
case _WcSessionUpdateRequest():
return $default(_that.namespaces);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, Namespace> namespaces)?  $default,) {final _that = this;
switch (_that) {
case _WcSessionUpdateRequest() when $default != null:
return $default(_that.namespaces);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class _WcSessionUpdateRequest implements WcSessionUpdateRequest {
  const _WcSessionUpdateRequest({required final  Map<String, Namespace> namespaces}): _namespaces = namespaces;
  factory _WcSessionUpdateRequest.fromJson(Map<String, dynamic> json) => _$WcSessionUpdateRequestFromJson(json);

 final  Map<String, Namespace> _namespaces;
@override Map<String, Namespace> get namespaces {
  if (_namespaces is EqualUnmodifiableMapView) return _namespaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_namespaces);
}


/// Create a copy of WcSessionUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WcSessionUpdateRequestCopyWith<_WcSessionUpdateRequest> get copyWith => __$WcSessionUpdateRequestCopyWithImpl<_WcSessionUpdateRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WcSessionUpdateRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WcSessionUpdateRequest&&const DeepCollectionEquality().equals(other._namespaces, _namespaces));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_namespaces));

@override
String toString() {
  return 'WcSessionUpdateRequest(namespaces: $namespaces)';
}


}

/// @nodoc
abstract mixin class _$WcSessionUpdateRequestCopyWith<$Res> implements $WcSessionUpdateRequestCopyWith<$Res> {
  factory _$WcSessionUpdateRequestCopyWith(_WcSessionUpdateRequest value, $Res Function(_WcSessionUpdateRequest) _then) = __$WcSessionUpdateRequestCopyWithImpl;
@override @useResult
$Res call({
 Map<String, Namespace> namespaces
});




}
/// @nodoc
class __$WcSessionUpdateRequestCopyWithImpl<$Res>
    implements _$WcSessionUpdateRequestCopyWith<$Res> {
  __$WcSessionUpdateRequestCopyWithImpl(this._self, this._then);

  final _WcSessionUpdateRequest _self;
  final $Res Function(_WcSessionUpdateRequest) _then;

/// Create a copy of WcSessionUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? namespaces = null,}) {
  return _then(_WcSessionUpdateRequest(
namespaces: null == namespaces ? _self._namespaces : namespaces // ignore: cast_nullable_to_non_nullable
as Map<String, Namespace>,
  ));
}


}


/// @nodoc
mixin _$WcSessionExtendRequest {

 Map<String, dynamic>? get data;
/// Create a copy of WcSessionExtendRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WcSessionExtendRequestCopyWith<WcSessionExtendRequest> get copyWith => _$WcSessionExtendRequestCopyWithImpl<WcSessionExtendRequest>(this as WcSessionExtendRequest, _$identity);

  /// Serializes this WcSessionExtendRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WcSessionExtendRequest&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'WcSessionExtendRequest(data: $data)';
}


}

/// @nodoc
abstract mixin class $WcSessionExtendRequestCopyWith<$Res>  {
  factory $WcSessionExtendRequestCopyWith(WcSessionExtendRequest value, $Res Function(WcSessionExtendRequest) _then) = _$WcSessionExtendRequestCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic>? data
});




}
/// @nodoc
class _$WcSessionExtendRequestCopyWithImpl<$Res>
    implements $WcSessionExtendRequestCopyWith<$Res> {
  _$WcSessionExtendRequestCopyWithImpl(this._self, this._then);

  final WcSessionExtendRequest _self;
  final $Res Function(WcSessionExtendRequest) _then;

/// Create a copy of WcSessionExtendRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = freezed,}) {
  return _then(_self.copyWith(
data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [WcSessionExtendRequest].
extension WcSessionExtendRequestPatterns on WcSessionExtendRequest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WcSessionExtendRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WcSessionExtendRequest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WcSessionExtendRequest value)  $default,){
final _that = this;
switch (_that) {
case _WcSessionExtendRequest():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WcSessionExtendRequest value)?  $default,){
final _that = this;
switch (_that) {
case _WcSessionExtendRequest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, dynamic>? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WcSessionExtendRequest() when $default != null:
return $default(_that.data);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, dynamic>? data)  $default,) {final _that = this;
switch (_that) {
case _WcSessionExtendRequest():
return $default(_that.data);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, dynamic>? data)?  $default,) {final _that = this;
switch (_that) {
case _WcSessionExtendRequest() when $default != null:
return $default(_that.data);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _WcSessionExtendRequest implements WcSessionExtendRequest {
  const _WcSessionExtendRequest({final  Map<String, dynamic>? data}): _data = data;
  factory _WcSessionExtendRequest.fromJson(Map<String, dynamic> json) => _$WcSessionExtendRequestFromJson(json);

 final  Map<String, dynamic>? _data;
@override Map<String, dynamic>? get data {
  final value = _data;
  if (value == null) return null;
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of WcSessionExtendRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WcSessionExtendRequestCopyWith<_WcSessionExtendRequest> get copyWith => __$WcSessionExtendRequestCopyWithImpl<_WcSessionExtendRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WcSessionExtendRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WcSessionExtendRequest&&const DeepCollectionEquality().equals(other._data, _data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'WcSessionExtendRequest(data: $data)';
}


}

/// @nodoc
abstract mixin class _$WcSessionExtendRequestCopyWith<$Res> implements $WcSessionExtendRequestCopyWith<$Res> {
  factory _$WcSessionExtendRequestCopyWith(_WcSessionExtendRequest value, $Res Function(_WcSessionExtendRequest) _then) = __$WcSessionExtendRequestCopyWithImpl;
@override @useResult
$Res call({
 Map<String, dynamic>? data
});




}
/// @nodoc
class __$WcSessionExtendRequestCopyWithImpl<$Res>
    implements _$WcSessionExtendRequestCopyWith<$Res> {
  __$WcSessionExtendRequestCopyWithImpl(this._self, this._then);

  final _WcSessionExtendRequest _self;
  final $Res Function(_WcSessionExtendRequest) _then;

/// Create a copy of WcSessionExtendRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = freezed,}) {
  return _then(_WcSessionExtendRequest(
data: freezed == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}


/// @nodoc
mixin _$WcSessionDeleteRequest {

 int get code; String get message; String? get data;
/// Create a copy of WcSessionDeleteRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WcSessionDeleteRequestCopyWith<WcSessionDeleteRequest> get copyWith => _$WcSessionDeleteRequestCopyWithImpl<WcSessionDeleteRequest>(this as WcSessionDeleteRequest, _$identity);

  /// Serializes this WcSessionDeleteRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WcSessionDeleteRequest&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message,data);

@override
String toString() {
  return 'WcSessionDeleteRequest(code: $code, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $WcSessionDeleteRequestCopyWith<$Res>  {
  factory $WcSessionDeleteRequestCopyWith(WcSessionDeleteRequest value, $Res Function(WcSessionDeleteRequest) _then) = _$WcSessionDeleteRequestCopyWithImpl;
@useResult
$Res call({
 int code, String message, String? data
});




}
/// @nodoc
class _$WcSessionDeleteRequestCopyWithImpl<$Res>
    implements $WcSessionDeleteRequestCopyWith<$Res> {
  _$WcSessionDeleteRequestCopyWithImpl(this._self, this._then);

  final WcSessionDeleteRequest _self;
  final $Res Function(WcSessionDeleteRequest) _then;

/// Create a copy of WcSessionDeleteRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? message = null,Object? data = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WcSessionDeleteRequest].
extension WcSessionDeleteRequestPatterns on WcSessionDeleteRequest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WcSessionDeleteRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WcSessionDeleteRequest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WcSessionDeleteRequest value)  $default,){
final _that = this;
switch (_that) {
case _WcSessionDeleteRequest():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WcSessionDeleteRequest value)?  $default,){
final _that = this;
switch (_that) {
case _WcSessionDeleteRequest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int code,  String message,  String? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WcSessionDeleteRequest() when $default != null:
return $default(_that.code,_that.message,_that.data);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int code,  String message,  String? data)  $default,) {final _that = this;
switch (_that) {
case _WcSessionDeleteRequest():
return $default(_that.code,_that.message,_that.data);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int code,  String message,  String? data)?  $default,) {final _that = this;
switch (_that) {
case _WcSessionDeleteRequest() when $default != null:
return $default(_that.code,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _WcSessionDeleteRequest implements WcSessionDeleteRequest {
  const _WcSessionDeleteRequest({required this.code, required this.message, this.data});
  factory _WcSessionDeleteRequest.fromJson(Map<String, dynamic> json) => _$WcSessionDeleteRequestFromJson(json);

@override final  int code;
@override final  String message;
@override final  String? data;

/// Create a copy of WcSessionDeleteRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WcSessionDeleteRequestCopyWith<_WcSessionDeleteRequest> get copyWith => __$WcSessionDeleteRequestCopyWithImpl<_WcSessionDeleteRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WcSessionDeleteRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WcSessionDeleteRequest&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message,data);

@override
String toString() {
  return 'WcSessionDeleteRequest(code: $code, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$WcSessionDeleteRequestCopyWith<$Res> implements $WcSessionDeleteRequestCopyWith<$Res> {
  factory _$WcSessionDeleteRequestCopyWith(_WcSessionDeleteRequest value, $Res Function(_WcSessionDeleteRequest) _then) = __$WcSessionDeleteRequestCopyWithImpl;
@override @useResult
$Res call({
 int code, String message, String? data
});




}
/// @nodoc
class __$WcSessionDeleteRequestCopyWithImpl<$Res>
    implements _$WcSessionDeleteRequestCopyWith<$Res> {
  __$WcSessionDeleteRequestCopyWithImpl(this._self, this._then);

  final _WcSessionDeleteRequest _self;
  final $Res Function(_WcSessionDeleteRequest) _then;

/// Create a copy of WcSessionDeleteRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = null,Object? data = freezed,}) {
  return _then(_WcSessionDeleteRequest(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$WcSessionPingRequest {

 Map<String, dynamic>? get data;
/// Create a copy of WcSessionPingRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WcSessionPingRequestCopyWith<WcSessionPingRequest> get copyWith => _$WcSessionPingRequestCopyWithImpl<WcSessionPingRequest>(this as WcSessionPingRequest, _$identity);

  /// Serializes this WcSessionPingRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WcSessionPingRequest&&const DeepCollectionEquality().equals(other.data, data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'WcSessionPingRequest(data: $data)';
}


}

/// @nodoc
abstract mixin class $WcSessionPingRequestCopyWith<$Res>  {
  factory $WcSessionPingRequestCopyWith(WcSessionPingRequest value, $Res Function(WcSessionPingRequest) _then) = _$WcSessionPingRequestCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic>? data
});




}
/// @nodoc
class _$WcSessionPingRequestCopyWithImpl<$Res>
    implements $WcSessionPingRequestCopyWith<$Res> {
  _$WcSessionPingRequestCopyWithImpl(this._self, this._then);

  final WcSessionPingRequest _self;
  final $Res Function(WcSessionPingRequest) _then;

/// Create a copy of WcSessionPingRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? data = freezed,}) {
  return _then(_self.copyWith(
data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [WcSessionPingRequest].
extension WcSessionPingRequestPatterns on WcSessionPingRequest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WcSessionPingRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WcSessionPingRequest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WcSessionPingRequest value)  $default,){
final _that = this;
switch (_that) {
case _WcSessionPingRequest():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WcSessionPingRequest value)?  $default,){
final _that = this;
switch (_that) {
case _WcSessionPingRequest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, dynamic>? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WcSessionPingRequest() when $default != null:
return $default(_that.data);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, dynamic>? data)  $default,) {final _that = this;
switch (_that) {
case _WcSessionPingRequest():
return $default(_that.data);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, dynamic>? data)?  $default,) {final _that = this;
switch (_that) {
case _WcSessionPingRequest() when $default != null:
return $default(_that.data);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _WcSessionPingRequest implements WcSessionPingRequest {
  const _WcSessionPingRequest({final  Map<String, dynamic>? data}): _data = data;
  factory _WcSessionPingRequest.fromJson(Map<String, dynamic> json) => _$WcSessionPingRequestFromJson(json);

 final  Map<String, dynamic>? _data;
@override Map<String, dynamic>? get data {
  final value = _data;
  if (value == null) return null;
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of WcSessionPingRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WcSessionPingRequestCopyWith<_WcSessionPingRequest> get copyWith => __$WcSessionPingRequestCopyWithImpl<_WcSessionPingRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WcSessionPingRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WcSessionPingRequest&&const DeepCollectionEquality().equals(other._data, _data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_data));

@override
String toString() {
  return 'WcSessionPingRequest(data: $data)';
}


}

/// @nodoc
abstract mixin class _$WcSessionPingRequestCopyWith<$Res> implements $WcSessionPingRequestCopyWith<$Res> {
  factory _$WcSessionPingRequestCopyWith(_WcSessionPingRequest value, $Res Function(_WcSessionPingRequest) _then) = __$WcSessionPingRequestCopyWithImpl;
@override @useResult
$Res call({
 Map<String, dynamic>? data
});




}
/// @nodoc
class __$WcSessionPingRequestCopyWithImpl<$Res>
    implements _$WcSessionPingRequestCopyWith<$Res> {
  __$WcSessionPingRequestCopyWithImpl(this._self, this._then);

  final _WcSessionPingRequest _self;
  final $Res Function(_WcSessionPingRequest) _then;

/// Create a copy of WcSessionPingRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? data = freezed,}) {
  return _then(_WcSessionPingRequest(
data: freezed == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}


/// @nodoc
mixin _$WcSessionRequestRequest {

 String get chainId; SessionRequestParams get request;
/// Create a copy of WcSessionRequestRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WcSessionRequestRequestCopyWith<WcSessionRequestRequest> get copyWith => _$WcSessionRequestRequestCopyWithImpl<WcSessionRequestRequest>(this as WcSessionRequestRequest, _$identity);

  /// Serializes this WcSessionRequestRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WcSessionRequestRequest&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.request, request) || other.request == request));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chainId,request);

@override
String toString() {
  return 'WcSessionRequestRequest(chainId: $chainId, request: $request)';
}


}

/// @nodoc
abstract mixin class $WcSessionRequestRequestCopyWith<$Res>  {
  factory $WcSessionRequestRequestCopyWith(WcSessionRequestRequest value, $Res Function(WcSessionRequestRequest) _then) = _$WcSessionRequestRequestCopyWithImpl;
@useResult
$Res call({
 String chainId, SessionRequestParams request
});


$SessionRequestParamsCopyWith<$Res> get request;

}
/// @nodoc
class _$WcSessionRequestRequestCopyWithImpl<$Res>
    implements $WcSessionRequestRequestCopyWith<$Res> {
  _$WcSessionRequestRequestCopyWithImpl(this._self, this._then);

  final WcSessionRequestRequest _self;
  final $Res Function(WcSessionRequestRequest) _then;

/// Create a copy of WcSessionRequestRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? chainId = null,Object? request = null,}) {
  return _then(_self.copyWith(
chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,request: null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as SessionRequestParams,
  ));
}
/// Create a copy of WcSessionRequestRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionRequestParamsCopyWith<$Res> get request {
  
  return $SessionRequestParamsCopyWith<$Res>(_self.request, (value) {
    return _then(_self.copyWith(request: value));
  });
}
}


/// Adds pattern-matching-related methods to [WcSessionRequestRequest].
extension WcSessionRequestRequestPatterns on WcSessionRequestRequest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WcSessionRequestRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WcSessionRequestRequest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WcSessionRequestRequest value)  $default,){
final _that = this;
switch (_that) {
case _WcSessionRequestRequest():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WcSessionRequestRequest value)?  $default,){
final _that = this;
switch (_that) {
case _WcSessionRequestRequest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String chainId,  SessionRequestParams request)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WcSessionRequestRequest() when $default != null:
return $default(_that.chainId,_that.request);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String chainId,  SessionRequestParams request)  $default,) {final _that = this;
switch (_that) {
case _WcSessionRequestRequest():
return $default(_that.chainId,_that.request);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String chainId,  SessionRequestParams request)?  $default,) {final _that = this;
switch (_that) {
case _WcSessionRequestRequest() when $default != null:
return $default(_that.chainId,_that.request);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class _WcSessionRequestRequest implements WcSessionRequestRequest {
  const _WcSessionRequestRequest({required this.chainId, required this.request});
  factory _WcSessionRequestRequest.fromJson(Map<String, dynamic> json) => _$WcSessionRequestRequestFromJson(json);

@override final  String chainId;
@override final  SessionRequestParams request;

/// Create a copy of WcSessionRequestRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WcSessionRequestRequestCopyWith<_WcSessionRequestRequest> get copyWith => __$WcSessionRequestRequestCopyWithImpl<_WcSessionRequestRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WcSessionRequestRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WcSessionRequestRequest&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.request, request) || other.request == request));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chainId,request);

@override
String toString() {
  return 'WcSessionRequestRequest(chainId: $chainId, request: $request)';
}


}

/// @nodoc
abstract mixin class _$WcSessionRequestRequestCopyWith<$Res> implements $WcSessionRequestRequestCopyWith<$Res> {
  factory _$WcSessionRequestRequestCopyWith(_WcSessionRequestRequest value, $Res Function(_WcSessionRequestRequest) _then) = __$WcSessionRequestRequestCopyWithImpl;
@override @useResult
$Res call({
 String chainId, SessionRequestParams request
});


@override $SessionRequestParamsCopyWith<$Res> get request;

}
/// @nodoc
class __$WcSessionRequestRequestCopyWithImpl<$Res>
    implements _$WcSessionRequestRequestCopyWith<$Res> {
  __$WcSessionRequestRequestCopyWithImpl(this._self, this._then);

  final _WcSessionRequestRequest _self;
  final $Res Function(_WcSessionRequestRequest) _then;

/// Create a copy of WcSessionRequestRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chainId = null,Object? request = null,}) {
  return _then(_WcSessionRequestRequest(
chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,request: null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as SessionRequestParams,
  ));
}

/// Create a copy of WcSessionRequestRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionRequestParamsCopyWith<$Res> get request {
  
  return $SessionRequestParamsCopyWith<$Res>(_self.request, (value) {
    return _then(_self.copyWith(request: value));
  });
}
}


/// @nodoc
mixin _$WcSessionEventRequest {

 String get chainId; SessionEventParams get event;
/// Create a copy of WcSessionEventRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WcSessionEventRequestCopyWith<WcSessionEventRequest> get copyWith => _$WcSessionEventRequestCopyWithImpl<WcSessionEventRequest>(this as WcSessionEventRequest, _$identity);

  /// Serializes this WcSessionEventRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WcSessionEventRequest&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.event, event) || other.event == event));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chainId,event);

@override
String toString() {
  return 'WcSessionEventRequest(chainId: $chainId, event: $event)';
}


}

/// @nodoc
abstract mixin class $WcSessionEventRequestCopyWith<$Res>  {
  factory $WcSessionEventRequestCopyWith(WcSessionEventRequest value, $Res Function(WcSessionEventRequest) _then) = _$WcSessionEventRequestCopyWithImpl;
@useResult
$Res call({
 String chainId, SessionEventParams event
});


$SessionEventParamsCopyWith<$Res> get event;

}
/// @nodoc
class _$WcSessionEventRequestCopyWithImpl<$Res>
    implements $WcSessionEventRequestCopyWith<$Res> {
  _$WcSessionEventRequestCopyWithImpl(this._self, this._then);

  final WcSessionEventRequest _self;
  final $Res Function(WcSessionEventRequest) _then;

/// Create a copy of WcSessionEventRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? chainId = null,Object? event = null,}) {
  return _then(_self.copyWith(
chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as SessionEventParams,
  ));
}
/// Create a copy of WcSessionEventRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionEventParamsCopyWith<$Res> get event {
  
  return $SessionEventParamsCopyWith<$Res>(_self.event, (value) {
    return _then(_self.copyWith(event: value));
  });
}
}


/// Adds pattern-matching-related methods to [WcSessionEventRequest].
extension WcSessionEventRequestPatterns on WcSessionEventRequest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WcSessionEventRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WcSessionEventRequest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WcSessionEventRequest value)  $default,){
final _that = this;
switch (_that) {
case _WcSessionEventRequest():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WcSessionEventRequest value)?  $default,){
final _that = this;
switch (_that) {
case _WcSessionEventRequest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String chainId,  SessionEventParams event)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WcSessionEventRequest() when $default != null:
return $default(_that.chainId,_that.event);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String chainId,  SessionEventParams event)  $default,) {final _that = this;
switch (_that) {
case _WcSessionEventRequest():
return $default(_that.chainId,_that.event);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String chainId,  SessionEventParams event)?  $default,) {final _that = this;
switch (_that) {
case _WcSessionEventRequest() when $default != null:
return $default(_that.chainId,_that.event);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class _WcSessionEventRequest implements WcSessionEventRequest {
  const _WcSessionEventRequest({required this.chainId, required this.event});
  factory _WcSessionEventRequest.fromJson(Map<String, dynamic> json) => _$WcSessionEventRequestFromJson(json);

@override final  String chainId;
@override final  SessionEventParams event;

/// Create a copy of WcSessionEventRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WcSessionEventRequestCopyWith<_WcSessionEventRequest> get copyWith => __$WcSessionEventRequestCopyWithImpl<_WcSessionEventRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WcSessionEventRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WcSessionEventRequest&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.event, event) || other.event == event));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chainId,event);

@override
String toString() {
  return 'WcSessionEventRequest(chainId: $chainId, event: $event)';
}


}

/// @nodoc
abstract mixin class _$WcSessionEventRequestCopyWith<$Res> implements $WcSessionEventRequestCopyWith<$Res> {
  factory _$WcSessionEventRequestCopyWith(_WcSessionEventRequest value, $Res Function(_WcSessionEventRequest) _then) = __$WcSessionEventRequestCopyWithImpl;
@override @useResult
$Res call({
 String chainId, SessionEventParams event
});


@override $SessionEventParamsCopyWith<$Res> get event;

}
/// @nodoc
class __$WcSessionEventRequestCopyWithImpl<$Res>
    implements _$WcSessionEventRequestCopyWith<$Res> {
  __$WcSessionEventRequestCopyWithImpl(this._self, this._then);

  final _WcSessionEventRequest _self;
  final $Res Function(_WcSessionEventRequest) _then;

/// Create a copy of WcSessionEventRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chainId = null,Object? event = null,}) {
  return _then(_WcSessionEventRequest(
chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,event: null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as SessionEventParams,
  ));
}

/// Create a copy of WcSessionEventRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionEventParamsCopyWith<$Res> get event {
  
  return $SessionEventParamsCopyWith<$Res>(_self.event, (value) {
    return _then(_self.copyWith(event: value));
  });
}
}


/// @nodoc
mixin _$WcSessionAuthRequestParams {

 SessionAuthPayload get authPayload; ConnectionMetadata get requester; int get expiryTimestamp;
/// Create a copy of WcSessionAuthRequestParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WcSessionAuthRequestParamsCopyWith<WcSessionAuthRequestParams> get copyWith => _$WcSessionAuthRequestParamsCopyWithImpl<WcSessionAuthRequestParams>(this as WcSessionAuthRequestParams, _$identity);

  /// Serializes this WcSessionAuthRequestParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WcSessionAuthRequestParams&&(identical(other.authPayload, authPayload) || other.authPayload == authPayload)&&(identical(other.requester, requester) || other.requester == requester)&&(identical(other.expiryTimestamp, expiryTimestamp) || other.expiryTimestamp == expiryTimestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,authPayload,requester,expiryTimestamp);

@override
String toString() {
  return 'WcSessionAuthRequestParams(authPayload: $authPayload, requester: $requester, expiryTimestamp: $expiryTimestamp)';
}


}

/// @nodoc
abstract mixin class $WcSessionAuthRequestParamsCopyWith<$Res>  {
  factory $WcSessionAuthRequestParamsCopyWith(WcSessionAuthRequestParams value, $Res Function(WcSessionAuthRequestParams) _then) = _$WcSessionAuthRequestParamsCopyWithImpl;
@useResult
$Res call({
 SessionAuthPayload authPayload, ConnectionMetadata requester, int expiryTimestamp
});


$SessionAuthPayloadCopyWith<$Res> get authPayload;$ConnectionMetadataCopyWith<$Res> get requester;

}
/// @nodoc
class _$WcSessionAuthRequestParamsCopyWithImpl<$Res>
    implements $WcSessionAuthRequestParamsCopyWith<$Res> {
  _$WcSessionAuthRequestParamsCopyWithImpl(this._self, this._then);

  final WcSessionAuthRequestParams _self;
  final $Res Function(WcSessionAuthRequestParams) _then;

/// Create a copy of WcSessionAuthRequestParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? authPayload = null,Object? requester = null,Object? expiryTimestamp = null,}) {
  return _then(_self.copyWith(
authPayload: null == authPayload ? _self.authPayload : authPayload // ignore: cast_nullable_to_non_nullable
as SessionAuthPayload,requester: null == requester ? _self.requester : requester // ignore: cast_nullable_to_non_nullable
as ConnectionMetadata,expiryTimestamp: null == expiryTimestamp ? _self.expiryTimestamp : expiryTimestamp // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of WcSessionAuthRequestParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionAuthPayloadCopyWith<$Res> get authPayload {
  
  return $SessionAuthPayloadCopyWith<$Res>(_self.authPayload, (value) {
    return _then(_self.copyWith(authPayload: value));
  });
}/// Create a copy of WcSessionAuthRequestParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConnectionMetadataCopyWith<$Res> get requester {
  
  return $ConnectionMetadataCopyWith<$Res>(_self.requester, (value) {
    return _then(_self.copyWith(requester: value));
  });
}
}


/// Adds pattern-matching-related methods to [WcSessionAuthRequestParams].
extension WcSessionAuthRequestParamsPatterns on WcSessionAuthRequestParams {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WcSessionAuthRequestParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WcSessionAuthRequestParams() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WcSessionAuthRequestParams value)  $default,){
final _that = this;
switch (_that) {
case _WcSessionAuthRequestParams():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WcSessionAuthRequestParams value)?  $default,){
final _that = this;
switch (_that) {
case _WcSessionAuthRequestParams() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SessionAuthPayload authPayload,  ConnectionMetadata requester,  int expiryTimestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WcSessionAuthRequestParams() when $default != null:
return $default(_that.authPayload,_that.requester,_that.expiryTimestamp);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SessionAuthPayload authPayload,  ConnectionMetadata requester,  int expiryTimestamp)  $default,) {final _that = this;
switch (_that) {
case _WcSessionAuthRequestParams():
return $default(_that.authPayload,_that.requester,_that.expiryTimestamp);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SessionAuthPayload authPayload,  ConnectionMetadata requester,  int expiryTimestamp)?  $default,) {final _that = this;
switch (_that) {
case _WcSessionAuthRequestParams() when $default != null:
return $default(_that.authPayload,_that.requester,_that.expiryTimestamp);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class _WcSessionAuthRequestParams implements WcSessionAuthRequestParams {
  const _WcSessionAuthRequestParams({required this.authPayload, required this.requester, required this.expiryTimestamp});
  factory _WcSessionAuthRequestParams.fromJson(Map<String, dynamic> json) => _$WcSessionAuthRequestParamsFromJson(json);

@override final  SessionAuthPayload authPayload;
@override final  ConnectionMetadata requester;
@override final  int expiryTimestamp;

/// Create a copy of WcSessionAuthRequestParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WcSessionAuthRequestParamsCopyWith<_WcSessionAuthRequestParams> get copyWith => __$WcSessionAuthRequestParamsCopyWithImpl<_WcSessionAuthRequestParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WcSessionAuthRequestParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WcSessionAuthRequestParams&&(identical(other.authPayload, authPayload) || other.authPayload == authPayload)&&(identical(other.requester, requester) || other.requester == requester)&&(identical(other.expiryTimestamp, expiryTimestamp) || other.expiryTimestamp == expiryTimestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,authPayload,requester,expiryTimestamp);

@override
String toString() {
  return 'WcSessionAuthRequestParams(authPayload: $authPayload, requester: $requester, expiryTimestamp: $expiryTimestamp)';
}


}

/// @nodoc
abstract mixin class _$WcSessionAuthRequestParamsCopyWith<$Res> implements $WcSessionAuthRequestParamsCopyWith<$Res> {
  factory _$WcSessionAuthRequestParamsCopyWith(_WcSessionAuthRequestParams value, $Res Function(_WcSessionAuthRequestParams) _then) = __$WcSessionAuthRequestParamsCopyWithImpl;
@override @useResult
$Res call({
 SessionAuthPayload authPayload, ConnectionMetadata requester, int expiryTimestamp
});


@override $SessionAuthPayloadCopyWith<$Res> get authPayload;@override $ConnectionMetadataCopyWith<$Res> get requester;

}
/// @nodoc
class __$WcSessionAuthRequestParamsCopyWithImpl<$Res>
    implements _$WcSessionAuthRequestParamsCopyWith<$Res> {
  __$WcSessionAuthRequestParamsCopyWithImpl(this._self, this._then);

  final _WcSessionAuthRequestParams _self;
  final $Res Function(_WcSessionAuthRequestParams) _then;

/// Create a copy of WcSessionAuthRequestParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? authPayload = null,Object? requester = null,Object? expiryTimestamp = null,}) {
  return _then(_WcSessionAuthRequestParams(
authPayload: null == authPayload ? _self.authPayload : authPayload // ignore: cast_nullable_to_non_nullable
as SessionAuthPayload,requester: null == requester ? _self.requester : requester // ignore: cast_nullable_to_non_nullable
as ConnectionMetadata,expiryTimestamp: null == expiryTimestamp ? _self.expiryTimestamp : expiryTimestamp // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of WcSessionAuthRequestParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SessionAuthPayloadCopyWith<$Res> get authPayload {
  
  return $SessionAuthPayloadCopyWith<$Res>(_self.authPayload, (value) {
    return _then(_self.copyWith(authPayload: value));
  });
}/// Create a copy of WcSessionAuthRequestParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConnectionMetadataCopyWith<$Res> get requester {
  
  return $ConnectionMetadataCopyWith<$Res>(_self.requester, (value) {
    return _then(_self.copyWith(requester: value));
  });
}
}


/// @nodoc
mixin _$WcSessionAuthRequestResult {

 List<Cacao> get cacaos; ConnectionMetadata get responder;
/// Create a copy of WcSessionAuthRequestResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WcSessionAuthRequestResultCopyWith<WcSessionAuthRequestResult> get copyWith => _$WcSessionAuthRequestResultCopyWithImpl<WcSessionAuthRequestResult>(this as WcSessionAuthRequestResult, _$identity);

  /// Serializes this WcSessionAuthRequestResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WcSessionAuthRequestResult&&const DeepCollectionEquality().equals(other.cacaos, cacaos)&&(identical(other.responder, responder) || other.responder == responder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(cacaos),responder);

@override
String toString() {
  return 'WcSessionAuthRequestResult(cacaos: $cacaos, responder: $responder)';
}


}

/// @nodoc
abstract mixin class $WcSessionAuthRequestResultCopyWith<$Res>  {
  factory $WcSessionAuthRequestResultCopyWith(WcSessionAuthRequestResult value, $Res Function(WcSessionAuthRequestResult) _then) = _$WcSessionAuthRequestResultCopyWithImpl;
@useResult
$Res call({
 List<Cacao> cacaos, ConnectionMetadata responder
});


$ConnectionMetadataCopyWith<$Res> get responder;

}
/// @nodoc
class _$WcSessionAuthRequestResultCopyWithImpl<$Res>
    implements $WcSessionAuthRequestResultCopyWith<$Res> {
  _$WcSessionAuthRequestResultCopyWithImpl(this._self, this._then);

  final WcSessionAuthRequestResult _self;
  final $Res Function(WcSessionAuthRequestResult) _then;

/// Create a copy of WcSessionAuthRequestResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cacaos = null,Object? responder = null,}) {
  return _then(_self.copyWith(
cacaos: null == cacaos ? _self.cacaos : cacaos // ignore: cast_nullable_to_non_nullable
as List<Cacao>,responder: null == responder ? _self.responder : responder // ignore: cast_nullable_to_non_nullable
as ConnectionMetadata,
  ));
}
/// Create a copy of WcSessionAuthRequestResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConnectionMetadataCopyWith<$Res> get responder {
  
  return $ConnectionMetadataCopyWith<$Res>(_self.responder, (value) {
    return _then(_self.copyWith(responder: value));
  });
}
}


/// Adds pattern-matching-related methods to [WcSessionAuthRequestResult].
extension WcSessionAuthRequestResultPatterns on WcSessionAuthRequestResult {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WcSessionAuthRequestResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WcSessionAuthRequestResult() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WcSessionAuthRequestResult value)  $default,){
final _that = this;
switch (_that) {
case _WcSessionAuthRequestResult():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WcSessionAuthRequestResult value)?  $default,){
final _that = this;
switch (_that) {
case _WcSessionAuthRequestResult() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Cacao> cacaos,  ConnectionMetadata responder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WcSessionAuthRequestResult() when $default != null:
return $default(_that.cacaos,_that.responder);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Cacao> cacaos,  ConnectionMetadata responder)  $default,) {final _that = this;
switch (_that) {
case _WcSessionAuthRequestResult():
return $default(_that.cacaos,_that.responder);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Cacao> cacaos,  ConnectionMetadata responder)?  $default,) {final _that = this;
switch (_that) {
case _WcSessionAuthRequestResult() when $default != null:
return $default(_that.cacaos,_that.responder);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class _WcSessionAuthRequestResult implements WcSessionAuthRequestResult {
  const _WcSessionAuthRequestResult({required final  List<Cacao> cacaos, required this.responder}): _cacaos = cacaos;
  factory _WcSessionAuthRequestResult.fromJson(Map<String, dynamic> json) => _$WcSessionAuthRequestResultFromJson(json);

 final  List<Cacao> _cacaos;
@override List<Cacao> get cacaos {
  if (_cacaos is EqualUnmodifiableListView) return _cacaos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cacaos);
}

@override final  ConnectionMetadata responder;

/// Create a copy of WcSessionAuthRequestResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WcSessionAuthRequestResultCopyWith<_WcSessionAuthRequestResult> get copyWith => __$WcSessionAuthRequestResultCopyWithImpl<_WcSessionAuthRequestResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WcSessionAuthRequestResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WcSessionAuthRequestResult&&const DeepCollectionEquality().equals(other._cacaos, _cacaos)&&(identical(other.responder, responder) || other.responder == responder));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_cacaos),responder);

@override
String toString() {
  return 'WcSessionAuthRequestResult(cacaos: $cacaos, responder: $responder)';
}


}

/// @nodoc
abstract mixin class _$WcSessionAuthRequestResultCopyWith<$Res> implements $WcSessionAuthRequestResultCopyWith<$Res> {
  factory _$WcSessionAuthRequestResultCopyWith(_WcSessionAuthRequestResult value, $Res Function(_WcSessionAuthRequestResult) _then) = __$WcSessionAuthRequestResultCopyWithImpl;
@override @useResult
$Res call({
 List<Cacao> cacaos, ConnectionMetadata responder
});


@override $ConnectionMetadataCopyWith<$Res> get responder;

}
/// @nodoc
class __$WcSessionAuthRequestResultCopyWithImpl<$Res>
    implements _$WcSessionAuthRequestResultCopyWith<$Res> {
  __$WcSessionAuthRequestResultCopyWithImpl(this._self, this._then);

  final _WcSessionAuthRequestResult _self;
  final $Res Function(_WcSessionAuthRequestResult) _then;

/// Create a copy of WcSessionAuthRequestResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cacaos = null,Object? responder = null,}) {
  return _then(_WcSessionAuthRequestResult(
cacaos: null == cacaos ? _self._cacaos : cacaos // ignore: cast_nullable_to_non_nullable
as List<Cacao>,responder: null == responder ? _self.responder : responder // ignore: cast_nullable_to_non_nullable
as ConnectionMetadata,
  ));
}

/// Create a copy of WcSessionAuthRequestResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConnectionMetadataCopyWith<$Res> get responder {
  
  return $ConnectionMetadataCopyWith<$Res>(_self.responder, (value) {
    return _then(_self.copyWith(responder: value));
  });
}
}

// dart format on
