// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'basic_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReownCoreError _$ReownCoreErrorFromJson(Map<String, dynamic> json) {
  return _ReownCoreError.fromJson(json);
}

/// @nodoc
mixin _$ReownCoreError {
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String? get data => throw _privateConstructorUsedError;

  /// Serializes this ReownCoreError to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReownCoreError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReownCoreErrorCopyWith<ReownCoreError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReownCoreErrorCopyWith<$Res> {
  factory $ReownCoreErrorCopyWith(
          ReownCoreError value, $Res Function(ReownCoreError) then) =
      _$ReownCoreErrorCopyWithImpl<$Res, ReownCoreError>;
  @useResult
  $Res call({int code, String message, String? data});
}

/// @nodoc
class _$ReownCoreErrorCopyWithImpl<$Res, $Val extends ReownCoreError>
    implements $ReownCoreErrorCopyWith<$Res> {
  _$ReownCoreErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReownCoreError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReownCoreErrorImplCopyWith<$Res>
    implements $ReownCoreErrorCopyWith<$Res> {
  factory _$$ReownCoreErrorImplCopyWith(_$ReownCoreErrorImpl value,
          $Res Function(_$ReownCoreErrorImpl) then) =
      __$$ReownCoreErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int code, String message, String? data});
}

/// @nodoc
class __$$ReownCoreErrorImplCopyWithImpl<$Res>
    extends _$ReownCoreErrorCopyWithImpl<$Res, _$ReownCoreErrorImpl>
    implements _$$ReownCoreErrorImplCopyWith<$Res> {
  __$$ReownCoreErrorImplCopyWithImpl(
      _$ReownCoreErrorImpl _value, $Res Function(_$ReownCoreErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReownCoreError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_$ReownCoreErrorImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$ReownCoreErrorImpl implements _ReownCoreError {
  const _$ReownCoreErrorImpl(
      {required this.code, required this.message, this.data});

  factory _$ReownCoreErrorImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReownCoreErrorImplFromJson(json);

  @override
  final int code;
  @override
  final String message;
  @override
  final String? data;

  @override
  String toString() {
    return 'ReownCoreError(code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReownCoreErrorImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, code, message, data);

  /// Create a copy of ReownCoreError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReownCoreErrorImplCopyWith<_$ReownCoreErrorImpl> get copyWith =>
      __$$ReownCoreErrorImplCopyWithImpl<_$ReownCoreErrorImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReownCoreErrorImplToJson(
      this,
    );
  }
}

abstract class _ReownCoreError implements ReownCoreError {
  const factory _ReownCoreError(
      {required final int code,
      required final String message,
      final String? data}) = _$ReownCoreErrorImpl;

  factory _ReownCoreError.fromJson(Map<String, dynamic> json) =
      _$ReownCoreErrorImpl.fromJson;

  @override
  int get code;
  @override
  String get message;
  @override
  String? get data;

  /// Create a copy of ReownCoreError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReownCoreErrorImplCopyWith<_$ReownCoreErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PublishOptions _$PublishOptionsFromJson(Map<String, dynamic> json) {
  return _PublishOptions.fromJson(json);
}

/// @nodoc
mixin _$PublishOptions {
  int? get ttl => throw _privateConstructorUsedError;
  int? get tag => throw _privateConstructorUsedError;
  int? get correlationId => throw _privateConstructorUsedError;
  Map<String, dynamic>? get tvf => throw _privateConstructorUsedError;
  String? get publishMethod => throw _privateConstructorUsedError;

  /// Serializes this PublishOptions to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PublishOptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PublishOptionsCopyWith<PublishOptions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PublishOptionsCopyWith<$Res> {
  factory $PublishOptionsCopyWith(
          PublishOptions value, $Res Function(PublishOptions) then) =
      _$PublishOptionsCopyWithImpl<$Res, PublishOptions>;
  @useResult
  $Res call(
      {int? ttl,
      int? tag,
      int? correlationId,
      Map<String, dynamic>? tvf,
      String? publishMethod});
}

/// @nodoc
class _$PublishOptionsCopyWithImpl<$Res, $Val extends PublishOptions>
    implements $PublishOptionsCopyWith<$Res> {
  _$PublishOptionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PublishOptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ttl = freezed,
    Object? tag = freezed,
    Object? correlationId = freezed,
    Object? tvf = freezed,
    Object? publishMethod = freezed,
  }) {
    return _then(_value.copyWith(
      ttl: freezed == ttl
          ? _value.ttl
          : ttl // ignore: cast_nullable_to_non_nullable
              as int?,
      tag: freezed == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as int?,
      correlationId: freezed == correlationId
          ? _value.correlationId
          : correlationId // ignore: cast_nullable_to_non_nullable
              as int?,
      tvf: freezed == tvf
          ? _value.tvf
          : tvf // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      publishMethod: freezed == publishMethod
          ? _value.publishMethod
          : publishMethod // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PublishOptionsImplCopyWith<$Res>
    implements $PublishOptionsCopyWith<$Res> {
  factory _$$PublishOptionsImplCopyWith(_$PublishOptionsImpl value,
          $Res Function(_$PublishOptionsImpl) then) =
      __$$PublishOptionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? ttl,
      int? tag,
      int? correlationId,
      Map<String, dynamic>? tvf,
      String? publishMethod});
}

/// @nodoc
class __$$PublishOptionsImplCopyWithImpl<$Res>
    extends _$PublishOptionsCopyWithImpl<$Res, _$PublishOptionsImpl>
    implements _$$PublishOptionsImplCopyWith<$Res> {
  __$$PublishOptionsImplCopyWithImpl(
      _$PublishOptionsImpl _value, $Res Function(_$PublishOptionsImpl) _then)
      : super(_value, _then);

  /// Create a copy of PublishOptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ttl = freezed,
    Object? tag = freezed,
    Object? correlationId = freezed,
    Object? tvf = freezed,
    Object? publishMethod = freezed,
  }) {
    return _then(_$PublishOptionsImpl(
      ttl: freezed == ttl
          ? _value.ttl
          : ttl // ignore: cast_nullable_to_non_nullable
              as int?,
      tag: freezed == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as int?,
      correlationId: freezed == correlationId
          ? _value.correlationId
          : correlationId // ignore: cast_nullable_to_non_nullable
              as int?,
      tvf: freezed == tvf
          ? _value._tvf
          : tvf // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      publishMethod: freezed == publishMethod
          ? _value.publishMethod
          : publishMethod // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$PublishOptionsImpl implements _PublishOptions {
  const _$PublishOptionsImpl(
      {this.ttl,
      this.tag,
      this.correlationId,
      final Map<String, dynamic>? tvf,
      this.publishMethod})
      : _tvf = tvf;

  factory _$PublishOptionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PublishOptionsImplFromJson(json);

  @override
  final int? ttl;
  @override
  final int? tag;
  @override
  final int? correlationId;
  final Map<String, dynamic>? _tvf;
  @override
  Map<String, dynamic>? get tvf {
    final value = _tvf;
    if (value == null) return null;
    if (_tvf is EqualUnmodifiableMapView) return _tvf;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String? publishMethod;

  @override
  String toString() {
    return 'PublishOptions(ttl: $ttl, tag: $tag, correlationId: $correlationId, tvf: $tvf, publishMethod: $publishMethod)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PublishOptionsImpl &&
            (identical(other.ttl, ttl) || other.ttl == ttl) &&
            (identical(other.tag, tag) || other.tag == tag) &&
            (identical(other.correlationId, correlationId) ||
                other.correlationId == correlationId) &&
            const DeepCollectionEquality().equals(other._tvf, _tvf) &&
            (identical(other.publishMethod, publishMethod) ||
                other.publishMethod == publishMethod));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, ttl, tag, correlationId,
      const DeepCollectionEquality().hash(_tvf), publishMethod);

  /// Create a copy of PublishOptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PublishOptionsImplCopyWith<_$PublishOptionsImpl> get copyWith =>
      __$$PublishOptionsImplCopyWithImpl<_$PublishOptionsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PublishOptionsImplToJson(
      this,
    );
  }
}

abstract class _PublishOptions implements PublishOptions {
  const factory _PublishOptions(
      {final int? ttl,
      final int? tag,
      final int? correlationId,
      final Map<String, dynamic>? tvf,
      final String? publishMethod}) = _$PublishOptionsImpl;

  factory _PublishOptions.fromJson(Map<String, dynamic> json) =
      _$PublishOptionsImpl.fromJson;

  @override
  int? get ttl;
  @override
  int? get tag;
  @override
  int? get correlationId;
  @override
  Map<String, dynamic>? get tvf;
  @override
  String? get publishMethod;

  /// Create a copy of PublishOptions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PublishOptionsImplCopyWith<_$PublishOptionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SubscribeOptions _$SubscribeOptionsFromJson(Map<String, dynamic> json) {
  return _SubscribeOptions.fromJson(json);
}

/// @nodoc
mixin _$SubscribeOptions {
  String get topic => throw _privateConstructorUsedError;
  TransportType get transportType => throw _privateConstructorUsedError;
  bool get skipSubscribe => throw _privateConstructorUsedError;

  /// Serializes this SubscribeOptions to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubscribeOptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubscribeOptionsCopyWith<SubscribeOptions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscribeOptionsCopyWith<$Res> {
  factory $SubscribeOptionsCopyWith(
          SubscribeOptions value, $Res Function(SubscribeOptions) then) =
      _$SubscribeOptionsCopyWithImpl<$Res, SubscribeOptions>;
  @useResult
  $Res call({String topic, TransportType transportType, bool skipSubscribe});
}

/// @nodoc
class _$SubscribeOptionsCopyWithImpl<$Res, $Val extends SubscribeOptions>
    implements $SubscribeOptionsCopyWith<$Res> {
  _$SubscribeOptionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubscribeOptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topic = null,
    Object? transportType = null,
    Object? skipSubscribe = null,
  }) {
    return _then(_value.copyWith(
      topic: null == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      transportType: null == transportType
          ? _value.transportType
          : transportType // ignore: cast_nullable_to_non_nullable
              as TransportType,
      skipSubscribe: null == skipSubscribe
          ? _value.skipSubscribe
          : skipSubscribe // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubscribeOptionsImplCopyWith<$Res>
    implements $SubscribeOptionsCopyWith<$Res> {
  factory _$$SubscribeOptionsImplCopyWith(_$SubscribeOptionsImpl value,
          $Res Function(_$SubscribeOptionsImpl) then) =
      __$$SubscribeOptionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String topic, TransportType transportType, bool skipSubscribe});
}

/// @nodoc
class __$$SubscribeOptionsImplCopyWithImpl<$Res>
    extends _$SubscribeOptionsCopyWithImpl<$Res, _$SubscribeOptionsImpl>
    implements _$$SubscribeOptionsImplCopyWith<$Res> {
  __$$SubscribeOptionsImplCopyWithImpl(_$SubscribeOptionsImpl _value,
      $Res Function(_$SubscribeOptionsImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubscribeOptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topic = null,
    Object? transportType = null,
    Object? skipSubscribe = null,
  }) {
    return _then(_$SubscribeOptionsImpl(
      topic: null == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      transportType: null == transportType
          ? _value.transportType
          : transportType // ignore: cast_nullable_to_non_nullable
              as TransportType,
      skipSubscribe: null == skipSubscribe
          ? _value.skipSubscribe
          : skipSubscribe // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$SubscribeOptionsImpl implements _SubscribeOptions {
  const _$SubscribeOptionsImpl(
      {required this.topic,
      this.transportType = TransportType.relay,
      this.skipSubscribe = false});

  factory _$SubscribeOptionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubscribeOptionsImplFromJson(json);

  @override
  final String topic;
  @override
  @JsonKey()
  final TransportType transportType;
  @override
  @JsonKey()
  final bool skipSubscribe;

  @override
  String toString() {
    return 'SubscribeOptions(topic: $topic, transportType: $transportType, skipSubscribe: $skipSubscribe)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscribeOptionsImpl &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.transportType, transportType) ||
                other.transportType == transportType) &&
            (identical(other.skipSubscribe, skipSubscribe) ||
                other.skipSubscribe == skipSubscribe));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, topic, transportType, skipSubscribe);

  /// Create a copy of SubscribeOptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscribeOptionsImplCopyWith<_$SubscribeOptionsImpl> get copyWith =>
      __$$SubscribeOptionsImplCopyWithImpl<_$SubscribeOptionsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubscribeOptionsImplToJson(
      this,
    );
  }
}

abstract class _SubscribeOptions implements SubscribeOptions {
  const factory _SubscribeOptions(
      {required final String topic,
      final TransportType transportType,
      final bool skipSubscribe}) = _$SubscribeOptionsImpl;

  factory _SubscribeOptions.fromJson(Map<String, dynamic> json) =
      _$SubscribeOptionsImpl.fromJson;

  @override
  String get topic;
  @override
  TransportType get transportType;
  @override
  bool get skipSubscribe;

  /// Create a copy of SubscribeOptions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscribeOptionsImplCopyWith<_$SubscribeOptionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
