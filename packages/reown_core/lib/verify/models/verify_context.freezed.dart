// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verify_context.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VerifyContext {

 String get origin; Validation get validation; String get verifyUrl; bool? get isScam;
/// Create a copy of VerifyContext
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VerifyContextCopyWith<VerifyContext> get copyWith => _$VerifyContextCopyWithImpl<VerifyContext>(this as VerifyContext, _$identity);

  /// Serializes this VerifyContext to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VerifyContext&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.validation, validation) || other.validation == validation)&&(identical(other.verifyUrl, verifyUrl) || other.verifyUrl == verifyUrl)&&(identical(other.isScam, isScam) || other.isScam == isScam));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,origin,validation,verifyUrl,isScam);

@override
String toString() {
  return 'VerifyContext(origin: $origin, validation: $validation, verifyUrl: $verifyUrl, isScam: $isScam)';
}


}

/// @nodoc
abstract mixin class $VerifyContextCopyWith<$Res>  {
  factory $VerifyContextCopyWith(VerifyContext value, $Res Function(VerifyContext) _then) = _$VerifyContextCopyWithImpl;
@useResult
$Res call({
 String origin, Validation validation, String verifyUrl, bool? isScam
});




}
/// @nodoc
class _$VerifyContextCopyWithImpl<$Res>
    implements $VerifyContextCopyWith<$Res> {
  _$VerifyContextCopyWithImpl(this._self, this._then);

  final VerifyContext _self;
  final $Res Function(VerifyContext) _then;

/// Create a copy of VerifyContext
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? origin = null,Object? validation = null,Object? verifyUrl = null,Object? isScam = freezed,}) {
  return _then(_self.copyWith(
origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as String,validation: null == validation ? _self.validation : validation // ignore: cast_nullable_to_non_nullable
as Validation,verifyUrl: null == verifyUrl ? _self.verifyUrl : verifyUrl // ignore: cast_nullable_to_non_nullable
as String,isScam: freezed == isScam ? _self.isScam : isScam // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [VerifyContext].
extension VerifyContextPatterns on VerifyContext {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VerifyContext value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VerifyContext() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VerifyContext value)  $default,){
final _that = this;
switch (_that) {
case _VerifyContext():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VerifyContext value)?  $default,){
final _that = this;
switch (_that) {
case _VerifyContext() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String origin,  Validation validation,  String verifyUrl,  bool? isScam)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VerifyContext() when $default != null:
return $default(_that.origin,_that.validation,_that.verifyUrl,_that.isScam);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String origin,  Validation validation,  String verifyUrl,  bool? isScam)  $default,) {final _that = this;
switch (_that) {
case _VerifyContext():
return $default(_that.origin,_that.validation,_that.verifyUrl,_that.isScam);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String origin,  Validation validation,  String verifyUrl,  bool? isScam)?  $default,) {final _that = this;
switch (_that) {
case _VerifyContext() when $default != null:
return $default(_that.origin,_that.validation,_that.verifyUrl,_that.isScam);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class _VerifyContext implements VerifyContext {
  const _VerifyContext({required this.origin, required this.validation, required this.verifyUrl, this.isScam});
  factory _VerifyContext.fromJson(Map<String, dynamic> json) => _$VerifyContextFromJson(json);

@override final  String origin;
@override final  Validation validation;
@override final  String verifyUrl;
@override final  bool? isScam;

/// Create a copy of VerifyContext
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VerifyContextCopyWith<_VerifyContext> get copyWith => __$VerifyContextCopyWithImpl<_VerifyContext>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VerifyContextToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyContext&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.validation, validation) || other.validation == validation)&&(identical(other.verifyUrl, verifyUrl) || other.verifyUrl == verifyUrl)&&(identical(other.isScam, isScam) || other.isScam == isScam));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,origin,validation,verifyUrl,isScam);

@override
String toString() {
  return 'VerifyContext(origin: $origin, validation: $validation, verifyUrl: $verifyUrl, isScam: $isScam)';
}


}

/// @nodoc
abstract mixin class _$VerifyContextCopyWith<$Res> implements $VerifyContextCopyWith<$Res> {
  factory _$VerifyContextCopyWith(_VerifyContext value, $Res Function(_VerifyContext) _then) = __$VerifyContextCopyWithImpl;
@override @useResult
$Res call({
 String origin, Validation validation, String verifyUrl, bool? isScam
});




}
/// @nodoc
class __$VerifyContextCopyWithImpl<$Res>
    implements _$VerifyContextCopyWith<$Res> {
  __$VerifyContextCopyWithImpl(this._self, this._then);

  final _VerifyContext _self;
  final $Res Function(_VerifyContext) _then;

/// Create a copy of VerifyContext
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? origin = null,Object? validation = null,Object? verifyUrl = null,Object? isScam = freezed,}) {
  return _then(_VerifyContext(
origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as String,validation: null == validation ? _self.validation : validation // ignore: cast_nullable_to_non_nullable
as Validation,verifyUrl: null == verifyUrl ? _self.verifyUrl : verifyUrl // ignore: cast_nullable_to_non_nullable
as String,isScam: freezed == isScam ? _self.isScam : isScam // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$AttestationResponse {

 String get origin; String get attestationId; bool? get isScam;
/// Create a copy of AttestationResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttestationResponseCopyWith<AttestationResponse> get copyWith => _$AttestationResponseCopyWithImpl<AttestationResponse>(this as AttestationResponse, _$identity);

  /// Serializes this AttestationResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttestationResponse&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.attestationId, attestationId) || other.attestationId == attestationId)&&(identical(other.isScam, isScam) || other.isScam == isScam));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,origin,attestationId,isScam);

@override
String toString() {
  return 'AttestationResponse(origin: $origin, attestationId: $attestationId, isScam: $isScam)';
}


}

/// @nodoc
abstract mixin class $AttestationResponseCopyWith<$Res>  {
  factory $AttestationResponseCopyWith(AttestationResponse value, $Res Function(AttestationResponse) _then) = _$AttestationResponseCopyWithImpl;
@useResult
$Res call({
 String origin, String attestationId, bool? isScam
});




}
/// @nodoc
class _$AttestationResponseCopyWithImpl<$Res>
    implements $AttestationResponseCopyWith<$Res> {
  _$AttestationResponseCopyWithImpl(this._self, this._then);

  final AttestationResponse _self;
  final $Res Function(AttestationResponse) _then;

/// Create a copy of AttestationResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? origin = null,Object? attestationId = null,Object? isScam = freezed,}) {
  return _then(_self.copyWith(
origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as String,attestationId: null == attestationId ? _self.attestationId : attestationId // ignore: cast_nullable_to_non_nullable
as String,isScam: freezed == isScam ? _self.isScam : isScam // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [AttestationResponse].
extension AttestationResponsePatterns on AttestationResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttestationResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttestationResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttestationResponse value)  $default,){
final _that = this;
switch (_that) {
case _AttestationResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttestationResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AttestationResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String origin,  String attestationId,  bool? isScam)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttestationResponse() when $default != null:
return $default(_that.origin,_that.attestationId,_that.isScam);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String origin,  String attestationId,  bool? isScam)  $default,) {final _that = this;
switch (_that) {
case _AttestationResponse():
return $default(_that.origin,_that.attestationId,_that.isScam);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String origin,  String attestationId,  bool? isScam)?  $default,) {final _that = this;
switch (_that) {
case _AttestationResponse() when $default != null:
return $default(_that.origin,_that.attestationId,_that.isScam);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class _AttestationResponse implements AttestationResponse {
  const _AttestationResponse({required this.origin, required this.attestationId, this.isScam});
  factory _AttestationResponse.fromJson(Map<String, dynamic> json) => _$AttestationResponseFromJson(json);

@override final  String origin;
@override final  String attestationId;
@override final  bool? isScam;

/// Create a copy of AttestationResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttestationResponseCopyWith<_AttestationResponse> get copyWith => __$AttestationResponseCopyWithImpl<_AttestationResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AttestationResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttestationResponse&&(identical(other.origin, origin) || other.origin == origin)&&(identical(other.attestationId, attestationId) || other.attestationId == attestationId)&&(identical(other.isScam, isScam) || other.isScam == isScam));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,origin,attestationId,isScam);

@override
String toString() {
  return 'AttestationResponse(origin: $origin, attestationId: $attestationId, isScam: $isScam)';
}


}

/// @nodoc
abstract mixin class _$AttestationResponseCopyWith<$Res> implements $AttestationResponseCopyWith<$Res> {
  factory _$AttestationResponseCopyWith(_AttestationResponse value, $Res Function(_AttestationResponse) _then) = __$AttestationResponseCopyWithImpl;
@override @useResult
$Res call({
 String origin, String attestationId, bool? isScam
});




}
/// @nodoc
class __$AttestationResponseCopyWithImpl<$Res>
    implements _$AttestationResponseCopyWith<$Res> {
  __$AttestationResponseCopyWithImpl(this._self, this._then);

  final _AttestationResponse _self;
  final $Res Function(_AttestationResponse) _then;

/// Create a copy of AttestationResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? origin = null,Object? attestationId = null,Object? isScam = freezed,}) {
  return _then(_AttestationResponse(
origin: null == origin ? _self.origin : origin // ignore: cast_nullable_to_non_nullable
as String,attestationId: null == attestationId ? _self.attestationId : attestationId // ignore: cast_nullable_to_non_nullable
as String,isScam: freezed == isScam ? _self.isScam : isScam // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
