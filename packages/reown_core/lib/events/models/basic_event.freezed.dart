// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'basic_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CoreEventProperties {

 String? get message; String? get name; String? get method; bool? get connected; String? get network; String? get explorer_id; String? get provider; String? get platform; List<String>? get trace; String? get topic; int? get correlation_id; String? get client_id; String? get direction; String? get userAgent; String? get sendToken; String? get sendAmount; String? get address; String? get project_id; String? get cursor;
/// Create a copy of CoreEventProperties
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoreEventPropertiesCopyWith<CoreEventProperties> get copyWith => _$CoreEventPropertiesCopyWithImpl<CoreEventProperties>(this as CoreEventProperties, _$identity);

  /// Serializes this CoreEventProperties to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoreEventProperties&&(identical(other.message, message) || other.message == message)&&(identical(other.name, name) || other.name == name)&&(identical(other.method, method) || other.method == method)&&(identical(other.connected, connected) || other.connected == connected)&&(identical(other.network, network) || other.network == network)&&(identical(other.explorer_id, explorer_id) || other.explorer_id == explorer_id)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.platform, platform) || other.platform == platform)&&const DeepCollectionEquality().equals(other.trace, trace)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.correlation_id, correlation_id) || other.correlation_id == correlation_id)&&(identical(other.client_id, client_id) || other.client_id == client_id)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.userAgent, userAgent) || other.userAgent == userAgent)&&(identical(other.sendToken, sendToken) || other.sendToken == sendToken)&&(identical(other.sendAmount, sendAmount) || other.sendAmount == sendAmount)&&(identical(other.address, address) || other.address == address)&&(identical(other.project_id, project_id) || other.project_id == project_id)&&(identical(other.cursor, cursor) || other.cursor == cursor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,message,name,method,connected,network,explorer_id,provider,platform,const DeepCollectionEquality().hash(trace),topic,correlation_id,client_id,direction,userAgent,sendToken,sendAmount,address,project_id,cursor]);

@override
String toString() {
  return 'CoreEventProperties(message: $message, name: $name, method: $method, connected: $connected, network: $network, explorer_id: $explorer_id, provider: $provider, platform: $platform, trace: $trace, topic: $topic, correlation_id: $correlation_id, client_id: $client_id, direction: $direction, userAgent: $userAgent, sendToken: $sendToken, sendAmount: $sendAmount, address: $address, project_id: $project_id, cursor: $cursor)';
}


}

/// @nodoc
abstract mixin class $CoreEventPropertiesCopyWith<$Res>  {
  factory $CoreEventPropertiesCopyWith(CoreEventProperties value, $Res Function(CoreEventProperties) _then) = _$CoreEventPropertiesCopyWithImpl;
@useResult
$Res call({
 String? message, String? name, String? method, bool? connected, String? network, String? explorer_id, String? provider, String? platform, List<String>? trace, String? topic, int? correlation_id, String? client_id, String? direction, String? userAgent, String? sendToken, String? sendAmount, String? address, String? project_id, String? cursor
});




}
/// @nodoc
class _$CoreEventPropertiesCopyWithImpl<$Res>
    implements $CoreEventPropertiesCopyWith<$Res> {
  _$CoreEventPropertiesCopyWithImpl(this._self, this._then);

  final CoreEventProperties _self;
  final $Res Function(CoreEventProperties) _then;

/// Create a copy of CoreEventProperties
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = freezed,Object? name = freezed,Object? method = freezed,Object? connected = freezed,Object? network = freezed,Object? explorer_id = freezed,Object? provider = freezed,Object? platform = freezed,Object? trace = freezed,Object? topic = freezed,Object? correlation_id = freezed,Object? client_id = freezed,Object? direction = freezed,Object? userAgent = freezed,Object? sendToken = freezed,Object? sendAmount = freezed,Object? address = freezed,Object? project_id = freezed,Object? cursor = freezed,}) {
  return _then(_self.copyWith(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,method: freezed == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String?,connected: freezed == connected ? _self.connected : connected // ignore: cast_nullable_to_non_nullable
as bool?,network: freezed == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String?,explorer_id: freezed == explorer_id ? _self.explorer_id : explorer_id // ignore: cast_nullable_to_non_nullable
as String?,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String?,platform: freezed == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String?,trace: freezed == trace ? _self.trace : trace // ignore: cast_nullable_to_non_nullable
as List<String>?,topic: freezed == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String?,correlation_id: freezed == correlation_id ? _self.correlation_id : correlation_id // ignore: cast_nullable_to_non_nullable
as int?,client_id: freezed == client_id ? _self.client_id : client_id // ignore: cast_nullable_to_non_nullable
as String?,direction: freezed == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String?,userAgent: freezed == userAgent ? _self.userAgent : userAgent // ignore: cast_nullable_to_non_nullable
as String?,sendToken: freezed == sendToken ? _self.sendToken : sendToken // ignore: cast_nullable_to_non_nullable
as String?,sendAmount: freezed == sendAmount ? _self.sendAmount : sendAmount // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,project_id: freezed == project_id ? _self.project_id : project_id // ignore: cast_nullable_to_non_nullable
as String?,cursor: freezed == cursor ? _self.cursor : cursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CoreEventProperties].
extension CoreEventPropertiesPatterns on CoreEventProperties {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CoreEventProperties value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CoreEventProperties() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CoreEventProperties value)  $default,){
final _that = this;
switch (_that) {
case _CoreEventProperties():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CoreEventProperties value)?  $default,){
final _that = this;
switch (_that) {
case _CoreEventProperties() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? message,  String? name,  String? method,  bool? connected,  String? network,  String? explorer_id,  String? provider,  String? platform,  List<String>? trace,  String? topic,  int? correlation_id,  String? client_id,  String? direction,  String? userAgent,  String? sendToken,  String? sendAmount,  String? address,  String? project_id,  String? cursor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CoreEventProperties() when $default != null:
return $default(_that.message,_that.name,_that.method,_that.connected,_that.network,_that.explorer_id,_that.provider,_that.platform,_that.trace,_that.topic,_that.correlation_id,_that.client_id,_that.direction,_that.userAgent,_that.sendToken,_that.sendAmount,_that.address,_that.project_id,_that.cursor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? message,  String? name,  String? method,  bool? connected,  String? network,  String? explorer_id,  String? provider,  String? platform,  List<String>? trace,  String? topic,  int? correlation_id,  String? client_id,  String? direction,  String? userAgent,  String? sendToken,  String? sendAmount,  String? address,  String? project_id,  String? cursor)  $default,) {final _that = this;
switch (_that) {
case _CoreEventProperties():
return $default(_that.message,_that.name,_that.method,_that.connected,_that.network,_that.explorer_id,_that.provider,_that.platform,_that.trace,_that.topic,_that.correlation_id,_that.client_id,_that.direction,_that.userAgent,_that.sendToken,_that.sendAmount,_that.address,_that.project_id,_that.cursor);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? message,  String? name,  String? method,  bool? connected,  String? network,  String? explorer_id,  String? provider,  String? platform,  List<String>? trace,  String? topic,  int? correlation_id,  String? client_id,  String? direction,  String? userAgent,  String? sendToken,  String? sendAmount,  String? address,  String? project_id,  String? cursor)?  $default,) {final _that = this;
switch (_that) {
case _CoreEventProperties() when $default != null:
return $default(_that.message,_that.name,_that.method,_that.connected,_that.network,_that.explorer_id,_that.provider,_that.platform,_that.trace,_that.topic,_that.correlation_id,_that.client_id,_that.direction,_that.userAgent,_that.sendToken,_that.sendAmount,_that.address,_that.project_id,_that.cursor);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _CoreEventProperties implements CoreEventProperties {
  const _CoreEventProperties({this.message, this.name, this.method, this.connected, this.network, this.explorer_id, this.provider, this.platform, final  List<String>? trace, this.topic, this.correlation_id, this.client_id, this.direction, this.userAgent, this.sendToken, this.sendAmount, this.address, this.project_id, this.cursor}): _trace = trace;
  factory _CoreEventProperties.fromJson(Map<String, dynamic> json) => _$CoreEventPropertiesFromJson(json);

@override final  String? message;
@override final  String? name;
@override final  String? method;
@override final  bool? connected;
@override final  String? network;
@override final  String? explorer_id;
@override final  String? provider;
@override final  String? platform;
 final  List<String>? _trace;
@override List<String>? get trace {
  final value = _trace;
  if (value == null) return null;
  if (_trace is EqualUnmodifiableListView) return _trace;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? topic;
@override final  int? correlation_id;
@override final  String? client_id;
@override final  String? direction;
@override final  String? userAgent;
@override final  String? sendToken;
@override final  String? sendAmount;
@override final  String? address;
@override final  String? project_id;
@override final  String? cursor;

/// Create a copy of CoreEventProperties
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CoreEventPropertiesCopyWith<_CoreEventProperties> get copyWith => __$CoreEventPropertiesCopyWithImpl<_CoreEventProperties>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CoreEventPropertiesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CoreEventProperties&&(identical(other.message, message) || other.message == message)&&(identical(other.name, name) || other.name == name)&&(identical(other.method, method) || other.method == method)&&(identical(other.connected, connected) || other.connected == connected)&&(identical(other.network, network) || other.network == network)&&(identical(other.explorer_id, explorer_id) || other.explorer_id == explorer_id)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.platform, platform) || other.platform == platform)&&const DeepCollectionEquality().equals(other._trace, _trace)&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.correlation_id, correlation_id) || other.correlation_id == correlation_id)&&(identical(other.client_id, client_id) || other.client_id == client_id)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.userAgent, userAgent) || other.userAgent == userAgent)&&(identical(other.sendToken, sendToken) || other.sendToken == sendToken)&&(identical(other.sendAmount, sendAmount) || other.sendAmount == sendAmount)&&(identical(other.address, address) || other.address == address)&&(identical(other.project_id, project_id) || other.project_id == project_id)&&(identical(other.cursor, cursor) || other.cursor == cursor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,message,name,method,connected,network,explorer_id,provider,platform,const DeepCollectionEquality().hash(_trace),topic,correlation_id,client_id,direction,userAgent,sendToken,sendAmount,address,project_id,cursor]);

@override
String toString() {
  return 'CoreEventProperties(message: $message, name: $name, method: $method, connected: $connected, network: $network, explorer_id: $explorer_id, provider: $provider, platform: $platform, trace: $trace, topic: $topic, correlation_id: $correlation_id, client_id: $client_id, direction: $direction, userAgent: $userAgent, sendToken: $sendToken, sendAmount: $sendAmount, address: $address, project_id: $project_id, cursor: $cursor)';
}


}

/// @nodoc
abstract mixin class _$CoreEventPropertiesCopyWith<$Res> implements $CoreEventPropertiesCopyWith<$Res> {
  factory _$CoreEventPropertiesCopyWith(_CoreEventProperties value, $Res Function(_CoreEventProperties) _then) = __$CoreEventPropertiesCopyWithImpl;
@override @useResult
$Res call({
 String? message, String? name, String? method, bool? connected, String? network, String? explorer_id, String? provider, String? platform, List<String>? trace, String? topic, int? correlation_id, String? client_id, String? direction, String? userAgent, String? sendToken, String? sendAmount, String? address, String? project_id, String? cursor
});




}
/// @nodoc
class __$CoreEventPropertiesCopyWithImpl<$Res>
    implements _$CoreEventPropertiesCopyWith<$Res> {
  __$CoreEventPropertiesCopyWithImpl(this._self, this._then);

  final _CoreEventProperties _self;
  final $Res Function(_CoreEventProperties) _then;

/// Create a copy of CoreEventProperties
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = freezed,Object? name = freezed,Object? method = freezed,Object? connected = freezed,Object? network = freezed,Object? explorer_id = freezed,Object? provider = freezed,Object? platform = freezed,Object? trace = freezed,Object? topic = freezed,Object? correlation_id = freezed,Object? client_id = freezed,Object? direction = freezed,Object? userAgent = freezed,Object? sendToken = freezed,Object? sendAmount = freezed,Object? address = freezed,Object? project_id = freezed,Object? cursor = freezed,}) {
  return _then(_CoreEventProperties(
message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,method: freezed == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String?,connected: freezed == connected ? _self.connected : connected // ignore: cast_nullable_to_non_nullable
as bool?,network: freezed == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String?,explorer_id: freezed == explorer_id ? _self.explorer_id : explorer_id // ignore: cast_nullable_to_non_nullable
as String?,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String?,platform: freezed == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String?,trace: freezed == trace ? _self._trace : trace // ignore: cast_nullable_to_non_nullable
as List<String>?,topic: freezed == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as String?,correlation_id: freezed == correlation_id ? _self.correlation_id : correlation_id // ignore: cast_nullable_to_non_nullable
as int?,client_id: freezed == client_id ? _self.client_id : client_id // ignore: cast_nullable_to_non_nullable
as String?,direction: freezed == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as String?,userAgent: freezed == userAgent ? _self.userAgent : userAgent // ignore: cast_nullable_to_non_nullable
as String?,sendToken: freezed == sendToken ? _self.sendToken : sendToken // ignore: cast_nullable_to_non_nullable
as String?,sendAmount: freezed == sendAmount ? _self.sendAmount : sendAmount // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,project_id: freezed == project_id ? _self.project_id : project_id // ignore: cast_nullable_to_non_nullable
as String?,cursor: freezed == cursor ? _self.cursor : cursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
