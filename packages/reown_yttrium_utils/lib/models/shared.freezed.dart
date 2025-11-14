// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shared.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PulseMetadataCompat {

 String get sdkVersion; String get sdkPlatform; String? get bundleId; String? get url;
/// Create a copy of PulseMetadataCompat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PulseMetadataCompatCopyWith<PulseMetadataCompat> get copyWith => _$PulseMetadataCompatCopyWithImpl<PulseMetadataCompat>(this as PulseMetadataCompat, _$identity);

  /// Serializes this PulseMetadataCompat to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PulseMetadataCompat&&(identical(other.sdkVersion, sdkVersion) || other.sdkVersion == sdkVersion)&&(identical(other.sdkPlatform, sdkPlatform) || other.sdkPlatform == sdkPlatform)&&(identical(other.bundleId, bundleId) || other.bundleId == bundleId)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sdkVersion,sdkPlatform,bundleId,url);

@override
String toString() {
  return 'PulseMetadataCompat(sdkVersion: $sdkVersion, sdkPlatform: $sdkPlatform, bundleId: $bundleId, url: $url)';
}


}

/// @nodoc
abstract mixin class $PulseMetadataCompatCopyWith<$Res>  {
  factory $PulseMetadataCompatCopyWith(PulseMetadataCompat value, $Res Function(PulseMetadataCompat) _then) = _$PulseMetadataCompatCopyWithImpl;
@useResult
$Res call({
 String sdkVersion, String sdkPlatform, String? bundleId, String? url
});




}
/// @nodoc
class _$PulseMetadataCompatCopyWithImpl<$Res>
    implements $PulseMetadataCompatCopyWith<$Res> {
  _$PulseMetadataCompatCopyWithImpl(this._self, this._then);

  final PulseMetadataCompat _self;
  final $Res Function(PulseMetadataCompat) _then;

/// Create a copy of PulseMetadataCompat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sdkVersion = null,Object? sdkPlatform = null,Object? bundleId = freezed,Object? url = freezed,}) {
  return _then(_self.copyWith(
sdkVersion: null == sdkVersion ? _self.sdkVersion : sdkVersion // ignore: cast_nullable_to_non_nullable
as String,sdkPlatform: null == sdkPlatform ? _self.sdkPlatform : sdkPlatform // ignore: cast_nullable_to_non_nullable
as String,bundleId: freezed == bundleId ? _self.bundleId : bundleId // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PulseMetadataCompat].
extension PulseMetadataCompatPatterns on PulseMetadataCompat {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PulseMetadataCompat value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PulseMetadataCompat() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PulseMetadataCompat value)  $default,){
final _that = this;
switch (_that) {
case _PulseMetadataCompat():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PulseMetadataCompat value)?  $default,){
final _that = this;
switch (_that) {
case _PulseMetadataCompat() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sdkVersion,  String sdkPlatform,  String? bundleId,  String? url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PulseMetadataCompat() when $default != null:
return $default(_that.sdkVersion,_that.sdkPlatform,_that.bundleId,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sdkVersion,  String sdkPlatform,  String? bundleId,  String? url)  $default,) {final _that = this;
switch (_that) {
case _PulseMetadataCompat():
return $default(_that.sdkVersion,_that.sdkPlatform,_that.bundleId,_that.url);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sdkVersion,  String sdkPlatform,  String? bundleId,  String? url)?  $default,) {final _that = this;
switch (_that) {
case _PulseMetadataCompat() when $default != null:
return $default(_that.sdkVersion,_that.sdkPlatform,_that.bundleId,_that.url);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PulseMetadataCompat implements PulseMetadataCompat {
  const _PulseMetadataCompat({required this.sdkVersion, required this.sdkPlatform, this.bundleId, this.url});
  factory _PulseMetadataCompat.fromJson(Map<String, dynamic> json) => _$PulseMetadataCompatFromJson(json);

@override final  String sdkVersion;
@override final  String sdkPlatform;
@override final  String? bundleId;
@override final  String? url;

/// Create a copy of PulseMetadataCompat
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PulseMetadataCompatCopyWith<_PulseMetadataCompat> get copyWith => __$PulseMetadataCompatCopyWithImpl<_PulseMetadataCompat>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PulseMetadataCompatToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PulseMetadataCompat&&(identical(other.sdkVersion, sdkVersion) || other.sdkVersion == sdkVersion)&&(identical(other.sdkPlatform, sdkPlatform) || other.sdkPlatform == sdkPlatform)&&(identical(other.bundleId, bundleId) || other.bundleId == bundleId)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sdkVersion,sdkPlatform,bundleId,url);

@override
String toString() {
  return 'PulseMetadataCompat(sdkVersion: $sdkVersion, sdkPlatform: $sdkPlatform, bundleId: $bundleId, url: $url)';
}


}

/// @nodoc
abstract mixin class _$PulseMetadataCompatCopyWith<$Res> implements $PulseMetadataCompatCopyWith<$Res> {
  factory _$PulseMetadataCompatCopyWith(_PulseMetadataCompat value, $Res Function(_PulseMetadataCompat) _then) = __$PulseMetadataCompatCopyWithImpl;
@override @useResult
$Res call({
 String sdkVersion, String sdkPlatform, String? bundleId, String? url
});




}
/// @nodoc
class __$PulseMetadataCompatCopyWithImpl<$Res>
    implements _$PulseMetadataCompatCopyWith<$Res> {
  __$PulseMetadataCompatCopyWithImpl(this._self, this._then);

  final _PulseMetadataCompat _self;
  final $Res Function(_PulseMetadataCompat) _then;

/// Create a copy of PulseMetadataCompat
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sdkVersion = null,Object? sdkPlatform = null,Object? bundleId = freezed,Object? url = freezed,}) {
  return _then(_PulseMetadataCompat(
sdkVersion: null == sdkVersion ? _self.sdkVersion : sdkVersion // ignore: cast_nullable_to_non_nullable
as String,sdkPlatform: null == sdkPlatform ? _self.sdkPlatform : sdkPlatform // ignore: cast_nullable_to_non_nullable
as String,bundleId: freezed == bundleId ? _self.bundleId : bundleId // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
