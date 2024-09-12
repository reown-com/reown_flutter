// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appkit_wallet_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReownAppKitModalWalletInfo _$ReownAppKitModalWalletInfoFromJson(
    Map<String, dynamic> json) {
  return _ReownAppKitModalWalletInfo.fromJson(json);
}

/// @nodoc
mixin _$ReownAppKitModalWalletInfo {
  Listing get listing => throw _privateConstructorUsedError;
  bool get installed => throw _privateConstructorUsedError;
  bool get recent => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReownAppKitModalWalletInfoCopyWith<ReownAppKitModalWalletInfo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReownAppKitModalWalletInfoCopyWith<$Res> {
  factory $ReownAppKitModalWalletInfoCopyWith(ReownAppKitModalWalletInfo value,
          $Res Function(ReownAppKitModalWalletInfo) then) =
      _$ReownAppKitModalWalletInfoCopyWithImpl<$Res,
          ReownAppKitModalWalletInfo>;
  @useResult
  $Res call({Listing listing, bool installed, bool recent});
}

/// @nodoc
class _$ReownAppKitModalWalletInfoCopyWithImpl<$Res,
        $Val extends ReownAppKitModalWalletInfo>
    implements $ReownAppKitModalWalletInfoCopyWith<$Res> {
  _$ReownAppKitModalWalletInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listing = null,
    Object? installed = null,
    Object? recent = null,
  }) {
    return _then(_value.copyWith(
      listing: null == listing
          ? _value.listing
          : listing // ignore: cast_nullable_to_non_nullable
              as Listing,
      installed: null == installed
          ? _value.installed
          : installed // ignore: cast_nullable_to_non_nullable
              as bool,
      recent: null == recent
          ? _value.recent
          : recent // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReownAppKitModalWalletInfoImplCopyWith<$Res>
    implements $ReownAppKitModalWalletInfoCopyWith<$Res> {
  factory _$$ReownAppKitModalWalletInfoImplCopyWith(
          _$ReownAppKitModalWalletInfoImpl value,
          $Res Function(_$ReownAppKitModalWalletInfoImpl) then) =
      __$$ReownAppKitModalWalletInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Listing listing, bool installed, bool recent});
}

/// @nodoc
class __$$ReownAppKitModalWalletInfoImplCopyWithImpl<$Res>
    extends _$ReownAppKitModalWalletInfoCopyWithImpl<$Res,
        _$ReownAppKitModalWalletInfoImpl>
    implements _$$ReownAppKitModalWalletInfoImplCopyWith<$Res> {
  __$$ReownAppKitModalWalletInfoImplCopyWithImpl(
      _$ReownAppKitModalWalletInfoImpl _value,
      $Res Function(_$ReownAppKitModalWalletInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listing = null,
    Object? installed = null,
    Object? recent = null,
  }) {
    return _then(_$ReownAppKitModalWalletInfoImpl(
      listing: null == listing
          ? _value.listing
          : listing // ignore: cast_nullable_to_non_nullable
              as Listing,
      installed: null == installed
          ? _value.installed
          : installed // ignore: cast_nullable_to_non_nullable
              as bool,
      recent: null == recent
          ? _value.recent
          : recent // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReownAppKitModalWalletInfoImpl implements _ReownAppKitModalWalletInfo {
  const _$ReownAppKitModalWalletInfoImpl(
      {required this.listing, required this.installed, required this.recent});

  factory _$ReownAppKitModalWalletInfoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ReownAppKitModalWalletInfoImplFromJson(json);

  @override
  final Listing listing;
  @override
  final bool installed;
  @override
  final bool recent;

  @override
  String toString() {
    return 'ReownAppKitModalWalletInfo(listing: $listing, installed: $installed, recent: $recent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReownAppKitModalWalletInfoImpl &&
            (identical(other.listing, listing) || other.listing == listing) &&
            (identical(other.installed, installed) ||
                other.installed == installed) &&
            (identical(other.recent, recent) || other.recent == recent));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, listing, installed, recent);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReownAppKitModalWalletInfoImplCopyWith<_$ReownAppKitModalWalletInfoImpl>
      get copyWith => __$$ReownAppKitModalWalletInfoImplCopyWithImpl<
          _$ReownAppKitModalWalletInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReownAppKitModalWalletInfoImplToJson(
      this,
    );
  }
}

abstract class _ReownAppKitModalWalletInfo
    implements ReownAppKitModalWalletInfo {
  const factory _ReownAppKitModalWalletInfo(
      {required final Listing listing,
      required final bool installed,
      required final bool recent}) = _$ReownAppKitModalWalletInfoImpl;

  factory _ReownAppKitModalWalletInfo.fromJson(Map<String, dynamic> json) =
      _$ReownAppKitModalWalletInfoImpl.fromJson;

  @override
  Listing get listing;
  @override
  bool get installed;
  @override
  bool get recent;
  @override
  @JsonKey(ignore: true)
  _$$ReownAppKitModalWalletInfoImplCopyWith<_$ReownAppKitModalWalletInfoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
