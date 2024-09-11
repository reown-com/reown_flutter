// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'json_rpc_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RpcOptions {
  int get ttl => throw _privateConstructorUsedError;
  bool get prompt => throw _privateConstructorUsedError;
  int get tag => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RpcOptionsCopyWith<RpcOptions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RpcOptionsCopyWith<$Res> {
  factory $RpcOptionsCopyWith(
          RpcOptions value, $Res Function(RpcOptions) then) =
      _$RpcOptionsCopyWithImpl<$Res, RpcOptions>;
  @useResult
  $Res call({int ttl, bool prompt, int tag});
}

/// @nodoc
class _$RpcOptionsCopyWithImpl<$Res, $Val extends RpcOptions>
    implements $RpcOptionsCopyWith<$Res> {
  _$RpcOptionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ttl = null,
    Object? prompt = null,
    Object? tag = null,
  }) {
    return _then(_value.copyWith(
      ttl: null == ttl
          ? _value.ttl
          : ttl // ignore: cast_nullable_to_non_nullable
              as int,
      prompt: null == prompt
          ? _value.prompt
          : prompt // ignore: cast_nullable_to_non_nullable
              as bool,
      tag: null == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RpcOptionsImplCopyWith<$Res>
    implements $RpcOptionsCopyWith<$Res> {
  factory _$$RpcOptionsImplCopyWith(
          _$RpcOptionsImpl value, $Res Function(_$RpcOptionsImpl) then) =
      __$$RpcOptionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int ttl, bool prompt, int tag});
}

/// @nodoc
class __$$RpcOptionsImplCopyWithImpl<$Res>
    extends _$RpcOptionsCopyWithImpl<$Res, _$RpcOptionsImpl>
    implements _$$RpcOptionsImplCopyWith<$Res> {
  __$$RpcOptionsImplCopyWithImpl(
      _$RpcOptionsImpl _value, $Res Function(_$RpcOptionsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ttl = null,
    Object? prompt = null,
    Object? tag = null,
  }) {
    return _then(_$RpcOptionsImpl(
      ttl: null == ttl
          ? _value.ttl
          : ttl // ignore: cast_nullable_to_non_nullable
              as int,
      prompt: null == prompt
          ? _value.prompt
          : prompt // ignore: cast_nullable_to_non_nullable
              as bool,
      tag: null == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$RpcOptionsImpl implements _RpcOptions {
  const _$RpcOptionsImpl(
      {required this.ttl, required this.prompt, required this.tag});

  @override
  final int ttl;
  @override
  final bool prompt;
  @override
  final int tag;

  @override
  String toString() {
    return 'RpcOptions(ttl: $ttl, prompt: $prompt, tag: $tag)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RpcOptionsImpl &&
            (identical(other.ttl, ttl) || other.ttl == ttl) &&
            (identical(other.prompt, prompt) || other.prompt == prompt) &&
            (identical(other.tag, tag) || other.tag == tag));
  }

  @override
  int get hashCode => Object.hash(runtimeType, ttl, prompt, tag);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RpcOptionsImplCopyWith<_$RpcOptionsImpl> get copyWith =>
      __$$RpcOptionsImplCopyWithImpl<_$RpcOptionsImpl>(this, _$identity);
}

abstract class _RpcOptions implements RpcOptions {
  const factory _RpcOptions(
      {required final int ttl,
      required final bool prompt,
      required final int tag}) = _$RpcOptionsImpl;

  @override
  int get ttl;
  @override
  bool get prompt;
  @override
  int get tag;
  @override
  @JsonKey(ignore: true)
  _$$RpcOptionsImplCopyWith<_$RpcOptionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

JsonRpcError _$JsonRpcErrorFromJson(Map<String, dynamic> json) {
  return _JsonRpcError.fromJson(json);
}

/// @nodoc
mixin _$JsonRpcError {
  int? get code => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JsonRpcErrorCopyWith<JsonRpcError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JsonRpcErrorCopyWith<$Res> {
  factory $JsonRpcErrorCopyWith(
          JsonRpcError value, $Res Function(JsonRpcError) then) =
      _$JsonRpcErrorCopyWithImpl<$Res, JsonRpcError>;
  @useResult
  $Res call({int? code, String? message});
}

/// @nodoc
class _$JsonRpcErrorCopyWithImpl<$Res, $Val extends JsonRpcError>
    implements $JsonRpcErrorCopyWith<$Res> {
  _$JsonRpcErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$JsonRpcErrorImplCopyWith<$Res>
    implements $JsonRpcErrorCopyWith<$Res> {
  factory _$$JsonRpcErrorImplCopyWith(
          _$JsonRpcErrorImpl value, $Res Function(_$JsonRpcErrorImpl) then) =
      __$$JsonRpcErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? code, String? message});
}

/// @nodoc
class __$$JsonRpcErrorImplCopyWithImpl<$Res>
    extends _$JsonRpcErrorCopyWithImpl<$Res, _$JsonRpcErrorImpl>
    implements _$$JsonRpcErrorImplCopyWith<$Res> {
  __$$JsonRpcErrorImplCopyWithImpl(
      _$JsonRpcErrorImpl _value, $Res Function(_$JsonRpcErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
  }) {
    return _then(_$JsonRpcErrorImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$JsonRpcErrorImpl implements _JsonRpcError {
  const _$JsonRpcErrorImpl({this.code, this.message});

  factory _$JsonRpcErrorImpl.fromJson(Map<String, dynamic> json) =>
      _$$JsonRpcErrorImplFromJson(json);

  @override
  final int? code;
  @override
  final String? message;

  @override
  String toString() {
    return 'JsonRpcError(code: $code, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JsonRpcErrorImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JsonRpcErrorImplCopyWith<_$JsonRpcErrorImpl> get copyWith =>
      __$$JsonRpcErrorImplCopyWithImpl<_$JsonRpcErrorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JsonRpcErrorImplToJson(
      this,
    );
  }
}

abstract class _JsonRpcError implements JsonRpcError {
  const factory _JsonRpcError({final int? code, final String? message}) =
      _$JsonRpcErrorImpl;

  factory _JsonRpcError.fromJson(Map<String, dynamic> json) =
      _$JsonRpcErrorImpl.fromJson;

  @override
  int? get code;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$JsonRpcErrorImplCopyWith<_$JsonRpcErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

JsonRpcRequest _$JsonRpcRequestFromJson(Map<String, dynamic> json) {
  return _JsonRpcRequest.fromJson(json);
}

/// @nodoc
mixin _$JsonRpcRequest {
  int get id => throw _privateConstructorUsedError;
  String get jsonrpc => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  dynamic get params => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JsonRpcRequestCopyWith<JsonRpcRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JsonRpcRequestCopyWith<$Res> {
  factory $JsonRpcRequestCopyWith(
          JsonRpcRequest value, $Res Function(JsonRpcRequest) then) =
      _$JsonRpcRequestCopyWithImpl<$Res, JsonRpcRequest>;
  @useResult
  $Res call({int id, String jsonrpc, String method, dynamic params});
}

/// @nodoc
class _$JsonRpcRequestCopyWithImpl<$Res, $Val extends JsonRpcRequest>
    implements $JsonRpcRequestCopyWith<$Res> {
  _$JsonRpcRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? jsonrpc = null,
    Object? method = null,
    Object? params = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      jsonrpc: null == jsonrpc
          ? _value.jsonrpc
          : jsonrpc // ignore: cast_nullable_to_non_nullable
              as String,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      params: freezed == params
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$JsonRpcRequestImplCopyWith<$Res>
    implements $JsonRpcRequestCopyWith<$Res> {
  factory _$$JsonRpcRequestImplCopyWith(_$JsonRpcRequestImpl value,
          $Res Function(_$JsonRpcRequestImpl) then) =
      __$$JsonRpcRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String jsonrpc, String method, dynamic params});
}

/// @nodoc
class __$$JsonRpcRequestImplCopyWithImpl<$Res>
    extends _$JsonRpcRequestCopyWithImpl<$Res, _$JsonRpcRequestImpl>
    implements _$$JsonRpcRequestImplCopyWith<$Res> {
  __$$JsonRpcRequestImplCopyWithImpl(
      _$JsonRpcRequestImpl _value, $Res Function(_$JsonRpcRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? jsonrpc = null,
    Object? method = null,
    Object? params = freezed,
  }) {
    return _then(_$JsonRpcRequestImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      jsonrpc: null == jsonrpc
          ? _value.jsonrpc
          : jsonrpc // ignore: cast_nullable_to_non_nullable
              as String,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      params: freezed == params
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$JsonRpcRequestImpl implements _JsonRpcRequest {
  const _$JsonRpcRequestImpl(
      {required this.id,
      this.jsonrpc = '2.0',
      required this.method,
      this.params});

  factory _$JsonRpcRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$JsonRpcRequestImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String jsonrpc;
  @override
  final String method;
  @override
  final dynamic params;

  @override
  String toString() {
    return 'JsonRpcRequest(id: $id, jsonrpc: $jsonrpc, method: $method, params: $params)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JsonRpcRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.jsonrpc, jsonrpc) || other.jsonrpc == jsonrpc) &&
            (identical(other.method, method) || other.method == method) &&
            const DeepCollectionEquality().equals(other.params, params));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, jsonrpc, method,
      const DeepCollectionEquality().hash(params));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JsonRpcRequestImplCopyWith<_$JsonRpcRequestImpl> get copyWith =>
      __$$JsonRpcRequestImplCopyWithImpl<_$JsonRpcRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JsonRpcRequestImplToJson(
      this,
    );
  }
}

abstract class _JsonRpcRequest implements JsonRpcRequest {
  const factory _JsonRpcRequest(
      {required final int id,
      final String jsonrpc,
      required final String method,
      final dynamic params}) = _$JsonRpcRequestImpl;

  factory _JsonRpcRequest.fromJson(Map<String, dynamic> json) =
      _$JsonRpcRequestImpl.fromJson;

  @override
  int get id;
  @override
  String get jsonrpc;
  @override
  String get method;
  @override
  dynamic get params;
  @override
  @JsonKey(ignore: true)
  _$$JsonRpcRequestImplCopyWith<_$JsonRpcRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

JsonRpcResponse<T> _$JsonRpcResponseFromJson<T>(
    Map<String, dynamic> json, T Function(Object?) fromJsonT) {
  return _JsonRpcResponse<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$JsonRpcResponse<T> {
  int get id => throw _privateConstructorUsedError;
  String get jsonrpc => throw _privateConstructorUsedError;
  JsonRpcError? get error => throw _privateConstructorUsedError;
  T? get result => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JsonRpcResponseCopyWith<T, JsonRpcResponse<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JsonRpcResponseCopyWith<T, $Res> {
  factory $JsonRpcResponseCopyWith(
          JsonRpcResponse<T> value, $Res Function(JsonRpcResponse<T>) then) =
      _$JsonRpcResponseCopyWithImpl<T, $Res, JsonRpcResponse<T>>;
  @useResult
  $Res call({int id, String jsonrpc, JsonRpcError? error, T? result});

  $JsonRpcErrorCopyWith<$Res>? get error;
}

/// @nodoc
class _$JsonRpcResponseCopyWithImpl<T, $Res, $Val extends JsonRpcResponse<T>>
    implements $JsonRpcResponseCopyWith<T, $Res> {
  _$JsonRpcResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? jsonrpc = null,
    Object? error = freezed,
    Object? result = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      jsonrpc: null == jsonrpc
          ? _value.jsonrpc
          : jsonrpc // ignore: cast_nullable_to_non_nullable
              as String,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as JsonRpcError?,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as T?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $JsonRpcErrorCopyWith<$Res>? get error {
    if (_value.error == null) {
      return null;
    }

    return $JsonRpcErrorCopyWith<$Res>(_value.error!, (value) {
      return _then(_value.copyWith(error: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$JsonRpcResponseImplCopyWith<T, $Res>
    implements $JsonRpcResponseCopyWith<T, $Res> {
  factory _$$JsonRpcResponseImplCopyWith(_$JsonRpcResponseImpl<T> value,
          $Res Function(_$JsonRpcResponseImpl<T>) then) =
      __$$JsonRpcResponseImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({int id, String jsonrpc, JsonRpcError? error, T? result});

  @override
  $JsonRpcErrorCopyWith<$Res>? get error;
}

/// @nodoc
class __$$JsonRpcResponseImplCopyWithImpl<T, $Res>
    extends _$JsonRpcResponseCopyWithImpl<T, $Res, _$JsonRpcResponseImpl<T>>
    implements _$$JsonRpcResponseImplCopyWith<T, $Res> {
  __$$JsonRpcResponseImplCopyWithImpl(_$JsonRpcResponseImpl<T> _value,
      $Res Function(_$JsonRpcResponseImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? jsonrpc = null,
    Object? error = freezed,
    Object? result = freezed,
  }) {
    return _then(_$JsonRpcResponseImpl<T>(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      jsonrpc: null == jsonrpc
          ? _value.jsonrpc
          : jsonrpc // ignore: cast_nullable_to_non_nullable
              as String,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as JsonRpcError?,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as T?,
    ));
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$JsonRpcResponseImpl<T> implements _JsonRpcResponse<T> {
  const _$JsonRpcResponseImpl(
      {required this.id, this.jsonrpc = '2.0', this.error, this.result});

  factory _$JsonRpcResponseImpl.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$$JsonRpcResponseImplFromJson(json, fromJsonT);

  @override
  final int id;
  @override
  @JsonKey()
  final String jsonrpc;
  @override
  final JsonRpcError? error;
  @override
  final T? result;

  @override
  String toString() {
    return 'JsonRpcResponse<$T>(id: $id, jsonrpc: $jsonrpc, error: $error, result: $result)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JsonRpcResponseImpl<T> &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.jsonrpc, jsonrpc) || other.jsonrpc == jsonrpc) &&
            (identical(other.error, error) || other.error == error) &&
            const DeepCollectionEquality().equals(other.result, result));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, jsonrpc, error,
      const DeepCollectionEquality().hash(result));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JsonRpcResponseImplCopyWith<T, _$JsonRpcResponseImpl<T>> get copyWith =>
      __$$JsonRpcResponseImplCopyWithImpl<T, _$JsonRpcResponseImpl<T>>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$JsonRpcResponseImplToJson<T>(this, toJsonT);
  }
}

abstract class _JsonRpcResponse<T> implements JsonRpcResponse<T> {
  const factory _JsonRpcResponse(
      {required final int id,
      final String jsonrpc,
      final JsonRpcError? error,
      final T? result}) = _$JsonRpcResponseImpl<T>;

  factory _JsonRpcResponse.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =
      _$JsonRpcResponseImpl<T>.fromJson;

  @override
  int get id;
  @override
  String get jsonrpc;
  @override
  JsonRpcError? get error;
  @override
  T? get result;
  @override
  @JsonKey(ignore: true)
  _$$JsonRpcResponseImplCopyWith<T, _$JsonRpcResponseImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
