// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'link_mode_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LinkModeOptions {

 int get tag;
/// Create a copy of LinkModeOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LinkModeOptionsCopyWith<LinkModeOptions> get copyWith => _$LinkModeOptionsCopyWithImpl<LinkModeOptions>(this as LinkModeOptions, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LinkModeOptions&&(identical(other.tag, tag) || other.tag == tag));
}


@override
int get hashCode => Object.hash(runtimeType,tag);

@override
String toString() {
  return 'LinkModeOptions(tag: $tag)';
}


}

/// @nodoc
abstract mixin class $LinkModeOptionsCopyWith<$Res>  {
  factory $LinkModeOptionsCopyWith(LinkModeOptions value, $Res Function(LinkModeOptions) _then) = _$LinkModeOptionsCopyWithImpl;
@useResult
$Res call({
 int tag
});




}
/// @nodoc
class _$LinkModeOptionsCopyWithImpl<$Res>
    implements $LinkModeOptionsCopyWith<$Res> {
  _$LinkModeOptionsCopyWithImpl(this._self, this._then);

  final LinkModeOptions _self;
  final $Res Function(LinkModeOptions) _then;

/// Create a copy of LinkModeOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tag = null,}) {
  return _then(_self.copyWith(
tag: null == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LinkModeOptions].
extension LinkModeOptionsPatterns on LinkModeOptions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LinkModeOptions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LinkModeOptions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LinkModeOptions value)  $default,){
final _that = this;
switch (_that) {
case _LinkModeOptions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LinkModeOptions value)?  $default,){
final _that = this;
switch (_that) {
case _LinkModeOptions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int tag)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LinkModeOptions() when $default != null:
return $default(_that.tag);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int tag)  $default,) {final _that = this;
switch (_that) {
case _LinkModeOptions():
return $default(_that.tag);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int tag)?  $default,) {final _that = this;
switch (_that) {
case _LinkModeOptions() when $default != null:
return $default(_that.tag);case _:
  return null;

}
}

}

/// @nodoc


class _LinkModeOptions implements LinkModeOptions {
  const _LinkModeOptions({required this.tag});
  

@override final  int tag;

/// Create a copy of LinkModeOptions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LinkModeOptionsCopyWith<_LinkModeOptions> get copyWith => __$LinkModeOptionsCopyWithImpl<_LinkModeOptions>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LinkModeOptions&&(identical(other.tag, tag) || other.tag == tag));
}


@override
int get hashCode => Object.hash(runtimeType,tag);

@override
String toString() {
  return 'LinkModeOptions(tag: $tag)';
}


}

/// @nodoc
abstract mixin class _$LinkModeOptionsCopyWith<$Res> implements $LinkModeOptionsCopyWith<$Res> {
  factory _$LinkModeOptionsCopyWith(_LinkModeOptions value, $Res Function(_LinkModeOptions) _then) = __$LinkModeOptionsCopyWithImpl;
@override @useResult
$Res call({
 int tag
});




}
/// @nodoc
class __$LinkModeOptionsCopyWithImpl<$Res>
    implements _$LinkModeOptionsCopyWith<$Res> {
  __$LinkModeOptionsCopyWithImpl(this._self, this._then);

  final _LinkModeOptions _self;
  final $Res Function(_LinkModeOptions) _then;

/// Create a copy of LinkModeOptions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tag = null,}) {
  return _then(_LinkModeOptions(
tag: null == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
