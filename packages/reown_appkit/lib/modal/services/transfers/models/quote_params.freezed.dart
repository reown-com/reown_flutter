// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quote_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GetQuoteParams {

 ExchangeAsset get sourceToken; ExchangeAsset get toToken; String get recipient; String get amount; String? get address;
/// Create a copy of GetQuoteParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetQuoteParamsCopyWith<GetQuoteParams> get copyWith => _$GetQuoteParamsCopyWithImpl<GetQuoteParams>(this as GetQuoteParams, _$identity);

  /// Serializes this GetQuoteParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetQuoteParams&&(identical(other.sourceToken, sourceToken) || other.sourceToken == sourceToken)&&(identical(other.toToken, toToken) || other.toToken == toToken)&&(identical(other.recipient, recipient) || other.recipient == recipient)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.address, address) || other.address == address));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sourceToken,toToken,recipient,amount,address);

@override
String toString() {
  return 'GetQuoteParams(sourceToken: $sourceToken, toToken: $toToken, recipient: $recipient, amount: $amount, address: $address)';
}


}

/// @nodoc
abstract mixin class $GetQuoteParamsCopyWith<$Res>  {
  factory $GetQuoteParamsCopyWith(GetQuoteParams value, $Res Function(GetQuoteParams) _then) = _$GetQuoteParamsCopyWithImpl;
@useResult
$Res call({
 ExchangeAsset sourceToken, ExchangeAsset toToken, String recipient, String amount, String? address
});


$ExchangeAssetCopyWith<$Res> get sourceToken;$ExchangeAssetCopyWith<$Res> get toToken;

}
/// @nodoc
class _$GetQuoteParamsCopyWithImpl<$Res>
    implements $GetQuoteParamsCopyWith<$Res> {
  _$GetQuoteParamsCopyWithImpl(this._self, this._then);

  final GetQuoteParams _self;
  final $Res Function(GetQuoteParams) _then;

/// Create a copy of GetQuoteParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sourceToken = null,Object? toToken = null,Object? recipient = null,Object? amount = null,Object? address = freezed,}) {
  return _then(_self.copyWith(
sourceToken: null == sourceToken ? _self.sourceToken : sourceToken // ignore: cast_nullable_to_non_nullable
as ExchangeAsset,toToken: null == toToken ? _self.toToken : toToken // ignore: cast_nullable_to_non_nullable
as ExchangeAsset,recipient: null == recipient ? _self.recipient : recipient // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of GetQuoteParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExchangeAssetCopyWith<$Res> get sourceToken {
  
  return $ExchangeAssetCopyWith<$Res>(_self.sourceToken, (value) {
    return _then(_self.copyWith(sourceToken: value));
  });
}/// Create a copy of GetQuoteParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExchangeAssetCopyWith<$Res> get toToken {
  
  return $ExchangeAssetCopyWith<$Res>(_self.toToken, (value) {
    return _then(_self.copyWith(toToken: value));
  });
}
}


/// Adds pattern-matching-related methods to [GetQuoteParams].
extension GetQuoteParamsPatterns on GetQuoteParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetQuoteParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetQuoteParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetQuoteParams value)  $default,){
final _that = this;
switch (_that) {
case _GetQuoteParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetQuoteParams value)?  $default,){
final _that = this;
switch (_that) {
case _GetQuoteParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ExchangeAsset sourceToken,  ExchangeAsset toToken,  String recipient,  String amount,  String? address)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetQuoteParams() when $default != null:
return $default(_that.sourceToken,_that.toToken,_that.recipient,_that.amount,_that.address);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ExchangeAsset sourceToken,  ExchangeAsset toToken,  String recipient,  String amount,  String? address)  $default,) {final _that = this;
switch (_that) {
case _GetQuoteParams():
return $default(_that.sourceToken,_that.toToken,_that.recipient,_that.amount,_that.address);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ExchangeAsset sourceToken,  ExchangeAsset toToken,  String recipient,  String amount,  String? address)?  $default,) {final _that = this;
switch (_that) {
case _GetQuoteParams() when $default != null:
return $default(_that.sourceToken,_that.toToken,_that.recipient,_that.amount,_that.address);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetQuoteParams implements GetQuoteParams {
  const _GetQuoteParams({required this.sourceToken, required this.toToken, required this.recipient, required this.amount, this.address});
  factory _GetQuoteParams.fromJson(Map<String, dynamic> json) => _$GetQuoteParamsFromJson(json);

@override final  ExchangeAsset sourceToken;
@override final  ExchangeAsset toToken;
@override final  String recipient;
@override final  String amount;
@override final  String? address;

/// Create a copy of GetQuoteParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetQuoteParamsCopyWith<_GetQuoteParams> get copyWith => __$GetQuoteParamsCopyWithImpl<_GetQuoteParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetQuoteParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetQuoteParams&&(identical(other.sourceToken, sourceToken) || other.sourceToken == sourceToken)&&(identical(other.toToken, toToken) || other.toToken == toToken)&&(identical(other.recipient, recipient) || other.recipient == recipient)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.address, address) || other.address == address));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sourceToken,toToken,recipient,amount,address);

@override
String toString() {
  return 'GetQuoteParams(sourceToken: $sourceToken, toToken: $toToken, recipient: $recipient, amount: $amount, address: $address)';
}


}

/// @nodoc
abstract mixin class _$GetQuoteParamsCopyWith<$Res> implements $GetQuoteParamsCopyWith<$Res> {
  factory _$GetQuoteParamsCopyWith(_GetQuoteParams value, $Res Function(_GetQuoteParams) _then) = __$GetQuoteParamsCopyWithImpl;
@override @useResult
$Res call({
 ExchangeAsset sourceToken, ExchangeAsset toToken, String recipient, String amount, String? address
});


@override $ExchangeAssetCopyWith<$Res> get sourceToken;@override $ExchangeAssetCopyWith<$Res> get toToken;

}
/// @nodoc
class __$GetQuoteParamsCopyWithImpl<$Res>
    implements _$GetQuoteParamsCopyWith<$Res> {
  __$GetQuoteParamsCopyWithImpl(this._self, this._then);

  final _GetQuoteParams _self;
  final $Res Function(_GetQuoteParams) _then;

/// Create a copy of GetQuoteParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sourceToken = null,Object? toToken = null,Object? recipient = null,Object? amount = null,Object? address = freezed,}) {
  return _then(_GetQuoteParams(
sourceToken: null == sourceToken ? _self.sourceToken : sourceToken // ignore: cast_nullable_to_non_nullable
as ExchangeAsset,toToken: null == toToken ? _self.toToken : toToken // ignore: cast_nullable_to_non_nullable
as ExchangeAsset,recipient: null == recipient ? _self.recipient : recipient // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of GetQuoteParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExchangeAssetCopyWith<$Res> get sourceToken {
  
  return $ExchangeAssetCopyWith<$Res>(_self.sourceToken, (value) {
    return _then(_self.copyWith(sourceToken: value));
  });
}/// Create a copy of GetQuoteParams
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExchangeAssetCopyWith<$Res> get toToken {
  
  return $ExchangeAssetCopyWith<$Res>(_self.toToken, (value) {
    return _then(_self.copyWith(toToken: value));
  });
}
}


/// @nodoc
mixin _$GetTransfersQuoteParams {

@JsonKey(includeIfNull: false) String? get user; String get originChainId; String get originCurrency; String get destinationChainId; String get destinationCurrency; String get recipient; String get amount;
/// Create a copy of GetTransfersQuoteParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetTransfersQuoteParamsCopyWith<GetTransfersQuoteParams> get copyWith => _$GetTransfersQuoteParamsCopyWithImpl<GetTransfersQuoteParams>(this as GetTransfersQuoteParams, _$identity);

  /// Serializes this GetTransfersQuoteParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetTransfersQuoteParams&&(identical(other.user, user) || other.user == user)&&(identical(other.originChainId, originChainId) || other.originChainId == originChainId)&&(identical(other.originCurrency, originCurrency) || other.originCurrency == originCurrency)&&(identical(other.destinationChainId, destinationChainId) || other.destinationChainId == destinationChainId)&&(identical(other.destinationCurrency, destinationCurrency) || other.destinationCurrency == destinationCurrency)&&(identical(other.recipient, recipient) || other.recipient == recipient)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,originChainId,originCurrency,destinationChainId,destinationCurrency,recipient,amount);

@override
String toString() {
  return 'GetTransfersQuoteParams(user: $user, originChainId: $originChainId, originCurrency: $originCurrency, destinationChainId: $destinationChainId, destinationCurrency: $destinationCurrency, recipient: $recipient, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $GetTransfersQuoteParamsCopyWith<$Res>  {
  factory $GetTransfersQuoteParamsCopyWith(GetTransfersQuoteParams value, $Res Function(GetTransfersQuoteParams) _then) = _$GetTransfersQuoteParamsCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeIfNull: false) String? user, String originChainId, String originCurrency, String destinationChainId, String destinationCurrency, String recipient, String amount
});




}
/// @nodoc
class _$GetTransfersQuoteParamsCopyWithImpl<$Res>
    implements $GetTransfersQuoteParamsCopyWith<$Res> {
  _$GetTransfersQuoteParamsCopyWithImpl(this._self, this._then);

  final GetTransfersQuoteParams _self;
  final $Res Function(GetTransfersQuoteParams) _then;

/// Create a copy of GetTransfersQuoteParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = freezed,Object? originChainId = null,Object? originCurrency = null,Object? destinationChainId = null,Object? destinationCurrency = null,Object? recipient = null,Object? amount = null,}) {
  return _then(_self.copyWith(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as String?,originChainId: null == originChainId ? _self.originChainId : originChainId // ignore: cast_nullable_to_non_nullable
as String,originCurrency: null == originCurrency ? _self.originCurrency : originCurrency // ignore: cast_nullable_to_non_nullable
as String,destinationChainId: null == destinationChainId ? _self.destinationChainId : destinationChainId // ignore: cast_nullable_to_non_nullable
as String,destinationCurrency: null == destinationCurrency ? _self.destinationCurrency : destinationCurrency // ignore: cast_nullable_to_non_nullable
as String,recipient: null == recipient ? _self.recipient : recipient // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GetTransfersQuoteParams].
extension GetTransfersQuoteParamsPatterns on GetTransfersQuoteParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetTransfersQuoteParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetTransfersQuoteParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetTransfersQuoteParams value)  $default,){
final _that = this;
switch (_that) {
case _GetTransfersQuoteParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetTransfersQuoteParams value)?  $default,){
final _that = this;
switch (_that) {
case _GetTransfersQuoteParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  String? user,  String originChainId,  String originCurrency,  String destinationChainId,  String destinationCurrency,  String recipient,  String amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetTransfersQuoteParams() when $default != null:
return $default(_that.user,_that.originChainId,_that.originCurrency,_that.destinationChainId,_that.destinationCurrency,_that.recipient,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeIfNull: false)  String? user,  String originChainId,  String originCurrency,  String destinationChainId,  String destinationCurrency,  String recipient,  String amount)  $default,) {final _that = this;
switch (_that) {
case _GetTransfersQuoteParams():
return $default(_that.user,_that.originChainId,_that.originCurrency,_that.destinationChainId,_that.destinationCurrency,_that.recipient,_that.amount);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeIfNull: false)  String? user,  String originChainId,  String originCurrency,  String destinationChainId,  String destinationCurrency,  String recipient,  String amount)?  $default,) {final _that = this;
switch (_that) {
case _GetTransfersQuoteParams() when $default != null:
return $default(_that.user,_that.originChainId,_that.originCurrency,_that.destinationChainId,_that.destinationCurrency,_that.recipient,_that.amount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetTransfersQuoteParams implements GetTransfersQuoteParams {
  const _GetTransfersQuoteParams({@JsonKey(includeIfNull: false) this.user, required this.originChainId, required this.originCurrency, required this.destinationChainId, required this.destinationCurrency, required this.recipient, required this.amount});
  factory _GetTransfersQuoteParams.fromJson(Map<String, dynamic> json) => _$GetTransfersQuoteParamsFromJson(json);

@override@JsonKey(includeIfNull: false) final  String? user;
@override final  String originChainId;
@override final  String originCurrency;
@override final  String destinationChainId;
@override final  String destinationCurrency;
@override final  String recipient;
@override final  String amount;

/// Create a copy of GetTransfersQuoteParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetTransfersQuoteParamsCopyWith<_GetTransfersQuoteParams> get copyWith => __$GetTransfersQuoteParamsCopyWithImpl<_GetTransfersQuoteParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetTransfersQuoteParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetTransfersQuoteParams&&(identical(other.user, user) || other.user == user)&&(identical(other.originChainId, originChainId) || other.originChainId == originChainId)&&(identical(other.originCurrency, originCurrency) || other.originCurrency == originCurrency)&&(identical(other.destinationChainId, destinationChainId) || other.destinationChainId == destinationChainId)&&(identical(other.destinationCurrency, destinationCurrency) || other.destinationCurrency == destinationCurrency)&&(identical(other.recipient, recipient) || other.recipient == recipient)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,originChainId,originCurrency,destinationChainId,destinationCurrency,recipient,amount);

@override
String toString() {
  return 'GetTransfersQuoteParams(user: $user, originChainId: $originChainId, originCurrency: $originCurrency, destinationChainId: $destinationChainId, destinationCurrency: $destinationCurrency, recipient: $recipient, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$GetTransfersQuoteParamsCopyWith<$Res> implements $GetTransfersQuoteParamsCopyWith<$Res> {
  factory _$GetTransfersQuoteParamsCopyWith(_GetTransfersQuoteParams value, $Res Function(_GetTransfersQuoteParams) _then) = __$GetTransfersQuoteParamsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeIfNull: false) String? user, String originChainId, String originCurrency, String destinationChainId, String destinationCurrency, String recipient, String amount
});




}
/// @nodoc
class __$GetTransfersQuoteParamsCopyWithImpl<$Res>
    implements _$GetTransfersQuoteParamsCopyWith<$Res> {
  __$GetTransfersQuoteParamsCopyWithImpl(this._self, this._then);

  final _GetTransfersQuoteParams _self;
  final $Res Function(_GetTransfersQuoteParams) _then;

/// Create a copy of GetTransfersQuoteParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = freezed,Object? originChainId = null,Object? originCurrency = null,Object? destinationChainId = null,Object? destinationCurrency = null,Object? recipient = null,Object? amount = null,}) {
  return _then(_GetTransfersQuoteParams(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as String?,originChainId: null == originChainId ? _self.originChainId : originChainId // ignore: cast_nullable_to_non_nullable
as String,originCurrency: null == originCurrency ? _self.originCurrency : originCurrency // ignore: cast_nullable_to_non_nullable
as String,destinationChainId: null == destinationChainId ? _self.destinationChainId : destinationChainId // ignore: cast_nullable_to_non_nullable
as String,destinationCurrency: null == destinationCurrency ? _self.destinationCurrency : destinationCurrency // ignore: cast_nullable_to_non_nullable
as String,recipient: null == recipient ? _self.recipient : recipient // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$GetQuoteStatusParams {

 String get requestId;
/// Create a copy of GetQuoteStatusParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetQuoteStatusParamsCopyWith<GetQuoteStatusParams> get copyWith => _$GetQuoteStatusParamsCopyWithImpl<GetQuoteStatusParams>(this as GetQuoteStatusParams, _$identity);

  /// Serializes this GetQuoteStatusParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetQuoteStatusParams&&(identical(other.requestId, requestId) || other.requestId == requestId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,requestId);

@override
String toString() {
  return 'GetQuoteStatusParams(requestId: $requestId)';
}


}

/// @nodoc
abstract mixin class $GetQuoteStatusParamsCopyWith<$Res>  {
  factory $GetQuoteStatusParamsCopyWith(GetQuoteStatusParams value, $Res Function(GetQuoteStatusParams) _then) = _$GetQuoteStatusParamsCopyWithImpl;
@useResult
$Res call({
 String requestId
});




}
/// @nodoc
class _$GetQuoteStatusParamsCopyWithImpl<$Res>
    implements $GetQuoteStatusParamsCopyWith<$Res> {
  _$GetQuoteStatusParamsCopyWithImpl(this._self, this._then);

  final GetQuoteStatusParams _self;
  final $Res Function(GetQuoteStatusParams) _then;

/// Create a copy of GetQuoteStatusParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? requestId = null,}) {
  return _then(_self.copyWith(
requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GetQuoteStatusParams].
extension GetQuoteStatusParamsPatterns on GetQuoteStatusParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetQuoteStatusParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetQuoteStatusParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetQuoteStatusParams value)  $default,){
final _that = this;
switch (_that) {
case _GetQuoteStatusParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetQuoteStatusParams value)?  $default,){
final _that = this;
switch (_that) {
case _GetQuoteStatusParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String requestId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetQuoteStatusParams() when $default != null:
return $default(_that.requestId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String requestId)  $default,) {final _that = this;
switch (_that) {
case _GetQuoteStatusParams():
return $default(_that.requestId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String requestId)?  $default,) {final _that = this;
switch (_that) {
case _GetQuoteStatusParams() when $default != null:
return $default(_that.requestId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetQuoteStatusParams implements GetQuoteStatusParams {
  const _GetQuoteStatusParams({required this.requestId});
  factory _GetQuoteStatusParams.fromJson(Map<String, dynamic> json) => _$GetQuoteStatusParamsFromJson(json);

@override final  String requestId;

/// Create a copy of GetQuoteStatusParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetQuoteStatusParamsCopyWith<_GetQuoteStatusParams> get copyWith => __$GetQuoteStatusParamsCopyWithImpl<_GetQuoteStatusParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetQuoteStatusParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetQuoteStatusParams&&(identical(other.requestId, requestId) || other.requestId == requestId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,requestId);

@override
String toString() {
  return 'GetQuoteStatusParams(requestId: $requestId)';
}


}

/// @nodoc
abstract mixin class _$GetQuoteStatusParamsCopyWith<$Res> implements $GetQuoteStatusParamsCopyWith<$Res> {
  factory _$GetQuoteStatusParamsCopyWith(_GetQuoteStatusParams value, $Res Function(_GetQuoteStatusParams) _then) = __$GetQuoteStatusParamsCopyWithImpl;
@override @useResult
$Res call({
 String requestId
});




}
/// @nodoc
class __$GetQuoteStatusParamsCopyWithImpl<$Res>
    implements _$GetQuoteStatusParamsCopyWith<$Res> {
  __$GetQuoteStatusParamsCopyWithImpl(this._self, this._then);

  final _GetQuoteStatusParams _self;
  final $Res Function(_GetQuoteStatusParams) _then;

/// Create a copy of GetQuoteStatusParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? requestId = null,}) {
  return _then(_GetQuoteStatusParams(
requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
