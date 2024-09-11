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

AppKitModalWalletInfo _$AppKitModalWalletInfoFromJson(
    Map<String, dynamic> json) {
  return _AppKitWalletInfo.fromJson(json);
}

/// @nodoc
mixin _$AppKitModalWalletInfo {
  Listing get listing => throw _privateConstructorUsedError;
  bool get installed => throw _privateConstructorUsedError;
  bool get recent => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppKitModalWalletInfoCopyWith<AppKitModalWalletInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppKitModalWalletInfoCopyWith<$Res> {
  factory $AppKitModalWalletInfoCopyWith(AppKitModalWalletInfo value,
          $Res Function(AppKitModalWalletInfo) then) =
      _$AppKitModalWalletInfoCopyWithImpl<$Res, AppKitModalWalletInfo>;
  @useResult
  $Res call({Listing listing, bool installed, bool recent});
}

/// @nodoc
class _$AppKitModalWalletInfoCopyWithImpl<$Res,
        $Val extends AppKitModalWalletInfo>
    implements $AppKitModalWalletInfoCopyWith<$Res> {
  _$AppKitModalWalletInfoCopyWithImpl(this._value, this._then);

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
abstract class _$$AppKitWalletInfoImplCopyWith<$Res>
    implements $AppKitModalWalletInfoCopyWith<$Res> {
  factory _$$AppKitWalletInfoImplCopyWith(_$AppKitWalletInfoImpl value,
          $Res Function(_$AppKitWalletInfoImpl) then) =
      __$$AppKitWalletInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Listing listing, bool installed, bool recent});
}

/// @nodoc
class __$$AppKitWalletInfoImplCopyWithImpl<$Res>
    extends _$AppKitModalWalletInfoCopyWithImpl<$Res, _$AppKitWalletInfoImpl>
    implements _$$AppKitWalletInfoImplCopyWith<$Res> {
  __$$AppKitWalletInfoImplCopyWithImpl(_$AppKitWalletInfoImpl _value,
      $Res Function(_$AppKitWalletInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listing = null,
    Object? installed = null,
    Object? recent = null,
  }) {
    return _then(_$AppKitWalletInfoImpl(
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
class _$AppKitWalletInfoImpl implements _AppKitWalletInfo {
  const _$AppKitWalletInfoImpl(
      {required this.listing, required this.installed, required this.recent});

  factory _$AppKitWalletInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AppKitWalletInfoImplFromJson(json);

  @override
  final Listing listing;
  @override
  final bool installed;
  @override
  final bool recent;

  @override
  String toString() {
    return 'AppKitModalWalletInfo(listing: $listing, installed: $installed, recent: $recent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppKitWalletInfoImpl &&
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
  _$$AppKitWalletInfoImplCopyWith<_$AppKitWalletInfoImpl> get copyWith =>
      __$$AppKitWalletInfoImplCopyWithImpl<_$AppKitWalletInfoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AppKitWalletInfoImplToJson(
      this,
    );
  }
}

abstract class _AppKitWalletInfo implements AppKitModalWalletInfo {
  const factory _AppKitWalletInfo(
      {required final Listing listing,
      required final bool installed,
      required final bool recent}) = _$AppKitWalletInfoImpl;

  factory _AppKitWalletInfo.fromJson(Map<String, dynamic> json) =
      _$AppKitWalletInfoImpl.fromJson;

  @override
  Listing get listing;
  @override
  bool get installed;
  @override
  bool get recent;
  @override
  @JsonKey(ignore: true)
  _$$AppKitWalletInfoImplCopyWith<_$AppKitWalletInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
