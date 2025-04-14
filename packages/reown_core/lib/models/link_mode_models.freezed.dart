// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'link_mode_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LinkModeOptions {
  int get tag => throw _privateConstructorUsedError;

  /// Create a copy of LinkModeOptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LinkModeOptionsCopyWith<LinkModeOptions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LinkModeOptionsCopyWith<$Res> {
  factory $LinkModeOptionsCopyWith(
          LinkModeOptions value, $Res Function(LinkModeOptions) then) =
      _$LinkModeOptionsCopyWithImpl<$Res, LinkModeOptions>;
  @useResult
  $Res call({int tag});
}

/// @nodoc
class _$LinkModeOptionsCopyWithImpl<$Res, $Val extends LinkModeOptions>
    implements $LinkModeOptionsCopyWith<$Res> {
  _$LinkModeOptionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LinkModeOptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tag = null,
  }) {
    return _then(_value.copyWith(
      tag: null == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LinkModeOptionsImplCopyWith<$Res>
    implements $LinkModeOptionsCopyWith<$Res> {
  factory _$$LinkModeOptionsImplCopyWith(_$LinkModeOptionsImpl value,
          $Res Function(_$LinkModeOptionsImpl) then) =
      __$$LinkModeOptionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int tag});
}

/// @nodoc
class __$$LinkModeOptionsImplCopyWithImpl<$Res>
    extends _$LinkModeOptionsCopyWithImpl<$Res, _$LinkModeOptionsImpl>
    implements _$$LinkModeOptionsImplCopyWith<$Res> {
  __$$LinkModeOptionsImplCopyWithImpl(
      _$LinkModeOptionsImpl _value, $Res Function(_$LinkModeOptionsImpl) _then)
      : super(_value, _then);

  /// Create a copy of LinkModeOptions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tag = null,
  }) {
    return _then(_$LinkModeOptionsImpl(
      tag: null == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$LinkModeOptionsImpl implements _LinkModeOptions {
  const _$LinkModeOptionsImpl({required this.tag});

  @override
  final int tag;

  @override
  String toString() {
    return 'LinkModeOptions(tag: $tag)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LinkModeOptionsImpl &&
            (identical(other.tag, tag) || other.tag == tag));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tag);

  /// Create a copy of LinkModeOptions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LinkModeOptionsImplCopyWith<_$LinkModeOptionsImpl> get copyWith =>
      __$$LinkModeOptionsImplCopyWithImpl<_$LinkModeOptionsImpl>(
          this, _$identity);
}

abstract class _LinkModeOptions implements LinkModeOptions {
  const factory _LinkModeOptions({required final int tag}) =
      _$LinkModeOptionsImpl;

  @override
  int get tag;

  /// Create a copy of LinkModeOptions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LinkModeOptionsImplCopyWith<_$LinkModeOptionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
