// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appkit_modal_theme_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReownAppKitModalThemeData {

 ReownAppKitModalColors get lightColors; ReownAppKitModalColors get darkColors; ReownAppKitModalTextStyles get textStyles; ReownAppKitModalRadiuses get radiuses;
/// Create a copy of ReownAppKitModalThemeData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReownAppKitModalThemeDataCopyWith<ReownAppKitModalThemeData> get copyWith => _$ReownAppKitModalThemeDataCopyWithImpl<ReownAppKitModalThemeData>(this as ReownAppKitModalThemeData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReownAppKitModalThemeData&&(identical(other.lightColors, lightColors) || other.lightColors == lightColors)&&(identical(other.darkColors, darkColors) || other.darkColors == darkColors)&&(identical(other.textStyles, textStyles) || other.textStyles == textStyles)&&(identical(other.radiuses, radiuses) || other.radiuses == radiuses));
}


@override
int get hashCode => Object.hash(runtimeType,lightColors,darkColors,textStyles,radiuses);

@override
String toString() {
  return 'ReownAppKitModalThemeData(lightColors: $lightColors, darkColors: $darkColors, textStyles: $textStyles, radiuses: $radiuses)';
}


}

/// @nodoc
abstract mixin class $ReownAppKitModalThemeDataCopyWith<$Res>  {
  factory $ReownAppKitModalThemeDataCopyWith(ReownAppKitModalThemeData value, $Res Function(ReownAppKitModalThemeData) _then) = _$ReownAppKitModalThemeDataCopyWithImpl;
@useResult
$Res call({
 ReownAppKitModalColors lightColors, ReownAppKitModalColors darkColors, ReownAppKitModalTextStyles textStyles, ReownAppKitModalRadiuses radiuses
});


$ReownAppKitModalColorsCopyWith<$Res> get lightColors;$ReownAppKitModalColorsCopyWith<$Res> get darkColors;$ReownAppKitModalTextStylesCopyWith<$Res> get textStyles;$ReownAppKitModalRadiusesCopyWith<$Res> get radiuses;

}
/// @nodoc
class _$ReownAppKitModalThemeDataCopyWithImpl<$Res>
    implements $ReownAppKitModalThemeDataCopyWith<$Res> {
  _$ReownAppKitModalThemeDataCopyWithImpl(this._self, this._then);

  final ReownAppKitModalThemeData _self;
  final $Res Function(ReownAppKitModalThemeData) _then;

/// Create a copy of ReownAppKitModalThemeData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lightColors = null,Object? darkColors = null,Object? textStyles = null,Object? radiuses = null,}) {
  return _then(_self.copyWith(
lightColors: null == lightColors ? _self.lightColors : lightColors // ignore: cast_nullable_to_non_nullable
as ReownAppKitModalColors,darkColors: null == darkColors ? _self.darkColors : darkColors // ignore: cast_nullable_to_non_nullable
as ReownAppKitModalColors,textStyles: null == textStyles ? _self.textStyles : textStyles // ignore: cast_nullable_to_non_nullable
as ReownAppKitModalTextStyles,radiuses: null == radiuses ? _self.radiuses : radiuses // ignore: cast_nullable_to_non_nullable
as ReownAppKitModalRadiuses,
  ));
}
/// Create a copy of ReownAppKitModalThemeData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReownAppKitModalColorsCopyWith<$Res> get lightColors {
  
  return $ReownAppKitModalColorsCopyWith<$Res>(_self.lightColors, (value) {
    return _then(_self.copyWith(lightColors: value));
  });
}/// Create a copy of ReownAppKitModalThemeData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReownAppKitModalColorsCopyWith<$Res> get darkColors {
  
  return $ReownAppKitModalColorsCopyWith<$Res>(_self.darkColors, (value) {
    return _then(_self.copyWith(darkColors: value));
  });
}/// Create a copy of ReownAppKitModalThemeData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReownAppKitModalTextStylesCopyWith<$Res> get textStyles {
  
  return $ReownAppKitModalTextStylesCopyWith<$Res>(_self.textStyles, (value) {
    return _then(_self.copyWith(textStyles: value));
  });
}/// Create a copy of ReownAppKitModalThemeData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReownAppKitModalRadiusesCopyWith<$Res> get radiuses {
  
  return $ReownAppKitModalRadiusesCopyWith<$Res>(_self.radiuses, (value) {
    return _then(_self.copyWith(radiuses: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReownAppKitModalThemeData].
extension ReownAppKitModalThemeDataPatterns on ReownAppKitModalThemeData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReownAppKitModalThemeData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReownAppKitModalThemeData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReownAppKitModalThemeData value)  $default,){
final _that = this;
switch (_that) {
case _ReownAppKitModalThemeData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReownAppKitModalThemeData value)?  $default,){
final _that = this;
switch (_that) {
case _ReownAppKitModalThemeData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ReownAppKitModalColors lightColors,  ReownAppKitModalColors darkColors,  ReownAppKitModalTextStyles textStyles,  ReownAppKitModalRadiuses radiuses)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReownAppKitModalThemeData() when $default != null:
return $default(_that.lightColors,_that.darkColors,_that.textStyles,_that.radiuses);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ReownAppKitModalColors lightColors,  ReownAppKitModalColors darkColors,  ReownAppKitModalTextStyles textStyles,  ReownAppKitModalRadiuses radiuses)  $default,) {final _that = this;
switch (_that) {
case _ReownAppKitModalThemeData():
return $default(_that.lightColors,_that.darkColors,_that.textStyles,_that.radiuses);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ReownAppKitModalColors lightColors,  ReownAppKitModalColors darkColors,  ReownAppKitModalTextStyles textStyles,  ReownAppKitModalRadiuses radiuses)?  $default,) {final _that = this;
switch (_that) {
case _ReownAppKitModalThemeData() when $default != null:
return $default(_that.lightColors,_that.darkColors,_that.textStyles,_that.radiuses);case _:
  return null;

}
}

}

/// @nodoc


class _ReownAppKitModalThemeData implements ReownAppKitModalThemeData {
  const _ReownAppKitModalThemeData({this.lightColors = ReownAppKitModalColors.lightMode, this.darkColors = ReownAppKitModalColors.darkMode, this.textStyles = ReownAppKitModalTextStyles.textStyle, this.radiuses = const ReownAppKitModalRadiuses()});
  

@override@JsonKey() final  ReownAppKitModalColors lightColors;
@override@JsonKey() final  ReownAppKitModalColors darkColors;
@override@JsonKey() final  ReownAppKitModalTextStyles textStyles;
@override@JsonKey() final  ReownAppKitModalRadiuses radiuses;

/// Create a copy of ReownAppKitModalThemeData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReownAppKitModalThemeDataCopyWith<_ReownAppKitModalThemeData> get copyWith => __$ReownAppKitModalThemeDataCopyWithImpl<_ReownAppKitModalThemeData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReownAppKitModalThemeData&&(identical(other.lightColors, lightColors) || other.lightColors == lightColors)&&(identical(other.darkColors, darkColors) || other.darkColors == darkColors)&&(identical(other.textStyles, textStyles) || other.textStyles == textStyles)&&(identical(other.radiuses, radiuses) || other.radiuses == radiuses));
}


@override
int get hashCode => Object.hash(runtimeType,lightColors,darkColors,textStyles,radiuses);

@override
String toString() {
  return 'ReownAppKitModalThemeData(lightColors: $lightColors, darkColors: $darkColors, textStyles: $textStyles, radiuses: $radiuses)';
}


}

/// @nodoc
abstract mixin class _$ReownAppKitModalThemeDataCopyWith<$Res> implements $ReownAppKitModalThemeDataCopyWith<$Res> {
  factory _$ReownAppKitModalThemeDataCopyWith(_ReownAppKitModalThemeData value, $Res Function(_ReownAppKitModalThemeData) _then) = __$ReownAppKitModalThemeDataCopyWithImpl;
@override @useResult
$Res call({
 ReownAppKitModalColors lightColors, ReownAppKitModalColors darkColors, ReownAppKitModalTextStyles textStyles, ReownAppKitModalRadiuses radiuses
});


@override $ReownAppKitModalColorsCopyWith<$Res> get lightColors;@override $ReownAppKitModalColorsCopyWith<$Res> get darkColors;@override $ReownAppKitModalTextStylesCopyWith<$Res> get textStyles;@override $ReownAppKitModalRadiusesCopyWith<$Res> get radiuses;

}
/// @nodoc
class __$ReownAppKitModalThemeDataCopyWithImpl<$Res>
    implements _$ReownAppKitModalThemeDataCopyWith<$Res> {
  __$ReownAppKitModalThemeDataCopyWithImpl(this._self, this._then);

  final _ReownAppKitModalThemeData _self;
  final $Res Function(_ReownAppKitModalThemeData) _then;

/// Create a copy of ReownAppKitModalThemeData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lightColors = null,Object? darkColors = null,Object? textStyles = null,Object? radiuses = null,}) {
  return _then(_ReownAppKitModalThemeData(
lightColors: null == lightColors ? _self.lightColors : lightColors // ignore: cast_nullable_to_non_nullable
as ReownAppKitModalColors,darkColors: null == darkColors ? _self.darkColors : darkColors // ignore: cast_nullable_to_non_nullable
as ReownAppKitModalColors,textStyles: null == textStyles ? _self.textStyles : textStyles // ignore: cast_nullable_to_non_nullable
as ReownAppKitModalTextStyles,radiuses: null == radiuses ? _self.radiuses : radiuses // ignore: cast_nullable_to_non_nullable
as ReownAppKitModalRadiuses,
  ));
}

/// Create a copy of ReownAppKitModalThemeData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReownAppKitModalColorsCopyWith<$Res> get lightColors {
  
  return $ReownAppKitModalColorsCopyWith<$Res>(_self.lightColors, (value) {
    return _then(_self.copyWith(lightColors: value));
  });
}/// Create a copy of ReownAppKitModalThemeData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReownAppKitModalColorsCopyWith<$Res> get darkColors {
  
  return $ReownAppKitModalColorsCopyWith<$Res>(_self.darkColors, (value) {
    return _then(_self.copyWith(darkColors: value));
  });
}/// Create a copy of ReownAppKitModalThemeData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReownAppKitModalTextStylesCopyWith<$Res> get textStyles {
  
  return $ReownAppKitModalTextStylesCopyWith<$Res>(_self.textStyles, (value) {
    return _then(_self.copyWith(textStyles: value));
  });
}/// Create a copy of ReownAppKitModalThemeData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReownAppKitModalRadiusesCopyWith<$Res> get radiuses {
  
  return $ReownAppKitModalRadiusesCopyWith<$Res>(_self.radiuses, (value) {
    return _then(_self.copyWith(radiuses: value));
  });
}
}

// dart format on
