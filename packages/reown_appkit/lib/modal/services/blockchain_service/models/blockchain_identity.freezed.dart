// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'blockchain_identity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BlockchainIdentity _$BlockchainIdentityFromJson(Map<String, dynamic> json) {
  return _BlockchainIdentity.fromJson(json);
}

/// @nodoc
mixin _$BlockchainIdentity {
  String? get name => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BlockchainIdentityCopyWith<BlockchainIdentity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BlockchainIdentityCopyWith<$Res> {
  factory $BlockchainIdentityCopyWith(
          BlockchainIdentity value, $Res Function(BlockchainIdentity) then) =
      _$BlockchainIdentityCopyWithImpl<$Res, BlockchainIdentity>;
  @useResult
  $Res call({String? name, String? avatar});
}

/// @nodoc
class _$BlockchainIdentityCopyWithImpl<$Res, $Val extends BlockchainIdentity>
    implements $BlockchainIdentityCopyWith<$Res> {
  _$BlockchainIdentityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? avatar = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BlockchainIdentityImplCopyWith<$Res>
    implements $BlockchainIdentityCopyWith<$Res> {
  factory _$$BlockchainIdentityImplCopyWith(_$BlockchainIdentityImpl value,
          $Res Function(_$BlockchainIdentityImpl) then) =
      __$$BlockchainIdentityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, String? avatar});
}

/// @nodoc
class __$$BlockchainIdentityImplCopyWithImpl<$Res>
    extends _$BlockchainIdentityCopyWithImpl<$Res, _$BlockchainIdentityImpl>
    implements _$$BlockchainIdentityImplCopyWith<$Res> {
  __$$BlockchainIdentityImplCopyWithImpl(_$BlockchainIdentityImpl _value,
      $Res Function(_$BlockchainIdentityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? avatar = freezed,
  }) {
    return _then(_$BlockchainIdentityImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BlockchainIdentityImpl implements _BlockchainIdentity {
  const _$BlockchainIdentityImpl({this.name, this.avatar});

  factory _$BlockchainIdentityImpl.fromJson(Map<String, dynamic> json) =>
      _$$BlockchainIdentityImplFromJson(json);

  @override
  final String? name;
  @override
  final String? avatar;

  @override
  String toString() {
    return 'BlockchainIdentity(name: $name, avatar: $avatar)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BlockchainIdentityImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatar, avatar) || other.avatar == avatar));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, avatar);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BlockchainIdentityImplCopyWith<_$BlockchainIdentityImpl> get copyWith =>
      __$$BlockchainIdentityImplCopyWithImpl<_$BlockchainIdentityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BlockchainIdentityImplToJson(
      this,
    );
  }
}

abstract class _BlockchainIdentity implements BlockchainIdentity {
  const factory _BlockchainIdentity(
      {final String? name, final String? avatar}) = _$BlockchainIdentityImpl;

  factory _BlockchainIdentity.fromJson(Map<String, dynamic> json) =
      _$BlockchainIdentityImpl.fromJson;

  @override
  String? get name;
  @override
  String? get avatar;
  @override
  @JsonKey(ignore: true)
  _$$BlockchainIdentityImplCopyWith<_$BlockchainIdentityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
