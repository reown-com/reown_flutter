// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shared.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PulseMetadataCompat _$PulseMetadataCompatFromJson(Map<String, dynamic> json) {
  return _PulseMetadataCompat.fromJson(json);
}

/// @nodoc
mixin _$PulseMetadataCompat {
  String? get url => throw _privateConstructorUsedError;
  String? get bundleId => throw _privateConstructorUsedError;
  String? get packageName => throw _privateConstructorUsedError;
  String get sdkVersion => throw _privateConstructorUsedError;
  String get sdkPlatform => throw _privateConstructorUsedError;

  /// Serializes this PulseMetadataCompat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PulseMetadataCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PulseMetadataCompatCopyWith<PulseMetadataCompat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PulseMetadataCompatCopyWith<$Res> {
  factory $PulseMetadataCompatCopyWith(
          PulseMetadataCompat value, $Res Function(PulseMetadataCompat) then) =
      _$PulseMetadataCompatCopyWithImpl<$Res, PulseMetadataCompat>;
  @useResult
  $Res call(
      {String? url,
      String? bundleId,
      String? packageName,
      String sdkVersion,
      String sdkPlatform});
}

/// @nodoc
class _$PulseMetadataCompatCopyWithImpl<$Res, $Val extends PulseMetadataCompat>
    implements $PulseMetadataCompatCopyWith<$Res> {
  _$PulseMetadataCompatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PulseMetadataCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
    Object? bundleId = freezed,
    Object? packageName = freezed,
    Object? sdkVersion = null,
    Object? sdkPlatform = null,
  }) {
    return _then(_value.copyWith(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      bundleId: freezed == bundleId
          ? _value.bundleId
          : bundleId // ignore: cast_nullable_to_non_nullable
              as String?,
      packageName: freezed == packageName
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String?,
      sdkVersion: null == sdkVersion
          ? _value.sdkVersion
          : sdkVersion // ignore: cast_nullable_to_non_nullable
              as String,
      sdkPlatform: null == sdkPlatform
          ? _value.sdkPlatform
          : sdkPlatform // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PulseMetadataCompatImplCopyWith<$Res>
    implements $PulseMetadataCompatCopyWith<$Res> {
  factory _$$PulseMetadataCompatImplCopyWith(_$PulseMetadataCompatImpl value,
          $Res Function(_$PulseMetadataCompatImpl) then) =
      __$$PulseMetadataCompatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? url,
      String? bundleId,
      String? packageName,
      String sdkVersion,
      String sdkPlatform});
}

/// @nodoc
class __$$PulseMetadataCompatImplCopyWithImpl<$Res>
    extends _$PulseMetadataCompatCopyWithImpl<$Res, _$PulseMetadataCompatImpl>
    implements _$$PulseMetadataCompatImplCopyWith<$Res> {
  __$$PulseMetadataCompatImplCopyWithImpl(_$PulseMetadataCompatImpl _value,
      $Res Function(_$PulseMetadataCompatImpl) _then)
      : super(_value, _then);

  /// Create a copy of PulseMetadataCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = freezed,
    Object? bundleId = freezed,
    Object? packageName = freezed,
    Object? sdkVersion = null,
    Object? sdkPlatform = null,
  }) {
    return _then(_$PulseMetadataCompatImpl(
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      bundleId: freezed == bundleId
          ? _value.bundleId
          : bundleId // ignore: cast_nullable_to_non_nullable
              as String?,
      packageName: freezed == packageName
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String?,
      sdkVersion: null == sdkVersion
          ? _value.sdkVersion
          : sdkVersion // ignore: cast_nullable_to_non_nullable
              as String,
      sdkPlatform: null == sdkPlatform
          ? _value.sdkPlatform
          : sdkPlatform // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PulseMetadataCompatImpl implements _PulseMetadataCompat {
  const _$PulseMetadataCompatImpl(
      {this.url,
      this.bundleId,
      this.packageName,
      required this.sdkVersion,
      required this.sdkPlatform});

  factory _$PulseMetadataCompatImpl.fromJson(Map<String, dynamic> json) =>
      _$$PulseMetadataCompatImplFromJson(json);

  @override
  final String? url;
  @override
  final String? bundleId;
  @override
  final String? packageName;
  @override
  final String sdkVersion;
  @override
  final String sdkPlatform;

  @override
  String toString() {
    return 'PulseMetadataCompat(url: $url, bundleId: $bundleId, packageName: $packageName, sdkVersion: $sdkVersion, sdkPlatform: $sdkPlatform)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PulseMetadataCompatImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.bundleId, bundleId) ||
                other.bundleId == bundleId) &&
            (identical(other.packageName, packageName) ||
                other.packageName == packageName) &&
            (identical(other.sdkVersion, sdkVersion) ||
                other.sdkVersion == sdkVersion) &&
            (identical(other.sdkPlatform, sdkPlatform) ||
                other.sdkPlatform == sdkPlatform));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, url, bundleId, packageName, sdkVersion, sdkPlatform);

  /// Create a copy of PulseMetadataCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PulseMetadataCompatImplCopyWith<_$PulseMetadataCompatImpl> get copyWith =>
      __$$PulseMetadataCompatImplCopyWithImpl<_$PulseMetadataCompatImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PulseMetadataCompatImplToJson(
      this,
    );
  }
}

abstract class _PulseMetadataCompat implements PulseMetadataCompat {
  const factory _PulseMetadataCompat(
      {final String? url,
      final String? bundleId,
      final String? packageName,
      required final String sdkVersion,
      required final String sdkPlatform}) = _$PulseMetadataCompatImpl;

  factory _PulseMetadataCompat.fromJson(Map<String, dynamic> json) =
      _$PulseMetadataCompatImpl.fromJson;

  @override
  String? get url;
  @override
  String? get bundleId;
  @override
  String? get packageName;
  @override
  String get sdkVersion;
  @override
  String get sdkPlatform;

  /// Create a copy of PulseMetadataCompat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PulseMetadataCompatImplCopyWith<_$PulseMetadataCompatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
