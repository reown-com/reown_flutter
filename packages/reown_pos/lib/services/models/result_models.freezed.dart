// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'result_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SolanaTransactionParams {

 String get transaction; String get pubkey;
/// Create a copy of SolanaTransactionParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SolanaTransactionParamsCopyWith<SolanaTransactionParams> get copyWith => _$SolanaTransactionParamsCopyWithImpl<SolanaTransactionParams>(this as SolanaTransactionParams, _$identity);

  /// Serializes this SolanaTransactionParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SolanaTransactionParams&&(identical(other.transaction, transaction) || other.transaction == transaction)&&(identical(other.pubkey, pubkey) || other.pubkey == pubkey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transaction,pubkey);

@override
String toString() {
  return 'SolanaTransactionParams(transaction: $transaction, pubkey: $pubkey)';
}


}

/// @nodoc
abstract mixin class $SolanaTransactionParamsCopyWith<$Res>  {
  factory $SolanaTransactionParamsCopyWith(SolanaTransactionParams value, $Res Function(SolanaTransactionParams) _then) = _$SolanaTransactionParamsCopyWithImpl;
@useResult
$Res call({
 String transaction, String pubkey
});




}
/// @nodoc
class _$SolanaTransactionParamsCopyWithImpl<$Res>
    implements $SolanaTransactionParamsCopyWith<$Res> {
  _$SolanaTransactionParamsCopyWithImpl(this._self, this._then);

  final SolanaTransactionParams _self;
  final $Res Function(SolanaTransactionParams) _then;

/// Create a copy of SolanaTransactionParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transaction = null,Object? pubkey = null,}) {
  return _then(_self.copyWith(
transaction: null == transaction ? _self.transaction : transaction // ignore: cast_nullable_to_non_nullable
as String,pubkey: null == pubkey ? _self.pubkey : pubkey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SolanaTransactionParams].
extension SolanaTransactionParamsPatterns on SolanaTransactionParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SolanaTransactionParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SolanaTransactionParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SolanaTransactionParams value)  $default,){
final _that = this;
switch (_that) {
case _SolanaTransactionParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SolanaTransactionParams value)?  $default,){
final _that = this;
switch (_that) {
case _SolanaTransactionParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String transaction,  String pubkey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SolanaTransactionParams() when $default != null:
return $default(_that.transaction,_that.pubkey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String transaction,  String pubkey)  $default,) {final _that = this;
switch (_that) {
case _SolanaTransactionParams():
return $default(_that.transaction,_that.pubkey);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String transaction,  String pubkey)?  $default,) {final _that = this;
switch (_that) {
case _SolanaTransactionParams() when $default != null:
return $default(_that.transaction,_that.pubkey);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SolanaTransactionParams implements SolanaTransactionParams {
  const _SolanaTransactionParams({required this.transaction, required this.pubkey});
  factory _SolanaTransactionParams.fromJson(Map<String, dynamic> json) => _$SolanaTransactionParamsFromJson(json);

@override final  String transaction;
@override final  String pubkey;

/// Create a copy of SolanaTransactionParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SolanaTransactionParamsCopyWith<_SolanaTransactionParams> get copyWith => __$SolanaTransactionParamsCopyWithImpl<_SolanaTransactionParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SolanaTransactionParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SolanaTransactionParams&&(identical(other.transaction, transaction) || other.transaction == transaction)&&(identical(other.pubkey, pubkey) || other.pubkey == pubkey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transaction,pubkey);

@override
String toString() {
  return 'SolanaTransactionParams(transaction: $transaction, pubkey: $pubkey)';
}


}

/// @nodoc
abstract mixin class _$SolanaTransactionParamsCopyWith<$Res> implements $SolanaTransactionParamsCopyWith<$Res> {
  factory _$SolanaTransactionParamsCopyWith(_SolanaTransactionParams value, $Res Function(_SolanaTransactionParams) _then) = __$SolanaTransactionParamsCopyWithImpl;
@override @useResult
$Res call({
 String transaction, String pubkey
});




}
/// @nodoc
class __$SolanaTransactionParamsCopyWithImpl<$Res>
    implements _$SolanaTransactionParamsCopyWith<$Res> {
  __$SolanaTransactionParamsCopyWithImpl(this._self, this._then);

  final _SolanaTransactionParams _self;
  final $Res Function(_SolanaTransactionParams) _then;

/// Create a copy of SolanaTransactionParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transaction = null,Object? pubkey = null,}) {
  return _then(_SolanaTransactionParams(
transaction: null == transaction ? _self.transaction : transaction // ignore: cast_nullable_to_non_nullable
as String,pubkey: null == pubkey ? _self.pubkey : pubkey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$EvmTransactionParams {

 String get from; String get to; String get value; String? get gas; String? get gasPrice; String? get maxFeePerGas; String? get maxPriorityFeePerGas; String? get input; String? get data;
/// Create a copy of EvmTransactionParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EvmTransactionParamsCopyWith<EvmTransactionParams> get copyWith => _$EvmTransactionParamsCopyWithImpl<EvmTransactionParams>(this as EvmTransactionParams, _$identity);

  /// Serializes this EvmTransactionParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EvmTransactionParams&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.value, value) || other.value == value)&&(identical(other.gas, gas) || other.gas == gas)&&(identical(other.gasPrice, gasPrice) || other.gasPrice == gasPrice)&&(identical(other.maxFeePerGas, maxFeePerGas) || other.maxFeePerGas == maxFeePerGas)&&(identical(other.maxPriorityFeePerGas, maxPriorityFeePerGas) || other.maxPriorityFeePerGas == maxPriorityFeePerGas)&&(identical(other.input, input) || other.input == input)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,from,to,value,gas,gasPrice,maxFeePerGas,maxPriorityFeePerGas,input,data);

@override
String toString() {
  return 'EvmTransactionParams(from: $from, to: $to, value: $value, gas: $gas, gasPrice: $gasPrice, maxFeePerGas: $maxFeePerGas, maxPriorityFeePerGas: $maxPriorityFeePerGas, input: $input, data: $data)';
}


}

/// @nodoc
abstract mixin class $EvmTransactionParamsCopyWith<$Res>  {
  factory $EvmTransactionParamsCopyWith(EvmTransactionParams value, $Res Function(EvmTransactionParams) _then) = _$EvmTransactionParamsCopyWithImpl;
@useResult
$Res call({
 String from, String to, String value, String? gas, String? gasPrice, String? maxFeePerGas, String? maxPriorityFeePerGas, String? input, String? data
});




}
/// @nodoc
class _$EvmTransactionParamsCopyWithImpl<$Res>
    implements $EvmTransactionParamsCopyWith<$Res> {
  _$EvmTransactionParamsCopyWithImpl(this._self, this._then);

  final EvmTransactionParams _self;
  final $Res Function(EvmTransactionParams) _then;

/// Create a copy of EvmTransactionParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? from = null,Object? to = null,Object? value = null,Object? gas = freezed,Object? gasPrice = freezed,Object? maxFeePerGas = freezed,Object? maxPriorityFeePerGas = freezed,Object? input = freezed,Object? data = freezed,}) {
  return _then(_self.copyWith(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,gas: freezed == gas ? _self.gas : gas // ignore: cast_nullable_to_non_nullable
as String?,gasPrice: freezed == gasPrice ? _self.gasPrice : gasPrice // ignore: cast_nullable_to_non_nullable
as String?,maxFeePerGas: freezed == maxFeePerGas ? _self.maxFeePerGas : maxFeePerGas // ignore: cast_nullable_to_non_nullable
as String?,maxPriorityFeePerGas: freezed == maxPriorityFeePerGas ? _self.maxPriorityFeePerGas : maxPriorityFeePerGas // ignore: cast_nullable_to_non_nullable
as String?,input: freezed == input ? _self.input : input // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EvmTransactionParams].
extension EvmTransactionParamsPatterns on EvmTransactionParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EvmTransactionParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EvmTransactionParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EvmTransactionParams value)  $default,){
final _that = this;
switch (_that) {
case _EvmTransactionParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EvmTransactionParams value)?  $default,){
final _that = this;
switch (_that) {
case _EvmTransactionParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String from,  String to,  String value,  String? gas,  String? gasPrice,  String? maxFeePerGas,  String? maxPriorityFeePerGas,  String? input,  String? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EvmTransactionParams() when $default != null:
return $default(_that.from,_that.to,_that.value,_that.gas,_that.gasPrice,_that.maxFeePerGas,_that.maxPriorityFeePerGas,_that.input,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String from,  String to,  String value,  String? gas,  String? gasPrice,  String? maxFeePerGas,  String? maxPriorityFeePerGas,  String? input,  String? data)  $default,) {final _that = this;
switch (_that) {
case _EvmTransactionParams():
return $default(_that.from,_that.to,_that.value,_that.gas,_that.gasPrice,_that.maxFeePerGas,_that.maxPriorityFeePerGas,_that.input,_that.data);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String from,  String to,  String value,  String? gas,  String? gasPrice,  String? maxFeePerGas,  String? maxPriorityFeePerGas,  String? input,  String? data)?  $default,) {final _that = this;
switch (_that) {
case _EvmTransactionParams() when $default != null:
return $default(_that.from,_that.to,_that.value,_that.gas,_that.gasPrice,_that.maxFeePerGas,_that.maxPriorityFeePerGas,_that.input,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EvmTransactionParams implements EvmTransactionParams {
  const _EvmTransactionParams({required this.from, required this.to, required this.value, this.gas, this.gasPrice, this.maxFeePerGas, this.maxPriorityFeePerGas, this.input, this.data});
  factory _EvmTransactionParams.fromJson(Map<String, dynamic> json) => _$EvmTransactionParamsFromJson(json);

@override final  String from;
@override final  String to;
@override final  String value;
@override final  String? gas;
@override final  String? gasPrice;
@override final  String? maxFeePerGas;
@override final  String? maxPriorityFeePerGas;
@override final  String? input;
@override final  String? data;

/// Create a copy of EvmTransactionParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EvmTransactionParamsCopyWith<_EvmTransactionParams> get copyWith => __$EvmTransactionParamsCopyWithImpl<_EvmTransactionParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EvmTransactionParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EvmTransactionParams&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.value, value) || other.value == value)&&(identical(other.gas, gas) || other.gas == gas)&&(identical(other.gasPrice, gasPrice) || other.gasPrice == gasPrice)&&(identical(other.maxFeePerGas, maxFeePerGas) || other.maxFeePerGas == maxFeePerGas)&&(identical(other.maxPriorityFeePerGas, maxPriorityFeePerGas) || other.maxPriorityFeePerGas == maxPriorityFeePerGas)&&(identical(other.input, input) || other.input == input)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,from,to,value,gas,gasPrice,maxFeePerGas,maxPriorityFeePerGas,input,data);

@override
String toString() {
  return 'EvmTransactionParams(from: $from, to: $to, value: $value, gas: $gas, gasPrice: $gasPrice, maxFeePerGas: $maxFeePerGas, maxPriorityFeePerGas: $maxPriorityFeePerGas, input: $input, data: $data)';
}


}

/// @nodoc
abstract mixin class _$EvmTransactionParamsCopyWith<$Res> implements $EvmTransactionParamsCopyWith<$Res> {
  factory _$EvmTransactionParamsCopyWith(_EvmTransactionParams value, $Res Function(_EvmTransactionParams) _then) = __$EvmTransactionParamsCopyWithImpl;
@override @useResult
$Res call({
 String from, String to, String value, String? gas, String? gasPrice, String? maxFeePerGas, String? maxPriorityFeePerGas, String? input, String? data
});




}
/// @nodoc
class __$EvmTransactionParamsCopyWithImpl<$Res>
    implements _$EvmTransactionParamsCopyWith<$Res> {
  __$EvmTransactionParamsCopyWithImpl(this._self, this._then);

  final _EvmTransactionParams _self;
  final $Res Function(_EvmTransactionParams) _then;

/// Create a copy of EvmTransactionParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = null,Object? to = null,Object? value = null,Object? gas = freezed,Object? gasPrice = freezed,Object? maxFeePerGas = freezed,Object? maxPriorityFeePerGas = freezed,Object? input = freezed,Object? data = freezed,}) {
  return _then(_EvmTransactionParams(
from: null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as String,to: null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,gas: freezed == gas ? _self.gas : gas // ignore: cast_nullable_to_non_nullable
as String?,gasPrice: freezed == gasPrice ? _self.gasPrice : gasPrice // ignore: cast_nullable_to_non_nullable
as String?,maxFeePerGas: freezed == maxFeePerGas ? _self.maxFeePerGas : maxFeePerGas // ignore: cast_nullable_to_non_nullable
as String?,maxPriorityFeePerGas: freezed == maxPriorityFeePerGas ? _self.maxPriorityFeePerGas : maxPriorityFeePerGas // ignore: cast_nullable_to_non_nullable
as String?,input: freezed == input ? _self.input : input // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TronTransactionObject {

 dynamic get raw_data; String get raw_data_hex; List<String>? get signature; String get txID; bool? get visible;
/// Create a copy of TronTransactionObject
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TronTransactionObjectCopyWith<TronTransactionObject> get copyWith => _$TronTransactionObjectCopyWithImpl<TronTransactionObject>(this as TronTransactionObject, _$identity);

  /// Serializes this TronTransactionObject to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TronTransactionObject&&const DeepCollectionEquality().equals(other.raw_data, raw_data)&&(identical(other.raw_data_hex, raw_data_hex) || other.raw_data_hex == raw_data_hex)&&const DeepCollectionEquality().equals(other.signature, signature)&&(identical(other.txID, txID) || other.txID == txID)&&(identical(other.visible, visible) || other.visible == visible));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(raw_data),raw_data_hex,const DeepCollectionEquality().hash(signature),txID,visible);

@override
String toString() {
  return 'TronTransactionObject(raw_data: $raw_data, raw_data_hex: $raw_data_hex, signature: $signature, txID: $txID, visible: $visible)';
}


}

/// @nodoc
abstract mixin class $TronTransactionObjectCopyWith<$Res>  {
  factory $TronTransactionObjectCopyWith(TronTransactionObject value, $Res Function(TronTransactionObject) _then) = _$TronTransactionObjectCopyWithImpl;
@useResult
$Res call({
 dynamic raw_data, String raw_data_hex, List<String>? signature, String txID, bool? visible
});




}
/// @nodoc
class _$TronTransactionObjectCopyWithImpl<$Res>
    implements $TronTransactionObjectCopyWith<$Res> {
  _$TronTransactionObjectCopyWithImpl(this._self, this._then);

  final TronTransactionObject _self;
  final $Res Function(TronTransactionObject) _then;

/// Create a copy of TronTransactionObject
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? raw_data = freezed,Object? raw_data_hex = null,Object? signature = freezed,Object? txID = null,Object? visible = freezed,}) {
  return _then(_self.copyWith(
raw_data: freezed == raw_data ? _self.raw_data : raw_data // ignore: cast_nullable_to_non_nullable
as dynamic,raw_data_hex: null == raw_data_hex ? _self.raw_data_hex : raw_data_hex // ignore: cast_nullable_to_non_nullable
as String,signature: freezed == signature ? _self.signature : signature // ignore: cast_nullable_to_non_nullable
as List<String>?,txID: null == txID ? _self.txID : txID // ignore: cast_nullable_to_non_nullable
as String,visible: freezed == visible ? _self.visible : visible // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [TronTransactionObject].
extension TronTransactionObjectPatterns on TronTransactionObject {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TronTransactionObject value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TronTransactionObject() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TronTransactionObject value)  $default,){
final _that = this;
switch (_that) {
case _TronTransactionObject():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TronTransactionObject value)?  $default,){
final _that = this;
switch (_that) {
case _TronTransactionObject() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( dynamic raw_data,  String raw_data_hex,  List<String>? signature,  String txID,  bool? visible)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TronTransactionObject() when $default != null:
return $default(_that.raw_data,_that.raw_data_hex,_that.signature,_that.txID,_that.visible);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( dynamic raw_data,  String raw_data_hex,  List<String>? signature,  String txID,  bool? visible)  $default,) {final _that = this;
switch (_that) {
case _TronTransactionObject():
return $default(_that.raw_data,_that.raw_data_hex,_that.signature,_that.txID,_that.visible);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( dynamic raw_data,  String raw_data_hex,  List<String>? signature,  String txID,  bool? visible)?  $default,) {final _that = this;
switch (_that) {
case _TronTransactionObject() when $default != null:
return $default(_that.raw_data,_that.raw_data_hex,_that.signature,_that.txID,_that.visible);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TronTransactionObject implements TronTransactionObject {
  const _TronTransactionObject({this.raw_data, required this.raw_data_hex, required final  List<String>? signature, required this.txID, this.visible}): _signature = signature;
  factory _TronTransactionObject.fromJson(Map<String, dynamic> json) => _$TronTransactionObjectFromJson(json);

@override final  dynamic raw_data;
@override final  String raw_data_hex;
 final  List<String>? _signature;
@override List<String>? get signature {
  final value = _signature;
  if (value == null) return null;
  if (_signature is EqualUnmodifiableListView) return _signature;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String txID;
@override final  bool? visible;

/// Create a copy of TronTransactionObject
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TronTransactionObjectCopyWith<_TronTransactionObject> get copyWith => __$TronTransactionObjectCopyWithImpl<_TronTransactionObject>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TronTransactionObjectToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TronTransactionObject&&const DeepCollectionEquality().equals(other.raw_data, raw_data)&&(identical(other.raw_data_hex, raw_data_hex) || other.raw_data_hex == raw_data_hex)&&const DeepCollectionEquality().equals(other._signature, _signature)&&(identical(other.txID, txID) || other.txID == txID)&&(identical(other.visible, visible) || other.visible == visible));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(raw_data),raw_data_hex,const DeepCollectionEquality().hash(_signature),txID,visible);

@override
String toString() {
  return 'TronTransactionObject(raw_data: $raw_data, raw_data_hex: $raw_data_hex, signature: $signature, txID: $txID, visible: $visible)';
}


}

/// @nodoc
abstract mixin class _$TronTransactionObjectCopyWith<$Res> implements $TronTransactionObjectCopyWith<$Res> {
  factory _$TronTransactionObjectCopyWith(_TronTransactionObject value, $Res Function(_TronTransactionObject) _then) = __$TronTransactionObjectCopyWithImpl;
@override @useResult
$Res call({
 dynamic raw_data, String raw_data_hex, List<String>? signature, String txID, bool? visible
});




}
/// @nodoc
class __$TronTransactionObjectCopyWithImpl<$Res>
    implements _$TronTransactionObjectCopyWith<$Res> {
  __$TronTransactionObjectCopyWithImpl(this._self, this._then);

  final _TronTransactionObject _self;
  final $Res Function(_TronTransactionObject) _then;

/// Create a copy of TronTransactionObject
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? raw_data = freezed,Object? raw_data_hex = null,Object? signature = freezed,Object? txID = null,Object? visible = freezed,}) {
  return _then(_TronTransactionObject(
raw_data: freezed == raw_data ? _self.raw_data : raw_data // ignore: cast_nullable_to_non_nullable
as dynamic,raw_data_hex: null == raw_data_hex ? _self.raw_data_hex : raw_data_hex // ignore: cast_nullable_to_non_nullable
as String,signature: freezed == signature ? _self._signature : signature // ignore: cast_nullable_to_non_nullable
as List<String>?,txID: null == txID ? _self.txID : txID // ignore: cast_nullable_to_non_nullable
as String,visible: freezed == visible ? _self.visible : visible // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$TronTransaction {

 TronTransactionResult get result; TronTransactionObject get transaction;
/// Create a copy of TronTransaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TronTransactionCopyWith<TronTransaction> get copyWith => _$TronTransactionCopyWithImpl<TronTransaction>(this as TronTransaction, _$identity);

  /// Serializes this TronTransaction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TronTransaction&&(identical(other.result, result) || other.result == result)&&(identical(other.transaction, transaction) || other.transaction == transaction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,result,transaction);

@override
String toString() {
  return 'TronTransaction(result: $result, transaction: $transaction)';
}


}

/// @nodoc
abstract mixin class $TronTransactionCopyWith<$Res>  {
  factory $TronTransactionCopyWith(TronTransaction value, $Res Function(TronTransaction) _then) = _$TronTransactionCopyWithImpl;
@useResult
$Res call({
 TronTransactionResult result, TronTransactionObject transaction
});


$TronTransactionResultCopyWith<$Res> get result;$TronTransactionObjectCopyWith<$Res> get transaction;

}
/// @nodoc
class _$TronTransactionCopyWithImpl<$Res>
    implements $TronTransactionCopyWith<$Res> {
  _$TronTransactionCopyWithImpl(this._self, this._then);

  final TronTransaction _self;
  final $Res Function(TronTransaction) _then;

/// Create a copy of TronTransaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? result = null,Object? transaction = null,}) {
  return _then(_self.copyWith(
result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as TronTransactionResult,transaction: null == transaction ? _self.transaction : transaction // ignore: cast_nullable_to_non_nullable
as TronTransactionObject,
  ));
}
/// Create a copy of TronTransaction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TronTransactionResultCopyWith<$Res> get result {
  
  return $TronTransactionResultCopyWith<$Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}/// Create a copy of TronTransaction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TronTransactionObjectCopyWith<$Res> get transaction {
  
  return $TronTransactionObjectCopyWith<$Res>(_self.transaction, (value) {
    return _then(_self.copyWith(transaction: value));
  });
}
}


/// Adds pattern-matching-related methods to [TronTransaction].
extension TronTransactionPatterns on TronTransaction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TronTransaction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TronTransaction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TronTransaction value)  $default,){
final _that = this;
switch (_that) {
case _TronTransaction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TronTransaction value)?  $default,){
final _that = this;
switch (_that) {
case _TronTransaction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TronTransactionResult result,  TronTransactionObject transaction)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TronTransaction() when $default != null:
return $default(_that.result,_that.transaction);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TronTransactionResult result,  TronTransactionObject transaction)  $default,) {final _that = this;
switch (_that) {
case _TronTransaction():
return $default(_that.result,_that.transaction);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TronTransactionResult result,  TronTransactionObject transaction)?  $default,) {final _that = this;
switch (_that) {
case _TronTransaction() when $default != null:
return $default(_that.result,_that.transaction);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TronTransaction implements TronTransaction {
  const _TronTransaction({required this.result, required this.transaction});
  factory _TronTransaction.fromJson(Map<String, dynamic> json) => _$TronTransactionFromJson(json);

@override final  TronTransactionResult result;
@override final  TronTransactionObject transaction;

/// Create a copy of TronTransaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TronTransactionCopyWith<_TronTransaction> get copyWith => __$TronTransactionCopyWithImpl<_TronTransaction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TronTransactionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TronTransaction&&(identical(other.result, result) || other.result == result)&&(identical(other.transaction, transaction) || other.transaction == transaction));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,result,transaction);

@override
String toString() {
  return 'TronTransaction(result: $result, transaction: $transaction)';
}


}

/// @nodoc
abstract mixin class _$TronTransactionCopyWith<$Res> implements $TronTransactionCopyWith<$Res> {
  factory _$TronTransactionCopyWith(_TronTransaction value, $Res Function(_TronTransaction) _then) = __$TronTransactionCopyWithImpl;
@override @useResult
$Res call({
 TronTransactionResult result, TronTransactionObject transaction
});


@override $TronTransactionResultCopyWith<$Res> get result;@override $TronTransactionObjectCopyWith<$Res> get transaction;

}
/// @nodoc
class __$TronTransactionCopyWithImpl<$Res>
    implements _$TronTransactionCopyWith<$Res> {
  __$TronTransactionCopyWithImpl(this._self, this._then);

  final _TronTransaction _self;
  final $Res Function(_TronTransaction) _then;

/// Create a copy of TronTransaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? result = null,Object? transaction = null,}) {
  return _then(_TronTransaction(
result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as TronTransactionResult,transaction: null == transaction ? _self.transaction : transaction // ignore: cast_nullable_to_non_nullable
as TronTransactionObject,
  ));
}

/// Create a copy of TronTransaction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TronTransactionResultCopyWith<$Res> get result {
  
  return $TronTransactionResultCopyWith<$Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}/// Create a copy of TronTransaction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TronTransactionObjectCopyWith<$Res> get transaction {
  
  return $TronTransactionObjectCopyWith<$Res>(_self.transaction, (value) {
    return _then(_self.copyWith(transaction: value));
  });
}
}


/// @nodoc
mixin _$TronTransactionResult {

 bool get result;
/// Create a copy of TronTransactionResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TronTransactionResultCopyWith<TronTransactionResult> get copyWith => _$TronTransactionResultCopyWithImpl<TronTransactionResult>(this as TronTransactionResult, _$identity);

  /// Serializes this TronTransactionResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TronTransactionResult&&(identical(other.result, result) || other.result == result));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,result);

@override
String toString() {
  return 'TronTransactionResult(result: $result)';
}


}

/// @nodoc
abstract mixin class $TronTransactionResultCopyWith<$Res>  {
  factory $TronTransactionResultCopyWith(TronTransactionResult value, $Res Function(TronTransactionResult) _then) = _$TronTransactionResultCopyWithImpl;
@useResult
$Res call({
 bool result
});




}
/// @nodoc
class _$TronTransactionResultCopyWithImpl<$Res>
    implements $TronTransactionResultCopyWith<$Res> {
  _$TronTransactionResultCopyWithImpl(this._self, this._then);

  final TronTransactionResult _self;
  final $Res Function(TronTransactionResult) _then;

/// Create a copy of TronTransactionResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? result = null,}) {
  return _then(_self.copyWith(
result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TronTransactionResult].
extension TronTransactionResultPatterns on TronTransactionResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TronTransactionResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TronTransactionResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TronTransactionResult value)  $default,){
final _that = this;
switch (_that) {
case _TronTransactionResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TronTransactionResult value)?  $default,){
final _that = this;
switch (_that) {
case _TronTransactionResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool result)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TronTransactionResult() when $default != null:
return $default(_that.result);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool result)  $default,) {final _that = this;
switch (_that) {
case _TronTransactionResult():
return $default(_that.result);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool result)?  $default,) {final _that = this;
switch (_that) {
case _TronTransactionResult() when $default != null:
return $default(_that.result);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TronTransactionResult implements TronTransactionResult {
  const _TronTransactionResult({required this.result});
  factory _TronTransactionResult.fromJson(Map<String, dynamic> json) => _$TronTransactionResultFromJson(json);

@override final  bool result;

/// Create a copy of TronTransactionResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TronTransactionResultCopyWith<_TronTransactionResult> get copyWith => __$TronTransactionResultCopyWithImpl<_TronTransactionResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TronTransactionResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TronTransactionResult&&(identical(other.result, result) || other.result == result));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,result);

@override
String toString() {
  return 'TronTransactionResult(result: $result)';
}


}

/// @nodoc
abstract mixin class _$TronTransactionResultCopyWith<$Res> implements $TronTransactionResultCopyWith<$Res> {
  factory _$TronTransactionResultCopyWith(_TronTransactionResult value, $Res Function(_TronTransactionResult) _then) = __$TronTransactionResultCopyWithImpl;
@override @useResult
$Res call({
 bool result
});




}
/// @nodoc
class __$TronTransactionResultCopyWithImpl<$Res>
    implements _$TronTransactionResultCopyWith<$Res> {
  __$TronTransactionResultCopyWithImpl(this._self, this._then);

  final _TronTransactionResult _self;
  final $Res Function(_TronTransactionResult) _then;

/// Create a copy of TronTransactionResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? result = null,}) {
  return _then(_TronTransactionResult(
result: null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$TronTransactionParams {

 TronTransaction get transaction; String get address;
/// Create a copy of TronTransactionParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TronTransactionParamsCopyWith<TronTransactionParams> get copyWith => _$TronTransactionParamsCopyWithImpl<TronTransactionParams>(this as TronTransactionParams, _$identity);

  /// Serializes this TronTransactionParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TronTransactionParams&&(identical(other.transaction, transaction) || other.transaction == transaction)&&(identical(other.address, address) || other.address == address));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transaction,address);

@override
String toString() {
  return 'TronTransactionParams(transaction: $transaction, address: $address)';
}


}

/// @nodoc
abstract mixin class $TronTransactionParamsCopyWith<$Res>  {
  factory $TronTransactionParamsCopyWith(TronTransactionParams value, $Res Function(TronTransactionParams) _then) = _$TronTransactionParamsCopyWithImpl;
@useResult
$Res call({
 TronTransaction transaction, String address
});


$TronTransactionCopyWith<$Res> get transaction;

}
/// @nodoc
class _$TronTransactionParamsCopyWithImpl<$Res>
    implements $TronTransactionParamsCopyWith<$Res> {
  _$TronTransactionParamsCopyWithImpl(this._self, this._then);

  final TronTransactionParams _self;
  final $Res Function(TronTransactionParams) _then;

/// Create a copy of TronTransactionParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transaction = null,Object? address = null,}) {
  return _then(_self.copyWith(
transaction: null == transaction ? _self.transaction : transaction // ignore: cast_nullable_to_non_nullable
as TronTransaction,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of TronTransactionParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TronTransactionCopyWith<$Res> get transaction {
  
  return $TronTransactionCopyWith<$Res>(_self.transaction, (value) {
    return _then(_self.copyWith(transaction: value));
  });
}
}


/// Adds pattern-matching-related methods to [TronTransactionParams].
extension TronTransactionParamsPatterns on TronTransactionParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TronTransactionParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TronTransactionParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TronTransactionParams value)  $default,){
final _that = this;
switch (_that) {
case _TronTransactionParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TronTransactionParams value)?  $default,){
final _that = this;
switch (_that) {
case _TronTransactionParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TronTransaction transaction,  String address)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TronTransactionParams() when $default != null:
return $default(_that.transaction,_that.address);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TronTransaction transaction,  String address)  $default,) {final _that = this;
switch (_that) {
case _TronTransactionParams():
return $default(_that.transaction,_that.address);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TronTransaction transaction,  String address)?  $default,) {final _that = this;
switch (_that) {
case _TronTransactionParams() when $default != null:
return $default(_that.transaction,_that.address);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TronTransactionParams implements TronTransactionParams {
  const _TronTransactionParams({required this.transaction, required this.address});
  factory _TronTransactionParams.fromJson(Map<String, dynamic> json) => _$TronTransactionParamsFromJson(json);

@override final  TronTransaction transaction;
@override final  String address;

/// Create a copy of TronTransactionParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TronTransactionParamsCopyWith<_TronTransactionParams> get copyWith => __$TronTransactionParamsCopyWithImpl<_TronTransactionParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TronTransactionParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TronTransactionParams&&(identical(other.transaction, transaction) || other.transaction == transaction)&&(identical(other.address, address) || other.address == address));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,transaction,address);

@override
String toString() {
  return 'TronTransactionParams(transaction: $transaction, address: $address)';
}


}

/// @nodoc
abstract mixin class _$TronTransactionParamsCopyWith<$Res> implements $TronTransactionParamsCopyWith<$Res> {
  factory _$TronTransactionParamsCopyWith(_TronTransactionParams value, $Res Function(_TronTransactionParams) _then) = __$TronTransactionParamsCopyWithImpl;
@override @useResult
$Res call({
 TronTransaction transaction, String address
});


@override $TronTransactionCopyWith<$Res> get transaction;

}
/// @nodoc
class __$TronTransactionParamsCopyWithImpl<$Res>
    implements _$TronTransactionParamsCopyWith<$Res> {
  __$TronTransactionParamsCopyWithImpl(this._self, this._then);

  final _TronTransactionParams _self;
  final $Res Function(_TronTransactionParams) _then;

/// Create a copy of TronTransactionParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transaction = null,Object? address = null,}) {
  return _then(_TronTransactionParams(
transaction: null == transaction ? _self.transaction : transaction // ignore: cast_nullable_to_non_nullable
as TronTransaction,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of TronTransactionParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TronTransactionCopyWith<$Res> get transaction {
  
  return $TronTransactionCopyWith<$Res>(_self.transaction, (value) {
    return _then(_self.copyWith(transaction: value));
  });
}
}

TransactionRpc _$TransactionRpcFromJson(
  Map<String, dynamic> json
) {
        switch (json['method']) {
                  case 'eth_sendTransaction':
          return EvmTransactionRpc.fromJson(
            json
          );
                case 'solana_signAndSendTransaction':
          return SolanaTransactionRpc.fromJson(
            json
          );
                case 'tron_signTransaction':
          return TronTransactionRpc.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'method',
  'TransactionRpc',
  'Invalid union type "${json['method']}"!'
);
        }
      
}

/// @nodoc
mixin _$TransactionRpc {

 String get id; String get chainId; String get method; Object get params;
/// Create a copy of TransactionRpc
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionRpcCopyWith<TransactionRpc> get copyWith => _$TransactionRpcCopyWithImpl<TransactionRpc>(this as TransactionRpc, _$identity);

  /// Serializes this TransactionRpc to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionRpc&&(identical(other.id, id) || other.id == id)&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.method, method) || other.method == method)&&const DeepCollectionEquality().equals(other.params, params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,chainId,method,const DeepCollectionEquality().hash(params));

@override
String toString() {
  return 'TransactionRpc(id: $id, chainId: $chainId, method: $method, params: $params)';
}


}

/// @nodoc
abstract mixin class $TransactionRpcCopyWith<$Res>  {
  factory $TransactionRpcCopyWith(TransactionRpc value, $Res Function(TransactionRpc) _then) = _$TransactionRpcCopyWithImpl;
@useResult
$Res call({
 String id, String chainId, String method
});




}
/// @nodoc
class _$TransactionRpcCopyWithImpl<$Res>
    implements $TransactionRpcCopyWith<$Res> {
  _$TransactionRpcCopyWithImpl(this._self, this._then);

  final TransactionRpc _self;
  final $Res Function(TransactionRpc) _then;

/// Create a copy of TransactionRpc
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? chainId = null,Object? method = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TransactionRpc].
extension TransactionRpcPatterns on TransactionRpc {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( EvmTransactionRpc value)?  evm,TResult Function( SolanaTransactionRpc value)?  solana,TResult Function( TronTransactionRpc value)?  tron,required TResult orElse(),}){
final _that = this;
switch (_that) {
case EvmTransactionRpc() when evm != null:
return evm(_that);case SolanaTransactionRpc() when solana != null:
return solana(_that);case TronTransactionRpc() when tron != null:
return tron(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( EvmTransactionRpc value)  evm,required TResult Function( SolanaTransactionRpc value)  solana,required TResult Function( TronTransactionRpc value)  tron,}){
final _that = this;
switch (_that) {
case EvmTransactionRpc():
return evm(_that);case SolanaTransactionRpc():
return solana(_that);case TronTransactionRpc():
return tron(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( EvmTransactionRpc value)?  evm,TResult? Function( SolanaTransactionRpc value)?  solana,TResult? Function( TronTransactionRpc value)?  tron,}){
final _that = this;
switch (_that) {
case EvmTransactionRpc() when evm != null:
return evm(_that);case SolanaTransactionRpc() when solana != null:
return solana(_that);case TronTransactionRpc() when tron != null:
return tron(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String id,  String chainId,  String method,  List<EvmTransactionParams> params)?  evm,TResult Function( String id,  String chainId,  String method,  SolanaTransactionParams params)?  solana,TResult Function( String id,  String chainId,  String method,  TronTransactionParams params)?  tron,required TResult orElse(),}) {final _that = this;
switch (_that) {
case EvmTransactionRpc() when evm != null:
return evm(_that.id,_that.chainId,_that.method,_that.params);case SolanaTransactionRpc() when solana != null:
return solana(_that.id,_that.chainId,_that.method,_that.params);case TronTransactionRpc() when tron != null:
return tron(_that.id,_that.chainId,_that.method,_that.params);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String id,  String chainId,  String method,  List<EvmTransactionParams> params)  evm,required TResult Function( String id,  String chainId,  String method,  SolanaTransactionParams params)  solana,required TResult Function( String id,  String chainId,  String method,  TronTransactionParams params)  tron,}) {final _that = this;
switch (_that) {
case EvmTransactionRpc():
return evm(_that.id,_that.chainId,_that.method,_that.params);case SolanaTransactionRpc():
return solana(_that.id,_that.chainId,_that.method,_that.params);case TronTransactionRpc():
return tron(_that.id,_that.chainId,_that.method,_that.params);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String id,  String chainId,  String method,  List<EvmTransactionParams> params)?  evm,TResult? Function( String id,  String chainId,  String method,  SolanaTransactionParams params)?  solana,TResult? Function( String id,  String chainId,  String method,  TronTransactionParams params)?  tron,}) {final _that = this;
switch (_that) {
case EvmTransactionRpc() when evm != null:
return evm(_that.id,_that.chainId,_that.method,_that.params);case SolanaTransactionRpc() when solana != null:
return solana(_that.id,_that.chainId,_that.method,_that.params);case TronTransactionRpc() when tron != null:
return tron(_that.id,_that.chainId,_that.method,_that.params);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class EvmTransactionRpc implements TransactionRpc {
  const EvmTransactionRpc({required this.id, required this.chainId, this.method = 'eth_sendTransaction', required final  List<EvmTransactionParams> params}): _params = params;
  factory EvmTransactionRpc.fromJson(Map<String, dynamic> json) => _$EvmTransactionRpcFromJson(json);

@override final  String id;
@override final  String chainId;
@override@JsonKey() final  String method;
 final  List<EvmTransactionParams> _params;
@override List<EvmTransactionParams> get params {
  if (_params is EqualUnmodifiableListView) return _params;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_params);
}


/// Create a copy of TransactionRpc
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EvmTransactionRpcCopyWith<EvmTransactionRpc> get copyWith => _$EvmTransactionRpcCopyWithImpl<EvmTransactionRpc>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EvmTransactionRpcToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EvmTransactionRpc&&(identical(other.id, id) || other.id == id)&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.method, method) || other.method == method)&&const DeepCollectionEquality().equals(other._params, _params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,chainId,method,const DeepCollectionEquality().hash(_params));

@override
String toString() {
  return 'TransactionRpc.evm(id: $id, chainId: $chainId, method: $method, params: $params)';
}


}

/// @nodoc
abstract mixin class $EvmTransactionRpcCopyWith<$Res> implements $TransactionRpcCopyWith<$Res> {
  factory $EvmTransactionRpcCopyWith(EvmTransactionRpc value, $Res Function(EvmTransactionRpc) _then) = _$EvmTransactionRpcCopyWithImpl;
@override @useResult
$Res call({
 String id, String chainId, String method, List<EvmTransactionParams> params
});




}
/// @nodoc
class _$EvmTransactionRpcCopyWithImpl<$Res>
    implements $EvmTransactionRpcCopyWith<$Res> {
  _$EvmTransactionRpcCopyWithImpl(this._self, this._then);

  final EvmTransactionRpc _self;
  final $Res Function(EvmTransactionRpc) _then;

/// Create a copy of TransactionRpc
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? chainId = null,Object? method = null,Object? params = null,}) {
  return _then(EvmTransactionRpc(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,params: null == params ? _self._params : params // ignore: cast_nullable_to_non_nullable
as List<EvmTransactionParams>,
  ));
}


}

/// @nodoc
@JsonSerializable()

class SolanaTransactionRpc implements TransactionRpc {
  const SolanaTransactionRpc({required this.id, required this.chainId, this.method = 'solana_signAndSendTransaction', required this.params});
  factory SolanaTransactionRpc.fromJson(Map<String, dynamic> json) => _$SolanaTransactionRpcFromJson(json);

@override final  String id;
@override final  String chainId;
@override@JsonKey() final  String method;
@override final  SolanaTransactionParams params;

/// Create a copy of TransactionRpc
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SolanaTransactionRpcCopyWith<SolanaTransactionRpc> get copyWith => _$SolanaTransactionRpcCopyWithImpl<SolanaTransactionRpc>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SolanaTransactionRpcToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SolanaTransactionRpc&&(identical(other.id, id) || other.id == id)&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.method, method) || other.method == method)&&(identical(other.params, params) || other.params == params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,chainId,method,params);

@override
String toString() {
  return 'TransactionRpc.solana(id: $id, chainId: $chainId, method: $method, params: $params)';
}


}

/// @nodoc
abstract mixin class $SolanaTransactionRpcCopyWith<$Res> implements $TransactionRpcCopyWith<$Res> {
  factory $SolanaTransactionRpcCopyWith(SolanaTransactionRpc value, $Res Function(SolanaTransactionRpc) _then) = _$SolanaTransactionRpcCopyWithImpl;
@override @useResult
$Res call({
 String id, String chainId, String method, SolanaTransactionParams params
});


$SolanaTransactionParamsCopyWith<$Res> get params;

}
/// @nodoc
class _$SolanaTransactionRpcCopyWithImpl<$Res>
    implements $SolanaTransactionRpcCopyWith<$Res> {
  _$SolanaTransactionRpcCopyWithImpl(this._self, this._then);

  final SolanaTransactionRpc _self;
  final $Res Function(SolanaTransactionRpc) _then;

/// Create a copy of TransactionRpc
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? chainId = null,Object? method = null,Object? params = null,}) {
  return _then(SolanaTransactionRpc(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as SolanaTransactionParams,
  ));
}

/// Create a copy of TransactionRpc
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SolanaTransactionParamsCopyWith<$Res> get params {
  
  return $SolanaTransactionParamsCopyWith<$Res>(_self.params, (value) {
    return _then(_self.copyWith(params: value));
  });
}
}

/// @nodoc
@JsonSerializable()

class TronTransactionRpc implements TransactionRpc {
  const TronTransactionRpc({required this.id, required this.chainId, this.method = 'tron_signTransaction', required this.params});
  factory TronTransactionRpc.fromJson(Map<String, dynamic> json) => _$TronTransactionRpcFromJson(json);

@override final  String id;
@override final  String chainId;
@override@JsonKey() final  String method;
@override final  TronTransactionParams params;

/// Create a copy of TransactionRpc
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TronTransactionRpcCopyWith<TronTransactionRpc> get copyWith => _$TronTransactionRpcCopyWithImpl<TronTransactionRpc>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TronTransactionRpcToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TronTransactionRpc&&(identical(other.id, id) || other.id == id)&&(identical(other.chainId, chainId) || other.chainId == chainId)&&(identical(other.method, method) || other.method == method)&&(identical(other.params, params) || other.params == params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,chainId,method,params);

@override
String toString() {
  return 'TransactionRpc.tron(id: $id, chainId: $chainId, method: $method, params: $params)';
}


}

/// @nodoc
abstract mixin class $TronTransactionRpcCopyWith<$Res> implements $TransactionRpcCopyWith<$Res> {
  factory $TronTransactionRpcCopyWith(TronTransactionRpc value, $Res Function(TronTransactionRpc) _then) = _$TronTransactionRpcCopyWithImpl;
@override @useResult
$Res call({
 String id, String chainId, String method, TronTransactionParams params
});


$TronTransactionParamsCopyWith<$Res> get params;

}
/// @nodoc
class _$TronTransactionRpcCopyWithImpl<$Res>
    implements $TronTransactionRpcCopyWith<$Res> {
  _$TronTransactionRpcCopyWithImpl(this._self, this._then);

  final TronTransactionRpc _self;
  final $Res Function(TronTransactionRpc) _then;

/// Create a copy of TransactionRpc
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? chainId = null,Object? method = null,Object? params = null,}) {
  return _then(TronTransactionRpc(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,chainId: null == chainId ? _self.chainId : chainId // ignore: cast_nullable_to_non_nullable
as String,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,params: null == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as TronTransactionParams,
  ));
}

/// Create a copy of TransactionRpc
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TronTransactionParamsCopyWith<$Res> get params {
  
  return $TronTransactionParamsCopyWith<$Res>(_self.params, (value) {
    return _then(_self.copyWith(params: value));
  });
}
}


/// @nodoc
mixin _$BuildTransactionResult {

 List<TransactionRpc> get transactions;
/// Create a copy of BuildTransactionResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BuildTransactionResultCopyWith<BuildTransactionResult> get copyWith => _$BuildTransactionResultCopyWithImpl<BuildTransactionResult>(this as BuildTransactionResult, _$identity);

  /// Serializes this BuildTransactionResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BuildTransactionResult&&const DeepCollectionEquality().equals(other.transactions, transactions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(transactions));

@override
String toString() {
  return 'BuildTransactionResult(transactions: $transactions)';
}


}

/// @nodoc
abstract mixin class $BuildTransactionResultCopyWith<$Res>  {
  factory $BuildTransactionResultCopyWith(BuildTransactionResult value, $Res Function(BuildTransactionResult) _then) = _$BuildTransactionResultCopyWithImpl;
@useResult
$Res call({
 List<TransactionRpc> transactions
});




}
/// @nodoc
class _$BuildTransactionResultCopyWithImpl<$Res>
    implements $BuildTransactionResultCopyWith<$Res> {
  _$BuildTransactionResultCopyWithImpl(this._self, this._then);

  final BuildTransactionResult _self;
  final $Res Function(BuildTransactionResult) _then;

/// Create a copy of BuildTransactionResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transactions = null,}) {
  return _then(_self.copyWith(
transactions: null == transactions ? _self.transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<TransactionRpc>,
  ));
}

}


/// Adds pattern-matching-related methods to [BuildTransactionResult].
extension BuildTransactionResultPatterns on BuildTransactionResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BuildTransactionResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BuildTransactionResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BuildTransactionResult value)  $default,){
final _that = this;
switch (_that) {
case _BuildTransactionResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BuildTransactionResult value)?  $default,){
final _that = this;
switch (_that) {
case _BuildTransactionResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TransactionRpc> transactions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BuildTransactionResult() when $default != null:
return $default(_that.transactions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TransactionRpc> transactions)  $default,) {final _that = this;
switch (_that) {
case _BuildTransactionResult():
return $default(_that.transactions);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TransactionRpc> transactions)?  $default,) {final _that = this;
switch (_that) {
case _BuildTransactionResult() when $default != null:
return $default(_that.transactions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BuildTransactionResult implements BuildTransactionResult {
  const _BuildTransactionResult({required final  List<TransactionRpc> transactions}): _transactions = transactions;
  factory _BuildTransactionResult.fromJson(Map<String, dynamic> json) => _$BuildTransactionResultFromJson(json);

 final  List<TransactionRpc> _transactions;
@override List<TransactionRpc> get transactions {
  if (_transactions is EqualUnmodifiableListView) return _transactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transactions);
}


/// Create a copy of BuildTransactionResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BuildTransactionResultCopyWith<_BuildTransactionResult> get copyWith => __$BuildTransactionResultCopyWithImpl<_BuildTransactionResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BuildTransactionResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BuildTransactionResult&&const DeepCollectionEquality().equals(other._transactions, _transactions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_transactions));

@override
String toString() {
  return 'BuildTransactionResult(transactions: $transactions)';
}


}

/// @nodoc
abstract mixin class _$BuildTransactionResultCopyWith<$Res> implements $BuildTransactionResultCopyWith<$Res> {
  factory _$BuildTransactionResultCopyWith(_BuildTransactionResult value, $Res Function(_BuildTransactionResult) _then) = __$BuildTransactionResultCopyWithImpl;
@override @useResult
$Res call({
 List<TransactionRpc> transactions
});




}
/// @nodoc
class __$BuildTransactionResultCopyWithImpl<$Res>
    implements _$BuildTransactionResultCopyWith<$Res> {
  __$BuildTransactionResultCopyWithImpl(this._self, this._then);

  final _BuildTransactionResult _self;
  final $Res Function(_BuildTransactionResult) _then;

/// Create a copy of BuildTransactionResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transactions = null,}) {
  return _then(_BuildTransactionResult(
transactions: null == transactions ? _self._transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<TransactionRpc>,
  ));
}


}


/// @nodoc
mixin _$SupportedNamespace {

 List<String> get assetNamespaces; dynamic get capabilities; List<String> get events; List<String> get methods; String get name;
/// Create a copy of SupportedNamespace
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupportedNamespaceCopyWith<SupportedNamespace> get copyWith => _$SupportedNamespaceCopyWithImpl<SupportedNamespace>(this as SupportedNamespace, _$identity);

  /// Serializes this SupportedNamespace to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupportedNamespace&&const DeepCollectionEquality().equals(other.assetNamespaces, assetNamespaces)&&const DeepCollectionEquality().equals(other.capabilities, capabilities)&&const DeepCollectionEquality().equals(other.events, events)&&const DeepCollectionEquality().equals(other.methods, methods)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(assetNamespaces),const DeepCollectionEquality().hash(capabilities),const DeepCollectionEquality().hash(events),const DeepCollectionEquality().hash(methods),name);

@override
String toString() {
  return 'SupportedNamespace(assetNamespaces: $assetNamespaces, capabilities: $capabilities, events: $events, methods: $methods, name: $name)';
}


}

/// @nodoc
abstract mixin class $SupportedNamespaceCopyWith<$Res>  {
  factory $SupportedNamespaceCopyWith(SupportedNamespace value, $Res Function(SupportedNamespace) _then) = _$SupportedNamespaceCopyWithImpl;
@useResult
$Res call({
 List<String> assetNamespaces, dynamic capabilities, List<String> events, List<String> methods, String name
});




}
/// @nodoc
class _$SupportedNamespaceCopyWithImpl<$Res>
    implements $SupportedNamespaceCopyWith<$Res> {
  _$SupportedNamespaceCopyWithImpl(this._self, this._then);

  final SupportedNamespace _self;
  final $Res Function(SupportedNamespace) _then;

/// Create a copy of SupportedNamespace
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? assetNamespaces = null,Object? capabilities = freezed,Object? events = null,Object? methods = null,Object? name = null,}) {
  return _then(_self.copyWith(
assetNamespaces: null == assetNamespaces ? _self.assetNamespaces : assetNamespaces // ignore: cast_nullable_to_non_nullable
as List<String>,capabilities: freezed == capabilities ? _self.capabilities : capabilities // ignore: cast_nullable_to_non_nullable
as dynamic,events: null == events ? _self.events : events // ignore: cast_nullable_to_non_nullable
as List<String>,methods: null == methods ? _self.methods : methods // ignore: cast_nullable_to_non_nullable
as List<String>,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SupportedNamespace].
extension SupportedNamespacePatterns on SupportedNamespace {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SupportedNamespace value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SupportedNamespace() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SupportedNamespace value)  $default,){
final _that = this;
switch (_that) {
case _SupportedNamespace():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SupportedNamespace value)?  $default,){
final _that = this;
switch (_that) {
case _SupportedNamespace() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> assetNamespaces,  dynamic capabilities,  List<String> events,  List<String> methods,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SupportedNamespace() when $default != null:
return $default(_that.assetNamespaces,_that.capabilities,_that.events,_that.methods,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> assetNamespaces,  dynamic capabilities,  List<String> events,  List<String> methods,  String name)  $default,) {final _that = this;
switch (_that) {
case _SupportedNamespace():
return $default(_that.assetNamespaces,_that.capabilities,_that.events,_that.methods,_that.name);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> assetNamespaces,  dynamic capabilities,  List<String> events,  List<String> methods,  String name)?  $default,) {final _that = this;
switch (_that) {
case _SupportedNamespace() when $default != null:
return $default(_that.assetNamespaces,_that.capabilities,_that.events,_that.methods,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SupportedNamespace implements SupportedNamespace {
  const _SupportedNamespace({required final  List<String> assetNamespaces, this.capabilities, required final  List<String> events, required final  List<String> methods, required this.name}): _assetNamespaces = assetNamespaces,_events = events,_methods = methods;
  factory _SupportedNamespace.fromJson(Map<String, dynamic> json) => _$SupportedNamespaceFromJson(json);

 final  List<String> _assetNamespaces;
@override List<String> get assetNamespaces {
  if (_assetNamespaces is EqualUnmodifiableListView) return _assetNamespaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_assetNamespaces);
}

@override final  dynamic capabilities;
 final  List<String> _events;
@override List<String> get events {
  if (_events is EqualUnmodifiableListView) return _events;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_events);
}

 final  List<String> _methods;
@override List<String> get methods {
  if (_methods is EqualUnmodifiableListView) return _methods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_methods);
}

@override final  String name;

/// Create a copy of SupportedNamespace
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SupportedNamespaceCopyWith<_SupportedNamespace> get copyWith => __$SupportedNamespaceCopyWithImpl<_SupportedNamespace>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SupportedNamespaceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SupportedNamespace&&const DeepCollectionEquality().equals(other._assetNamespaces, _assetNamespaces)&&const DeepCollectionEquality().equals(other.capabilities, capabilities)&&const DeepCollectionEquality().equals(other._events, _events)&&const DeepCollectionEquality().equals(other._methods, _methods)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_assetNamespaces),const DeepCollectionEquality().hash(capabilities),const DeepCollectionEquality().hash(_events),const DeepCollectionEquality().hash(_methods),name);

@override
String toString() {
  return 'SupportedNamespace(assetNamespaces: $assetNamespaces, capabilities: $capabilities, events: $events, methods: $methods, name: $name)';
}


}

/// @nodoc
abstract mixin class _$SupportedNamespaceCopyWith<$Res> implements $SupportedNamespaceCopyWith<$Res> {
  factory _$SupportedNamespaceCopyWith(_SupportedNamespace value, $Res Function(_SupportedNamespace) _then) = __$SupportedNamespaceCopyWithImpl;
@override @useResult
$Res call({
 List<String> assetNamespaces, dynamic capabilities, List<String> events, List<String> methods, String name
});




}
/// @nodoc
class __$SupportedNamespaceCopyWithImpl<$Res>
    implements _$SupportedNamespaceCopyWith<$Res> {
  __$SupportedNamespaceCopyWithImpl(this._self, this._then);

  final _SupportedNamespace _self;
  final $Res Function(_SupportedNamespace) _then;

/// Create a copy of SupportedNamespace
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? assetNamespaces = null,Object? capabilities = freezed,Object? events = null,Object? methods = null,Object? name = null,}) {
  return _then(_SupportedNamespace(
assetNamespaces: null == assetNamespaces ? _self._assetNamespaces : assetNamespaces // ignore: cast_nullable_to_non_nullable
as List<String>,capabilities: freezed == capabilities ? _self.capabilities : capabilities // ignore: cast_nullable_to_non_nullable
as dynamic,events: null == events ? _self._events : events // ignore: cast_nullable_to_non_nullable
as List<String>,methods: null == methods ? _self._methods : methods // ignore: cast_nullable_to_non_nullable
as List<String>,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SupportedNetworksResult {

 List<SupportedNamespace> get namespaces;
/// Create a copy of SupportedNetworksResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SupportedNetworksResultCopyWith<SupportedNetworksResult> get copyWith => _$SupportedNetworksResultCopyWithImpl<SupportedNetworksResult>(this as SupportedNetworksResult, _$identity);

  /// Serializes this SupportedNetworksResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SupportedNetworksResult&&const DeepCollectionEquality().equals(other.namespaces, namespaces));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(namespaces));

@override
String toString() {
  return 'SupportedNetworksResult(namespaces: $namespaces)';
}


}

/// @nodoc
abstract mixin class $SupportedNetworksResultCopyWith<$Res>  {
  factory $SupportedNetworksResultCopyWith(SupportedNetworksResult value, $Res Function(SupportedNetworksResult) _then) = _$SupportedNetworksResultCopyWithImpl;
@useResult
$Res call({
 List<SupportedNamespace> namespaces
});




}
/// @nodoc
class _$SupportedNetworksResultCopyWithImpl<$Res>
    implements $SupportedNetworksResultCopyWith<$Res> {
  _$SupportedNetworksResultCopyWithImpl(this._self, this._then);

  final SupportedNetworksResult _self;
  final $Res Function(SupportedNetworksResult) _then;

/// Create a copy of SupportedNetworksResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? namespaces = null,}) {
  return _then(_self.copyWith(
namespaces: null == namespaces ? _self.namespaces : namespaces // ignore: cast_nullable_to_non_nullable
as List<SupportedNamespace>,
  ));
}

}


/// Adds pattern-matching-related methods to [SupportedNetworksResult].
extension SupportedNetworksResultPatterns on SupportedNetworksResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SupportedNetworksResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SupportedNetworksResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SupportedNetworksResult value)  $default,){
final _that = this;
switch (_that) {
case _SupportedNetworksResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SupportedNetworksResult value)?  $default,){
final _that = this;
switch (_that) {
case _SupportedNetworksResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SupportedNamespace> namespaces)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SupportedNetworksResult() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SupportedNamespace> namespaces)  $default,) {final _that = this;
switch (_that) {
case _SupportedNetworksResult():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SupportedNamespace> namespaces)?  $default,) {final _that = this;
switch (_that) {
case _SupportedNetworksResult() when $default != null:
return $default(_that.namespaces);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SupportedNetworksResult implements SupportedNetworksResult {
  const _SupportedNetworksResult({required final  List<SupportedNamespace> namespaces}): _namespaces = namespaces;
  factory _SupportedNetworksResult.fromJson(Map<String, dynamic> json) => _$SupportedNetworksResultFromJson(json);

 final  List<SupportedNamespace> _namespaces;
@override List<SupportedNamespace> get namespaces {
  if (_namespaces is EqualUnmodifiableListView) return _namespaces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_namespaces);
}


/// Create a copy of SupportedNetworksResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SupportedNetworksResultCopyWith<_SupportedNetworksResult> get copyWith => __$SupportedNetworksResultCopyWithImpl<_SupportedNetworksResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SupportedNetworksResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SupportedNetworksResult&&const DeepCollectionEquality().equals(other._namespaces, _namespaces));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_namespaces));

@override
String toString() {
  return 'SupportedNetworksResult(namespaces: $namespaces)';
}


}

/// @nodoc
abstract mixin class _$SupportedNetworksResultCopyWith<$Res> implements $SupportedNetworksResultCopyWith<$Res> {
  factory _$SupportedNetworksResultCopyWith(_SupportedNetworksResult value, $Res Function(_SupportedNetworksResult) _then) = __$SupportedNetworksResultCopyWithImpl;
@override @useResult
$Res call({
 List<SupportedNamespace> namespaces
});




}
/// @nodoc
class __$SupportedNetworksResultCopyWithImpl<$Res>
    implements _$SupportedNetworksResultCopyWith<$Res> {
  __$SupportedNetworksResultCopyWithImpl(this._self, this._then);

  final _SupportedNetworksResult _self;
  final $Res Function(_SupportedNetworksResult) _then;

/// Create a copy of SupportedNetworksResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? namespaces = null,}) {
  return _then(_SupportedNetworksResult(
namespaces: null == namespaces ? _self._namespaces : namespaces // ignore: cast_nullable_to_non_nullable
as List<SupportedNamespace>,
  ));
}


}

// dart format on
