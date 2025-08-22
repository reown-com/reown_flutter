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
mixin _$ReownCoreError {

 int get code; String get message; String? get data;
/// Create a copy of ReownCoreError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReownCoreErrorCopyWith<ReownCoreError> get copyWith => _$ReownCoreErrorCopyWithImpl<ReownCoreError>(this as ReownCoreError, _$identity);

  /// Serializes this ReownCoreError to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReownCoreError&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message,data);

@override
String toString() {
  return 'ReownCoreError(code: $code, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $ReownCoreErrorCopyWith<$Res>  {
  factory $ReownCoreErrorCopyWith(ReownCoreError value, $Res Function(ReownCoreError) _then) = _$ReownCoreErrorCopyWithImpl;
@useResult
$Res call({
 int code, String message, String? data
});




}
/// @nodoc
class _$ReownCoreErrorCopyWithImpl<$Res>
    implements $ReownCoreErrorCopyWith<$Res> {
  _$ReownCoreErrorCopyWithImpl(this._self, this._then);

  final ReownCoreError _self;
  final $Res Function(ReownCoreError) _then;

/// Create a copy of ReownCoreError
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


/// Adds pattern-matching-related methods to [ReownCoreError].
extension ReownCoreErrorPatterns on ReownCoreError {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReownCoreError value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReownCoreError() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReownCoreError value)  $default,){
final _that = this;
switch (_that) {
case _ReownCoreError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReownCoreError value)?  $default,){
final _that = this;
switch (_that) {
case _ReownCoreError() when $default != null:
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
case _ReownCoreError() when $default != null:
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
case _ReownCoreError():
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
case _ReownCoreError() when $default != null:
return $default(_that.code,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _ReownCoreError implements ReownCoreError {
  const _ReownCoreError({required this.code, required this.message, this.data});
  factory _ReownCoreError.fromJson(Map<String, dynamic> json) => _$ReownCoreErrorFromJson(json);

@override final  int code;
@override final  String message;
@override final  String? data;

/// Create a copy of ReownCoreError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReownCoreErrorCopyWith<_ReownCoreError> get copyWith => __$ReownCoreErrorCopyWithImpl<_ReownCoreError>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReownCoreErrorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReownCoreError&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message,data);

@override
String toString() {
  return 'ReownCoreError(code: $code, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$ReownCoreErrorCopyWith<$Res> implements $ReownCoreErrorCopyWith<$Res> {
  factory _$ReownCoreErrorCopyWith(_ReownCoreError value, $Res Function(_ReownCoreError) _then) = __$ReownCoreErrorCopyWithImpl;
@override @useResult
$Res call({
 int code, String message, String? data
});




}
/// @nodoc
class __$ReownCoreErrorCopyWithImpl<$Res>
    implements _$ReownCoreErrorCopyWith<$Res> {
  __$ReownCoreErrorCopyWithImpl(this._self, this._then);

  final _ReownCoreError _self;
  final $Res Function(_ReownCoreError) _then;

/// Create a copy of ReownCoreError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? message = null,Object? data = freezed,}) {
  return _then(_ReownCoreError(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PublishOptions {

 int? get ttl; int? get tag; int? get correlationId; Map<String, dynamic>? get tvf; String? get publishMethod;
/// Create a copy of PublishOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PublishOptionsCopyWith<PublishOptions> get copyWith => _$PublishOptionsCopyWithImpl<PublishOptions>(this as PublishOptions, _$identity);

  /// Serializes this PublishOptions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PublishOptions&&(identical(other.ttl, ttl) || other.ttl == ttl)&&(identical(other.tag, tag) || other.tag == tag)&&(identical(other.correlationId, correlationId) || other.correlationId == correlationId)&&const DeepCollectionEquality().equals(other.tvf, tvf)&&(identical(other.publishMethod, publishMethod) || other.publishMethod == publishMethod));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ttl,tag,correlationId,const DeepCollectionEquality().hash(tvf),publishMethod);

@override
String toString() {
  return 'PublishOptions(ttl: $ttl, tag: $tag, correlationId: $correlationId, tvf: $tvf, publishMethod: $publishMethod)';
}


}

/// @nodoc
abstract mixin class $PublishOptionsCopyWith<$Res>  {
  factory $PublishOptionsCopyWith(PublishOptions value, $Res Function(PublishOptions) _then) = _$PublishOptionsCopyWithImpl;
@useResult
$Res call({
 int? ttl, int? tag, int? correlationId, Map<String, dynamic>? tvf, String? publishMethod
});




}
/// @nodoc
class _$PublishOptionsCopyWithImpl<$Res>
    implements $PublishOptionsCopyWith<$Res> {
  _$PublishOptionsCopyWithImpl(this._self, this._then);

  final PublishOptions _self;
  final $Res Function(PublishOptions) _then;

/// Create a copy of PublishOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ttl = freezed,Object? tag = freezed,Object? correlationId = freezed,Object? tvf = freezed,Object? publishMethod = freezed,}) {
  return _then(_self.copyWith(
ttl: freezed == ttl ? _self.ttl : ttl // ignore: cast_nullable_to_non_nullable
as int?,tag: freezed == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as int?,correlationId: freezed == correlationId ? _self.correlationId : correlationId // ignore: cast_nullable_to_non_nullable
as int?,tvf: freezed == tvf ? _self.tvf : tvf // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,publishMethod: freezed == publishMethod ? _self.publishMethod : publishMethod // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PublishOptions].
extension PublishOptionsPatterns on PublishOptions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PublishOptions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PublishOptions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PublishOptions value)  $default,){
final _that = this;
switch (_that) {
case _PublishOptions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PublishOptions value)?  $default,){
final _that = this;
switch (_that) {
case _PublishOptions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? ttl,  int? tag,  int? correlationId,  Map<String, dynamic>? tvf,  String? publishMethod)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PublishOptions() when $default != null:
return $default(_that.ttl,_that.tag,_that.correlationId,_that.tvf,_that.publishMethod);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? ttl,  int? tag,  int? correlationId,  Map<String, dynamic>? tvf,  String? publishMethod)  $default,) {final _that = this;
switch (_that) {
case _PublishOptions():
return $default(_that.ttl,_that.tag,_that.correlationId,_that.tvf,_that.publishMethod);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? ttl,  int? tag,  int? correlationId,  Map<String, dynamic>? tvf,  String? publishMethod)?  $default,) {final _that = this;
switch (_that) {
case _PublishOptions() when $default != null:
return $default(_that.ttl,_that.tag,_that.correlationId,_that.tvf,_that.publishMethod);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _PublishOptions implements PublishOptions {
  const _PublishOptions({this.ttl, this.tag, this.correlationId, final  Map<String, dynamic>? tvf, this.publishMethod}): _tvf = tvf;
  factory _PublishOptions.fromJson(Map<String, dynamic> json) => _$PublishOptionsFromJson(json);

@override final  int? ttl;
@override final  int? tag;
@override final  int? correlationId;
 final  Map<String, dynamic>? _tvf;
@override Map<String, dynamic>? get tvf {
  final value = _tvf;
  if (value == null) return null;
  if (_tvf is EqualUnmodifiableMapView) return _tvf;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? publishMethod;

/// Create a copy of PublishOptions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PublishOptionsCopyWith<_PublishOptions> get copyWith => __$PublishOptionsCopyWithImpl<_PublishOptions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PublishOptionsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PublishOptions&&(identical(other.ttl, ttl) || other.ttl == ttl)&&(identical(other.tag, tag) || other.tag == tag)&&(identical(other.correlationId, correlationId) || other.correlationId == correlationId)&&const DeepCollectionEquality().equals(other._tvf, _tvf)&&(identical(other.publishMethod, publishMethod) || other.publishMethod == publishMethod));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,ttl,tag,correlationId,const DeepCollectionEquality().hash(_tvf),publishMethod);

@override
String toString() {
  return 'PublishOptions(ttl: $ttl, tag: $tag, correlationId: $correlationId, tvf: $tvf, publishMethod: $publishMethod)';
}


}

/// @nodoc
abstract mixin class _$PublishOptionsCopyWith<$Res> implements $PublishOptionsCopyWith<$Res> {
  factory _$PublishOptionsCopyWith(_PublishOptions value, $Res Function(_PublishOptions) _then) = __$PublishOptionsCopyWithImpl;
@override @useResult
$Res call({
 int? ttl, int? tag, int? correlationId, Map<String, dynamic>? tvf, String? publishMethod
});




}
/// @nodoc
class __$PublishOptionsCopyWithImpl<$Res>
    implements _$PublishOptionsCopyWith<$Res> {
  __$PublishOptionsCopyWithImpl(this._self, this._then);

  final _PublishOptions _self;
  final $Res Function(_PublishOptions) _then;

/// Create a copy of PublishOptions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ttl = freezed,Object? tag = freezed,Object? correlationId = freezed,Object? tvf = freezed,Object? publishMethod = freezed,}) {
  return _then(_PublishOptions(
ttl: freezed == ttl ? _self.ttl : ttl // ignore: cast_nullable_to_non_nullable
as int?,tag: freezed == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as int?,correlationId: freezed == correlationId ? _self.correlationId : correlationId // ignore: cast_nullable_to_non_nullable
as int?,tvf: freezed == tvf ? _self._tvf : tvf // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,publishMethod: freezed == publishMethod ? _self.publishMethod : publishMethod // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SubscribeOptions {

 String get topic; TransportType get transportType; bool get skipSubscribe;
/// Create a copy of SubscribeOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscribeOptionsCopyWith<SubscribeOptions> get copyWith => _$SubscribeOptionsCopyWithImpl<SubscribeOptions>(this as SubscribeOptions, _$identity);

  /// Serializes this SubscribeOptions to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscribeOptions&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.transportType, transportType) || other.transportType == transportType)&&(identical(other.skipSubscribe, skipSubscribe) || other.skipSubscribe == skipSubscribe));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,topic,transportType,skipSubscribe);

@override
String toString() {
  return 'SubscribeOptions(topic: $topic, transportType: $transportType, skipSubscribe: $skipSubscribe)';
}


}

/// @nodoc
abstract mixin class $SubscribeOptionsCopyWith<$Res>  {
  factory $SubscribeOptionsCopyWith(SubscribeOptions value, $Res Function(SubscribeOptions) _then) = _$SubscribeOptionsCopyWithImpl;
@useResult
$Res call({
 String topic, TransportType transportType, bool skipSubscribe
});




}
/// @nodoc
class _$SubscribeOptionsCopyWithImpl<$Res>
    implements $SubscribeOptionsCopyWith<$Res> {
  _$SubscribeOptionsCopyWithImpl(this._self, this._then);

  final SubscribeOptions _self;
  final $Res Function(SubscribeOptions) _then;

/// Create a copy of SubscribeOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? topic = null,Object? transportType = null,Object? skipSubscribe = null,}) {
  return _then(_self.copyWith(
topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,transportType: null == transportType ? _self.transportType : transportType // ignore: cast_nullable_to_non_nullable
as TransportType,skipSubscribe: null == skipSubscribe ? _self.skipSubscribe : skipSubscribe // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SubscribeOptions].
extension SubscribeOptionsPatterns on SubscribeOptions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscribeOptions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscribeOptions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscribeOptions value)  $default,){
final _that = this;
switch (_that) {
case _SubscribeOptions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscribeOptions value)?  $default,){
final _that = this;
switch (_that) {
case _SubscribeOptions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String topic,  TransportType transportType,  bool skipSubscribe)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscribeOptions() when $default != null:
return $default(_that.topic,_that.transportType,_that.skipSubscribe);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String topic,  TransportType transportType,  bool skipSubscribe)  $default,) {final _that = this;
switch (_that) {
case _SubscribeOptions():
return $default(_that.topic,_that.transportType,_that.skipSubscribe);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String topic,  TransportType transportType,  bool skipSubscribe)?  $default,) {final _that = this;
switch (_that) {
case _SubscribeOptions() when $default != null:
return $default(_that.topic,_that.transportType,_that.skipSubscribe);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _SubscribeOptions implements SubscribeOptions {
  const _SubscribeOptions({required this.topic, this.transportType = TransportType.relay, this.skipSubscribe = false});
  factory _SubscribeOptions.fromJson(Map<String, dynamic> json) => _$SubscribeOptionsFromJson(json);

@override final  String topic;
@override@JsonKey() final  TransportType transportType;
@override@JsonKey() final  bool skipSubscribe;

/// Create a copy of SubscribeOptions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscribeOptionsCopyWith<_SubscribeOptions> get copyWith => __$SubscribeOptionsCopyWithImpl<_SubscribeOptions>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscribeOptionsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscribeOptions&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.transportType, transportType) || other.transportType == transportType)&&(identical(other.skipSubscribe, skipSubscribe) || other.skipSubscribe == skipSubscribe));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,topic,transportType,skipSubscribe);

@override
String toString() {
  return 'SubscribeOptions(topic: $topic, transportType: $transportType, skipSubscribe: $skipSubscribe)';
}


}

/// @nodoc
abstract mixin class _$SubscribeOptionsCopyWith<$Res> implements $SubscribeOptionsCopyWith<$Res> {
  factory _$SubscribeOptionsCopyWith(_SubscribeOptions value, $Res Function(_SubscribeOptions) _then) = __$SubscribeOptionsCopyWithImpl;
@override @useResult
$Res call({
 String topic, TransportType transportType, bool skipSubscribe
});




}
/// @nodoc
class __$SubscribeOptionsCopyWithImpl<$Res>
    implements _$SubscribeOptionsCopyWith<$Res> {
  __$SubscribeOptionsCopyWithImpl(this._self, this._then);

  final _SubscribeOptions _self;
  final $Res Function(_SubscribeOptions) _then;

/// Create a copy of SubscribeOptions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? topic = null,Object? transportType = null,Object? skipSubscribe = null,}) {
  return _then(_SubscribeOptions(
topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String,transportType: null == transportType ? _self.transportType : transportType // ignore: cast_nullable_to_non_nullable
as TransportType,skipSubscribe: null == skipSubscribe ? _self.skipSubscribe : skipSubscribe // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
