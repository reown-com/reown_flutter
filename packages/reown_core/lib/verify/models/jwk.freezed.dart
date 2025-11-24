// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'jwk.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JWK {

 PublicKey get publicKey; int get expiresAt;
/// Create a copy of JWK
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JWKCopyWith<JWK> get copyWith => _$JWKCopyWithImpl<JWK>(this as JWK, _$identity);

  /// Serializes this JWK to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JWK&&(identical(other.publicKey, publicKey) || other.publicKey == publicKey)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,publicKey,expiresAt);

@override
String toString() {
  return 'JWK(publicKey: $publicKey, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $JWKCopyWith<$Res>  {
  factory $JWKCopyWith(JWK value, $Res Function(JWK) _then) = _$JWKCopyWithImpl;
@useResult
$Res call({
 PublicKey publicKey, int expiresAt
});


$PublicKeyCopyWith<$Res> get publicKey;

}
/// @nodoc
class _$JWKCopyWithImpl<$Res>
    implements $JWKCopyWith<$Res> {
  _$JWKCopyWithImpl(this._self, this._then);

  final JWK _self;
  final $Res Function(JWK) _then;

/// Create a copy of JWK
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? publicKey = null,Object? expiresAt = null,}) {
  return _then(_self.copyWith(
publicKey: null == publicKey ? _self.publicKey : publicKey // ignore: cast_nullable_to_non_nullable
as PublicKey,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of JWK
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PublicKeyCopyWith<$Res> get publicKey {
  
  return $PublicKeyCopyWith<$Res>(_self.publicKey, (value) {
    return _then(_self.copyWith(publicKey: value));
  });
}
}


/// Adds pattern-matching-related methods to [JWK].
extension JWKPatterns on JWK {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JWK value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JWK() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JWK value)  $default,){
final _that = this;
switch (_that) {
case _JWK():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JWK value)?  $default,){
final _that = this;
switch (_that) {
case _JWK() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PublicKey publicKey,  int expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JWK() when $default != null:
return $default(_that.publicKey,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PublicKey publicKey,  int expiresAt)  $default,) {final _that = this;
switch (_that) {
case _JWK():
return $default(_that.publicKey,_that.expiresAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PublicKey publicKey,  int expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _JWK() when $default != null:
return $default(_that.publicKey,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JWK implements JWK {
  const _JWK({required this.publicKey, required this.expiresAt});
  factory _JWK.fromJson(Map<String, dynamic> json) => _$JWKFromJson(json);

@override final  PublicKey publicKey;
@override final  int expiresAt;

/// Create a copy of JWK
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JWKCopyWith<_JWK> get copyWith => __$JWKCopyWithImpl<_JWK>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JWKToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JWK&&(identical(other.publicKey, publicKey) || other.publicKey == publicKey)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,publicKey,expiresAt);

@override
String toString() {
  return 'JWK(publicKey: $publicKey, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$JWKCopyWith<$Res> implements $JWKCopyWith<$Res> {
  factory _$JWKCopyWith(_JWK value, $Res Function(_JWK) _then) = __$JWKCopyWithImpl;
@override @useResult
$Res call({
 PublicKey publicKey, int expiresAt
});


@override $PublicKeyCopyWith<$Res> get publicKey;

}
/// @nodoc
class __$JWKCopyWithImpl<$Res>
    implements _$JWKCopyWith<$Res> {
  __$JWKCopyWithImpl(this._self, this._then);

  final _JWK _self;
  final $Res Function(_JWK) _then;

/// Create a copy of JWK
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? publicKey = null,Object? expiresAt = null,}) {
  return _then(_JWK(
publicKey: null == publicKey ? _self.publicKey : publicKey // ignore: cast_nullable_to_non_nullable
as PublicKey,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of JWK
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PublicKeyCopyWith<$Res> get publicKey {
  
  return $PublicKeyCopyWith<$Res>(_self.publicKey, (value) {
    return _then(_self.copyWith(publicKey: value));
  });
}
}


/// @nodoc
mixin _$PublicKey {

@JsonKey(name: 'crv') String get crv;@JsonKey(name: 'ext') bool get ext;@JsonKey(name: 'key_ops') List<String> get keyOps;@JsonKey(name: 'kty') String get kty;@JsonKey(name: 'x') String get x;@JsonKey(name: 'y') String get y;
/// Create a copy of PublicKey
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PublicKeyCopyWith<PublicKey> get copyWith => _$PublicKeyCopyWithImpl<PublicKey>(this as PublicKey, _$identity);

  /// Serializes this PublicKey to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PublicKey&&(identical(other.crv, crv) || other.crv == crv)&&(identical(other.ext, ext) || other.ext == ext)&&const DeepCollectionEquality().equals(other.keyOps, keyOps)&&(identical(other.kty, kty) || other.kty == kty)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,crv,ext,const DeepCollectionEquality().hash(keyOps),kty,x,y);

@override
String toString() {
  return 'PublicKey(crv: $crv, ext: $ext, keyOps: $keyOps, kty: $kty, x: $x, y: $y)';
}


}

/// @nodoc
abstract mixin class $PublicKeyCopyWith<$Res>  {
  factory $PublicKeyCopyWith(PublicKey value, $Res Function(PublicKey) _then) = _$PublicKeyCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'crv') String crv,@JsonKey(name: 'ext') bool ext,@JsonKey(name: 'key_ops') List<String> keyOps,@JsonKey(name: 'kty') String kty,@JsonKey(name: 'x') String x,@JsonKey(name: 'y') String y
});




}
/// @nodoc
class _$PublicKeyCopyWithImpl<$Res>
    implements $PublicKeyCopyWith<$Res> {
  _$PublicKeyCopyWithImpl(this._self, this._then);

  final PublicKey _self;
  final $Res Function(PublicKey) _then;

/// Create a copy of PublicKey
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? crv = null,Object? ext = null,Object? keyOps = null,Object? kty = null,Object? x = null,Object? y = null,}) {
  return _then(_self.copyWith(
crv: null == crv ? _self.crv : crv // ignore: cast_nullable_to_non_nullable
as String,ext: null == ext ? _self.ext : ext // ignore: cast_nullable_to_non_nullable
as bool,keyOps: null == keyOps ? _self.keyOps : keyOps // ignore: cast_nullable_to_non_nullable
as List<String>,kty: null == kty ? _self.kty : kty // ignore: cast_nullable_to_non_nullable
as String,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as String,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PublicKey].
extension PublicKeyPatterns on PublicKey {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PublicKey value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PublicKey() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PublicKey value)  $default,){
final _that = this;
switch (_that) {
case _PublicKey():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PublicKey value)?  $default,){
final _that = this;
switch (_that) {
case _PublicKey() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'crv')  String crv, @JsonKey(name: 'ext')  bool ext, @JsonKey(name: 'key_ops')  List<String> keyOps, @JsonKey(name: 'kty')  String kty, @JsonKey(name: 'x')  String x, @JsonKey(name: 'y')  String y)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PublicKey() when $default != null:
return $default(_that.crv,_that.ext,_that.keyOps,_that.kty,_that.x,_that.y);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'crv')  String crv, @JsonKey(name: 'ext')  bool ext, @JsonKey(name: 'key_ops')  List<String> keyOps, @JsonKey(name: 'kty')  String kty, @JsonKey(name: 'x')  String x, @JsonKey(name: 'y')  String y)  $default,) {final _that = this;
switch (_that) {
case _PublicKey():
return $default(_that.crv,_that.ext,_that.keyOps,_that.kty,_that.x,_that.y);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'crv')  String crv, @JsonKey(name: 'ext')  bool ext, @JsonKey(name: 'key_ops')  List<String> keyOps, @JsonKey(name: 'kty')  String kty, @JsonKey(name: 'x')  String x, @JsonKey(name: 'y')  String y)?  $default,) {final _that = this;
switch (_that) {
case _PublicKey() when $default != null:
return $default(_that.crv,_that.ext,_that.keyOps,_that.kty,_that.x,_that.y);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PublicKey implements PublicKey {
  const _PublicKey({@JsonKey(name: 'crv') required this.crv, @JsonKey(name: 'ext') required this.ext, @JsonKey(name: 'key_ops') required final  List<String> keyOps, @JsonKey(name: 'kty') required this.kty, @JsonKey(name: 'x') required this.x, @JsonKey(name: 'y') required this.y}): _keyOps = keyOps;
  factory _PublicKey.fromJson(Map<String, dynamic> json) => _$PublicKeyFromJson(json);

@override@JsonKey(name: 'crv') final  String crv;
@override@JsonKey(name: 'ext') final  bool ext;
 final  List<String> _keyOps;
@override@JsonKey(name: 'key_ops') List<String> get keyOps {
  if (_keyOps is EqualUnmodifiableListView) return _keyOps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_keyOps);
}

@override@JsonKey(name: 'kty') final  String kty;
@override@JsonKey(name: 'x') final  String x;
@override@JsonKey(name: 'y') final  String y;

/// Create a copy of PublicKey
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PublicKeyCopyWith<_PublicKey> get copyWith => __$PublicKeyCopyWithImpl<_PublicKey>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PublicKeyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PublicKey&&(identical(other.crv, crv) || other.crv == crv)&&(identical(other.ext, ext) || other.ext == ext)&&const DeepCollectionEquality().equals(other._keyOps, _keyOps)&&(identical(other.kty, kty) || other.kty == kty)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,crv,ext,const DeepCollectionEquality().hash(_keyOps),kty,x,y);

@override
String toString() {
  return 'PublicKey(crv: $crv, ext: $ext, keyOps: $keyOps, kty: $kty, x: $x, y: $y)';
}


}

/// @nodoc
abstract mixin class _$PublicKeyCopyWith<$Res> implements $PublicKeyCopyWith<$Res> {
  factory _$PublicKeyCopyWith(_PublicKey value, $Res Function(_PublicKey) _then) = __$PublicKeyCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'crv') String crv,@JsonKey(name: 'ext') bool ext,@JsonKey(name: 'key_ops') List<String> keyOps,@JsonKey(name: 'kty') String kty,@JsonKey(name: 'x') String x,@JsonKey(name: 'y') String y
});




}
/// @nodoc
class __$PublicKeyCopyWithImpl<$Res>
    implements _$PublicKeyCopyWith<$Res> {
  __$PublicKeyCopyWithImpl(this._self, this._then);

  final _PublicKey _self;
  final $Res Function(_PublicKey) _then;

/// Create a copy of PublicKey
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? crv = null,Object? ext = null,Object? keyOps = null,Object? kty = null,Object? x = null,Object? y = null,}) {
  return _then(_PublicKey(
crv: null == crv ? _self.crv : crv // ignore: cast_nullable_to_non_nullable
as String,ext: null == ext ? _self.ext : ext // ignore: cast_nullable_to_non_nullable
as bool,keyOps: null == keyOps ? _self._keyOps : keyOps // ignore: cast_nullable_to_non_nullable
as List<String>,kty: null == kty ? _self.kty : kty // ignore: cast_nullable_to_non_nullable
as String,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as String,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
