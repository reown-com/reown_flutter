// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'json_rpc_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RpcOptions {

 int get ttl; bool get prompt; int get tag;
/// Create a copy of RpcOptions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RpcOptionsCopyWith<RpcOptions> get copyWith => _$RpcOptionsCopyWithImpl<RpcOptions>(this as RpcOptions, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RpcOptions&&(identical(other.ttl, ttl) || other.ttl == ttl)&&(identical(other.prompt, prompt) || other.prompt == prompt)&&(identical(other.tag, tag) || other.tag == tag));
}


@override
int get hashCode => Object.hash(runtimeType,ttl,prompt,tag);

@override
String toString() {
  return 'RpcOptions(ttl: $ttl, prompt: $prompt, tag: $tag)';
}


}

/// @nodoc
abstract mixin class $RpcOptionsCopyWith<$Res>  {
  factory $RpcOptionsCopyWith(RpcOptions value, $Res Function(RpcOptions) _then) = _$RpcOptionsCopyWithImpl;
@useResult
$Res call({
 int ttl, bool prompt, int tag
});




}
/// @nodoc
class _$RpcOptionsCopyWithImpl<$Res>
    implements $RpcOptionsCopyWith<$Res> {
  _$RpcOptionsCopyWithImpl(this._self, this._then);

  final RpcOptions _self;
  final $Res Function(RpcOptions) _then;

/// Create a copy of RpcOptions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ttl = null,Object? prompt = null,Object? tag = null,}) {
  return _then(_self.copyWith(
ttl: null == ttl ? _self.ttl : ttl // ignore: cast_nullable_to_non_nullable
as int,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as bool,tag: null == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [RpcOptions].
extension RpcOptionsPatterns on RpcOptions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RpcOptions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RpcOptions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RpcOptions value)  $default,){
final _that = this;
switch (_that) {
case _RpcOptions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RpcOptions value)?  $default,){
final _that = this;
switch (_that) {
case _RpcOptions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int ttl,  bool prompt,  int tag)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RpcOptions() when $default != null:
return $default(_that.ttl,_that.prompt,_that.tag);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int ttl,  bool prompt,  int tag)  $default,) {final _that = this;
switch (_that) {
case _RpcOptions():
return $default(_that.ttl,_that.prompt,_that.tag);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int ttl,  bool prompt,  int tag)?  $default,) {final _that = this;
switch (_that) {
case _RpcOptions() when $default != null:
return $default(_that.ttl,_that.prompt,_that.tag);case _:
  return null;

}
}

}

/// @nodoc


class _RpcOptions implements RpcOptions {
  const _RpcOptions({required this.ttl, required this.prompt, required this.tag});
  

@override final  int ttl;
@override final  bool prompt;
@override final  int tag;

/// Create a copy of RpcOptions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RpcOptionsCopyWith<_RpcOptions> get copyWith => __$RpcOptionsCopyWithImpl<_RpcOptions>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RpcOptions&&(identical(other.ttl, ttl) || other.ttl == ttl)&&(identical(other.prompt, prompt) || other.prompt == prompt)&&(identical(other.tag, tag) || other.tag == tag));
}


@override
int get hashCode => Object.hash(runtimeType,ttl,prompt,tag);

@override
String toString() {
  return 'RpcOptions(ttl: $ttl, prompt: $prompt, tag: $tag)';
}


}

/// @nodoc
abstract mixin class _$RpcOptionsCopyWith<$Res> implements $RpcOptionsCopyWith<$Res> {
  factory _$RpcOptionsCopyWith(_RpcOptions value, $Res Function(_RpcOptions) _then) = __$RpcOptionsCopyWithImpl;
@override @useResult
$Res call({
 int ttl, bool prompt, int tag
});




}
/// @nodoc
class __$RpcOptionsCopyWithImpl<$Res>
    implements _$RpcOptionsCopyWith<$Res> {
  __$RpcOptionsCopyWithImpl(this._self, this._then);

  final _RpcOptions _self;
  final $Res Function(_RpcOptions) _then;

/// Create a copy of RpcOptions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ttl = null,Object? prompt = null,Object? tag = null,}) {
  return _then(_RpcOptions(
ttl: null == ttl ? _self.ttl : ttl // ignore: cast_nullable_to_non_nullable
as int,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as bool,tag: null == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$JsonRpcError {

 int? get code; String? get message;
/// Create a copy of JsonRpcError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JsonRpcErrorCopyWith<JsonRpcError> get copyWith => _$JsonRpcErrorCopyWithImpl<JsonRpcError>(this as JsonRpcError, _$identity);

  /// Serializes this JsonRpcError to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JsonRpcError&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'JsonRpcError(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class $JsonRpcErrorCopyWith<$Res>  {
  factory $JsonRpcErrorCopyWith(JsonRpcError value, $Res Function(JsonRpcError) _then) = _$JsonRpcErrorCopyWithImpl;
@useResult
$Res call({
 int? code, String? message
});




}
/// @nodoc
class _$JsonRpcErrorCopyWithImpl<$Res>
    implements $JsonRpcErrorCopyWith<$Res> {
  _$JsonRpcErrorCopyWithImpl(this._self, this._then);

  final JsonRpcError _self;
  final $Res Function(JsonRpcError) _then;

/// Create a copy of JsonRpcError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = freezed,Object? message = freezed,}) {
  return _then(_self.copyWith(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [JsonRpcError].
extension JsonRpcErrorPatterns on JsonRpcError {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JsonRpcError value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JsonRpcError() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JsonRpcError value)  $default,){
final _that = this;
switch (_that) {
case _JsonRpcError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JsonRpcError value)?  $default,){
final _that = this;
switch (_that) {
case _JsonRpcError() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? code,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JsonRpcError() when $default != null:
return $default(_that.code,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? code,  String? message)  $default,) {final _that = this;
switch (_that) {
case _JsonRpcError():
return $default(_that.code,_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? code,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _JsonRpcError() when $default != null:
return $default(_that.code,_that.message);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _JsonRpcError implements JsonRpcError {
  const _JsonRpcError({this.code, this.message});
  factory _JsonRpcError.fromJson(Map<String, dynamic> json) => _$JsonRpcErrorFromJson(json);

@override final  int? code;
@override final  String? message;

/// Create a copy of JsonRpcError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JsonRpcErrorCopyWith<_JsonRpcError> get copyWith => __$JsonRpcErrorCopyWithImpl<_JsonRpcError>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JsonRpcErrorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JsonRpcError&&(identical(other.code, code) || other.code == code)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,code,message);

@override
String toString() {
  return 'JsonRpcError(code: $code, message: $message)';
}


}

/// @nodoc
abstract mixin class _$JsonRpcErrorCopyWith<$Res> implements $JsonRpcErrorCopyWith<$Res> {
  factory _$JsonRpcErrorCopyWith(_JsonRpcError value, $Res Function(_JsonRpcError) _then) = __$JsonRpcErrorCopyWithImpl;
@override @useResult
$Res call({
 int? code, String? message
});




}
/// @nodoc
class __$JsonRpcErrorCopyWithImpl<$Res>
    implements _$JsonRpcErrorCopyWith<$Res> {
  __$JsonRpcErrorCopyWithImpl(this._self, this._then);

  final _JsonRpcError _self;
  final $Res Function(_JsonRpcError) _then;

/// Create a copy of JsonRpcError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = freezed,Object? message = freezed,}) {
  return _then(_JsonRpcError(
code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$JsonRpcRequest {

 int get id; String get jsonrpc; String get method; dynamic get params;
/// Create a copy of JsonRpcRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JsonRpcRequestCopyWith<JsonRpcRequest> get copyWith => _$JsonRpcRequestCopyWithImpl<JsonRpcRequest>(this as JsonRpcRequest, _$identity);

  /// Serializes this JsonRpcRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JsonRpcRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.jsonrpc, jsonrpc) || other.jsonrpc == jsonrpc)&&(identical(other.method, method) || other.method == method)&&const DeepCollectionEquality().equals(other.params, params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,jsonrpc,method,const DeepCollectionEquality().hash(params));

@override
String toString() {
  return 'JsonRpcRequest(id: $id, jsonrpc: $jsonrpc, method: $method, params: $params)';
}


}

/// @nodoc
abstract mixin class $JsonRpcRequestCopyWith<$Res>  {
  factory $JsonRpcRequestCopyWith(JsonRpcRequest value, $Res Function(JsonRpcRequest) _then) = _$JsonRpcRequestCopyWithImpl;
@useResult
$Res call({
 int id, String jsonrpc, String method, dynamic params
});




}
/// @nodoc
class _$JsonRpcRequestCopyWithImpl<$Res>
    implements $JsonRpcRequestCopyWith<$Res> {
  _$JsonRpcRequestCopyWithImpl(this._self, this._then);

  final JsonRpcRequest _self;
  final $Res Function(JsonRpcRequest) _then;

/// Create a copy of JsonRpcRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? jsonrpc = null,Object? method = null,Object? params = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,jsonrpc: null == jsonrpc ? _self.jsonrpc : jsonrpc // ignore: cast_nullable_to_non_nullable
as String,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,params: freezed == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}

}


/// Adds pattern-matching-related methods to [JsonRpcRequest].
extension JsonRpcRequestPatterns on JsonRpcRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JsonRpcRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JsonRpcRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JsonRpcRequest value)  $default,){
final _that = this;
switch (_that) {
case _JsonRpcRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JsonRpcRequest value)?  $default,){
final _that = this;
switch (_that) {
case _JsonRpcRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String jsonrpc,  String method,  dynamic params)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JsonRpcRequest() when $default != null:
return $default(_that.id,_that.jsonrpc,_that.method,_that.params);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String jsonrpc,  String method,  dynamic params)  $default,) {final _that = this;
switch (_that) {
case _JsonRpcRequest():
return $default(_that.id,_that.jsonrpc,_that.method,_that.params);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String jsonrpc,  String method,  dynamic params)?  $default,) {final _that = this;
switch (_that) {
case _JsonRpcRequest() when $default != null:
return $default(_that.id,_that.jsonrpc,_that.method,_that.params);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable()
class _JsonRpcRequest implements JsonRpcRequest {
  const _JsonRpcRequest({required this.id, this.jsonrpc = '2.0', required this.method, this.params});
  factory _JsonRpcRequest.fromJson(Map<String, dynamic> json) => _$JsonRpcRequestFromJson(json);

@override final  int id;
@override@JsonKey() final  String jsonrpc;
@override final  String method;
@override final  dynamic params;

/// Create a copy of JsonRpcRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JsonRpcRequestCopyWith<_JsonRpcRequest> get copyWith => __$JsonRpcRequestCopyWithImpl<_JsonRpcRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JsonRpcRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JsonRpcRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.jsonrpc, jsonrpc) || other.jsonrpc == jsonrpc)&&(identical(other.method, method) || other.method == method)&&const DeepCollectionEquality().equals(other.params, params));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,jsonrpc,method,const DeepCollectionEquality().hash(params));

@override
String toString() {
  return 'JsonRpcRequest(id: $id, jsonrpc: $jsonrpc, method: $method, params: $params)';
}


}

/// @nodoc
abstract mixin class _$JsonRpcRequestCopyWith<$Res> implements $JsonRpcRequestCopyWith<$Res> {
  factory _$JsonRpcRequestCopyWith(_JsonRpcRequest value, $Res Function(_JsonRpcRequest) _then) = __$JsonRpcRequestCopyWithImpl;
@override @useResult
$Res call({
 int id, String jsonrpc, String method, dynamic params
});




}
/// @nodoc
class __$JsonRpcRequestCopyWithImpl<$Res>
    implements _$JsonRpcRequestCopyWith<$Res> {
  __$JsonRpcRequestCopyWithImpl(this._self, this._then);

  final _JsonRpcRequest _self;
  final $Res Function(_JsonRpcRequest) _then;

/// Create a copy of JsonRpcRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? jsonrpc = null,Object? method = null,Object? params = freezed,}) {
  return _then(_JsonRpcRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,jsonrpc: null == jsonrpc ? _self.jsonrpc : jsonrpc // ignore: cast_nullable_to_non_nullable
as String,method: null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,params: freezed == params ? _self.params : params // ignore: cast_nullable_to_non_nullable
as dynamic,
  ));
}


}


/// @nodoc
mixin _$JsonRpcResponse<T> {

 int get id; String get jsonrpc; JsonRpcError? get error; T? get result;
/// Create a copy of JsonRpcResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JsonRpcResponseCopyWith<T, JsonRpcResponse<T>> get copyWith => _$JsonRpcResponseCopyWithImpl<T, JsonRpcResponse<T>>(this as JsonRpcResponse<T>, _$identity);

  /// Serializes this JsonRpcResponse to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT);


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JsonRpcResponse<T>&&(identical(other.id, id) || other.id == id)&&(identical(other.jsonrpc, jsonrpc) || other.jsonrpc == jsonrpc)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other.result, result));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,jsonrpc,error,const DeepCollectionEquality().hash(result));

@override
String toString() {
  return 'JsonRpcResponse<$T>(id: $id, jsonrpc: $jsonrpc, error: $error, result: $result)';
}


}

/// @nodoc
abstract mixin class $JsonRpcResponseCopyWith<T,$Res>  {
  factory $JsonRpcResponseCopyWith(JsonRpcResponse<T> value, $Res Function(JsonRpcResponse<T>) _then) = _$JsonRpcResponseCopyWithImpl;
@useResult
$Res call({
 int id, String jsonrpc, JsonRpcError? error, T? result
});


$JsonRpcErrorCopyWith<$Res>? get error;

}
/// @nodoc
class _$JsonRpcResponseCopyWithImpl<T,$Res>
    implements $JsonRpcResponseCopyWith<T, $Res> {
  _$JsonRpcResponseCopyWithImpl(this._self, this._then);

  final JsonRpcResponse<T> _self;
  final $Res Function(JsonRpcResponse<T>) _then;

/// Create a copy of JsonRpcResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? jsonrpc = null,Object? error = freezed,Object? result = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,jsonrpc: null == jsonrpc ? _self.jsonrpc : jsonrpc // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as JsonRpcError?,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as T?,
  ));
}
/// Create a copy of JsonRpcResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JsonRpcErrorCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $JsonRpcErrorCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}


/// Adds pattern-matching-related methods to [JsonRpcResponse].
extension JsonRpcResponsePatterns<T> on JsonRpcResponse<T> {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JsonRpcResponse<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JsonRpcResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JsonRpcResponse<T> value)  $default,){
final _that = this;
switch (_that) {
case _JsonRpcResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JsonRpcResponse<T> value)?  $default,){
final _that = this;
switch (_that) {
case _JsonRpcResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String jsonrpc,  JsonRpcError? error,  T? result)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JsonRpcResponse() when $default != null:
return $default(_that.id,_that.jsonrpc,_that.error,_that.result);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String jsonrpc,  JsonRpcError? error,  T? result)  $default,) {final _that = this;
switch (_that) {
case _JsonRpcResponse():
return $default(_that.id,_that.jsonrpc,_that.error,_that.result);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String jsonrpc,  JsonRpcError? error,  T? result)?  $default,) {final _that = this;
switch (_that) {
case _JsonRpcResponse() when $default != null:
return $default(_that.id,_that.jsonrpc,_that.error,_that.result);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)

class _JsonRpcResponse<T> implements JsonRpcResponse<T> {
  const _JsonRpcResponse({required this.id, this.jsonrpc = '2.0', this.error, this.result});
  factory _JsonRpcResponse.fromJson(Map<String, dynamic> json,T Function(Object?) fromJsonT) => _$JsonRpcResponseFromJson(json,fromJsonT);

@override final  int id;
@override@JsonKey() final  String jsonrpc;
@override final  JsonRpcError? error;
@override final  T? result;

/// Create a copy of JsonRpcResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JsonRpcResponseCopyWith<T, _JsonRpcResponse<T>> get copyWith => __$JsonRpcResponseCopyWithImpl<T, _JsonRpcResponse<T>>(this, _$identity);

@override
Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
  return _$JsonRpcResponseToJson<T>(this, toJsonT);
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JsonRpcResponse<T>&&(identical(other.id, id) || other.id == id)&&(identical(other.jsonrpc, jsonrpc) || other.jsonrpc == jsonrpc)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other.result, result));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,jsonrpc,error,const DeepCollectionEquality().hash(result));

@override
String toString() {
  return 'JsonRpcResponse<$T>(id: $id, jsonrpc: $jsonrpc, error: $error, result: $result)';
}


}

/// @nodoc
abstract mixin class _$JsonRpcResponseCopyWith<T,$Res> implements $JsonRpcResponseCopyWith<T, $Res> {
  factory _$JsonRpcResponseCopyWith(_JsonRpcResponse<T> value, $Res Function(_JsonRpcResponse<T>) _then) = __$JsonRpcResponseCopyWithImpl;
@override @useResult
$Res call({
 int id, String jsonrpc, JsonRpcError? error, T? result
});


@override $JsonRpcErrorCopyWith<$Res>? get error;

}
/// @nodoc
class __$JsonRpcResponseCopyWithImpl<T,$Res>
    implements _$JsonRpcResponseCopyWith<T, $Res> {
  __$JsonRpcResponseCopyWithImpl(this._self, this._then);

  final _JsonRpcResponse<T> _self;
  final $Res Function(_JsonRpcResponse<T>) _then;

/// Create a copy of JsonRpcResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? jsonrpc = null,Object? error = freezed,Object? result = freezed,}) {
  return _then(_JsonRpcResponse<T>(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,jsonrpc: null == jsonrpc ? _self.jsonrpc : jsonrpc // ignore: cast_nullable_to_non_nullable
as String,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as JsonRpcError?,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as T?,
  ));
}

/// Create a copy of JsonRpcResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JsonRpcErrorCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $JsonRpcErrorCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}

// dart format on
