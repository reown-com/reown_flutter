// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quote_results.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GetQuoteStatusResult {

 QuoteStatus get status;
/// Create a copy of GetQuoteStatusResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GetQuoteStatusResultCopyWith<GetQuoteStatusResult> get copyWith => _$GetQuoteStatusResultCopyWithImpl<GetQuoteStatusResult>(this as GetQuoteStatusResult, _$identity);

  /// Serializes this GetQuoteStatusResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GetQuoteStatusResult&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'GetQuoteStatusResult(status: $status)';
}


}

/// @nodoc
abstract mixin class $GetQuoteStatusResultCopyWith<$Res>  {
  factory $GetQuoteStatusResultCopyWith(GetQuoteStatusResult value, $Res Function(GetQuoteStatusResult) _then) = _$GetQuoteStatusResultCopyWithImpl;
@useResult
$Res call({
 QuoteStatus status
});




}
/// @nodoc
class _$GetQuoteStatusResultCopyWithImpl<$Res>
    implements $GetQuoteStatusResultCopyWith<$Res> {
  _$GetQuoteStatusResultCopyWithImpl(this._self, this._then);

  final GetQuoteStatusResult _self;
  final $Res Function(GetQuoteStatusResult) _then;

/// Create a copy of GetQuoteStatusResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as QuoteStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [GetQuoteStatusResult].
extension GetQuoteStatusResultPatterns on GetQuoteStatusResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GetQuoteStatusResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetQuoteStatusResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GetQuoteStatusResult value)  $default,){
final _that = this;
switch (_that) {
case _GetQuoteStatusResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GetQuoteStatusResult value)?  $default,){
final _that = this;
switch (_that) {
case _GetQuoteStatusResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( QuoteStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetQuoteStatusResult() when $default != null:
return $default(_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( QuoteStatus status)  $default,) {final _that = this;
switch (_that) {
case _GetQuoteStatusResult():
return $default(_that.status);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( QuoteStatus status)?  $default,) {final _that = this;
switch (_that) {
case _GetQuoteStatusResult() when $default != null:
return $default(_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GetQuoteStatusResult implements GetQuoteStatusResult {
  const _GetQuoteStatusResult({required this.status});
  factory _GetQuoteStatusResult.fromJson(Map<String, dynamic> json) => _$GetQuoteStatusResultFromJson(json);

@override final  QuoteStatus status;

/// Create a copy of GetQuoteStatusResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GetQuoteStatusResultCopyWith<_GetQuoteStatusResult> get copyWith => __$GetQuoteStatusResultCopyWithImpl<_GetQuoteStatusResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GetQuoteStatusResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetQuoteStatusResult&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'GetQuoteStatusResult(status: $status)';
}


}

/// @nodoc
abstract mixin class _$GetQuoteStatusResultCopyWith<$Res> implements $GetQuoteStatusResultCopyWith<$Res> {
  factory _$GetQuoteStatusResultCopyWith(_GetQuoteStatusResult value, $Res Function(_GetQuoteStatusResult) _then) = __$GetQuoteStatusResultCopyWithImpl;
@override @useResult
$Res call({
 QuoteStatus status
});




}
/// @nodoc
class __$GetQuoteStatusResultCopyWithImpl<$Res>
    implements _$GetQuoteStatusResultCopyWith<$Res> {
  __$GetQuoteStatusResultCopyWithImpl(this._self, this._then);

  final _GetQuoteStatusResult _self;
  final $Res Function(_GetQuoteStatusResult) _then;

/// Create a copy of GetQuoteStatusResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,}) {
  return _then(_GetQuoteStatusResult(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as QuoteStatus,
  ));
}


}

// dart format on
