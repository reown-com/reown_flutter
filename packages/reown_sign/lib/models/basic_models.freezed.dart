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

ReownSignError _$ReownSignErrorFromJson(Map<String, dynamic> json) {
  return _ReownSignError.fromJson(json);
}

/// @nodoc
mixin _$ReownSignError {
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String? get data => throw _privateConstructorUsedError;

  /// Serializes this ReownSignError to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReownSignError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReownSignErrorCopyWith<ReownSignError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReownSignErrorCopyWith<$Res> {
  factory $ReownSignErrorCopyWith(
          ReownSignError value, $Res Function(ReownSignError) then) =
      _$ReownSignErrorCopyWithImpl<$Res, ReownSignError>;
  @useResult
  $Res call({int code, String message, String? data});
}

/// @nodoc
class _$ReownSignErrorCopyWithImpl<$Res, $Val extends ReownSignError>
    implements $ReownSignErrorCopyWith<$Res> {
  _$ReownSignErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReownSignError
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
abstract class _$$ReownSignErrorImplCopyWith<$Res>
    implements $ReownSignErrorCopyWith<$Res> {
  factory _$$ReownSignErrorImplCopyWith(_$ReownSignErrorImpl value,
          $Res Function(_$ReownSignErrorImpl) then) =
      __$$ReownSignErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int code, String message, String? data});
}

/// @nodoc
class __$$ReownSignErrorImplCopyWithImpl<$Res>
    extends _$ReownSignErrorCopyWithImpl<$Res, _$ReownSignErrorImpl>
    implements _$$ReownSignErrorImplCopyWith<$Res> {
  __$$ReownSignErrorImplCopyWithImpl(
      _$ReownSignErrorImpl _value, $Res Function(_$ReownSignErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReownSignError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_$ReownSignErrorImpl(
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
class _$ReownSignErrorImpl implements _ReownSignError {
  const _$ReownSignErrorImpl(
      {required this.code, required this.message, this.data});

  factory _$ReownSignErrorImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReownSignErrorImplFromJson(json);

  @override
  final int code;
  @override
  final String message;
  @override
  final String? data;

  @override
  String toString() {
    return 'ReownSignError(code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReownSignErrorImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, code, message, data);

  /// Create a copy of ReownSignError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReownSignErrorImplCopyWith<_$ReownSignErrorImpl> get copyWith =>
      __$$ReownSignErrorImplCopyWithImpl<_$ReownSignErrorImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReownSignErrorImplToJson(
      this,
    );
  }
}

abstract class _ReownSignError implements ReownSignError {
  const factory _ReownSignError(
      {required final int code,
      required final String message,
      final String? data}) = _$ReownSignErrorImpl;

  factory _ReownSignError.fromJson(Map<String, dynamic> json) =
      _$ReownSignErrorImpl.fromJson;

  @override
  int get code;
  @override
  String get message;
  @override
  String? get data;

  /// Create a copy of ReownSignError
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReownSignErrorImplCopyWith<_$ReownSignErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ConnectionMetadata _$ConnectionMetadataFromJson(Map<String, dynamic> json) {
  return _ConnectionMetadata.fromJson(json);
}

/// @nodoc
mixin _$ConnectionMetadata {
  String get publicKey => throw _privateConstructorUsedError;
  PairingMetadata get metadata => throw _privateConstructorUsedError;

  /// Serializes this ConnectionMetadata to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConnectionMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConnectionMetadataCopyWith<ConnectionMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectionMetadataCopyWith<$Res> {
  factory $ConnectionMetadataCopyWith(
          ConnectionMetadata value, $Res Function(ConnectionMetadata) then) =
      _$ConnectionMetadataCopyWithImpl<$Res, ConnectionMetadata>;
  @useResult
  $Res call({String publicKey, PairingMetadata metadata});

  $PairingMetadataCopyWith<$Res> get metadata;
}

/// @nodoc
class _$ConnectionMetadataCopyWithImpl<$Res, $Val extends ConnectionMetadata>
    implements $ConnectionMetadataCopyWith<$Res> {
  _$ConnectionMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConnectionMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? publicKey = null,
    Object? metadata = null,
  }) {
    return _then(_value.copyWith(
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as PairingMetadata,
    ) as $Val);
  }

  /// Create a copy of ConnectionMetadata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PairingMetadataCopyWith<$Res> get metadata {
    return $PairingMetadataCopyWith<$Res>(_value.metadata, (value) {
      return _then(_value.copyWith(metadata: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ConnectionMetadataImplCopyWith<$Res>
    implements $ConnectionMetadataCopyWith<$Res> {
  factory _$$ConnectionMetadataImplCopyWith(_$ConnectionMetadataImpl value,
          $Res Function(_$ConnectionMetadataImpl) then) =
      __$$ConnectionMetadataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String publicKey, PairingMetadata metadata});

  @override
  $PairingMetadataCopyWith<$Res> get metadata;
}

/// @nodoc
class __$$ConnectionMetadataImplCopyWithImpl<$Res>
    extends _$ConnectionMetadataCopyWithImpl<$Res, _$ConnectionMetadataImpl>
    implements _$$ConnectionMetadataImplCopyWith<$Res> {
  __$$ConnectionMetadataImplCopyWithImpl(_$ConnectionMetadataImpl _value,
      $Res Function(_$ConnectionMetadataImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectionMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? publicKey = null,
    Object? metadata = null,
  }) {
    return _then(_$ConnectionMetadataImpl(
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as PairingMetadata,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConnectionMetadataImpl implements _ConnectionMetadata {
  const _$ConnectionMetadataImpl(
      {required this.publicKey, required this.metadata});

  factory _$ConnectionMetadataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConnectionMetadataImplFromJson(json);

  @override
  final String publicKey;
  @override
  final PairingMetadata metadata;

  @override
  String toString() {
    return 'ConnectionMetadata(publicKey: $publicKey, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionMetadataImpl &&
            (identical(other.publicKey, publicKey) ||
                other.publicKey == publicKey) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, publicKey, metadata);

  /// Create a copy of ConnectionMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionMetadataImplCopyWith<_$ConnectionMetadataImpl> get copyWith =>
      __$$ConnectionMetadataImplCopyWithImpl<_$ConnectionMetadataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConnectionMetadataImplToJson(
      this,
    );
  }
}

abstract class _ConnectionMetadata implements ConnectionMetadata {
  const factory _ConnectionMetadata(
      {required final String publicKey,
      required final PairingMetadata metadata}) = _$ConnectionMetadataImpl;

  factory _ConnectionMetadata.fromJson(Map<String, dynamic> json) =
      _$ConnectionMetadataImpl.fromJson;

  @override
  String get publicKey;
  @override
  PairingMetadata get metadata;

  /// Create a copy of ConnectionMetadata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionMetadataImplCopyWith<_$ConnectionMetadataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AuthPublicKey _$AuthPublicKeyFromJson(Map<String, dynamic> json) {
  return _AuthPublicKey.fromJson(json);
}

/// @nodoc
mixin _$AuthPublicKey {
  String get publicKey => throw _privateConstructorUsedError;

  /// Serializes this AuthPublicKey to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuthPublicKey
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuthPublicKeyCopyWith<AuthPublicKey> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthPublicKeyCopyWith<$Res> {
  factory $AuthPublicKeyCopyWith(
          AuthPublicKey value, $Res Function(AuthPublicKey) then) =
      _$AuthPublicKeyCopyWithImpl<$Res, AuthPublicKey>;
  @useResult
  $Res call({String publicKey});
}

/// @nodoc
class _$AuthPublicKeyCopyWithImpl<$Res, $Val extends AuthPublicKey>
    implements $AuthPublicKeyCopyWith<$Res> {
  _$AuthPublicKeyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthPublicKey
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? publicKey = null,
  }) {
    return _then(_value.copyWith(
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthPublicKeyImplCopyWith<$Res>
    implements $AuthPublicKeyCopyWith<$Res> {
  factory _$$AuthPublicKeyImplCopyWith(
          _$AuthPublicKeyImpl value, $Res Function(_$AuthPublicKeyImpl) then) =
      __$$AuthPublicKeyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String publicKey});
}

/// @nodoc
class __$$AuthPublicKeyImplCopyWithImpl<$Res>
    extends _$AuthPublicKeyCopyWithImpl<$Res, _$AuthPublicKeyImpl>
    implements _$$AuthPublicKeyImplCopyWith<$Res> {
  __$$AuthPublicKeyImplCopyWithImpl(
      _$AuthPublicKeyImpl _value, $Res Function(_$AuthPublicKeyImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuthPublicKey
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? publicKey = null,
  }) {
    return _then(_$AuthPublicKeyImpl(
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$AuthPublicKeyImpl implements _AuthPublicKey {
  const _$AuthPublicKeyImpl({required this.publicKey});

  factory _$AuthPublicKeyImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthPublicKeyImplFromJson(json);

  @override
  final String publicKey;

  @override
  String toString() {
    return 'AuthPublicKey(publicKey: $publicKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthPublicKeyImpl &&
            (identical(other.publicKey, publicKey) ||
                other.publicKey == publicKey));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, publicKey);

  /// Create a copy of AuthPublicKey
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthPublicKeyImplCopyWith<_$AuthPublicKeyImpl> get copyWith =>
      __$$AuthPublicKeyImplCopyWithImpl<_$AuthPublicKeyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthPublicKeyImplToJson(
      this,
    );
  }
}

abstract class _AuthPublicKey implements AuthPublicKey {
  const factory _AuthPublicKey({required final String publicKey}) =
      _$AuthPublicKeyImpl;

  factory _AuthPublicKey.fromJson(Map<String, dynamic> json) =
      _$AuthPublicKeyImpl.fromJson;

  @override
  String get publicKey;

  /// Create a copy of AuthPublicKey
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthPublicKeyImplCopyWith<_$AuthPublicKeyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
