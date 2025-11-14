// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ton.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TonKeyPair {

 String get sk; String get pk;
/// Create a copy of TonKeyPair
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TonKeyPairCopyWith<TonKeyPair> get copyWith => _$TonKeyPairCopyWithImpl<TonKeyPair>(this as TonKeyPair, _$identity);

  /// Serializes this TonKeyPair to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TonKeyPair&&(identical(other.sk, sk) || other.sk == sk)&&(identical(other.pk, pk) || other.pk == pk));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sk,pk);

@override
String toString() {
  return 'TonKeyPair(sk: $sk, pk: $pk)';
}


}

/// @nodoc
abstract mixin class $TonKeyPairCopyWith<$Res>  {
  factory $TonKeyPairCopyWith(TonKeyPair value, $Res Function(TonKeyPair) _then) = _$TonKeyPairCopyWithImpl;
@useResult
$Res call({
 String sk, String pk
});




}
/// @nodoc
class _$TonKeyPairCopyWithImpl<$Res>
    implements $TonKeyPairCopyWith<$Res> {
  _$TonKeyPairCopyWithImpl(this._self, this._then);

  final TonKeyPair _self;
  final $Res Function(TonKeyPair) _then;

/// Create a copy of TonKeyPair
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sk = null,Object? pk = null,}) {
  return _then(_self.copyWith(
sk: null == sk ? _self.sk : sk // ignore: cast_nullable_to_non_nullable
as String,pk: null == pk ? _self.pk : pk // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TonKeyPair].
extension TonKeyPairPatterns on TonKeyPair {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TonKeyPair value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TonKeyPair() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TonKeyPair value)  $default,){
final _that = this;
switch (_that) {
case _TonKeyPair():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TonKeyPair value)?  $default,){
final _that = this;
switch (_that) {
case _TonKeyPair() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sk,  String pk)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TonKeyPair() when $default != null:
return $default(_that.sk,_that.pk);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sk,  String pk)  $default,) {final _that = this;
switch (_that) {
case _TonKeyPair():
return $default(_that.sk,_that.pk);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sk,  String pk)?  $default,) {final _that = this;
switch (_that) {
case _TonKeyPair() when $default != null:
return $default(_that.sk,_that.pk);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TonKeyPair implements TonKeyPair {
  const _TonKeyPair({required this.sk, required this.pk});
  factory _TonKeyPair.fromJson(Map<String, dynamic> json) => _$TonKeyPairFromJson(json);

@override final  String sk;
@override final  String pk;

/// Create a copy of TonKeyPair
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TonKeyPairCopyWith<_TonKeyPair> get copyWith => __$TonKeyPairCopyWithImpl<_TonKeyPair>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TonKeyPairToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TonKeyPair&&(identical(other.sk, sk) || other.sk == sk)&&(identical(other.pk, pk) || other.pk == pk));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sk,pk);

@override
String toString() {
  return 'TonKeyPair(sk: $sk, pk: $pk)';
}


}

/// @nodoc
abstract mixin class _$TonKeyPairCopyWith<$Res> implements $TonKeyPairCopyWith<$Res> {
  factory _$TonKeyPairCopyWith(_TonKeyPair value, $Res Function(_TonKeyPair) _then) = __$TonKeyPairCopyWithImpl;
@override @useResult
$Res call({
 String sk, String pk
});




}
/// @nodoc
class __$TonKeyPairCopyWithImpl<$Res>
    implements _$TonKeyPairCopyWith<$Res> {
  __$TonKeyPairCopyWithImpl(this._self, this._then);

  final _TonKeyPair _self;
  final $Res Function(_TonKeyPair) _then;

/// Create a copy of TonKeyPair
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sk = null,Object? pk = null,}) {
  return _then(_TonKeyPair(
sk: null == sk ? _self.sk : sk // ignore: cast_nullable_to_non_nullable
as String,pk: null == pk ? _self.pk : pk // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$TonIdentity {

 String get friendlyEq; String get rawHex; String get workchain;
/// Create a copy of TonIdentity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TonIdentityCopyWith<TonIdentity> get copyWith => _$TonIdentityCopyWithImpl<TonIdentity>(this as TonIdentity, _$identity);

  /// Serializes this TonIdentity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TonIdentity&&(identical(other.friendlyEq, friendlyEq) || other.friendlyEq == friendlyEq)&&(identical(other.rawHex, rawHex) || other.rawHex == rawHex)&&(identical(other.workchain, workchain) || other.workchain == workchain));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,friendlyEq,rawHex,workchain);

@override
String toString() {
  return 'TonIdentity(friendlyEq: $friendlyEq, rawHex: $rawHex, workchain: $workchain)';
}


}

/// @nodoc
abstract mixin class $TonIdentityCopyWith<$Res>  {
  factory $TonIdentityCopyWith(TonIdentity value, $Res Function(TonIdentity) _then) = _$TonIdentityCopyWithImpl;
@useResult
$Res call({
 String friendlyEq, String rawHex, String workchain
});




}
/// @nodoc
class _$TonIdentityCopyWithImpl<$Res>
    implements $TonIdentityCopyWith<$Res> {
  _$TonIdentityCopyWithImpl(this._self, this._then);

  final TonIdentity _self;
  final $Res Function(TonIdentity) _then;

/// Create a copy of TonIdentity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? friendlyEq = null,Object? rawHex = null,Object? workchain = null,}) {
  return _then(_self.copyWith(
friendlyEq: null == friendlyEq ? _self.friendlyEq : friendlyEq // ignore: cast_nullable_to_non_nullable
as String,rawHex: null == rawHex ? _self.rawHex : rawHex // ignore: cast_nullable_to_non_nullable
as String,workchain: null == workchain ? _self.workchain : workchain // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TonIdentity].
extension TonIdentityPatterns on TonIdentity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TonIdentity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TonIdentity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TonIdentity value)  $default,){
final _that = this;
switch (_that) {
case _TonIdentity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TonIdentity value)?  $default,){
final _that = this;
switch (_that) {
case _TonIdentity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String friendlyEq,  String rawHex,  String workchain)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TonIdentity() when $default != null:
return $default(_that.friendlyEq,_that.rawHex,_that.workchain);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String friendlyEq,  String rawHex,  String workchain)  $default,) {final _that = this;
switch (_that) {
case _TonIdentity():
return $default(_that.friendlyEq,_that.rawHex,_that.workchain);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String friendlyEq,  String rawHex,  String workchain)?  $default,) {final _that = this;
switch (_that) {
case _TonIdentity() when $default != null:
return $default(_that.friendlyEq,_that.rawHex,_that.workchain);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TonIdentity implements TonIdentity {
  const _TonIdentity({required this.friendlyEq, required this.rawHex, required this.workchain});
  factory _TonIdentity.fromJson(Map<String, dynamic> json) => _$TonIdentityFromJson(json);

@override final  String friendlyEq;
@override final  String rawHex;
@override final  String workchain;

/// Create a copy of TonIdentity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TonIdentityCopyWith<_TonIdentity> get copyWith => __$TonIdentityCopyWithImpl<_TonIdentity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TonIdentityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TonIdentity&&(identical(other.friendlyEq, friendlyEq) || other.friendlyEq == friendlyEq)&&(identical(other.rawHex, rawHex) || other.rawHex == rawHex)&&(identical(other.workchain, workchain) || other.workchain == workchain));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,friendlyEq,rawHex,workchain);

@override
String toString() {
  return 'TonIdentity(friendlyEq: $friendlyEq, rawHex: $rawHex, workchain: $workchain)';
}


}

/// @nodoc
abstract mixin class _$TonIdentityCopyWith<$Res> implements $TonIdentityCopyWith<$Res> {
  factory _$TonIdentityCopyWith(_TonIdentity value, $Res Function(_TonIdentity) _then) = __$TonIdentityCopyWithImpl;
@override @useResult
$Res call({
 String friendlyEq, String rawHex, String workchain
});




}
/// @nodoc
class __$TonIdentityCopyWithImpl<$Res>
    implements _$TonIdentityCopyWith<$Res> {
  __$TonIdentityCopyWithImpl(this._self, this._then);

  final _TonIdentity _self;
  final $Res Function(_TonIdentity) _then;

/// Create a copy of TonIdentity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? friendlyEq = null,Object? rawHex = null,Object? workchain = null,}) {
  return _then(_TonIdentity(
friendlyEq: null == friendlyEq ? _self.friendlyEq : friendlyEq // ignore: cast_nullable_to_non_nullable
as String,rawHex: null == rawHex ? _self.rawHex : rawHex // ignore: cast_nullable_to_non_nullable
as String,workchain: null == workchain ? _self.workchain : workchain // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$TonMessage {

 String get address; String get amount; String? get payload; String? get stateInit;
/// Create a copy of TonMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TonMessageCopyWith<TonMessage> get copyWith => _$TonMessageCopyWithImpl<TonMessage>(this as TonMessage, _$identity);

  /// Serializes this TonMessage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TonMessage&&(identical(other.address, address) || other.address == address)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.payload, payload) || other.payload == payload)&&(identical(other.stateInit, stateInit) || other.stateInit == stateInit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,address,amount,payload,stateInit);

@override
String toString() {
  return 'TonMessage(address: $address, amount: $amount, payload: $payload, stateInit: $stateInit)';
}


}

/// @nodoc
abstract mixin class $TonMessageCopyWith<$Res>  {
  factory $TonMessageCopyWith(TonMessage value, $Res Function(TonMessage) _then) = _$TonMessageCopyWithImpl;
@useResult
$Res call({
 String address, String amount, String? payload, String? stateInit
});




}
/// @nodoc
class _$TonMessageCopyWithImpl<$Res>
    implements $TonMessageCopyWith<$Res> {
  _$TonMessageCopyWithImpl(this._self, this._then);

  final TonMessage _self;
  final $Res Function(TonMessage) _then;

/// Create a copy of TonMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? address = null,Object? amount = null,Object? payload = freezed,Object? stateInit = freezed,}) {
  return _then(_self.copyWith(
address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,payload: freezed == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as String?,stateInit: freezed == stateInit ? _self.stateInit : stateInit // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TonMessage].
extension TonMessagePatterns on TonMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TonMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TonMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TonMessage value)  $default,){
final _that = this;
switch (_that) {
case _TonMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TonMessage value)?  $default,){
final _that = this;
switch (_that) {
case _TonMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String address,  String amount,  String? payload,  String? stateInit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TonMessage() when $default != null:
return $default(_that.address,_that.amount,_that.payload,_that.stateInit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String address,  String amount,  String? payload,  String? stateInit)  $default,) {final _that = this;
switch (_that) {
case _TonMessage():
return $default(_that.address,_that.amount,_that.payload,_that.stateInit);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String address,  String amount,  String? payload,  String? stateInit)?  $default,) {final _that = this;
switch (_that) {
case _TonMessage() when $default != null:
return $default(_that.address,_that.amount,_that.payload,_that.stateInit);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TonMessage implements TonMessage {
  const _TonMessage({required this.address, required this.amount, this.payload, this.stateInit});
  factory _TonMessage.fromJson(Map<String, dynamic> json) => _$TonMessageFromJson(json);

@override final  String address;
@override final  String amount;
@override final  String? payload;
@override final  String? stateInit;

/// Create a copy of TonMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TonMessageCopyWith<_TonMessage> get copyWith => __$TonMessageCopyWithImpl<_TonMessage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TonMessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TonMessage&&(identical(other.address, address) || other.address == address)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.payload, payload) || other.payload == payload)&&(identical(other.stateInit, stateInit) || other.stateInit == stateInit));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,address,amount,payload,stateInit);

@override
String toString() {
  return 'TonMessage(address: $address, amount: $amount, payload: $payload, stateInit: $stateInit)';
}


}

/// @nodoc
abstract mixin class _$TonMessageCopyWith<$Res> implements $TonMessageCopyWith<$Res> {
  factory _$TonMessageCopyWith(_TonMessage value, $Res Function(_TonMessage) _then) = __$TonMessageCopyWithImpl;
@override @useResult
$Res call({
 String address, String amount, String? payload, String? stateInit
});




}
/// @nodoc
class __$TonMessageCopyWithImpl<$Res>
    implements _$TonMessageCopyWith<$Res> {
  __$TonMessageCopyWithImpl(this._self, this._then);

  final _TonMessage _self;
  final $Res Function(_TonMessage) _then;

/// Create a copy of TonMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? address = null,Object? amount = null,Object? payload = freezed,Object? stateInit = freezed,}) {
  return _then(_TonMessage(
address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,payload: freezed == payload ? _self.payload : payload // ignore: cast_nullable_to_non_nullable
as String?,stateInit: freezed == stateInit ? _self.stateInit : stateInit // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
