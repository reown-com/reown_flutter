// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'blockchain_identity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BlockchainIdentity {

 String? get name; String? get avatar;
/// Create a copy of BlockchainIdentity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BlockchainIdentityCopyWith<BlockchainIdentity> get copyWith => _$BlockchainIdentityCopyWithImpl<BlockchainIdentity>(this as BlockchainIdentity, _$identity);

  /// Serializes this BlockchainIdentity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BlockchainIdentity&&(identical(other.name, name) || other.name == name)&&(identical(other.avatar, avatar) || other.avatar == avatar));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,avatar);

@override
String toString() {
  return 'BlockchainIdentity(name: $name, avatar: $avatar)';
}


}

/// @nodoc
abstract mixin class $BlockchainIdentityCopyWith<$Res>  {
  factory $BlockchainIdentityCopyWith(BlockchainIdentity value, $Res Function(BlockchainIdentity) _then) = _$BlockchainIdentityCopyWithImpl;
@useResult
$Res call({
 String? name, String? avatar
});




}
/// @nodoc
class _$BlockchainIdentityCopyWithImpl<$Res>
    implements $BlockchainIdentityCopyWith<$Res> {
  _$BlockchainIdentityCopyWithImpl(this._self, this._then);

  final BlockchainIdentity _self;
  final $Res Function(BlockchainIdentity) _then;

/// Create a copy of BlockchainIdentity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? avatar = freezed,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BlockchainIdentity].
extension BlockchainIdentityPatterns on BlockchainIdentity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BlockchainIdentity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BlockchainIdentity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BlockchainIdentity value)  $default,){
final _that = this;
switch (_that) {
case _BlockchainIdentity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BlockchainIdentity value)?  $default,){
final _that = this;
switch (_that) {
case _BlockchainIdentity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name,  String? avatar)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BlockchainIdentity() when $default != null:
return $default(_that.name,_that.avatar);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name,  String? avatar)  $default,) {final _that = this;
switch (_that) {
case _BlockchainIdentity():
return $default(_that.name,_that.avatar);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name,  String? avatar)?  $default,) {final _that = this;
switch (_that) {
case _BlockchainIdentity() when $default != null:
return $default(_that.name,_that.avatar);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BlockchainIdentity implements BlockchainIdentity {
  const _BlockchainIdentity({this.name, this.avatar});
  factory _BlockchainIdentity.fromJson(Map<String, dynamic> json) => _$BlockchainIdentityFromJson(json);

@override final  String? name;
@override final  String? avatar;

/// Create a copy of BlockchainIdentity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BlockchainIdentityCopyWith<_BlockchainIdentity> get copyWith => __$BlockchainIdentityCopyWithImpl<_BlockchainIdentity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BlockchainIdentityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BlockchainIdentity&&(identical(other.name, name) || other.name == name)&&(identical(other.avatar, avatar) || other.avatar == avatar));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,avatar);

@override
String toString() {
  return 'BlockchainIdentity(name: $name, avatar: $avatar)';
}


}

/// @nodoc
abstract mixin class _$BlockchainIdentityCopyWith<$Res> implements $BlockchainIdentityCopyWith<$Res> {
  factory _$BlockchainIdentityCopyWith(_BlockchainIdentity value, $Res Function(_BlockchainIdentity) _then) = __$BlockchainIdentityCopyWithImpl;
@override @useResult
$Res call({
 String? name, String? avatar
});




}
/// @nodoc
class __$BlockchainIdentityCopyWithImpl<$Res>
    implements _$BlockchainIdentityCopyWith<$Res> {
  __$BlockchainIdentityCopyWithImpl(this._self, this._then);

  final _BlockchainIdentity _self;
  final $Res Function(_BlockchainIdentity) _then;

/// Create a copy of BlockchainIdentity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? avatar = freezed,}) {
  return _then(_BlockchainIdentity(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
