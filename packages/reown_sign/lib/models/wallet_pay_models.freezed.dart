// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_pay_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WalletPayRequestParams {

 String get version; List<PaymentOption> get acceptedPayments; int get expiry; String? get orderId;
/// Create a copy of WalletPayRequestParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletPayRequestParamsCopyWith<WalletPayRequestParams> get copyWith => _$WalletPayRequestParamsCopyWithImpl<WalletPayRequestParams>(this as WalletPayRequestParams, _$identity);

  /// Serializes this WalletPayRequestParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletPayRequestParams&&(identical(other.version, version) || other.version == version)&&const DeepCollectionEquality().equals(other.acceptedPayments, acceptedPayments)&&(identical(other.expiry, expiry) || other.expiry == expiry)&&(identical(other.orderId, orderId) || other.orderId == orderId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,const DeepCollectionEquality().hash(acceptedPayments),expiry,orderId);

@override
String toString() {
  return 'WalletPayRequestParams(version: $version, acceptedPayments: $acceptedPayments, expiry: $expiry, orderId: $orderId)';
}


}

/// @nodoc
abstract mixin class $WalletPayRequestParamsCopyWith<$Res>  {
  factory $WalletPayRequestParamsCopyWith(WalletPayRequestParams value, $Res Function(WalletPayRequestParams) _then) = _$WalletPayRequestParamsCopyWithImpl;
@useResult
$Res call({
 String version, List<PaymentOption> acceptedPayments, int expiry, String? orderId
});




}
/// @nodoc
class _$WalletPayRequestParamsCopyWithImpl<$Res>
    implements $WalletPayRequestParamsCopyWith<$Res> {
  _$WalletPayRequestParamsCopyWithImpl(this._self, this._then);

  final WalletPayRequestParams _self;
  final $Res Function(WalletPayRequestParams) _then;

/// Create a copy of WalletPayRequestParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? version = null,Object? acceptedPayments = null,Object? expiry = null,Object? orderId = freezed,}) {
  return _then(_self.copyWith(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,acceptedPayments: null == acceptedPayments ? _self.acceptedPayments : acceptedPayments // ignore: cast_nullable_to_non_nullable
as List<PaymentOption>,expiry: null == expiry ? _self.expiry : expiry // ignore: cast_nullable_to_non_nullable
as int,orderId: freezed == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WalletPayRequestParams].
extension WalletPayRequestParamsPatterns on WalletPayRequestParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WalletPayRequestParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WalletPayRequestParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WalletPayRequestParams value)  $default,){
final _that = this;
switch (_that) {
case _WalletPayRequestParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WalletPayRequestParams value)?  $default,){
final _that = this;
switch (_that) {
case _WalletPayRequestParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String version,  List<PaymentOption> acceptedPayments,  int expiry,  String? orderId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WalletPayRequestParams() when $default != null:
return $default(_that.version,_that.acceptedPayments,_that.expiry,_that.orderId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String version,  List<PaymentOption> acceptedPayments,  int expiry,  String? orderId)  $default,) {final _that = this;
switch (_that) {
case _WalletPayRequestParams():
return $default(_that.version,_that.acceptedPayments,_that.expiry,_that.orderId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String version,  List<PaymentOption> acceptedPayments,  int expiry,  String? orderId)?  $default,) {final _that = this;
switch (_that) {
case _WalletPayRequestParams() when $default != null:
return $default(_that.version,_that.acceptedPayments,_that.expiry,_that.orderId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WalletPayRequestParams implements WalletPayRequestParams {
  const _WalletPayRequestParams({required this.version, required final  List<PaymentOption> acceptedPayments, required this.expiry, this.orderId}): _acceptedPayments = acceptedPayments;
  factory _WalletPayRequestParams.fromJson(Map<String, dynamic> json) => _$WalletPayRequestParamsFromJson(json);

@override final  String version;
 final  List<PaymentOption> _acceptedPayments;
@override List<PaymentOption> get acceptedPayments {
  if (_acceptedPayments is EqualUnmodifiableListView) return _acceptedPayments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_acceptedPayments);
}

@override final  int expiry;
@override final  String? orderId;

/// Create a copy of WalletPayRequestParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletPayRequestParamsCopyWith<_WalletPayRequestParams> get copyWith => __$WalletPayRequestParamsCopyWithImpl<_WalletPayRequestParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WalletPayRequestParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalletPayRequestParams&&(identical(other.version, version) || other.version == version)&&const DeepCollectionEquality().equals(other._acceptedPayments, _acceptedPayments)&&(identical(other.expiry, expiry) || other.expiry == expiry)&&(identical(other.orderId, orderId) || other.orderId == orderId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,version,const DeepCollectionEquality().hash(_acceptedPayments),expiry,orderId);

@override
String toString() {
  return 'WalletPayRequestParams(version: $version, acceptedPayments: $acceptedPayments, expiry: $expiry, orderId: $orderId)';
}


}

/// @nodoc
abstract mixin class _$WalletPayRequestParamsCopyWith<$Res> implements $WalletPayRequestParamsCopyWith<$Res> {
  factory _$WalletPayRequestParamsCopyWith(_WalletPayRequestParams value, $Res Function(_WalletPayRequestParams) _then) = __$WalletPayRequestParamsCopyWithImpl;
@override @useResult
$Res call({
 String version, List<PaymentOption> acceptedPayments, int expiry, String? orderId
});




}
/// @nodoc
class __$WalletPayRequestParamsCopyWithImpl<$Res>
    implements _$WalletPayRequestParamsCopyWith<$Res> {
  __$WalletPayRequestParamsCopyWithImpl(this._self, this._then);

  final _WalletPayRequestParams _self;
  final $Res Function(_WalletPayRequestParams) _then;

/// Create a copy of WalletPayRequestParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? version = null,Object? acceptedPayments = null,Object? expiry = null,Object? orderId = freezed,}) {
  return _then(_WalletPayRequestParams(
version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,acceptedPayments: null == acceptedPayments ? _self._acceptedPayments : acceptedPayments // ignore: cast_nullable_to_non_nullable
as List<PaymentOption>,expiry: null == expiry ? _self.expiry : expiry // ignore: cast_nullable_to_non_nullable
as int,orderId: freezed == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PaymentOption {

 String get recipient;// chain-specific addr
 String get asset;// CAIP-19
 String get amount;// Hex string
 List<String> get types;
/// Create a copy of PaymentOption
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentOptionCopyWith<PaymentOption> get copyWith => _$PaymentOptionCopyWithImpl<PaymentOption>(this as PaymentOption, _$identity);

  /// Serializes this PaymentOption to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentOption&&(identical(other.recipient, recipient) || other.recipient == recipient)&&(identical(other.asset, asset) || other.asset == asset)&&(identical(other.amount, amount) || other.amount == amount)&&const DeepCollectionEquality().equals(other.types, types));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,recipient,asset,amount,const DeepCollectionEquality().hash(types));

@override
String toString() {
  return 'PaymentOption(recipient: $recipient, asset: $asset, amount: $amount, types: $types)';
}


}

/// @nodoc
abstract mixin class $PaymentOptionCopyWith<$Res>  {
  factory $PaymentOptionCopyWith(PaymentOption value, $Res Function(PaymentOption) _then) = _$PaymentOptionCopyWithImpl;
@useResult
$Res call({
 String recipient, String asset, String amount, List<String> types
});




}
/// @nodoc
class _$PaymentOptionCopyWithImpl<$Res>
    implements $PaymentOptionCopyWith<$Res> {
  _$PaymentOptionCopyWithImpl(this._self, this._then);

  final PaymentOption _self;
  final $Res Function(PaymentOption) _then;

/// Create a copy of PaymentOption
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? recipient = null,Object? asset = null,Object? amount = null,Object? types = null,}) {
  return _then(_self.copyWith(
recipient: null == recipient ? _self.recipient : recipient // ignore: cast_nullable_to_non_nullable
as String,asset: null == asset ? _self.asset : asset // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,types: null == types ? _self.types : types // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentOption].
extension PaymentOptionPatterns on PaymentOption {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentOption value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentOption() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentOption value)  $default,){
final _that = this;
switch (_that) {
case _PaymentOption():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentOption value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentOption() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String recipient,  String asset,  String amount,  List<String> types)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentOption() when $default != null:
return $default(_that.recipient,_that.asset,_that.amount,_that.types);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String recipient,  String asset,  String amount,  List<String> types)  $default,) {final _that = this;
switch (_that) {
case _PaymentOption():
return $default(_that.recipient,_that.asset,_that.amount,_that.types);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String recipient,  String asset,  String amount,  List<String> types)?  $default,) {final _that = this;
switch (_that) {
case _PaymentOption() when $default != null:
return $default(_that.recipient,_that.asset,_that.amount,_that.types);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentOption implements PaymentOption {
  const _PaymentOption({required this.recipient, required this.asset, required this.amount, required final  List<String> types}): _types = types;
  factory _PaymentOption.fromJson(Map<String, dynamic> json) => _$PaymentOptionFromJson(json);

@override final  String recipient;
// chain-specific addr
@override final  String asset;
// CAIP-19
@override final  String amount;
// Hex string
 final  List<String> _types;
// Hex string
@override List<String> get types {
  if (_types is EqualUnmodifiableListView) return _types;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_types);
}


/// Create a copy of PaymentOption
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentOptionCopyWith<_PaymentOption> get copyWith => __$PaymentOptionCopyWithImpl<_PaymentOption>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentOptionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentOption&&(identical(other.recipient, recipient) || other.recipient == recipient)&&(identical(other.asset, asset) || other.asset == asset)&&(identical(other.amount, amount) || other.amount == amount)&&const DeepCollectionEquality().equals(other._types, _types));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,recipient,asset,amount,const DeepCollectionEquality().hash(_types));

@override
String toString() {
  return 'PaymentOption(recipient: $recipient, asset: $asset, amount: $amount, types: $types)';
}


}

/// @nodoc
abstract mixin class _$PaymentOptionCopyWith<$Res> implements $PaymentOptionCopyWith<$Res> {
  factory _$PaymentOptionCopyWith(_PaymentOption value, $Res Function(_PaymentOption) _then) = __$PaymentOptionCopyWithImpl;
@override @useResult
$Res call({
 String recipient, String asset, String amount, List<String> types
});




}
/// @nodoc
class __$PaymentOptionCopyWithImpl<$Res>
    implements _$PaymentOptionCopyWith<$Res> {
  __$PaymentOptionCopyWithImpl(this._self, this._then);

  final _PaymentOption _self;
  final $Res Function(_PaymentOption) _then;

/// Create a copy of PaymentOption
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? recipient = null,Object? asset = null,Object? amount = null,Object? types = null,}) {
  return _then(_PaymentOption(
recipient: null == recipient ? _self.recipient : recipient // ignore: cast_nullable_to_non_nullable
as String,asset: null == asset ? _self.asset : asset // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,types: null == types ? _self._types : types // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
