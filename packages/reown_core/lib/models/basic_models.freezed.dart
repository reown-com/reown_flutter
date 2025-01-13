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
