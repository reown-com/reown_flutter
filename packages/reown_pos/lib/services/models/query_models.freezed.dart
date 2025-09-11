// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'query_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QueryParams {

 String get projectId; String get deviceId; String get st; String get sv;
/// Create a copy of QueryParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QueryParamsCopyWith<QueryParams> get copyWith => _$QueryParamsCopyWithImpl<QueryParams>(this as QueryParams, _$identity);

  /// Serializes this QueryParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueryParams&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.st, st) || other.st == st)&&(identical(other.sv, sv) || other.sv == sv));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,projectId,deviceId,st,sv);

@override
String toString() {
  return 'QueryParams(projectId: $projectId, deviceId: $deviceId, st: $st, sv: $sv)';
}


}

/// @nodoc
abstract mixin class $QueryParamsCopyWith<$Res>  {
  factory $QueryParamsCopyWith(QueryParams value, $Res Function(QueryParams) _then) = _$QueryParamsCopyWithImpl;
@useResult
$Res call({
 String projectId, String deviceId, String st, String sv
});




}
/// @nodoc
class _$QueryParamsCopyWithImpl<$Res>
    implements $QueryParamsCopyWith<$Res> {
  _$QueryParamsCopyWithImpl(this._self, this._then);

  final QueryParams _self;
  final $Res Function(QueryParams) _then;

/// Create a copy of QueryParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? projectId = null,Object? deviceId = null,Object? st = null,Object? sv = null,}) {
  return _then(_self.copyWith(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,st: null == st ? _self.st : st // ignore: cast_nullable_to_non_nullable
as String,sv: null == sv ? _self.sv : sv // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [QueryParams].
extension QueryParamsPatterns on QueryParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QueryParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QueryParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QueryParams value)  $default,){
final _that = this;
switch (_that) {
case _QueryParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QueryParams value)?  $default,){
final _that = this;
switch (_that) {
case _QueryParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String projectId,  String deviceId,  String st,  String sv)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QueryParams() when $default != null:
return $default(_that.projectId,_that.deviceId,_that.st,_that.sv);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String projectId,  String deviceId,  String st,  String sv)  $default,) {final _that = this;
switch (_that) {
case _QueryParams():
return $default(_that.projectId,_that.deviceId,_that.st,_that.sv);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String projectId,  String deviceId,  String st,  String sv)?  $default,) {final _that = this;
switch (_that) {
case _QueryParams() when $default != null:
return $default(_that.projectId,_that.deviceId,_that.st,_that.sv);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QueryParams implements QueryParams {
  const _QueryParams({required this.projectId, required this.deviceId, required this.st, required this.sv});
  factory _QueryParams.fromJson(Map<String, dynamic> json) => _$QueryParamsFromJson(json);

@override final  String projectId;
@override final  String deviceId;
@override final  String st;
@override final  String sv;

/// Create a copy of QueryParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QueryParamsCopyWith<_QueryParams> get copyWith => __$QueryParamsCopyWithImpl<_QueryParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QueryParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QueryParams&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.st, st) || other.st == st)&&(identical(other.sv, sv) || other.sv == sv));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,projectId,deviceId,st,sv);

@override
String toString() {
  return 'QueryParams(projectId: $projectId, deviceId: $deviceId, st: $st, sv: $sv)';
}


}

/// @nodoc
abstract mixin class _$QueryParamsCopyWith<$Res> implements $QueryParamsCopyWith<$Res> {
  factory _$QueryParamsCopyWith(_QueryParams value, $Res Function(_QueryParams) _then) = __$QueryParamsCopyWithImpl;
@override @useResult
$Res call({
 String projectId, String deviceId, String st, String sv
});




}
/// @nodoc
class __$QueryParamsCopyWithImpl<$Res>
    implements _$QueryParamsCopyWith<$Res> {
  __$QueryParamsCopyWithImpl(this._self, this._then);

  final _QueryParams _self;
  final $Res Function(_QueryParams) _then;

/// Create a copy of QueryParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? projectId = null,Object? deviceId = null,Object? st = null,Object? sv = null,}) {
  return _then(_QueryParams(
projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,st: null == st ? _self.st : st // ignore: cast_nullable_to_non_nullable
as String,sv: null == sv ? _self.sv : sv // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PaymentIntentParams {

 String get asset; String get amount; String get sender; String get recipient;
/// Create a copy of PaymentIntentParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentIntentParamsCopyWith<PaymentIntentParams> get copyWith => _$PaymentIntentParamsCopyWithImpl<PaymentIntentParams>(this as PaymentIntentParams, _$identity);

  /// Serializes this PaymentIntentParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentIntentParams&&(identical(other.asset, asset) || other.asset == asset)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.sender, sender) || other.sender == sender)&&(identical(other.recipient, recipient) || other.recipient == recipient));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,asset,amount,sender,recipient);

@override
String toString() {
  return 'PaymentIntentParams(asset: $asset, amount: $amount, sender: $sender, recipient: $recipient)';
}


}

/// @nodoc
abstract mixin class $PaymentIntentParamsCopyWith<$Res>  {
  factory $PaymentIntentParamsCopyWith(PaymentIntentParams value, $Res Function(PaymentIntentParams) _then) = _$PaymentIntentParamsCopyWithImpl;
@useResult
$Res call({
 String asset, String amount, String sender, String recipient
});




}
/// @nodoc
class _$PaymentIntentParamsCopyWithImpl<$Res>
    implements $PaymentIntentParamsCopyWith<$Res> {
  _$PaymentIntentParamsCopyWithImpl(this._self, this._then);

  final PaymentIntentParams _self;
  final $Res Function(PaymentIntentParams) _then;

/// Create a copy of PaymentIntentParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? asset = null,Object? amount = null,Object? sender = null,Object? recipient = null,}) {
  return _then(_self.copyWith(
asset: null == asset ? _self.asset : asset // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,sender: null == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as String,recipient: null == recipient ? _self.recipient : recipient // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentIntentParams].
extension PaymentIntentParamsPatterns on PaymentIntentParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentIntentParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentIntentParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentIntentParams value)  $default,){
final _that = this;
switch (_that) {
case _PaymentIntentParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentIntentParams value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentIntentParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String asset,  String amount,  String sender,  String recipient)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentIntentParams() when $default != null:
return $default(_that.asset,_that.amount,_that.sender,_that.recipient);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String asset,  String amount,  String sender,  String recipient)  $default,) {final _that = this;
switch (_that) {
case _PaymentIntentParams():
return $default(_that.asset,_that.amount,_that.sender,_that.recipient);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String asset,  String amount,  String sender,  String recipient)?  $default,) {final _that = this;
switch (_that) {
case _PaymentIntentParams() when $default != null:
return $default(_that.asset,_that.amount,_that.sender,_that.recipient);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentIntentParams implements PaymentIntentParams {
  const _PaymentIntentParams({required this.asset, required this.amount, required this.sender, required this.recipient});
  factory _PaymentIntentParams.fromJson(Map<String, dynamic> json) => _$PaymentIntentParamsFromJson(json);

@override final  String asset;
@override final  String amount;
@override final  String sender;
@override final  String recipient;

/// Create a copy of PaymentIntentParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentIntentParamsCopyWith<_PaymentIntentParams> get copyWith => __$PaymentIntentParamsCopyWithImpl<_PaymentIntentParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentIntentParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentIntentParams&&(identical(other.asset, asset) || other.asset == asset)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.sender, sender) || other.sender == sender)&&(identical(other.recipient, recipient) || other.recipient == recipient));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,asset,amount,sender,recipient);

@override
String toString() {
  return 'PaymentIntentParams(asset: $asset, amount: $amount, sender: $sender, recipient: $recipient)';
}


}

/// @nodoc
abstract mixin class _$PaymentIntentParamsCopyWith<$Res> implements $PaymentIntentParamsCopyWith<$Res> {
  factory _$PaymentIntentParamsCopyWith(_PaymentIntentParams value, $Res Function(_PaymentIntentParams) _then) = __$PaymentIntentParamsCopyWithImpl;
@override @useResult
$Res call({
 String asset, String amount, String sender, String recipient
});




}
/// @nodoc
class __$PaymentIntentParamsCopyWithImpl<$Res>
    implements _$PaymentIntentParamsCopyWith<$Res> {
  __$PaymentIntentParamsCopyWithImpl(this._self, this._then);

  final _PaymentIntentParams _self;
  final $Res Function(_PaymentIntentParams) _then;

/// Create a copy of PaymentIntentParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? asset = null,Object? amount = null,Object? sender = null,Object? recipient = null,}) {
  return _then(_PaymentIntentParams(
asset: null == asset ? _self.asset : asset // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as String,sender: null == sender ? _self.sender : sender // ignore: cast_nullable_to_non_nullable
as String,recipient: null == recipient ? _self.recipient : recipient // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$BuildTransactionParams {

 List<PaymentIntentParams> get paymentIntents; dynamic get capabilities;
/// Create a copy of BuildTransactionParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BuildTransactionParamsCopyWith<BuildTransactionParams> get copyWith => _$BuildTransactionParamsCopyWithImpl<BuildTransactionParams>(this as BuildTransactionParams, _$identity);

  /// Serializes this BuildTransactionParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BuildTransactionParams&&const DeepCollectionEquality().equals(other.paymentIntents, paymentIntents)&&const DeepCollectionEquality().equals(other.capabilities, capabilities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(paymentIntents),const DeepCollectionEquality().hash(capabilities));

@override
String toString() {
  return 'BuildTransactionParams(paymentIntents: $paymentIntents, capabilities: $capabilities)';
}


}

/// @nodoc
abstract mixin class $BuildTransactionParamsCopyWith<$Res>  {
  factory $BuildTransactionParamsCopyWith(BuildTransactionParams value, $Res Function(BuildTransactionParams) _then) = _$BuildTransactionParamsCopyWithImpl;
@useResult
$Res call({
 List<PaymentIntentParams> paymentIntents, dynamic capabilities
});




}
/// @nodoc
class _$BuildTransactionParamsCopyWithImpl<$Res>
    implements $BuildTransactionParamsCopyWith<$Res> {
  _$BuildTransactionParamsCopyWithImpl(this._self, this._then);

  final BuildTransactionParams _self;
  final $Res Function(BuildTransactionParams) _then;

/// Create a copy of BuildTransactionParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? paymentIntents = null,Object? capabilities = freezed,}) {
  return _then(_self.copyWith(
paymentIntents: null == paymentIntents ? _self.paymentIntents : paymentIntents // ignore: cast_nullable_to_non_nullable
as List<PaymentIntentParams>,capabilities: freezed == capabilities ? _self.capabilities : capabilities // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// Adds pattern-matching-related methods to [BuildTransactionParams].
extension BuildTransactionParamsPatterns on BuildTransactionParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BuildTransactionParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BuildTransactionParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BuildTransactionParams value)  $default,){
final _that = this;
switch (_that) {
case _BuildTransactionParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BuildTransactionParams value)?  $default,){
final _that = this;
switch (_that) {
case _BuildTransactionParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PaymentIntentParams> paymentIntents,  dynamic capabilities)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BuildTransactionParams() when $default != null:
return $default(_that.paymentIntents,_that.capabilities);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PaymentIntentParams> paymentIntents,  dynamic capabilities)  $default,) {final _that = this;
switch (_that) {
case _BuildTransactionParams():
return $default(_that.paymentIntents,_that.capabilities);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PaymentIntentParams> paymentIntents,  dynamic capabilities)?  $default,) {final _that = this;
switch (_that) {
case _BuildTransactionParams() when $default != null:
return $default(_that.paymentIntents,_that.capabilities);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BuildTransactionParams implements BuildTransactionParams {
  const _BuildTransactionParams({required final  List<PaymentIntentParams> paymentIntents, this.capabilities}): _paymentIntents = paymentIntents;
  factory _BuildTransactionParams.fromJson(Map<String, dynamic> json) => _$BuildTransactionParamsFromJson(json);

 final  List<PaymentIntentParams> _paymentIntents;
@override List<PaymentIntentParams> get paymentIntents {
  if (_paymentIntents is EqualUnmodifiableListView) return _paymentIntents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_paymentIntents);
}

@override final  dynamic capabilities;

/// Create a copy of BuildTransactionParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BuildTransactionParamsCopyWith<_BuildTransactionParams> get copyWith => __$BuildTransactionParamsCopyWithImpl<_BuildTransactionParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BuildTransactionParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BuildTransactionParams&&const DeepCollectionEquality().equals(other._paymentIntents, _paymentIntents)&&const DeepCollectionEquality().equals(other.capabilities, capabilities));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_paymentIntents),const DeepCollectionEquality().hash(capabilities));

@override
String toString() {
  return 'BuildTransactionParams(paymentIntents: $paymentIntents, capabilities: $capabilities)';
}


}

/// @nodoc
abstract mixin class _$BuildTransactionParamsCopyWith<$Res> implements $BuildTransactionParamsCopyWith<$Res> {
  factory _$BuildTransactionParamsCopyWith(_BuildTransactionParams value, $Res Function(_BuildTransactionParams) _then) = __$BuildTransactionParamsCopyWithImpl;
@override @useResult
$Res call({
 List<PaymentIntentParams> paymentIntents, dynamic capabilities
});




}
/// @nodoc
class __$BuildTransactionParamsCopyWithImpl<$Res>
    implements _$BuildTransactionParamsCopyWith<$Res> {
  __$BuildTransactionParamsCopyWithImpl(this._self, this._then);

  final _BuildTransactionParams _self;
  final $Res Function(_BuildTransactionParams) _then;

/// Create a copy of BuildTransactionParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? paymentIntents = null,Object? capabilities = freezed,}) {
  return _then(_BuildTransactionParams(
paymentIntents: null == paymentIntents ? _self._paymentIntents : paymentIntents // ignore: cast_nullable_to_non_nullable
as List<PaymentIntentParams>,capabilities: freezed == capabilities ? _self.capabilities : capabilities // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}


/// @nodoc
mixin _$CheckTransactionParams {

 String get id; String get sendResult;
/// Create a copy of CheckTransactionParams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckTransactionParamsCopyWith<CheckTransactionParams> get copyWith => _$CheckTransactionParamsCopyWithImpl<CheckTransactionParams>(this as CheckTransactionParams, _$identity);

  /// Serializes this CheckTransactionParams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckTransactionParams&&(identical(other.id, id) || other.id == id)&&(identical(other.sendResult, sendResult) || other.sendResult == sendResult));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,sendResult);

@override
String toString() {
  return 'CheckTransactionParams(id: $id, sendResult: $sendResult)';
}


}

/// @nodoc
abstract mixin class $CheckTransactionParamsCopyWith<$Res>  {
  factory $CheckTransactionParamsCopyWith(CheckTransactionParams value, $Res Function(CheckTransactionParams) _then) = _$CheckTransactionParamsCopyWithImpl;
@useResult
$Res call({
 String id, String sendResult
});




}
/// @nodoc
class _$CheckTransactionParamsCopyWithImpl<$Res>
    implements $CheckTransactionParamsCopyWith<$Res> {
  _$CheckTransactionParamsCopyWithImpl(this._self, this._then);

  final CheckTransactionParams _self;
  final $Res Function(CheckTransactionParams) _then;

/// Create a copy of CheckTransactionParams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? sendResult = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sendResult: null == sendResult ? _self.sendResult : sendResult // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckTransactionParams].
extension CheckTransactionParamsPatterns on CheckTransactionParams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckTransactionParams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckTransactionParams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckTransactionParams value)  $default,){
final _that = this;
switch (_that) {
case _CheckTransactionParams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckTransactionParams value)?  $default,){
final _that = this;
switch (_that) {
case _CheckTransactionParams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String sendResult)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckTransactionParams() when $default != null:
return $default(_that.id,_that.sendResult);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String sendResult)  $default,) {final _that = this;
switch (_that) {
case _CheckTransactionParams():
return $default(_that.id,_that.sendResult);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String sendResult)?  $default,) {final _that = this;
switch (_that) {
case _CheckTransactionParams() when $default != null:
return $default(_that.id,_that.sendResult);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CheckTransactionParams implements CheckTransactionParams {
  const _CheckTransactionParams({required this.id, required this.sendResult});
  factory _CheckTransactionParams.fromJson(Map<String, dynamic> json) => _$CheckTransactionParamsFromJson(json);

@override final  String id;
@override final  String sendResult;

/// Create a copy of CheckTransactionParams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckTransactionParamsCopyWith<_CheckTransactionParams> get copyWith => __$CheckTransactionParamsCopyWithImpl<_CheckTransactionParams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CheckTransactionParamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckTransactionParams&&(identical(other.id, id) || other.id == id)&&(identical(other.sendResult, sendResult) || other.sendResult == sendResult));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,sendResult);

@override
String toString() {
  return 'CheckTransactionParams(id: $id, sendResult: $sendResult)';
}


}

/// @nodoc
abstract mixin class _$CheckTransactionParamsCopyWith<$Res> implements $CheckTransactionParamsCopyWith<$Res> {
  factory _$CheckTransactionParamsCopyWith(_CheckTransactionParams value, $Res Function(_CheckTransactionParams) _then) = __$CheckTransactionParamsCopyWithImpl;
@override @useResult
$Res call({
 String id, String sendResult
});




}
/// @nodoc
class __$CheckTransactionParamsCopyWithImpl<$Res>
    implements _$CheckTransactionParamsCopyWith<$Res> {
  __$CheckTransactionParamsCopyWithImpl(this._self, this._then);

  final _CheckTransactionParams _self;
  final $Res Function(_CheckTransactionParams) _then;

/// Create a copy of CheckTransactionParams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sendResult = null,}) {
  return _then(_CheckTransactionParams(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,sendResult: null == sendResult ? _self.sendResult : sendResult // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
