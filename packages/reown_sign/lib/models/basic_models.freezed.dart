// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'basic_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReownSignError {

 int get code; String get message; String? get data;
/// Create a copy of ReownSignError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReownSignErrorCopyWith<ReownSignError> get copyWith => _$ReownSignErrorCopyWithImpl<ReownSignError>(this as ReownSignError, _$identity);

  /// Serializes this ReownSignError to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReownSignError&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message,data);

@override
String toString() {
  return 'ReownSignError(code: $code, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $ReownSignErrorCopyWith<$Res>  {
  factory $ReownSignErrorCopyWith(ReownSignError value, $Res Function(ReownSignError) _then) = _$ReownSignErrorCopyWithImpl;
@useResult
$Res call({
 int code, String message, String? data
});




}
/// @nodoc
class _$ReownSignErrorCopyWithImpl<$Res>
    implements $ReownSignErrorCopyWith<$Res> {
  _$ReownSignErrorCopyWithImpl(this._self, this._then);

  final ReownSignError _self;
  final $Res Function(ReownSignError) _then;

/// Create a copy of ReownSignError
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


/// Adds pattern-matching-related methods to [ReownSignError].
extension ReownSignErrorPatterns on ReownSignError {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReownSignError value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReownSignError() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReownSignError value)  $default,){
final _that = this;
switch (_that) {
case _ReownSignError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReownSignError value)?  $default,){
final _that = this;
switch (_that) {
case _ReownSignError() when $default != null:
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
case _ReownSignError() when $default != null:
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
case _ReownSignError():
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
case _ReownSignError() when $default != null:
return $default(_that.code,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _ReownSignError implements ReownSignError {
  const _ReownSignError({required this.code, required this.message, this.data});
  factory _ReownSignError.fromJson(Map<String, dynamic> json) => _$ReownSignErrorFromJson(json);

@override final  int code;
@override final  String message;
@override final  String? data;

/// Create a copy of ReownSignError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReownSignErrorCopyWith<_ReownSignError> get copyWith => __$ReownSignErrorCopyWithImpl<_ReownSignError>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReownSignErrorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReownSignError&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message,data);

@override
String toString() {
  return 'ReownSignError(code: $code, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$ReownSignErrorCopyWith<$Res> implements $ReownSignErrorCopyWith<$Res> {
  factory _$ReownSignErrorCopyWith(_ReownSignError value, $Res Function(_ReownSignError) _then) = __$ReownSignErrorCopyWithImpl;
@override @useResult
$Res call({
 int code, String message, String? data
});




}
/// @nodoc
class __$ReownSignErrorCopyWithImpl<$Res>
    implements _$ReownSignErrorCopyWith<$Res> {
  __$ReownSignErrorCopyWithImpl(this._self, this._then);

  final _ReownSignError _self;
  final $Res Function(_ReownSignError) _then;

/// Create a copy of ReownSignError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = null,Object? data = freezed,}) {
  return _then(_ReownSignError(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ConnectionMetadata {

 String get publicKey; PairingMetadata get metadata;
/// Create a copy of ConnectionMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConnectionMetadataCopyWith<ConnectionMetadata> get copyWith => _$ConnectionMetadataCopyWithImpl<ConnectionMetadata>(this as ConnectionMetadata, _$identity);

  /// Serializes this ConnectionMetadata to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectionMetadata&&(identical(other.publicKey, publicKey) || other.publicKey == publicKey)&&(identical(other.metadata, metadata) || other.metadata == metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,publicKey,metadata);

@override
String toString() {
  return 'ConnectionMetadata(publicKey: $publicKey, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $ConnectionMetadataCopyWith<$Res>  {
  factory $ConnectionMetadataCopyWith(ConnectionMetadata value, $Res Function(ConnectionMetadata) _then) = _$ConnectionMetadataCopyWithImpl;
@useResult
$Res call({
 String publicKey, PairingMetadata metadata
});


$PairingMetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class _$ConnectionMetadataCopyWithImpl<$Res>
    implements $ConnectionMetadataCopyWith<$Res> {
  _$ConnectionMetadataCopyWithImpl(this._self, this._then);

  final ConnectionMetadata _self;
  final $Res Function(ConnectionMetadata) _then;

/// Create a copy of ConnectionMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? publicKey = null,Object? metadata = null,}) {
  return _then(_self.copyWith(
publicKey: null == publicKey ? _self.publicKey : publicKey // ignore: cast_nullable_to_non_nullable
as String,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as PairingMetadata,
  ));
}
/// Create a copy of ConnectionMetadata
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PairingMetadataCopyWith<$Res> get metadata {
  
  return $PairingMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}


/// Adds pattern-matching-related methods to [ConnectionMetadata].
extension ConnectionMetadataPatterns on ConnectionMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConnectionMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConnectionMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConnectionMetadata value)  $default,){
final _that = this;
switch (_that) {
case _ConnectionMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConnectionMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _ConnectionMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String publicKey,  PairingMetadata metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConnectionMetadata() when $default != null:
return $default(_that.publicKey,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String publicKey,  PairingMetadata metadata)  $default,) {final _that = this;
switch (_that) {
case _ConnectionMetadata():
return $default(_that.publicKey,_that.metadata);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String publicKey,  PairingMetadata metadata)?  $default,) {final _that = this;
switch (_that) {
case _ConnectionMetadata() when $default != null:
return $default(_that.publicKey,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConnectionMetadata implements ConnectionMetadata {
  const _ConnectionMetadata({required this.publicKey, required this.metadata});
  factory _ConnectionMetadata.fromJson(Map<String, dynamic> json) => _$ConnectionMetadataFromJson(json);

@override final  String publicKey;
@override final  PairingMetadata metadata;

/// Create a copy of ConnectionMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConnectionMetadataCopyWith<_ConnectionMetadata> get copyWith => __$ConnectionMetadataCopyWithImpl<_ConnectionMetadata>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConnectionMetadataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectionMetadata&&(identical(other.publicKey, publicKey) || other.publicKey == publicKey)&&(identical(other.metadata, metadata) || other.metadata == metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,publicKey,metadata);

@override
String toString() {
  return 'ConnectionMetadata(publicKey: $publicKey, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$ConnectionMetadataCopyWith<$Res> implements $ConnectionMetadataCopyWith<$Res> {
  factory _$ConnectionMetadataCopyWith(_ConnectionMetadata value, $Res Function(_ConnectionMetadata) _then) = __$ConnectionMetadataCopyWithImpl;
@override @useResult
$Res call({
 String publicKey, PairingMetadata metadata
});


@override $PairingMetadataCopyWith<$Res> get metadata;

}
/// @nodoc
class __$ConnectionMetadataCopyWithImpl<$Res>
    implements _$ConnectionMetadataCopyWith<$Res> {
  __$ConnectionMetadataCopyWithImpl(this._self, this._then);

  final _ConnectionMetadata _self;
  final $Res Function(_ConnectionMetadata) _then;

/// Create a copy of ConnectionMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? publicKey = null,Object? metadata = null,}) {
  return _then(_ConnectionMetadata(
publicKey: null == publicKey ? _self.publicKey : publicKey // ignore: cast_nullable_to_non_nullable
as String,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as PairingMetadata,
  ));
}

/// Create a copy of ConnectionMetadata
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PairingMetadataCopyWith<$Res> get metadata {
  
  return $PairingMetadataCopyWith<$Res>(_self.metadata, (value) {
    return _then(_self.copyWith(metadata: value));
  });
}
}


/// @nodoc
mixin _$AuthPublicKey {

 String get publicKey;
/// Create a copy of AuthPublicKey
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthPublicKeyCopyWith<AuthPublicKey> get copyWith => _$AuthPublicKeyCopyWithImpl<AuthPublicKey>(this as AuthPublicKey, _$identity);

  /// Serializes this AuthPublicKey to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthPublicKey&&(identical(other.publicKey, publicKey) || other.publicKey == publicKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,publicKey);

@override
String toString() {
  return 'AuthPublicKey(publicKey: $publicKey)';
}


}

/// @nodoc
abstract mixin class $AuthPublicKeyCopyWith<$Res>  {
  factory $AuthPublicKeyCopyWith(AuthPublicKey value, $Res Function(AuthPublicKey) _then) = _$AuthPublicKeyCopyWithImpl;
@useResult
$Res call({
 String publicKey
});




}
/// @nodoc
class _$AuthPublicKeyCopyWithImpl<$Res>
    implements $AuthPublicKeyCopyWith<$Res> {
  _$AuthPublicKeyCopyWithImpl(this._self, this._then);

  final AuthPublicKey _self;
  final $Res Function(AuthPublicKey) _then;

/// Create a copy of AuthPublicKey
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? publicKey = null,}) {
  return _then(_self.copyWith(
publicKey: null == publicKey ? _self.publicKey : publicKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthPublicKey].
extension AuthPublicKeyPatterns on AuthPublicKey {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthPublicKey value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthPublicKey() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthPublicKey value)  $default,){
final _that = this;
switch (_that) {
case _AuthPublicKey():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthPublicKey value)?  $default,){
final _that = this;
switch (_that) {
case _AuthPublicKey() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String publicKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthPublicKey() when $default != null:
return $default(_that.publicKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String publicKey)  $default,) {final _that = this;
switch (_that) {
case _AuthPublicKey():
return $default(_that.publicKey);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String publicKey)?  $default,) {final _that = this;
switch (_that) {
case _AuthPublicKey() when $default != null:
return $default(_that.publicKey);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _AuthPublicKey implements AuthPublicKey {
  const _AuthPublicKey({required this.publicKey});
  factory _AuthPublicKey.fromJson(Map<String, dynamic> json) => _$AuthPublicKeyFromJson(json);

@override final  String publicKey;

/// Create a copy of AuthPublicKey
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthPublicKeyCopyWith<_AuthPublicKey> get copyWith => __$AuthPublicKeyCopyWithImpl<_AuthPublicKey>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthPublicKeyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthPublicKey&&(identical(other.publicKey, publicKey) || other.publicKey == publicKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,publicKey);

@override
String toString() {
  return 'AuthPublicKey(publicKey: $publicKey)';
}


}

/// @nodoc
abstract mixin class _$AuthPublicKeyCopyWith<$Res> implements $AuthPublicKeyCopyWith<$Res> {
  factory _$AuthPublicKeyCopyWith(_AuthPublicKey value, $Res Function(_AuthPublicKey) _then) = __$AuthPublicKeyCopyWithImpl;
@override @useResult
$Res call({
 String publicKey
});




}
/// @nodoc
class __$AuthPublicKeyCopyWithImpl<$Res>
    implements _$AuthPublicKeyCopyWith<$Res> {
  __$AuthPublicKeyCopyWithImpl(this._self, this._then);

  final _AuthPublicKey _self;
  final $Res Function(_AuthPublicKey) _then;

/// Create a copy of AuthPublicKey
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? publicKey = null,}) {
  return _then(_AuthPublicKey(
publicKey: null == publicKey ? _self.publicKey : publicKey // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
