// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chain_abstraction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AmountCompat _$AmountCompatFromJson(Map<String, dynamic> json) {
  return _AmountCompat.fromJson(json);
}

/// @nodoc
mixin _$AmountCompat {
  String get symbol => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;
  int get unit => throw _privateConstructorUsedError;
  String get formatted => throw _privateConstructorUsedError;
  String get formattedAlt => throw _privateConstructorUsedError;

  /// Serializes this AmountCompat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AmountCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AmountCompatCopyWith<AmountCompat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AmountCompatCopyWith<$Res> {
  factory $AmountCompatCopyWith(
          AmountCompat value, $Res Function(AmountCompat) then) =
      _$AmountCompatCopyWithImpl<$Res, AmountCompat>;
  @useResult
  $Res call(
      {String symbol,
      String amount,
      int unit,
      String formatted,
      String formattedAlt});
}

/// @nodoc
class _$AmountCompatCopyWithImpl<$Res, $Val extends AmountCompat>
    implements $AmountCompatCopyWith<$Res> {
  _$AmountCompatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AmountCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = null,
    Object? amount = null,
    Object? unit = null,
    Object? formatted = null,
    Object? formattedAlt = null,
  }) {
    return _then(_value.copyWith(
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as int,
      formatted: null == formatted
          ? _value.formatted
          : formatted // ignore: cast_nullable_to_non_nullable
              as String,
      formattedAlt: null == formattedAlt
          ? _value.formattedAlt
          : formattedAlt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AmountCompatImplCopyWith<$Res>
    implements $AmountCompatCopyWith<$Res> {
  factory _$$AmountCompatImplCopyWith(
          _$AmountCompatImpl value, $Res Function(_$AmountCompatImpl) then) =
      __$$AmountCompatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String symbol,
      String amount,
      int unit,
      String formatted,
      String formattedAlt});
}

/// @nodoc
class __$$AmountCompatImplCopyWithImpl<$Res>
    extends _$AmountCompatCopyWithImpl<$Res, _$AmountCompatImpl>
    implements _$$AmountCompatImplCopyWith<$Res> {
  __$$AmountCompatImplCopyWithImpl(
      _$AmountCompatImpl _value, $Res Function(_$AmountCompatImpl) _then)
      : super(_value, _then);

  /// Create a copy of AmountCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symbol = null,
    Object? amount = null,
    Object? unit = null,
    Object? formatted = null,
    Object? formattedAlt = null,
  }) {
    return _then(_$AmountCompatImpl(
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as int,
      formatted: null == formatted
          ? _value.formatted
          : formatted // ignore: cast_nullable_to_non_nullable
              as String,
      formattedAlt: null == formattedAlt
          ? _value.formattedAlt
          : formattedAlt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AmountCompatImpl implements _AmountCompat {
  const _$AmountCompatImpl(
      {required this.symbol,
      required this.amount,
      required this.unit,
      required this.formatted,
      required this.formattedAlt});

  factory _$AmountCompatImpl.fromJson(Map<String, dynamic> json) =>
      _$$AmountCompatImplFromJson(json);

  @override
  final String symbol;
  @override
  final String amount;
  @override
  final int unit;
  @override
  final String formatted;
  @override
  final String formattedAlt;

  @override
  String toString() {
    return 'AmountCompat(symbol: $symbol, amount: $amount, unit: $unit, formatted: $formatted, formattedAlt: $formattedAlt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AmountCompatImpl &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.formatted, formatted) ||
                other.formatted == formatted) &&
            (identical(other.formattedAlt, formattedAlt) ||
                other.formattedAlt == formattedAlt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, symbol, amount, unit, formatted, formattedAlt);

  /// Create a copy of AmountCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AmountCompatImplCopyWith<_$AmountCompatImpl> get copyWith =>
      __$$AmountCompatImplCopyWithImpl<_$AmountCompatImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AmountCompatImplToJson(
      this,
    );
  }
}

abstract class _AmountCompat implements AmountCompat {
  const factory _AmountCompat(
      {required final String symbol,
      required final String amount,
      required final int unit,
      required final String formatted,
      required final String formattedAlt}) = _$AmountCompatImpl;

  factory _AmountCompat.fromJson(Map<String, dynamic> json) =
      _$AmountCompatImpl.fromJson;

  @override
  String get symbol;
  @override
  String get amount;
  @override
  int get unit;
  @override
  String get formatted;
  @override
  String get formattedAlt;

  /// Create a copy of AmountCompat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AmountCompatImplCopyWith<_$AmountCompatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CallCompat _$CallCompatFromJson(Map<String, dynamic> json) {
  return _CallCompat.fromJson(json);
}

/// @nodoc
mixin _$CallCompat {
  String get to => throw _privateConstructorUsedError;
  String get input => throw _privateConstructorUsedError;
  BigInt? get value => throw _privateConstructorUsedError;

  /// Serializes this CallCompat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CallCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CallCompatCopyWith<CallCompat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallCompatCopyWith<$Res> {
  factory $CallCompatCopyWith(
          CallCompat value, $Res Function(CallCompat) then) =
      _$CallCompatCopyWithImpl<$Res, CallCompat>;
  @useResult
  $Res call({String to, String input, BigInt? value});
}

/// @nodoc
class _$CallCompatCopyWithImpl<$Res, $Val extends CallCompat>
    implements $CallCompatCopyWith<$Res> {
  _$CallCompatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CallCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? to = null,
    Object? input = null,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
      input: null == input
          ? _value.input
          : input // ignore: cast_nullable_to_non_nullable
              as String,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as BigInt?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CallCompatImplCopyWith<$Res>
    implements $CallCompatCopyWith<$Res> {
  factory _$$CallCompatImplCopyWith(
          _$CallCompatImpl value, $Res Function(_$CallCompatImpl) then) =
      __$$CallCompatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String to, String input, BigInt? value});
}

/// @nodoc
class __$$CallCompatImplCopyWithImpl<$Res>
    extends _$CallCompatCopyWithImpl<$Res, _$CallCompatImpl>
    implements _$$CallCompatImplCopyWith<$Res> {
  __$$CallCompatImplCopyWithImpl(
      _$CallCompatImpl _value, $Res Function(_$CallCompatImpl) _then)
      : super(_value, _then);

  /// Create a copy of CallCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? to = null,
    Object? input = null,
    Object? value = freezed,
  }) {
    return _then(_$CallCompatImpl(
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
      input: null == input
          ? _value.input
          : input // ignore: cast_nullable_to_non_nullable
              as String,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as BigInt?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CallCompatImpl implements _CallCompat {
  const _$CallCompatImpl({required this.to, required this.input, this.value});

  factory _$CallCompatImpl.fromJson(Map<String, dynamic> json) =>
      _$$CallCompatImplFromJson(json);

  @override
  final String to;
  @override
  final String input;
  @override
  final BigInt? value;

  @override
  String toString() {
    return 'CallCompat(to: $to, input: $input, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CallCompatImpl &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.input, input) || other.input == input) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, to, input, value);

  /// Create a copy of CallCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CallCompatImplCopyWith<_$CallCompatImpl> get copyWith =>
      __$$CallCompatImplCopyWithImpl<_$CallCompatImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CallCompatImplToJson(
      this,
    );
  }
}

abstract class _CallCompat implements CallCompat {
  const factory _CallCompat(
      {required final String to,
      required final String input,
      final BigInt? value}) = _$CallCompatImpl;

  factory _CallCompat.fromJson(Map<String, dynamic> json) =
      _$CallCompatImpl.fromJson;

  @override
  String get to;
  @override
  String get input;
  @override
  BigInt? get value;

  /// Create a copy of CallCompat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CallCompatImplCopyWith<_$CallCompatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Eip1559EstimationCompat _$Eip1559EstimationCompatFromJson(
    Map<String, dynamic> json) {
  return _Eip1559EstimationCompat.fromJson(json);
}

/// @nodoc
mixin _$Eip1559EstimationCompat {
  String get maxFeePerGas => throw _privateConstructorUsedError;
  String get maxPriorityFeePerGas => throw _privateConstructorUsedError;

  /// Serializes this Eip1559EstimationCompat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Eip1559EstimationCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $Eip1559EstimationCompatCopyWith<Eip1559EstimationCompat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $Eip1559EstimationCompatCopyWith<$Res> {
  factory $Eip1559EstimationCompatCopyWith(Eip1559EstimationCompat value,
          $Res Function(Eip1559EstimationCompat) then) =
      _$Eip1559EstimationCompatCopyWithImpl<$Res, Eip1559EstimationCompat>;
  @useResult
  $Res call({String maxFeePerGas, String maxPriorityFeePerGas});
}

/// @nodoc
class _$Eip1559EstimationCompatCopyWithImpl<$Res,
        $Val extends Eip1559EstimationCompat>
    implements $Eip1559EstimationCompatCopyWith<$Res> {
  _$Eip1559EstimationCompatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Eip1559EstimationCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxFeePerGas = null,
    Object? maxPriorityFeePerGas = null,
  }) {
    return _then(_value.copyWith(
      maxFeePerGas: null == maxFeePerGas
          ? _value.maxFeePerGas
          : maxFeePerGas // ignore: cast_nullable_to_non_nullable
              as String,
      maxPriorityFeePerGas: null == maxPriorityFeePerGas
          ? _value.maxPriorityFeePerGas
          : maxPriorityFeePerGas // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$Eip1559EstimationCompatImplCopyWith<$Res>
    implements $Eip1559EstimationCompatCopyWith<$Res> {
  factory _$$Eip1559EstimationCompatImplCopyWith(
          _$Eip1559EstimationCompatImpl value,
          $Res Function(_$Eip1559EstimationCompatImpl) then) =
      __$$Eip1559EstimationCompatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String maxFeePerGas, String maxPriorityFeePerGas});
}

/// @nodoc
class __$$Eip1559EstimationCompatImplCopyWithImpl<$Res>
    extends _$Eip1559EstimationCompatCopyWithImpl<$Res,
        _$Eip1559EstimationCompatImpl>
    implements _$$Eip1559EstimationCompatImplCopyWith<$Res> {
  __$$Eip1559EstimationCompatImplCopyWithImpl(
      _$Eip1559EstimationCompatImpl _value,
      $Res Function(_$Eip1559EstimationCompatImpl) _then)
      : super(_value, _then);

  /// Create a copy of Eip1559EstimationCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxFeePerGas = null,
    Object? maxPriorityFeePerGas = null,
  }) {
    return _then(_$Eip1559EstimationCompatImpl(
      maxFeePerGas: null == maxFeePerGas
          ? _value.maxFeePerGas
          : maxFeePerGas // ignore: cast_nullable_to_non_nullable
              as String,
      maxPriorityFeePerGas: null == maxPriorityFeePerGas
          ? _value.maxPriorityFeePerGas
          : maxPriorityFeePerGas // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$Eip1559EstimationCompatImpl implements _Eip1559EstimationCompat {
  const _$Eip1559EstimationCompatImpl(
      {required this.maxFeePerGas, required this.maxPriorityFeePerGas});

  factory _$Eip1559EstimationCompatImpl.fromJson(Map<String, dynamic> json) =>
      _$$Eip1559EstimationCompatImplFromJson(json);

  @override
  final String maxFeePerGas;
  @override
  final String maxPriorityFeePerGas;

  @override
  String toString() {
    return 'Eip1559EstimationCompat(maxFeePerGas: $maxFeePerGas, maxPriorityFeePerGas: $maxPriorityFeePerGas)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Eip1559EstimationCompatImpl &&
            (identical(other.maxFeePerGas, maxFeePerGas) ||
                other.maxFeePerGas == maxFeePerGas) &&
            (identical(other.maxPriorityFeePerGas, maxPriorityFeePerGas) ||
                other.maxPriorityFeePerGas == maxPriorityFeePerGas));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, maxFeePerGas, maxPriorityFeePerGas);

  /// Create a copy of Eip1559EstimationCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$Eip1559EstimationCompatImplCopyWith<_$Eip1559EstimationCompatImpl>
      get copyWith => __$$Eip1559EstimationCompatImplCopyWithImpl<
          _$Eip1559EstimationCompatImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$Eip1559EstimationCompatImplToJson(
      this,
    );
  }
}

abstract class _Eip1559EstimationCompat implements Eip1559EstimationCompat {
  const factory _Eip1559EstimationCompat(
          {required final String maxFeePerGas,
          required final String maxPriorityFeePerGas}) =
      _$Eip1559EstimationCompatImpl;

  factory _Eip1559EstimationCompat.fromJson(Map<String, dynamic> json) =
      _$Eip1559EstimationCompatImpl.fromJson;

  @override
  String get maxFeePerGas;
  @override
  String get maxPriorityFeePerGas;

  /// Create a copy of Eip1559EstimationCompat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$Eip1559EstimationCompatImplCopyWith<_$Eip1559EstimationCompatImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ErrorCompat {
  String get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) general,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? general,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? general,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ErrorCompat_General value) general,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ErrorCompat_General value)? general,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ErrorCompat_General value)? general,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Create a copy of ErrorCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ErrorCompatCopyWith<ErrorCompat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorCompatCopyWith<$Res> {
  factory $ErrorCompatCopyWith(
          ErrorCompat value, $Res Function(ErrorCompat) then) =
      _$ErrorCompatCopyWithImpl<$Res, ErrorCompat>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$ErrorCompatCopyWithImpl<$Res, $Val extends ErrorCompat>
    implements $ErrorCompatCopyWith<$Res> {
  _$ErrorCompatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ErrorCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ErrorCompat_GeneralImplCopyWith<$Res>
    implements $ErrorCompatCopyWith<$Res> {
  factory _$$ErrorCompat_GeneralImplCopyWith(_$ErrorCompat_GeneralImpl value,
          $Res Function(_$ErrorCompat_GeneralImpl) then) =
      __$$ErrorCompat_GeneralImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorCompat_GeneralImplCopyWithImpl<$Res>
    extends _$ErrorCompatCopyWithImpl<$Res, _$ErrorCompat_GeneralImpl>
    implements _$$ErrorCompat_GeneralImplCopyWith<$Res> {
  __$$ErrorCompat_GeneralImplCopyWithImpl(_$ErrorCompat_GeneralImpl _value,
      $Res Function(_$ErrorCompat_GeneralImpl) _then)
      : super(_value, _then);

  /// Create a copy of ErrorCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorCompat_GeneralImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorCompat_GeneralImpl extends ErrorCompat_General {
  const _$ErrorCompat_GeneralImpl({required this.message}) : super._();

  @override
  final String message;

  @override
  String toString() {
    return 'ErrorCompat.general(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorCompat_GeneralImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ErrorCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorCompat_GeneralImplCopyWith<_$ErrorCompat_GeneralImpl> get copyWith =>
      __$$ErrorCompat_GeneralImplCopyWithImpl<_$ErrorCompat_GeneralImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) general,
  }) {
    return general(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? general,
  }) {
    return general?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? general,
    required TResult orElse(),
  }) {
    if (general != null) {
      return general(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ErrorCompat_General value) general,
  }) {
    return general(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ErrorCompat_General value)? general,
  }) {
    return general?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ErrorCompat_General value)? general,
    required TResult orElse(),
  }) {
    if (general != null) {
      return general(this);
    }
    return orElse();
  }
}

abstract class ErrorCompat_General extends ErrorCompat {
  const factory ErrorCompat_General({required final String message}) =
      _$ErrorCompat_GeneralImpl;
  const ErrorCompat_General._() : super._();

  @override
  String get message;

  /// Create a copy of ErrorCompat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorCompat_GeneralImplCopyWith<_$ErrorCompat_GeneralImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExecuteDetailsCompat _$ExecuteDetailsCompatFromJson(Map<String, dynamic> json) {
  return _ExecuteDetailsCompat.fromJson(json);
}

/// @nodoc
mixin _$ExecuteDetailsCompat {
// required TransactionReceiptCompat initialTxnReceipt,
  String get initialTxnReceipt => throw _privateConstructorUsedError;
  String get initialTxnHash => throw _privateConstructorUsedError;

  /// Serializes this ExecuteDetailsCompat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ExecuteDetailsCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExecuteDetailsCompatCopyWith<ExecuteDetailsCompat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExecuteDetailsCompatCopyWith<$Res> {
  factory $ExecuteDetailsCompatCopyWith(ExecuteDetailsCompat value,
          $Res Function(ExecuteDetailsCompat) then) =
      _$ExecuteDetailsCompatCopyWithImpl<$Res, ExecuteDetailsCompat>;
  @useResult
  $Res call({String initialTxnReceipt, String initialTxnHash});
}

/// @nodoc
class _$ExecuteDetailsCompatCopyWithImpl<$Res,
        $Val extends ExecuteDetailsCompat>
    implements $ExecuteDetailsCompatCopyWith<$Res> {
  _$ExecuteDetailsCompatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExecuteDetailsCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? initialTxnReceipt = null,
    Object? initialTxnHash = null,
  }) {
    return _then(_value.copyWith(
      initialTxnReceipt: null == initialTxnReceipt
          ? _value.initialTxnReceipt
          : initialTxnReceipt // ignore: cast_nullable_to_non_nullable
              as String,
      initialTxnHash: null == initialTxnHash
          ? _value.initialTxnHash
          : initialTxnHash // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExecuteDetailsCompatImplCopyWith<$Res>
    implements $ExecuteDetailsCompatCopyWith<$Res> {
  factory _$$ExecuteDetailsCompatImplCopyWith(_$ExecuteDetailsCompatImpl value,
          $Res Function(_$ExecuteDetailsCompatImpl) then) =
      __$$ExecuteDetailsCompatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String initialTxnReceipt, String initialTxnHash});
}

/// @nodoc
class __$$ExecuteDetailsCompatImplCopyWithImpl<$Res>
    extends _$ExecuteDetailsCompatCopyWithImpl<$Res, _$ExecuteDetailsCompatImpl>
    implements _$$ExecuteDetailsCompatImplCopyWith<$Res> {
  __$$ExecuteDetailsCompatImplCopyWithImpl(_$ExecuteDetailsCompatImpl _value,
      $Res Function(_$ExecuteDetailsCompatImpl) _then)
      : super(_value, _then);

  /// Create a copy of ExecuteDetailsCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? initialTxnReceipt = null,
    Object? initialTxnHash = null,
  }) {
    return _then(_$ExecuteDetailsCompatImpl(
      initialTxnReceipt: null == initialTxnReceipt
          ? _value.initialTxnReceipt
          : initialTxnReceipt // ignore: cast_nullable_to_non_nullable
              as String,
      initialTxnHash: null == initialTxnHash
          ? _value.initialTxnHash
          : initialTxnHash // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExecuteDetailsCompatImpl implements _ExecuteDetailsCompat {
  const _$ExecuteDetailsCompatImpl(
      {required this.initialTxnReceipt, required this.initialTxnHash});

  factory _$ExecuteDetailsCompatImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExecuteDetailsCompatImplFromJson(json);

// required TransactionReceiptCompat initialTxnReceipt,
  @override
  final String initialTxnReceipt;
  @override
  final String initialTxnHash;

  @override
  String toString() {
    return 'ExecuteDetailsCompat(initialTxnReceipt: $initialTxnReceipt, initialTxnHash: $initialTxnHash)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExecuteDetailsCompatImpl &&
            (identical(other.initialTxnReceipt, initialTxnReceipt) ||
                other.initialTxnReceipt == initialTxnReceipt) &&
            (identical(other.initialTxnHash, initialTxnHash) ||
                other.initialTxnHash == initialTxnHash));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, initialTxnReceipt, initialTxnHash);

  /// Create a copy of ExecuteDetailsCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExecuteDetailsCompatImplCopyWith<_$ExecuteDetailsCompatImpl>
      get copyWith =>
          __$$ExecuteDetailsCompatImplCopyWithImpl<_$ExecuteDetailsCompatImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExecuteDetailsCompatImplToJson(
      this,
    );
  }
}

abstract class _ExecuteDetailsCompat implements ExecuteDetailsCompat {
  const factory _ExecuteDetailsCompat(
      {required final String initialTxnReceipt,
      required final String initialTxnHash}) = _$ExecuteDetailsCompatImpl;

  factory _ExecuteDetailsCompat.fromJson(Map<String, dynamic> json) =
      _$ExecuteDetailsCompatImpl.fromJson;

// required TransactionReceiptCompat initialTxnReceipt,
  @override
  String get initialTxnReceipt;
  @override
  String get initialTxnHash;

  /// Create a copy of ExecuteDetailsCompat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExecuteDetailsCompatImplCopyWith<_$ExecuteDetailsCompatImpl>
      get copyWith => throw _privateConstructorUsedError;
}

FeeEstimatedTransactionCompat _$FeeEstimatedTransactionCompatFromJson(
    Map<String, dynamic> json) {
  return _FeeEstimatedTransactionCompat.fromJson(json);
}

/// @nodoc
mixin _$FeeEstimatedTransactionCompat {
  String get chainId => throw _privateConstructorUsedError;
  String get from => throw _privateConstructorUsedError;
  String get to => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;
  String get input => throw _privateConstructorUsedError;
  String get gasLimit => throw _privateConstructorUsedError;
  String get nonce => throw _privateConstructorUsedError;
  String get maxFeePerGas => throw _privateConstructorUsedError;
  String get maxPriorityFeePerGas => throw _privateConstructorUsedError;

  /// Serializes this FeeEstimatedTransactionCompat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FeeEstimatedTransactionCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeeEstimatedTransactionCompatCopyWith<FeeEstimatedTransactionCompat>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeeEstimatedTransactionCompatCopyWith<$Res> {
  factory $FeeEstimatedTransactionCompatCopyWith(
          FeeEstimatedTransactionCompat value,
          $Res Function(FeeEstimatedTransactionCompat) then) =
      _$FeeEstimatedTransactionCompatCopyWithImpl<$Res,
          FeeEstimatedTransactionCompat>;
  @useResult
  $Res call(
      {String chainId,
      String from,
      String to,
      String value,
      String input,
      String gasLimit,
      String nonce,
      String maxFeePerGas,
      String maxPriorityFeePerGas});
}

/// @nodoc
class _$FeeEstimatedTransactionCompatCopyWithImpl<$Res,
        $Val extends FeeEstimatedTransactionCompat>
    implements $FeeEstimatedTransactionCompatCopyWith<$Res> {
  _$FeeEstimatedTransactionCompatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeeEstimatedTransactionCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chainId = null,
    Object? from = null,
    Object? to = null,
    Object? value = null,
    Object? input = null,
    Object? gasLimit = null,
    Object? nonce = null,
    Object? maxFeePerGas = null,
    Object? maxPriorityFeePerGas = null,
  }) {
    return _then(_value.copyWith(
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as String,
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String,
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      input: null == input
          ? _value.input
          : input // ignore: cast_nullable_to_non_nullable
              as String,
      gasLimit: null == gasLimit
          ? _value.gasLimit
          : gasLimit // ignore: cast_nullable_to_non_nullable
              as String,
      nonce: null == nonce
          ? _value.nonce
          : nonce // ignore: cast_nullable_to_non_nullable
              as String,
      maxFeePerGas: null == maxFeePerGas
          ? _value.maxFeePerGas
          : maxFeePerGas // ignore: cast_nullable_to_non_nullable
              as String,
      maxPriorityFeePerGas: null == maxPriorityFeePerGas
          ? _value.maxPriorityFeePerGas
          : maxPriorityFeePerGas // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeeEstimatedTransactionCompatImplCopyWith<$Res>
    implements $FeeEstimatedTransactionCompatCopyWith<$Res> {
  factory _$$FeeEstimatedTransactionCompatImplCopyWith(
          _$FeeEstimatedTransactionCompatImpl value,
          $Res Function(_$FeeEstimatedTransactionCompatImpl) then) =
      __$$FeeEstimatedTransactionCompatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String chainId,
      String from,
      String to,
      String value,
      String input,
      String gasLimit,
      String nonce,
      String maxFeePerGas,
      String maxPriorityFeePerGas});
}

/// @nodoc
class __$$FeeEstimatedTransactionCompatImplCopyWithImpl<$Res>
    extends _$FeeEstimatedTransactionCompatCopyWithImpl<$Res,
        _$FeeEstimatedTransactionCompatImpl>
    implements _$$FeeEstimatedTransactionCompatImplCopyWith<$Res> {
  __$$FeeEstimatedTransactionCompatImplCopyWithImpl(
      _$FeeEstimatedTransactionCompatImpl _value,
      $Res Function(_$FeeEstimatedTransactionCompatImpl) _then)
      : super(_value, _then);

  /// Create a copy of FeeEstimatedTransactionCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chainId = null,
    Object? from = null,
    Object? to = null,
    Object? value = null,
    Object? input = null,
    Object? gasLimit = null,
    Object? nonce = null,
    Object? maxFeePerGas = null,
    Object? maxPriorityFeePerGas = null,
  }) {
    return _then(_$FeeEstimatedTransactionCompatImpl(
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as String,
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String,
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      input: null == input
          ? _value.input
          : input // ignore: cast_nullable_to_non_nullable
              as String,
      gasLimit: null == gasLimit
          ? _value.gasLimit
          : gasLimit // ignore: cast_nullable_to_non_nullable
              as String,
      nonce: null == nonce
          ? _value.nonce
          : nonce // ignore: cast_nullable_to_non_nullable
              as String,
      maxFeePerGas: null == maxFeePerGas
          ? _value.maxFeePerGas
          : maxFeePerGas // ignore: cast_nullable_to_non_nullable
              as String,
      maxPriorityFeePerGas: null == maxPriorityFeePerGas
          ? _value.maxPriorityFeePerGas
          : maxPriorityFeePerGas // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FeeEstimatedTransactionCompatImpl
    implements _FeeEstimatedTransactionCompat {
  const _$FeeEstimatedTransactionCompatImpl(
      {required this.chainId,
      required this.from,
      required this.to,
      required this.value,
      required this.input,
      required this.gasLimit,
      required this.nonce,
      required this.maxFeePerGas,
      required this.maxPriorityFeePerGas});

  factory _$FeeEstimatedTransactionCompatImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$FeeEstimatedTransactionCompatImplFromJson(json);

  @override
  final String chainId;
  @override
  final String from;
  @override
  final String to;
  @override
  final String value;
  @override
  final String input;
  @override
  final String gasLimit;
  @override
  final String nonce;
  @override
  final String maxFeePerGas;
  @override
  final String maxPriorityFeePerGas;

  @override
  String toString() {
    return 'FeeEstimatedTransactionCompat(chainId: $chainId, from: $from, to: $to, value: $value, input: $input, gasLimit: $gasLimit, nonce: $nonce, maxFeePerGas: $maxFeePerGas, maxPriorityFeePerGas: $maxPriorityFeePerGas)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeeEstimatedTransactionCompatImpl &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.input, input) || other.input == input) &&
            (identical(other.gasLimit, gasLimit) ||
                other.gasLimit == gasLimit) &&
            (identical(other.nonce, nonce) || other.nonce == nonce) &&
            (identical(other.maxFeePerGas, maxFeePerGas) ||
                other.maxFeePerGas == maxFeePerGas) &&
            (identical(other.maxPriorityFeePerGas, maxPriorityFeePerGas) ||
                other.maxPriorityFeePerGas == maxPriorityFeePerGas));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, chainId, from, to, value, input,
      gasLimit, nonce, maxFeePerGas, maxPriorityFeePerGas);

  /// Create a copy of FeeEstimatedTransactionCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeeEstimatedTransactionCompatImplCopyWith<
          _$FeeEstimatedTransactionCompatImpl>
      get copyWith => __$$FeeEstimatedTransactionCompatImplCopyWithImpl<
          _$FeeEstimatedTransactionCompatImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeeEstimatedTransactionCompatImplToJson(
      this,
    );
  }
}

abstract class _FeeEstimatedTransactionCompat
    implements FeeEstimatedTransactionCompat {
  const factory _FeeEstimatedTransactionCompat(
          {required final String chainId,
          required final String from,
          required final String to,
          required final String value,
          required final String input,
          required final String gasLimit,
          required final String nonce,
          required final String maxFeePerGas,
          required final String maxPriorityFeePerGas}) =
      _$FeeEstimatedTransactionCompatImpl;

  factory _FeeEstimatedTransactionCompat.fromJson(Map<String, dynamic> json) =
      _$FeeEstimatedTransactionCompatImpl.fromJson;

  @override
  String get chainId;
  @override
  String get from;
  @override
  String get to;
  @override
  String get value;
  @override
  String get input;
  @override
  String get gasLimit;
  @override
  String get nonce;
  @override
  String get maxFeePerGas;
  @override
  String get maxPriorityFeePerGas;

  /// Create a copy of FeeEstimatedTransactionCompat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeeEstimatedTransactionCompatImplCopyWith<
          _$FeeEstimatedTransactionCompatImpl>
      get copyWith => throw _privateConstructorUsedError;
}

FundingMetadataCompat _$FundingMetadataCompatFromJson(
    Map<String, dynamic> json) {
  return _FundingMetadataCompat.fromJson(json);
}

/// @nodoc
mixin _$FundingMetadataCompat {
  String get chainId => throw _privateConstructorUsedError;
  String get tokenContract => throw _privateConstructorUsedError;
  String get symbol => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;
  String get bridgingFee => throw _privateConstructorUsedError;
  int get decimals => throw _privateConstructorUsedError;

  /// Serializes this FundingMetadataCompat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FundingMetadataCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FundingMetadataCompatCopyWith<FundingMetadataCompat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FundingMetadataCompatCopyWith<$Res> {
  factory $FundingMetadataCompatCopyWith(FundingMetadataCompat value,
          $Res Function(FundingMetadataCompat) then) =
      _$FundingMetadataCompatCopyWithImpl<$Res, FundingMetadataCompat>;
  @useResult
  $Res call(
      {String chainId,
      String tokenContract,
      String symbol,
      String amount,
      String bridgingFee,
      int decimals});
}

/// @nodoc
class _$FundingMetadataCompatCopyWithImpl<$Res,
        $Val extends FundingMetadataCompat>
    implements $FundingMetadataCompatCopyWith<$Res> {
  _$FundingMetadataCompatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FundingMetadataCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chainId = null,
    Object? tokenContract = null,
    Object? symbol = null,
    Object? amount = null,
    Object? bridgingFee = null,
    Object? decimals = null,
  }) {
    return _then(_value.copyWith(
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as String,
      tokenContract: null == tokenContract
          ? _value.tokenContract
          : tokenContract // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      bridgingFee: null == bridgingFee
          ? _value.bridgingFee
          : bridgingFee // ignore: cast_nullable_to_non_nullable
              as String,
      decimals: null == decimals
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FundingMetadataCompatImplCopyWith<$Res>
    implements $FundingMetadataCompatCopyWith<$Res> {
  factory _$$FundingMetadataCompatImplCopyWith(
          _$FundingMetadataCompatImpl value,
          $Res Function(_$FundingMetadataCompatImpl) then) =
      __$$FundingMetadataCompatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String chainId,
      String tokenContract,
      String symbol,
      String amount,
      String bridgingFee,
      int decimals});
}

/// @nodoc
class __$$FundingMetadataCompatImplCopyWithImpl<$Res>
    extends _$FundingMetadataCompatCopyWithImpl<$Res,
        _$FundingMetadataCompatImpl>
    implements _$$FundingMetadataCompatImplCopyWith<$Res> {
  __$$FundingMetadataCompatImplCopyWithImpl(_$FundingMetadataCompatImpl _value,
      $Res Function(_$FundingMetadataCompatImpl) _then)
      : super(_value, _then);

  /// Create a copy of FundingMetadataCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chainId = null,
    Object? tokenContract = null,
    Object? symbol = null,
    Object? amount = null,
    Object? bridgingFee = null,
    Object? decimals = null,
  }) {
    return _then(_$FundingMetadataCompatImpl(
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as String,
      tokenContract: null == tokenContract
          ? _value.tokenContract
          : tokenContract // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      bridgingFee: null == bridgingFee
          ? _value.bridgingFee
          : bridgingFee // ignore: cast_nullable_to_non_nullable
              as String,
      decimals: null == decimals
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FundingMetadataCompatImpl implements _FundingMetadataCompat {
  const _$FundingMetadataCompatImpl(
      {required this.chainId,
      required this.tokenContract,
      required this.symbol,
      required this.amount,
      required this.bridgingFee,
      required this.decimals});

  factory _$FundingMetadataCompatImpl.fromJson(Map<String, dynamic> json) =>
      _$$FundingMetadataCompatImplFromJson(json);

  @override
  final String chainId;
  @override
  final String tokenContract;
  @override
  final String symbol;
  @override
  final String amount;
  @override
  final String bridgingFee;
  @override
  final int decimals;

  @override
  String toString() {
    return 'FundingMetadataCompat(chainId: $chainId, tokenContract: $tokenContract, symbol: $symbol, amount: $amount, bridgingFee: $bridgingFee, decimals: $decimals)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FundingMetadataCompatImpl &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            (identical(other.tokenContract, tokenContract) ||
                other.tokenContract == tokenContract) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.bridgingFee, bridgingFee) ||
                other.bridgingFee == bridgingFee) &&
            (identical(other.decimals, decimals) ||
                other.decimals == decimals));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, chainId, tokenContract, symbol,
      amount, bridgingFee, decimals);

  /// Create a copy of FundingMetadataCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FundingMetadataCompatImplCopyWith<_$FundingMetadataCompatImpl>
      get copyWith => __$$FundingMetadataCompatImplCopyWithImpl<
          _$FundingMetadataCompatImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FundingMetadataCompatImplToJson(
      this,
    );
  }
}

abstract class _FundingMetadataCompat implements FundingMetadataCompat {
  const factory _FundingMetadataCompat(
      {required final String chainId,
      required final String tokenContract,
      required final String symbol,
      required final String amount,
      required final String bridgingFee,
      required final int decimals}) = _$FundingMetadataCompatImpl;

  factory _FundingMetadataCompat.fromJson(Map<String, dynamic> json) =
      _$FundingMetadataCompatImpl.fromJson;

  @override
  String get chainId;
  @override
  String get tokenContract;
  @override
  String get symbol;
  @override
  String get amount;
  @override
  String get bridgingFee;
  @override
  int get decimals;

  /// Create a copy of FundingMetadataCompat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FundingMetadataCompatImplCopyWith<_$FundingMetadataCompatImpl>
      get copyWith => throw _privateConstructorUsedError;
}

InitialTransactionMetadataCompat _$InitialTransactionMetadataCompatFromJson(
    Map<String, dynamic> json) {
  return _InitialTransactionMetadataCompat.fromJson(json);
}

/// @nodoc
mixin _$InitialTransactionMetadataCompat {
  String get transferTo => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;
  String get tokenContract => throw _privateConstructorUsedError;
  String get symbol => throw _privateConstructorUsedError;
  int get decimals => throw _privateConstructorUsedError;

  /// Serializes this InitialTransactionMetadataCompat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InitialTransactionMetadataCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InitialTransactionMetadataCompatCopyWith<InitialTransactionMetadataCompat>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InitialTransactionMetadataCompatCopyWith<$Res> {
  factory $InitialTransactionMetadataCompatCopyWith(
          InitialTransactionMetadataCompat value,
          $Res Function(InitialTransactionMetadataCompat) then) =
      _$InitialTransactionMetadataCompatCopyWithImpl<$Res,
          InitialTransactionMetadataCompat>;
  @useResult
  $Res call(
      {String transferTo,
      String amount,
      String tokenContract,
      String symbol,
      int decimals});
}

/// @nodoc
class _$InitialTransactionMetadataCompatCopyWithImpl<$Res,
        $Val extends InitialTransactionMetadataCompat>
    implements $InitialTransactionMetadataCompatCopyWith<$Res> {
  _$InitialTransactionMetadataCompatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InitialTransactionMetadataCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transferTo = null,
    Object? amount = null,
    Object? tokenContract = null,
    Object? symbol = null,
    Object? decimals = null,
  }) {
    return _then(_value.copyWith(
      transferTo: null == transferTo
          ? _value.transferTo
          : transferTo // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      tokenContract: null == tokenContract
          ? _value.tokenContract
          : tokenContract // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      decimals: null == decimals
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialTransactionMetadataCompatImplCopyWith<$Res>
    implements $InitialTransactionMetadataCompatCopyWith<$Res> {
  factory _$$InitialTransactionMetadataCompatImplCopyWith(
          _$InitialTransactionMetadataCompatImpl value,
          $Res Function(_$InitialTransactionMetadataCompatImpl) then) =
      __$$InitialTransactionMetadataCompatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String transferTo,
      String amount,
      String tokenContract,
      String symbol,
      int decimals});
}

/// @nodoc
class __$$InitialTransactionMetadataCompatImplCopyWithImpl<$Res>
    extends _$InitialTransactionMetadataCompatCopyWithImpl<$Res,
        _$InitialTransactionMetadataCompatImpl>
    implements _$$InitialTransactionMetadataCompatImplCopyWith<$Res> {
  __$$InitialTransactionMetadataCompatImplCopyWithImpl(
      _$InitialTransactionMetadataCompatImpl _value,
      $Res Function(_$InitialTransactionMetadataCompatImpl) _then)
      : super(_value, _then);

  /// Create a copy of InitialTransactionMetadataCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transferTo = null,
    Object? amount = null,
    Object? tokenContract = null,
    Object? symbol = null,
    Object? decimals = null,
  }) {
    return _then(_$InitialTransactionMetadataCompatImpl(
      transferTo: null == transferTo
          ? _value.transferTo
          : transferTo // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String,
      tokenContract: null == tokenContract
          ? _value.tokenContract
          : tokenContract // ignore: cast_nullable_to_non_nullable
              as String,
      symbol: null == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String,
      decimals: null == decimals
          ? _value.decimals
          : decimals // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InitialTransactionMetadataCompatImpl
    implements _InitialTransactionMetadataCompat {
  const _$InitialTransactionMetadataCompatImpl(
      {required this.transferTo,
      required this.amount,
      required this.tokenContract,
      required this.symbol,
      required this.decimals});

  factory _$InitialTransactionMetadataCompatImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$InitialTransactionMetadataCompatImplFromJson(json);

  @override
  final String transferTo;
  @override
  final String amount;
  @override
  final String tokenContract;
  @override
  final String symbol;
  @override
  final int decimals;

  @override
  String toString() {
    return 'InitialTransactionMetadataCompat(transferTo: $transferTo, amount: $amount, tokenContract: $tokenContract, symbol: $symbol, decimals: $decimals)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialTransactionMetadataCompatImpl &&
            (identical(other.transferTo, transferTo) ||
                other.transferTo == transferTo) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.tokenContract, tokenContract) ||
                other.tokenContract == tokenContract) &&
            (identical(other.symbol, symbol) || other.symbol == symbol) &&
            (identical(other.decimals, decimals) ||
                other.decimals == decimals));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, transferTo, amount, tokenContract, symbol, decimals);

  /// Create a copy of InitialTransactionMetadataCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialTransactionMetadataCompatImplCopyWith<
          _$InitialTransactionMetadataCompatImpl>
      get copyWith => __$$InitialTransactionMetadataCompatImplCopyWithImpl<
          _$InitialTransactionMetadataCompatImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InitialTransactionMetadataCompatImplToJson(
      this,
    );
  }
}

abstract class _InitialTransactionMetadataCompat
    implements InitialTransactionMetadataCompat {
  const factory _InitialTransactionMetadataCompat(
      {required final String transferTo,
      required final String amount,
      required final String tokenContract,
      required final String symbol,
      required final int decimals}) = _$InitialTransactionMetadataCompatImpl;

  factory _InitialTransactionMetadataCompat.fromJson(
          Map<String, dynamic> json) =
      _$InitialTransactionMetadataCompatImpl.fromJson;

  @override
  String get transferTo;
  @override
  String get amount;
  @override
  String get tokenContract;
  @override
  String get symbol;
  @override
  int get decimals;

  /// Create a copy of InitialTransactionMetadataCompat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InitialTransactionMetadataCompatImplCopyWith<
          _$InitialTransactionMetadataCompatImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MetadataCompat _$MetadataCompatFromJson(Map<String, dynamic> json) {
  return _MetadataCompat.fromJson(json);
}

/// @nodoc
mixin _$MetadataCompat {
  List<FundingMetadataCompat> get fundingFrom =>
      throw _privateConstructorUsedError;
  InitialTransactionMetadataCompat get initialTransaction =>
      throw _privateConstructorUsedError;
  BigInt get checkIn => throw _privateConstructorUsedError;

  /// Serializes this MetadataCompat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MetadataCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MetadataCompatCopyWith<MetadataCompat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MetadataCompatCopyWith<$Res> {
  factory $MetadataCompatCopyWith(
          MetadataCompat value, $Res Function(MetadataCompat) then) =
      _$MetadataCompatCopyWithImpl<$Res, MetadataCompat>;
  @useResult
  $Res call(
      {List<FundingMetadataCompat> fundingFrom,
      InitialTransactionMetadataCompat initialTransaction,
      BigInt checkIn});

  $InitialTransactionMetadataCompatCopyWith<$Res> get initialTransaction;
}

/// @nodoc
class _$MetadataCompatCopyWithImpl<$Res, $Val extends MetadataCompat>
    implements $MetadataCompatCopyWith<$Res> {
  _$MetadataCompatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MetadataCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fundingFrom = null,
    Object? initialTransaction = null,
    Object? checkIn = null,
  }) {
    return _then(_value.copyWith(
      fundingFrom: null == fundingFrom
          ? _value.fundingFrom
          : fundingFrom // ignore: cast_nullable_to_non_nullable
              as List<FundingMetadataCompat>,
      initialTransaction: null == initialTransaction
          ? _value.initialTransaction
          : initialTransaction // ignore: cast_nullable_to_non_nullable
              as InitialTransactionMetadataCompat,
      checkIn: null == checkIn
          ? _value.checkIn
          : checkIn // ignore: cast_nullable_to_non_nullable
              as BigInt,
    ) as $Val);
  }

  /// Create a copy of MetadataCompat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $InitialTransactionMetadataCompatCopyWith<$Res> get initialTransaction {
    return $InitialTransactionMetadataCompatCopyWith<$Res>(
        _value.initialTransaction, (value) {
      return _then(_value.copyWith(initialTransaction: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MetadataCompatImplCopyWith<$Res>
    implements $MetadataCompatCopyWith<$Res> {
  factory _$$MetadataCompatImplCopyWith(_$MetadataCompatImpl value,
          $Res Function(_$MetadataCompatImpl) then) =
      __$$MetadataCompatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<FundingMetadataCompat> fundingFrom,
      InitialTransactionMetadataCompat initialTransaction,
      BigInt checkIn});

  @override
  $InitialTransactionMetadataCompatCopyWith<$Res> get initialTransaction;
}

/// @nodoc
class __$$MetadataCompatImplCopyWithImpl<$Res>
    extends _$MetadataCompatCopyWithImpl<$Res, _$MetadataCompatImpl>
    implements _$$MetadataCompatImplCopyWith<$Res> {
  __$$MetadataCompatImplCopyWithImpl(
      _$MetadataCompatImpl _value, $Res Function(_$MetadataCompatImpl) _then)
      : super(_value, _then);

  /// Create a copy of MetadataCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fundingFrom = null,
    Object? initialTransaction = null,
    Object? checkIn = null,
  }) {
    return _then(_$MetadataCompatImpl(
      fundingFrom: null == fundingFrom
          ? _value._fundingFrom
          : fundingFrom // ignore: cast_nullable_to_non_nullable
              as List<FundingMetadataCompat>,
      initialTransaction: null == initialTransaction
          ? _value.initialTransaction
          : initialTransaction // ignore: cast_nullable_to_non_nullable
              as InitialTransactionMetadataCompat,
      checkIn: null == checkIn
          ? _value.checkIn
          : checkIn // ignore: cast_nullable_to_non_nullable
              as BigInt,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MetadataCompatImpl implements _MetadataCompat {
  const _$MetadataCompatImpl(
      {required final List<FundingMetadataCompat> fundingFrom,
      required this.initialTransaction,
      required this.checkIn})
      : _fundingFrom = fundingFrom;

  factory _$MetadataCompatImpl.fromJson(Map<String, dynamic> json) =>
      _$$MetadataCompatImplFromJson(json);

  final List<FundingMetadataCompat> _fundingFrom;
  @override
  List<FundingMetadataCompat> get fundingFrom {
    if (_fundingFrom is EqualUnmodifiableListView) return _fundingFrom;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fundingFrom);
  }

  @override
  final InitialTransactionMetadataCompat initialTransaction;
  @override
  final BigInt checkIn;

  @override
  String toString() {
    return 'MetadataCompat(fundingFrom: $fundingFrom, initialTransaction: $initialTransaction, checkIn: $checkIn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MetadataCompatImpl &&
            const DeepCollectionEquality()
                .equals(other._fundingFrom, _fundingFrom) &&
            (identical(other.initialTransaction, initialTransaction) ||
                other.initialTransaction == initialTransaction) &&
            (identical(other.checkIn, checkIn) || other.checkIn == checkIn));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_fundingFrom),
      initialTransaction,
      checkIn);

  /// Create a copy of MetadataCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MetadataCompatImplCopyWith<_$MetadataCompatImpl> get copyWith =>
      __$$MetadataCompatImplCopyWithImpl<_$MetadataCompatImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MetadataCompatImplToJson(
      this,
    );
  }
}

abstract class _MetadataCompat implements MetadataCompat {
  const factory _MetadataCompat(
      {required final List<FundingMetadataCompat> fundingFrom,
      required final InitialTransactionMetadataCompat initialTransaction,
      required final BigInt checkIn}) = _$MetadataCompatImpl;

  factory _MetadataCompat.fromJson(Map<String, dynamic> json) =
      _$MetadataCompatImpl.fromJson;

  @override
  List<FundingMetadataCompat> get fundingFrom;
  @override
  InitialTransactionMetadataCompat get initialTransaction;
  @override
  BigInt get checkIn;

  /// Create a copy of MetadataCompat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MetadataCompatImplCopyWith<_$MetadataCompatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PrepareDetailedResponseCompat {
  Object get value => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PrepareDetailedResponseSuccessCompat value)
        success,
    required TResult Function(PrepareDetailedResponseError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PrepareDetailedResponseSuccessCompat value)? success,
    TResult? Function(PrepareDetailedResponseError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PrepareDetailedResponseSuccessCompat value)? success,
    TResult Function(PrepareDetailedResponseError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PrepareDetailedResponseCompat_Success value)
        success,
    required TResult Function(PrepareDetailedResponseCompat_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PrepareDetailedResponseCompat_Success value)? success,
    TResult? Function(PrepareDetailedResponseCompat_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PrepareDetailedResponseCompat_Success value)? success,
    TResult Function(PrepareDetailedResponseCompat_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrepareDetailedResponseCompatCopyWith<$Res> {
  factory $PrepareDetailedResponseCompatCopyWith(
          PrepareDetailedResponseCompat value,
          $Res Function(PrepareDetailedResponseCompat) then) =
      _$PrepareDetailedResponseCompatCopyWithImpl<$Res,
          PrepareDetailedResponseCompat>;
}

/// @nodoc
class _$PrepareDetailedResponseCompatCopyWithImpl<$Res,
        $Val extends PrepareDetailedResponseCompat>
    implements $PrepareDetailedResponseCompatCopyWith<$Res> {
  _$PrepareDetailedResponseCompatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PrepareDetailedResponseCompat
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$PrepareDetailedResponseCompat_SuccessImplCopyWith<$Res> {
  factory _$$PrepareDetailedResponseCompat_SuccessImplCopyWith(
          _$PrepareDetailedResponseCompat_SuccessImpl value,
          $Res Function(_$PrepareDetailedResponseCompat_SuccessImpl) then) =
      __$$PrepareDetailedResponseCompat_SuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PrepareDetailedResponseSuccessCompat value});

  $PrepareDetailedResponseSuccessCompatCopyWith<$Res> get value;
}

/// @nodoc
class __$$PrepareDetailedResponseCompat_SuccessImplCopyWithImpl<$Res>
    extends _$PrepareDetailedResponseCompatCopyWithImpl<$Res,
        _$PrepareDetailedResponseCompat_SuccessImpl>
    implements _$$PrepareDetailedResponseCompat_SuccessImplCopyWith<$Res> {
  __$$PrepareDetailedResponseCompat_SuccessImplCopyWithImpl(
      _$PrepareDetailedResponseCompat_SuccessImpl _value,
      $Res Function(_$PrepareDetailedResponseCompat_SuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of PrepareDetailedResponseCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$PrepareDetailedResponseCompat_SuccessImpl(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as PrepareDetailedResponseSuccessCompat,
    ));
  }

  /// Create a copy of PrepareDetailedResponseCompat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PrepareDetailedResponseSuccessCompatCopyWith<$Res> get value {
    return $PrepareDetailedResponseSuccessCompatCopyWith<$Res>(_value.value,
        (value) {
      return _then(_value.copyWith(value: value));
    });
  }
}

/// @nodoc

class _$PrepareDetailedResponseCompat_SuccessImpl
    extends PrepareDetailedResponseCompat_Success {
  const _$PrepareDetailedResponseCompat_SuccessImpl({required this.value})
      : super._();

  @override
  final PrepareDetailedResponseSuccessCompat value;

  @override
  String toString() {
    return 'PrepareDetailedResponseCompat.success(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrepareDetailedResponseCompat_SuccessImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of PrepareDetailedResponseCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PrepareDetailedResponseCompat_SuccessImplCopyWith<
          _$PrepareDetailedResponseCompat_SuccessImpl>
      get copyWith => __$$PrepareDetailedResponseCompat_SuccessImplCopyWithImpl<
          _$PrepareDetailedResponseCompat_SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PrepareDetailedResponseSuccessCompat value)
        success,
    required TResult Function(PrepareDetailedResponseError value) error,
  }) {
    return success(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PrepareDetailedResponseSuccessCompat value)? success,
    TResult? Function(PrepareDetailedResponseError value)? error,
  }) {
    return success?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PrepareDetailedResponseSuccessCompat value)? success,
    TResult Function(PrepareDetailedResponseError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PrepareDetailedResponseCompat_Success value)
        success,
    required TResult Function(PrepareDetailedResponseCompat_Error value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PrepareDetailedResponseCompat_Success value)? success,
    TResult? Function(PrepareDetailedResponseCompat_Error value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PrepareDetailedResponseCompat_Success value)? success,
    TResult Function(PrepareDetailedResponseCompat_Error value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class PrepareDetailedResponseCompat_Success
    extends PrepareDetailedResponseCompat {
  const factory PrepareDetailedResponseCompat_Success(
          {required final PrepareDetailedResponseSuccessCompat value}) =
      _$PrepareDetailedResponseCompat_SuccessImpl;
  const PrepareDetailedResponseCompat_Success._() : super._();

  @override
  PrepareDetailedResponseSuccessCompat get value;

  /// Create a copy of PrepareDetailedResponseCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PrepareDetailedResponseCompat_SuccessImplCopyWith<
          _$PrepareDetailedResponseCompat_SuccessImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PrepareDetailedResponseCompat_ErrorImplCopyWith<$Res> {
  factory _$$PrepareDetailedResponseCompat_ErrorImplCopyWith(
          _$PrepareDetailedResponseCompat_ErrorImpl value,
          $Res Function(_$PrepareDetailedResponseCompat_ErrorImpl) then) =
      __$$PrepareDetailedResponseCompat_ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PrepareDetailedResponseError value});
}

/// @nodoc
class __$$PrepareDetailedResponseCompat_ErrorImplCopyWithImpl<$Res>
    extends _$PrepareDetailedResponseCompatCopyWithImpl<$Res,
        _$PrepareDetailedResponseCompat_ErrorImpl>
    implements _$$PrepareDetailedResponseCompat_ErrorImplCopyWith<$Res> {
  __$$PrepareDetailedResponseCompat_ErrorImplCopyWithImpl(
      _$PrepareDetailedResponseCompat_ErrorImpl _value,
      $Res Function(_$PrepareDetailedResponseCompat_ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of PrepareDetailedResponseCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$PrepareDetailedResponseCompat_ErrorImpl(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as PrepareDetailedResponseError,
    ));
  }
}

/// @nodoc

class _$PrepareDetailedResponseCompat_ErrorImpl
    extends PrepareDetailedResponseCompat_Error {
  const _$PrepareDetailedResponseCompat_ErrorImpl({required this.value})
      : super._();

  @override
  final PrepareDetailedResponseError value;

  @override
  String toString() {
    return 'PrepareDetailedResponseCompat.error(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrepareDetailedResponseCompat_ErrorImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of PrepareDetailedResponseCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PrepareDetailedResponseCompat_ErrorImplCopyWith<
          _$PrepareDetailedResponseCompat_ErrorImpl>
      get copyWith => __$$PrepareDetailedResponseCompat_ErrorImplCopyWithImpl<
          _$PrepareDetailedResponseCompat_ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(PrepareDetailedResponseSuccessCompat value)
        success,
    required TResult Function(PrepareDetailedResponseError value) error,
  }) {
    return error(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(PrepareDetailedResponseSuccessCompat value)? success,
    TResult? Function(PrepareDetailedResponseError value)? error,
  }) {
    return error?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(PrepareDetailedResponseSuccessCompat value)? success,
    TResult Function(PrepareDetailedResponseError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PrepareDetailedResponseCompat_Success value)
        success,
    required TResult Function(PrepareDetailedResponseCompat_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PrepareDetailedResponseCompat_Success value)? success,
    TResult? Function(PrepareDetailedResponseCompat_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PrepareDetailedResponseCompat_Success value)? success,
    TResult Function(PrepareDetailedResponseCompat_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class PrepareDetailedResponseCompat_Error
    extends PrepareDetailedResponseCompat {
  const factory PrepareDetailedResponseCompat_Error(
          {required final PrepareDetailedResponseError value}) =
      _$PrepareDetailedResponseCompat_ErrorImpl;
  const PrepareDetailedResponseCompat_Error._() : super._();

  @override
  PrepareDetailedResponseError get value;

  /// Create a copy of PrepareDetailedResponseCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PrepareDetailedResponseCompat_ErrorImplCopyWith<
          _$PrepareDetailedResponseCompat_ErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PrepareDetailedResponseSuccessCompat
    _$PrepareDetailedResponseSuccessCompatFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'available':
      return PrepareDetailedResponseSuccessCompat_Available.fromJson(json);
    case 'notRequired':
      return PrepareDetailedResponseSuccessCompat_NotRequired.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json,
          'runtimeType',
          'PrepareDetailedResponseSuccessCompat',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$PrepareDetailedResponseSuccessCompat {
  Object get value => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UiFieldsCompat value) available,
    required TResult Function(PrepareResponseNotRequiredCompat value)
        notRequired,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UiFieldsCompat value)? available,
    TResult? Function(PrepareResponseNotRequiredCompat value)? notRequired,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UiFieldsCompat value)? available,
    TResult Function(PrepareResponseNotRequiredCompat value)? notRequired,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(
            PrepareDetailedResponseSuccessCompat_Available value)
        available,
    required TResult Function(
            PrepareDetailedResponseSuccessCompat_NotRequired value)
        notRequired,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PrepareDetailedResponseSuccessCompat_Available value)?
        available,
    TResult? Function(PrepareDetailedResponseSuccessCompat_NotRequired value)?
        notRequired,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PrepareDetailedResponseSuccessCompat_Available value)?
        available,
    TResult Function(PrepareDetailedResponseSuccessCompat_NotRequired value)?
        notRequired,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  /// Serializes this PrepareDetailedResponseSuccessCompat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrepareDetailedResponseSuccessCompatCopyWith<$Res> {
  factory $PrepareDetailedResponseSuccessCompatCopyWith(
          PrepareDetailedResponseSuccessCompat value,
          $Res Function(PrepareDetailedResponseSuccessCompat) then) =
      _$PrepareDetailedResponseSuccessCompatCopyWithImpl<$Res,
          PrepareDetailedResponseSuccessCompat>;
}

/// @nodoc
class _$PrepareDetailedResponseSuccessCompatCopyWithImpl<$Res,
        $Val extends PrepareDetailedResponseSuccessCompat>
    implements $PrepareDetailedResponseSuccessCompatCopyWith<$Res> {
  _$PrepareDetailedResponseSuccessCompatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PrepareDetailedResponseSuccessCompat
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$PrepareDetailedResponseSuccessCompat_AvailableImplCopyWith<
    $Res> {
  factory _$$PrepareDetailedResponseSuccessCompat_AvailableImplCopyWith(
          _$PrepareDetailedResponseSuccessCompat_AvailableImpl value,
          $Res Function(_$PrepareDetailedResponseSuccessCompat_AvailableImpl)
              then) =
      __$$PrepareDetailedResponseSuccessCompat_AvailableImplCopyWithImpl<$Res>;
  @useResult
  $Res call({UiFieldsCompat value});

  $UiFieldsCompatCopyWith<$Res> get value;
}

/// @nodoc
class __$$PrepareDetailedResponseSuccessCompat_AvailableImplCopyWithImpl<$Res>
    extends _$PrepareDetailedResponseSuccessCompatCopyWithImpl<$Res,
        _$PrepareDetailedResponseSuccessCompat_AvailableImpl>
    implements
        _$$PrepareDetailedResponseSuccessCompat_AvailableImplCopyWith<$Res> {
  __$$PrepareDetailedResponseSuccessCompat_AvailableImplCopyWithImpl(
      _$PrepareDetailedResponseSuccessCompat_AvailableImpl _value,
      $Res Function(_$PrepareDetailedResponseSuccessCompat_AvailableImpl) _then)
      : super(_value, _then);

  /// Create a copy of PrepareDetailedResponseSuccessCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$PrepareDetailedResponseSuccessCompat_AvailableImpl(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as UiFieldsCompat,
    ));
  }

  /// Create a copy of PrepareDetailedResponseSuccessCompat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UiFieldsCompatCopyWith<$Res> get value {
    return $UiFieldsCompatCopyWith<$Res>(_value.value, (value) {
      return _then(_value.copyWith(value: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$PrepareDetailedResponseSuccessCompat_AvailableImpl
    extends PrepareDetailedResponseSuccessCompat_Available {
  const _$PrepareDetailedResponseSuccessCompat_AvailableImpl(
      {required this.value, final String? $type})
      : $type = $type ?? 'available',
        super._();

  factory _$PrepareDetailedResponseSuccessCompat_AvailableImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$PrepareDetailedResponseSuccessCompat_AvailableImplFromJson(json);

  @override
  final UiFieldsCompat value;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'PrepareDetailedResponseSuccessCompat.available(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrepareDetailedResponseSuccessCompat_AvailableImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of PrepareDetailedResponseSuccessCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PrepareDetailedResponseSuccessCompat_AvailableImplCopyWith<
          _$PrepareDetailedResponseSuccessCompat_AvailableImpl>
      get copyWith =>
          __$$PrepareDetailedResponseSuccessCompat_AvailableImplCopyWithImpl<
                  _$PrepareDetailedResponseSuccessCompat_AvailableImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UiFieldsCompat value) available,
    required TResult Function(PrepareResponseNotRequiredCompat value)
        notRequired,
  }) {
    return available(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UiFieldsCompat value)? available,
    TResult? Function(PrepareResponseNotRequiredCompat value)? notRequired,
  }) {
    return available?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UiFieldsCompat value)? available,
    TResult Function(PrepareResponseNotRequiredCompat value)? notRequired,
    required TResult orElse(),
  }) {
    if (available != null) {
      return available(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(
            PrepareDetailedResponseSuccessCompat_Available value)
        available,
    required TResult Function(
            PrepareDetailedResponseSuccessCompat_NotRequired value)
        notRequired,
  }) {
    return available(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PrepareDetailedResponseSuccessCompat_Available value)?
        available,
    TResult? Function(PrepareDetailedResponseSuccessCompat_NotRequired value)?
        notRequired,
  }) {
    return available?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PrepareDetailedResponseSuccessCompat_Available value)?
        available,
    TResult Function(PrepareDetailedResponseSuccessCompat_NotRequired value)?
        notRequired,
    required TResult orElse(),
  }) {
    if (available != null) {
      return available(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PrepareDetailedResponseSuccessCompat_AvailableImplToJson(
      this,
    );
  }
}

abstract class PrepareDetailedResponseSuccessCompat_Available
    extends PrepareDetailedResponseSuccessCompat {
  const factory PrepareDetailedResponseSuccessCompat_Available(
          {required final UiFieldsCompat value}) =
      _$PrepareDetailedResponseSuccessCompat_AvailableImpl;
  const PrepareDetailedResponseSuccessCompat_Available._() : super._();

  factory PrepareDetailedResponseSuccessCompat_Available.fromJson(
          Map<String, dynamic> json) =
      _$PrepareDetailedResponseSuccessCompat_AvailableImpl.fromJson;

  @override
  UiFieldsCompat get value;

  /// Create a copy of PrepareDetailedResponseSuccessCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PrepareDetailedResponseSuccessCompat_AvailableImplCopyWith<
          _$PrepareDetailedResponseSuccessCompat_AvailableImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PrepareDetailedResponseSuccessCompat_NotRequiredImplCopyWith<
    $Res> {
  factory _$$PrepareDetailedResponseSuccessCompat_NotRequiredImplCopyWith(
          _$PrepareDetailedResponseSuccessCompat_NotRequiredImpl value,
          $Res Function(_$PrepareDetailedResponseSuccessCompat_NotRequiredImpl)
              then) =
      __$$PrepareDetailedResponseSuccessCompat_NotRequiredImplCopyWithImpl<
          $Res>;
  @useResult
  $Res call({PrepareResponseNotRequiredCompat value});

  $PrepareResponseNotRequiredCompatCopyWith<$Res> get value;
}

/// @nodoc
class __$$PrepareDetailedResponseSuccessCompat_NotRequiredImplCopyWithImpl<$Res>
    extends _$PrepareDetailedResponseSuccessCompatCopyWithImpl<$Res,
        _$PrepareDetailedResponseSuccessCompat_NotRequiredImpl>
    implements
        _$$PrepareDetailedResponseSuccessCompat_NotRequiredImplCopyWith<$Res> {
  __$$PrepareDetailedResponseSuccessCompat_NotRequiredImplCopyWithImpl(
      _$PrepareDetailedResponseSuccessCompat_NotRequiredImpl _value,
      $Res Function(_$PrepareDetailedResponseSuccessCompat_NotRequiredImpl)
          _then)
      : super(_value, _then);

  /// Create a copy of PrepareDetailedResponseSuccessCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? value = null,
  }) {
    return _then(_$PrepareDetailedResponseSuccessCompat_NotRequiredImpl(
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as PrepareResponseNotRequiredCompat,
    ));
  }

  /// Create a copy of PrepareDetailedResponseSuccessCompat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PrepareResponseNotRequiredCompatCopyWith<$Res> get value {
    return $PrepareResponseNotRequiredCompatCopyWith<$Res>(_value.value,
        (value) {
      return _then(_value.copyWith(value: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _$PrepareDetailedResponseSuccessCompat_NotRequiredImpl
    extends PrepareDetailedResponseSuccessCompat_NotRequired {
  const _$PrepareDetailedResponseSuccessCompat_NotRequiredImpl(
      {required this.value, final String? $type})
      : $type = $type ?? 'notRequired',
        super._();

  factory _$PrepareDetailedResponseSuccessCompat_NotRequiredImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$PrepareDetailedResponseSuccessCompat_NotRequiredImplFromJson(json);

  @override
  final PrepareResponseNotRequiredCompat value;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'PrepareDetailedResponseSuccessCompat.notRequired(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrepareDetailedResponseSuccessCompat_NotRequiredImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of PrepareDetailedResponseSuccessCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PrepareDetailedResponseSuccessCompat_NotRequiredImplCopyWith<
          _$PrepareDetailedResponseSuccessCompat_NotRequiredImpl>
      get copyWith =>
          __$$PrepareDetailedResponseSuccessCompat_NotRequiredImplCopyWithImpl<
                  _$PrepareDetailedResponseSuccessCompat_NotRequiredImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(UiFieldsCompat value) available,
    required TResult Function(PrepareResponseNotRequiredCompat value)
        notRequired,
  }) {
    return notRequired(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(UiFieldsCompat value)? available,
    TResult? Function(PrepareResponseNotRequiredCompat value)? notRequired,
  }) {
    return notRequired?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(UiFieldsCompat value)? available,
    TResult Function(PrepareResponseNotRequiredCompat value)? notRequired,
    required TResult orElse(),
  }) {
    if (notRequired != null) {
      return notRequired(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(
            PrepareDetailedResponseSuccessCompat_Available value)
        available,
    required TResult Function(
            PrepareDetailedResponseSuccessCompat_NotRequired value)
        notRequired,
  }) {
    return notRequired(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PrepareDetailedResponseSuccessCompat_Available value)?
        available,
    TResult? Function(PrepareDetailedResponseSuccessCompat_NotRequired value)?
        notRequired,
  }) {
    return notRequired?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PrepareDetailedResponseSuccessCompat_Available value)?
        available,
    TResult Function(PrepareDetailedResponseSuccessCompat_NotRequired value)?
        notRequired,
    required TResult orElse(),
  }) {
    if (notRequired != null) {
      return notRequired(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PrepareDetailedResponseSuccessCompat_NotRequiredImplToJson(
      this,
    );
  }
}

abstract class PrepareDetailedResponseSuccessCompat_NotRequired
    extends PrepareDetailedResponseSuccessCompat {
  const factory PrepareDetailedResponseSuccessCompat_NotRequired(
          {required final PrepareResponseNotRequiredCompat value}) =
      _$PrepareDetailedResponseSuccessCompat_NotRequiredImpl;
  const PrepareDetailedResponseSuccessCompat_NotRequired._() : super._();

  factory PrepareDetailedResponseSuccessCompat_NotRequired.fromJson(
          Map<String, dynamic> json) =
      _$PrepareDetailedResponseSuccessCompat_NotRequiredImpl.fromJson;

  @override
  PrepareResponseNotRequiredCompat get value;

  /// Create a copy of PrepareDetailedResponseSuccessCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PrepareDetailedResponseSuccessCompat_NotRequiredImplCopyWith<
          _$PrepareDetailedResponseSuccessCompat_NotRequiredImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PrepareResponseAvailableCompat _$PrepareResponseAvailableCompatFromJson(
    Map<String, dynamic> json) {
  return _PrepareResponseAvailableCompat.fromJson(json);
}

/// @nodoc
mixin _$PrepareResponseAvailableCompat {
  String get orchestrationId => throw _privateConstructorUsedError;
  TransactionCompat get initialTransaction =>
      throw _privateConstructorUsedError;
  List<TransactionCompat> get transactions =>
      throw _privateConstructorUsedError;
  MetadataCompat get metadata => throw _privateConstructorUsedError;

  /// Serializes this PrepareResponseAvailableCompat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PrepareResponseAvailableCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PrepareResponseAvailableCompatCopyWith<PrepareResponseAvailableCompat>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrepareResponseAvailableCompatCopyWith<$Res> {
  factory $PrepareResponseAvailableCompatCopyWith(
          PrepareResponseAvailableCompat value,
          $Res Function(PrepareResponseAvailableCompat) then) =
      _$PrepareResponseAvailableCompatCopyWithImpl<$Res,
          PrepareResponseAvailableCompat>;
  @useResult
  $Res call(
      {String orchestrationId,
      TransactionCompat initialTransaction,
      List<TransactionCompat> transactions,
      MetadataCompat metadata});

  $TransactionCompatCopyWith<$Res> get initialTransaction;
  $MetadataCompatCopyWith<$Res> get metadata;
}

/// @nodoc
class _$PrepareResponseAvailableCompatCopyWithImpl<$Res,
        $Val extends PrepareResponseAvailableCompat>
    implements $PrepareResponseAvailableCompatCopyWith<$Res> {
  _$PrepareResponseAvailableCompatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PrepareResponseAvailableCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orchestrationId = null,
    Object? initialTransaction = null,
    Object? transactions = null,
    Object? metadata = null,
  }) {
    return _then(_value.copyWith(
      orchestrationId: null == orchestrationId
          ? _value.orchestrationId
          : orchestrationId // ignore: cast_nullable_to_non_nullable
              as String,
      initialTransaction: null == initialTransaction
          ? _value.initialTransaction
          : initialTransaction // ignore: cast_nullable_to_non_nullable
              as TransactionCompat,
      transactions: null == transactions
          ? _value.transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<TransactionCompat>,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as MetadataCompat,
    ) as $Val);
  }

  /// Create a copy of PrepareResponseAvailableCompat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransactionCompatCopyWith<$Res> get initialTransaction {
    return $TransactionCompatCopyWith<$Res>(_value.initialTransaction, (value) {
      return _then(_value.copyWith(initialTransaction: value) as $Val);
    });
  }

  /// Create a copy of PrepareResponseAvailableCompat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MetadataCompatCopyWith<$Res> get metadata {
    return $MetadataCompatCopyWith<$Res>(_value.metadata, (value) {
      return _then(_value.copyWith(metadata: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PrepareResponseAvailableCompatImplCopyWith<$Res>
    implements $PrepareResponseAvailableCompatCopyWith<$Res> {
  factory _$$PrepareResponseAvailableCompatImplCopyWith(
          _$PrepareResponseAvailableCompatImpl value,
          $Res Function(_$PrepareResponseAvailableCompatImpl) then) =
      __$$PrepareResponseAvailableCompatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String orchestrationId,
      TransactionCompat initialTransaction,
      List<TransactionCompat> transactions,
      MetadataCompat metadata});

  @override
  $TransactionCompatCopyWith<$Res> get initialTransaction;
  @override
  $MetadataCompatCopyWith<$Res> get metadata;
}

/// @nodoc
class __$$PrepareResponseAvailableCompatImplCopyWithImpl<$Res>
    extends _$PrepareResponseAvailableCompatCopyWithImpl<$Res,
        _$PrepareResponseAvailableCompatImpl>
    implements _$$PrepareResponseAvailableCompatImplCopyWith<$Res> {
  __$$PrepareResponseAvailableCompatImplCopyWithImpl(
      _$PrepareResponseAvailableCompatImpl _value,
      $Res Function(_$PrepareResponseAvailableCompatImpl) _then)
      : super(_value, _then);

  /// Create a copy of PrepareResponseAvailableCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orchestrationId = null,
    Object? initialTransaction = null,
    Object? transactions = null,
    Object? metadata = null,
  }) {
    return _then(_$PrepareResponseAvailableCompatImpl(
      orchestrationId: null == orchestrationId
          ? _value.orchestrationId
          : orchestrationId // ignore: cast_nullable_to_non_nullable
              as String,
      initialTransaction: null == initialTransaction
          ? _value.initialTransaction
          : initialTransaction // ignore: cast_nullable_to_non_nullable
              as TransactionCompat,
      transactions: null == transactions
          ? _value._transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<TransactionCompat>,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as MetadataCompat,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PrepareResponseAvailableCompatImpl
    implements _PrepareResponseAvailableCompat {
  const _$PrepareResponseAvailableCompatImpl(
      {required this.orchestrationId,
      required this.initialTransaction,
      required final List<TransactionCompat> transactions,
      required this.metadata})
      : _transactions = transactions;

  factory _$PrepareResponseAvailableCompatImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$PrepareResponseAvailableCompatImplFromJson(json);

  @override
  final String orchestrationId;
  @override
  final TransactionCompat initialTransaction;
  final List<TransactionCompat> _transactions;
  @override
  List<TransactionCompat> get transactions {
    if (_transactions is EqualUnmodifiableListView) return _transactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transactions);
  }

  @override
  final MetadataCompat metadata;

  @override
  String toString() {
    return 'PrepareResponseAvailableCompat(orchestrationId: $orchestrationId, initialTransaction: $initialTransaction, transactions: $transactions, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrepareResponseAvailableCompatImpl &&
            (identical(other.orchestrationId, orchestrationId) ||
                other.orchestrationId == orchestrationId) &&
            (identical(other.initialTransaction, initialTransaction) ||
                other.initialTransaction == initialTransaction) &&
            const DeepCollectionEquality()
                .equals(other._transactions, _transactions) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      orchestrationId,
      initialTransaction,
      const DeepCollectionEquality().hash(_transactions),
      metadata);

  /// Create a copy of PrepareResponseAvailableCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PrepareResponseAvailableCompatImplCopyWith<
          _$PrepareResponseAvailableCompatImpl>
      get copyWith => __$$PrepareResponseAvailableCompatImplCopyWithImpl<
          _$PrepareResponseAvailableCompatImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PrepareResponseAvailableCompatImplToJson(
      this,
    );
  }
}

abstract class _PrepareResponseAvailableCompat
    implements PrepareResponseAvailableCompat {
  const factory _PrepareResponseAvailableCompat(
          {required final String orchestrationId,
          required final TransactionCompat initialTransaction,
          required final List<TransactionCompat> transactions,
          required final MetadataCompat metadata}) =
      _$PrepareResponseAvailableCompatImpl;

  factory _PrepareResponseAvailableCompat.fromJson(Map<String, dynamic> json) =
      _$PrepareResponseAvailableCompatImpl.fromJson;

  @override
  String get orchestrationId;
  @override
  TransactionCompat get initialTransaction;
  @override
  List<TransactionCompat> get transactions;
  @override
  MetadataCompat get metadata;

  /// Create a copy of PrepareResponseAvailableCompat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PrepareResponseAvailableCompatImplCopyWith<
          _$PrepareResponseAvailableCompatImpl>
      get copyWith => throw _privateConstructorUsedError;
}

PrepareResponseNotRequiredCompat _$PrepareResponseNotRequiredCompatFromJson(
    Map<String, dynamic> json) {
  return _PrepareResponseNotRequiredCompat.fromJson(json);
}

/// @nodoc
mixin _$PrepareResponseNotRequiredCompat {
  TransactionCompat get initialTransaction =>
      throw _privateConstructorUsedError;
  List<TransactionCompat> get transactions =>
      throw _privateConstructorUsedError;

  /// Serializes this PrepareResponseNotRequiredCompat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PrepareResponseNotRequiredCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PrepareResponseNotRequiredCompatCopyWith<PrepareResponseNotRequiredCompat>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrepareResponseNotRequiredCompatCopyWith<$Res> {
  factory $PrepareResponseNotRequiredCompatCopyWith(
          PrepareResponseNotRequiredCompat value,
          $Res Function(PrepareResponseNotRequiredCompat) then) =
      _$PrepareResponseNotRequiredCompatCopyWithImpl<$Res,
          PrepareResponseNotRequiredCompat>;
  @useResult
  $Res call(
      {TransactionCompat initialTransaction,
      List<TransactionCompat> transactions});

  $TransactionCompatCopyWith<$Res> get initialTransaction;
}

/// @nodoc
class _$PrepareResponseNotRequiredCompatCopyWithImpl<$Res,
        $Val extends PrepareResponseNotRequiredCompat>
    implements $PrepareResponseNotRequiredCompatCopyWith<$Res> {
  _$PrepareResponseNotRequiredCompatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PrepareResponseNotRequiredCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? initialTransaction = null,
    Object? transactions = null,
  }) {
    return _then(_value.copyWith(
      initialTransaction: null == initialTransaction
          ? _value.initialTransaction
          : initialTransaction // ignore: cast_nullable_to_non_nullable
              as TransactionCompat,
      transactions: null == transactions
          ? _value.transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<TransactionCompat>,
    ) as $Val);
  }

  /// Create a copy of PrepareResponseNotRequiredCompat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransactionCompatCopyWith<$Res> get initialTransaction {
    return $TransactionCompatCopyWith<$Res>(_value.initialTransaction, (value) {
      return _then(_value.copyWith(initialTransaction: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PrepareResponseNotRequiredCompatImplCopyWith<$Res>
    implements $PrepareResponseNotRequiredCompatCopyWith<$Res> {
  factory _$$PrepareResponseNotRequiredCompatImplCopyWith(
          _$PrepareResponseNotRequiredCompatImpl value,
          $Res Function(_$PrepareResponseNotRequiredCompatImpl) then) =
      __$$PrepareResponseNotRequiredCompatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TransactionCompat initialTransaction,
      List<TransactionCompat> transactions});

  @override
  $TransactionCompatCopyWith<$Res> get initialTransaction;
}

/// @nodoc
class __$$PrepareResponseNotRequiredCompatImplCopyWithImpl<$Res>
    extends _$PrepareResponseNotRequiredCompatCopyWithImpl<$Res,
        _$PrepareResponseNotRequiredCompatImpl>
    implements _$$PrepareResponseNotRequiredCompatImplCopyWith<$Res> {
  __$$PrepareResponseNotRequiredCompatImplCopyWithImpl(
      _$PrepareResponseNotRequiredCompatImpl _value,
      $Res Function(_$PrepareResponseNotRequiredCompatImpl) _then)
      : super(_value, _then);

  /// Create a copy of PrepareResponseNotRequiredCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? initialTransaction = null,
    Object? transactions = null,
  }) {
    return _then(_$PrepareResponseNotRequiredCompatImpl(
      initialTransaction: null == initialTransaction
          ? _value.initialTransaction
          : initialTransaction // ignore: cast_nullable_to_non_nullable
              as TransactionCompat,
      transactions: null == transactions
          ? _value._transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as List<TransactionCompat>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PrepareResponseNotRequiredCompatImpl
    implements _PrepareResponseNotRequiredCompat {
  const _$PrepareResponseNotRequiredCompatImpl(
      {required this.initialTransaction,
      required final List<TransactionCompat> transactions})
      : _transactions = transactions;

  factory _$PrepareResponseNotRequiredCompatImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$PrepareResponseNotRequiredCompatImplFromJson(json);

  @override
  final TransactionCompat initialTransaction;
  final List<TransactionCompat> _transactions;
  @override
  List<TransactionCompat> get transactions {
    if (_transactions is EqualUnmodifiableListView) return _transactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transactions);
  }

  @override
  String toString() {
    return 'PrepareResponseNotRequiredCompat(initialTransaction: $initialTransaction, transactions: $transactions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrepareResponseNotRequiredCompatImpl &&
            (identical(other.initialTransaction, initialTransaction) ||
                other.initialTransaction == initialTransaction) &&
            const DeepCollectionEquality()
                .equals(other._transactions, _transactions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, initialTransaction,
      const DeepCollectionEquality().hash(_transactions));

  /// Create a copy of PrepareResponseNotRequiredCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PrepareResponseNotRequiredCompatImplCopyWith<
          _$PrepareResponseNotRequiredCompatImpl>
      get copyWith => __$$PrepareResponseNotRequiredCompatImplCopyWithImpl<
          _$PrepareResponseNotRequiredCompatImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PrepareResponseNotRequiredCompatImplToJson(
      this,
    );
  }
}

abstract class _PrepareResponseNotRequiredCompat
    implements PrepareResponseNotRequiredCompat {
  const factory _PrepareResponseNotRequiredCompat(
          {required final TransactionCompat initialTransaction,
          required final List<TransactionCompat> transactions}) =
      _$PrepareResponseNotRequiredCompatImpl;

  factory _PrepareResponseNotRequiredCompat.fromJson(
          Map<String, dynamic> json) =
      _$PrepareResponseNotRequiredCompatImpl.fromJson;

  @override
  TransactionCompat get initialTransaction;
  @override
  List<TransactionCompat> get transactions;

  /// Create a copy of PrepareResponseNotRequiredCompat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PrepareResponseNotRequiredCompatImplCopyWith<
          _$PrepareResponseNotRequiredCompatImpl>
      get copyWith => throw _privateConstructorUsedError;
}

TransactionCompat _$TransactionCompatFromJson(Map<String, dynamic> json) {
  return _TransactionCompat.fromJson(json);
}

/// @nodoc
mixin _$TransactionCompat {
  String get chainId => throw _privateConstructorUsedError;
  String get from => throw _privateConstructorUsedError;
  String get to => throw _privateConstructorUsedError;
  String get value => throw _privateConstructorUsedError;
  String get input => throw _privateConstructorUsedError;
  BigInt get gasLimit => throw _privateConstructorUsedError;
  BigInt get nonce => throw _privateConstructorUsedError;

  /// Serializes this TransactionCompat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TransactionCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionCompatCopyWith<TransactionCompat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionCompatCopyWith<$Res> {
  factory $TransactionCompatCopyWith(
          TransactionCompat value, $Res Function(TransactionCompat) then) =
      _$TransactionCompatCopyWithImpl<$Res, TransactionCompat>;
  @useResult
  $Res call(
      {String chainId,
      String from,
      String to,
      String value,
      String input,
      BigInt gasLimit,
      BigInt nonce});
}

/// @nodoc
class _$TransactionCompatCopyWithImpl<$Res, $Val extends TransactionCompat>
    implements $TransactionCompatCopyWith<$Res> {
  _$TransactionCompatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chainId = null,
    Object? from = null,
    Object? to = null,
    Object? value = null,
    Object? input = null,
    Object? gasLimit = null,
    Object? nonce = null,
  }) {
    return _then(_value.copyWith(
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as String,
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String,
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      input: null == input
          ? _value.input
          : input // ignore: cast_nullable_to_non_nullable
              as String,
      gasLimit: null == gasLimit
          ? _value.gasLimit
          : gasLimit // ignore: cast_nullable_to_non_nullable
              as BigInt,
      nonce: null == nonce
          ? _value.nonce
          : nonce // ignore: cast_nullable_to_non_nullable
              as BigInt,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransactionCompatImplCopyWith<$Res>
    implements $TransactionCompatCopyWith<$Res> {
  factory _$$TransactionCompatImplCopyWith(_$TransactionCompatImpl value,
          $Res Function(_$TransactionCompatImpl) then) =
      __$$TransactionCompatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String chainId,
      String from,
      String to,
      String value,
      String input,
      BigInt gasLimit,
      BigInt nonce});
}

/// @nodoc
class __$$TransactionCompatImplCopyWithImpl<$Res>
    extends _$TransactionCompatCopyWithImpl<$Res, _$TransactionCompatImpl>
    implements _$$TransactionCompatImplCopyWith<$Res> {
  __$$TransactionCompatImplCopyWithImpl(_$TransactionCompatImpl _value,
      $Res Function(_$TransactionCompatImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chainId = null,
    Object? from = null,
    Object? to = null,
    Object? value = null,
    Object? input = null,
    Object? gasLimit = null,
    Object? nonce = null,
  }) {
    return _then(_$TransactionCompatImpl(
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as String,
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String,
      to: null == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
      input: null == input
          ? _value.input
          : input // ignore: cast_nullable_to_non_nullable
              as String,
      gasLimit: null == gasLimit
          ? _value.gasLimit
          : gasLimit // ignore: cast_nullable_to_non_nullable
              as BigInt,
      nonce: null == nonce
          ? _value.nonce
          : nonce // ignore: cast_nullable_to_non_nullable
              as BigInt,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionCompatImpl implements _TransactionCompat {
  const _$TransactionCompatImpl(
      {required this.chainId,
      required this.from,
      required this.to,
      required this.value,
      required this.input,
      required this.gasLimit,
      required this.nonce});

  factory _$TransactionCompatImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionCompatImplFromJson(json);

  @override
  final String chainId;
  @override
  final String from;
  @override
  final String to;
  @override
  final String value;
  @override
  final String input;
  @override
  final BigInt gasLimit;
  @override
  final BigInt nonce;

  @override
  String toString() {
    return 'TransactionCompat(chainId: $chainId, from: $from, to: $to, value: $value, input: $input, gasLimit: $gasLimit, nonce: $nonce)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionCompatImpl &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.input, input) || other.input == input) &&
            (identical(other.gasLimit, gasLimit) ||
                other.gasLimit == gasLimit) &&
            (identical(other.nonce, nonce) || other.nonce == nonce));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, chainId, from, to, value, input, gasLimit, nonce);

  /// Create a copy of TransactionCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionCompatImplCopyWith<_$TransactionCompatImpl> get copyWith =>
      __$$TransactionCompatImplCopyWithImpl<_$TransactionCompatImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionCompatImplToJson(
      this,
    );
  }
}

abstract class _TransactionCompat implements TransactionCompat {
  const factory _TransactionCompat(
      {required final String chainId,
      required final String from,
      required final String to,
      required final String value,
      required final String input,
      required final BigInt gasLimit,
      required final BigInt nonce}) = _$TransactionCompatImpl;

  factory _TransactionCompat.fromJson(Map<String, dynamic> json) =
      _$TransactionCompatImpl.fromJson;

  @override
  String get chainId;
  @override
  String get from;
  @override
  String get to;
  @override
  String get value;
  @override
  String get input;
  @override
  BigInt get gasLimit;
  @override
  BigInt get nonce;

  /// Create a copy of TransactionCompat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionCompatImplCopyWith<_$TransactionCompatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TransactionFeeCompat _$TransactionFeeCompatFromJson(Map<String, dynamic> json) {
  return _TransactionFeeCompat.fromJson(json);
}

/// @nodoc
mixin _$TransactionFeeCompat {
  AmountCompat get fee => throw _privateConstructorUsedError;
  AmountCompat get localFee => throw _privateConstructorUsedError;

  /// Serializes this TransactionFeeCompat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TransactionFeeCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionFeeCompatCopyWith<TransactionFeeCompat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionFeeCompatCopyWith<$Res> {
  factory $TransactionFeeCompatCopyWith(TransactionFeeCompat value,
          $Res Function(TransactionFeeCompat) then) =
      _$TransactionFeeCompatCopyWithImpl<$Res, TransactionFeeCompat>;
  @useResult
  $Res call({AmountCompat fee, AmountCompat localFee});

  $AmountCompatCopyWith<$Res> get fee;
  $AmountCompatCopyWith<$Res> get localFee;
}

/// @nodoc
class _$TransactionFeeCompatCopyWithImpl<$Res,
        $Val extends TransactionFeeCompat>
    implements $TransactionFeeCompatCopyWith<$Res> {
  _$TransactionFeeCompatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionFeeCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fee = null,
    Object? localFee = null,
  }) {
    return _then(_value.copyWith(
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as AmountCompat,
      localFee: null == localFee
          ? _value.localFee
          : localFee // ignore: cast_nullable_to_non_nullable
              as AmountCompat,
    ) as $Val);
  }

  /// Create a copy of TransactionFeeCompat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AmountCompatCopyWith<$Res> get fee {
    return $AmountCompatCopyWith<$Res>(_value.fee, (value) {
      return _then(_value.copyWith(fee: value) as $Val);
    });
  }

  /// Create a copy of TransactionFeeCompat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AmountCompatCopyWith<$Res> get localFee {
    return $AmountCompatCopyWith<$Res>(_value.localFee, (value) {
      return _then(_value.copyWith(localFee: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TransactionFeeCompatImplCopyWith<$Res>
    implements $TransactionFeeCompatCopyWith<$Res> {
  factory _$$TransactionFeeCompatImplCopyWith(_$TransactionFeeCompatImpl value,
          $Res Function(_$TransactionFeeCompatImpl) then) =
      __$$TransactionFeeCompatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AmountCompat fee, AmountCompat localFee});

  @override
  $AmountCompatCopyWith<$Res> get fee;
  @override
  $AmountCompatCopyWith<$Res> get localFee;
}

/// @nodoc
class __$$TransactionFeeCompatImplCopyWithImpl<$Res>
    extends _$TransactionFeeCompatCopyWithImpl<$Res, _$TransactionFeeCompatImpl>
    implements _$$TransactionFeeCompatImplCopyWith<$Res> {
  __$$TransactionFeeCompatImplCopyWithImpl(_$TransactionFeeCompatImpl _value,
      $Res Function(_$TransactionFeeCompatImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionFeeCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fee = null,
    Object? localFee = null,
  }) {
    return _then(_$TransactionFeeCompatImpl(
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as AmountCompat,
      localFee: null == localFee
          ? _value.localFee
          : localFee // ignore: cast_nullable_to_non_nullable
              as AmountCompat,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionFeeCompatImpl implements _TransactionFeeCompat {
  const _$TransactionFeeCompatImpl({required this.fee, required this.localFee});

  factory _$TransactionFeeCompatImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionFeeCompatImplFromJson(json);

  @override
  final AmountCompat fee;
  @override
  final AmountCompat localFee;

  @override
  String toString() {
    return 'TransactionFeeCompat(fee: $fee, localFee: $localFee)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionFeeCompatImpl &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.localFee, localFee) ||
                other.localFee == localFee));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, fee, localFee);

  /// Create a copy of TransactionFeeCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionFeeCompatImplCopyWith<_$TransactionFeeCompatImpl>
      get copyWith =>
          __$$TransactionFeeCompatImplCopyWithImpl<_$TransactionFeeCompatImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionFeeCompatImplToJson(
      this,
    );
  }
}

abstract class _TransactionFeeCompat implements TransactionFeeCompat {
  const factory _TransactionFeeCompat(
      {required final AmountCompat fee,
      required final AmountCompat localFee}) = _$TransactionFeeCompatImpl;

  factory _TransactionFeeCompat.fromJson(Map<String, dynamic> json) =
      _$TransactionFeeCompatImpl.fromJson;

  @override
  AmountCompat get fee;
  @override
  AmountCompat get localFee;

  /// Create a copy of TransactionFeeCompat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionFeeCompatImplCopyWith<_$TransactionFeeCompatImpl>
      get copyWith => throw _privateConstructorUsedError;
}

TransactionReceiptCompat _$TransactionReceiptCompatFromJson(
    Map<String, dynamic> json) {
  return _TransactionReceiptCompat.fromJson(json);
}

/// @nodoc
mixin _$TransactionReceiptCompat {
  String get transactionHash => throw _privateConstructorUsedError;
  BigInt? get transactionIndex => throw _privateConstructorUsedError;
  String? get blockHash => throw _privateConstructorUsedError;
  BigInt? get blockNumber => throw _privateConstructorUsedError;
  BigInt get gasUsed => throw _privateConstructorUsedError;
  String get effectiveGasPrice => throw _privateConstructorUsedError;
  BigInt? get blobGasUsed => throw _privateConstructorUsedError;
  String? get blobGasPrice => throw _privateConstructorUsedError;
  String get from => throw _privateConstructorUsedError;
  String? get to => throw _privateConstructorUsedError;
  String? get contractAddress => throw _privateConstructorUsedError;

  /// Serializes this TransactionReceiptCompat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TransactionReceiptCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionReceiptCompatCopyWith<TransactionReceiptCompat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionReceiptCompatCopyWith<$Res> {
  factory $TransactionReceiptCompatCopyWith(TransactionReceiptCompat value,
          $Res Function(TransactionReceiptCompat) then) =
      _$TransactionReceiptCompatCopyWithImpl<$Res, TransactionReceiptCompat>;
  @useResult
  $Res call(
      {String transactionHash,
      BigInt? transactionIndex,
      String? blockHash,
      BigInt? blockNumber,
      BigInt gasUsed,
      String effectiveGasPrice,
      BigInt? blobGasUsed,
      String? blobGasPrice,
      String from,
      String? to,
      String? contractAddress});
}

/// @nodoc
class _$TransactionReceiptCompatCopyWithImpl<$Res,
        $Val extends TransactionReceiptCompat>
    implements $TransactionReceiptCompatCopyWith<$Res> {
  _$TransactionReceiptCompatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionReceiptCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionHash = null,
    Object? transactionIndex = freezed,
    Object? blockHash = freezed,
    Object? blockNumber = freezed,
    Object? gasUsed = null,
    Object? effectiveGasPrice = null,
    Object? blobGasUsed = freezed,
    Object? blobGasPrice = freezed,
    Object? from = null,
    Object? to = freezed,
    Object? contractAddress = freezed,
  }) {
    return _then(_value.copyWith(
      transactionHash: null == transactionHash
          ? _value.transactionHash
          : transactionHash // ignore: cast_nullable_to_non_nullable
              as String,
      transactionIndex: freezed == transactionIndex
          ? _value.transactionIndex
          : transactionIndex // ignore: cast_nullable_to_non_nullable
              as BigInt?,
      blockHash: freezed == blockHash
          ? _value.blockHash
          : blockHash // ignore: cast_nullable_to_non_nullable
              as String?,
      blockNumber: freezed == blockNumber
          ? _value.blockNumber
          : blockNumber // ignore: cast_nullable_to_non_nullable
              as BigInt?,
      gasUsed: null == gasUsed
          ? _value.gasUsed
          : gasUsed // ignore: cast_nullable_to_non_nullable
              as BigInt,
      effectiveGasPrice: null == effectiveGasPrice
          ? _value.effectiveGasPrice
          : effectiveGasPrice // ignore: cast_nullable_to_non_nullable
              as String,
      blobGasUsed: freezed == blobGasUsed
          ? _value.blobGasUsed
          : blobGasUsed // ignore: cast_nullable_to_non_nullable
              as BigInt?,
      blobGasPrice: freezed == blobGasPrice
          ? _value.blobGasPrice
          : blobGasPrice // ignore: cast_nullable_to_non_nullable
              as String?,
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String,
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String?,
      contractAddress: freezed == contractAddress
          ? _value.contractAddress
          : contractAddress // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransactionReceiptCompatImplCopyWith<$Res>
    implements $TransactionReceiptCompatCopyWith<$Res> {
  factory _$$TransactionReceiptCompatImplCopyWith(
          _$TransactionReceiptCompatImpl value,
          $Res Function(_$TransactionReceiptCompatImpl) then) =
      __$$TransactionReceiptCompatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String transactionHash,
      BigInt? transactionIndex,
      String? blockHash,
      BigInt? blockNumber,
      BigInt gasUsed,
      String effectiveGasPrice,
      BigInt? blobGasUsed,
      String? blobGasPrice,
      String from,
      String? to,
      String? contractAddress});
}

/// @nodoc
class __$$TransactionReceiptCompatImplCopyWithImpl<$Res>
    extends _$TransactionReceiptCompatCopyWithImpl<$Res,
        _$TransactionReceiptCompatImpl>
    implements _$$TransactionReceiptCompatImplCopyWith<$Res> {
  __$$TransactionReceiptCompatImplCopyWithImpl(
      _$TransactionReceiptCompatImpl _value,
      $Res Function(_$TransactionReceiptCompatImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionReceiptCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionHash = null,
    Object? transactionIndex = freezed,
    Object? blockHash = freezed,
    Object? blockNumber = freezed,
    Object? gasUsed = null,
    Object? effectiveGasPrice = null,
    Object? blobGasUsed = freezed,
    Object? blobGasPrice = freezed,
    Object? from = null,
    Object? to = freezed,
    Object? contractAddress = freezed,
  }) {
    return _then(_$TransactionReceiptCompatImpl(
      transactionHash: null == transactionHash
          ? _value.transactionHash
          : transactionHash // ignore: cast_nullable_to_non_nullable
              as String,
      transactionIndex: freezed == transactionIndex
          ? _value.transactionIndex
          : transactionIndex // ignore: cast_nullable_to_non_nullable
              as BigInt?,
      blockHash: freezed == blockHash
          ? _value.blockHash
          : blockHash // ignore: cast_nullable_to_non_nullable
              as String?,
      blockNumber: freezed == blockNumber
          ? _value.blockNumber
          : blockNumber // ignore: cast_nullable_to_non_nullable
              as BigInt?,
      gasUsed: null == gasUsed
          ? _value.gasUsed
          : gasUsed // ignore: cast_nullable_to_non_nullable
              as BigInt,
      effectiveGasPrice: null == effectiveGasPrice
          ? _value.effectiveGasPrice
          : effectiveGasPrice // ignore: cast_nullable_to_non_nullable
              as String,
      blobGasUsed: freezed == blobGasUsed
          ? _value.blobGasUsed
          : blobGasUsed // ignore: cast_nullable_to_non_nullable
              as BigInt?,
      blobGasPrice: freezed == blobGasPrice
          ? _value.blobGasPrice
          : blobGasPrice // ignore: cast_nullable_to_non_nullable
              as String?,
      from: null == from
          ? _value.from
          : from // ignore: cast_nullable_to_non_nullable
              as String,
      to: freezed == to
          ? _value.to
          : to // ignore: cast_nullable_to_non_nullable
              as String?,
      contractAddress: freezed == contractAddress
          ? _value.contractAddress
          : contractAddress // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionReceiptCompatImpl implements _TransactionReceiptCompat {
  const _$TransactionReceiptCompatImpl(
      {required this.transactionHash,
      this.transactionIndex,
      this.blockHash,
      this.blockNumber,
      required this.gasUsed,
      required this.effectiveGasPrice,
      this.blobGasUsed,
      this.blobGasPrice,
      required this.from,
      this.to,
      this.contractAddress});

  factory _$TransactionReceiptCompatImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionReceiptCompatImplFromJson(json);

  @override
  final String transactionHash;
  @override
  final BigInt? transactionIndex;
  @override
  final String? blockHash;
  @override
  final BigInt? blockNumber;
  @override
  final BigInt gasUsed;
  @override
  final String effectiveGasPrice;
  @override
  final BigInt? blobGasUsed;
  @override
  final String? blobGasPrice;
  @override
  final String from;
  @override
  final String? to;
  @override
  final String? contractAddress;

  @override
  String toString() {
    return 'TransactionReceiptCompat(transactionHash: $transactionHash, transactionIndex: $transactionIndex, blockHash: $blockHash, blockNumber: $blockNumber, gasUsed: $gasUsed, effectiveGasPrice: $effectiveGasPrice, blobGasUsed: $blobGasUsed, blobGasPrice: $blobGasPrice, from: $from, to: $to, contractAddress: $contractAddress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionReceiptCompatImpl &&
            (identical(other.transactionHash, transactionHash) ||
                other.transactionHash == transactionHash) &&
            (identical(other.transactionIndex, transactionIndex) ||
                other.transactionIndex == transactionIndex) &&
            (identical(other.blockHash, blockHash) ||
                other.blockHash == blockHash) &&
            (identical(other.blockNumber, blockNumber) ||
                other.blockNumber == blockNumber) &&
            (identical(other.gasUsed, gasUsed) || other.gasUsed == gasUsed) &&
            (identical(other.effectiveGasPrice, effectiveGasPrice) ||
                other.effectiveGasPrice == effectiveGasPrice) &&
            (identical(other.blobGasUsed, blobGasUsed) ||
                other.blobGasUsed == blobGasUsed) &&
            (identical(other.blobGasPrice, blobGasPrice) ||
                other.blobGasPrice == blobGasPrice) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.contractAddress, contractAddress) ||
                other.contractAddress == contractAddress));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      transactionHash,
      transactionIndex,
      blockHash,
      blockNumber,
      gasUsed,
      effectiveGasPrice,
      blobGasUsed,
      blobGasPrice,
      from,
      to,
      contractAddress);

  /// Create a copy of TransactionReceiptCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionReceiptCompatImplCopyWith<_$TransactionReceiptCompatImpl>
      get copyWith => __$$TransactionReceiptCompatImplCopyWithImpl<
          _$TransactionReceiptCompatImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionReceiptCompatImplToJson(
      this,
    );
  }
}

abstract class _TransactionReceiptCompat implements TransactionReceiptCompat {
  const factory _TransactionReceiptCompat(
      {required final String transactionHash,
      final BigInt? transactionIndex,
      final String? blockHash,
      final BigInt? blockNumber,
      required final BigInt gasUsed,
      required final String effectiveGasPrice,
      final BigInt? blobGasUsed,
      final String? blobGasPrice,
      required final String from,
      final String? to,
      final String? contractAddress}) = _$TransactionReceiptCompatImpl;

  factory _TransactionReceiptCompat.fromJson(Map<String, dynamic> json) =
      _$TransactionReceiptCompatImpl.fromJson;

  @override
  String get transactionHash;
  @override
  BigInt? get transactionIndex;
  @override
  String? get blockHash;
  @override
  BigInt? get blockNumber;
  @override
  BigInt get gasUsed;
  @override
  String get effectiveGasPrice;
  @override
  BigInt? get blobGasUsed;
  @override
  String? get blobGasPrice;
  @override
  String get from;
  @override
  String? get to;
  @override
  String? get contractAddress;

  /// Create a copy of TransactionReceiptCompat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionReceiptCompatImplCopyWith<_$TransactionReceiptCompatImpl>
      get copyWith => throw _privateConstructorUsedError;
}

TxnDetailsCompat _$TxnDetailsCompatFromJson(Map<String, dynamic> json) {
  return _TxnDetailsCompat.fromJson(json);
}

/// @nodoc
mixin _$TxnDetailsCompat {
  FeeEstimatedTransactionCompat get transaction =>
      throw _privateConstructorUsedError;
  String get transactionHashToSign => throw _privateConstructorUsedError;
  TransactionFeeCompat get fee => throw _privateConstructorUsedError;

  /// Serializes this TxnDetailsCompat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TxnDetailsCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TxnDetailsCompatCopyWith<TxnDetailsCompat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TxnDetailsCompatCopyWith<$Res> {
  factory $TxnDetailsCompatCopyWith(
          TxnDetailsCompat value, $Res Function(TxnDetailsCompat) then) =
      _$TxnDetailsCompatCopyWithImpl<$Res, TxnDetailsCompat>;
  @useResult
  $Res call(
      {FeeEstimatedTransactionCompat transaction,
      String transactionHashToSign,
      TransactionFeeCompat fee});

  $FeeEstimatedTransactionCompatCopyWith<$Res> get transaction;
  $TransactionFeeCompatCopyWith<$Res> get fee;
}

/// @nodoc
class _$TxnDetailsCompatCopyWithImpl<$Res, $Val extends TxnDetailsCompat>
    implements $TxnDetailsCompatCopyWith<$Res> {
  _$TxnDetailsCompatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TxnDetailsCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transaction = null,
    Object? transactionHashToSign = null,
    Object? fee = null,
  }) {
    return _then(_value.copyWith(
      transaction: null == transaction
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as FeeEstimatedTransactionCompat,
      transactionHashToSign: null == transactionHashToSign
          ? _value.transactionHashToSign
          : transactionHashToSign // ignore: cast_nullable_to_non_nullable
              as String,
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as TransactionFeeCompat,
    ) as $Val);
  }

  /// Create a copy of TxnDetailsCompat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FeeEstimatedTransactionCompatCopyWith<$Res> get transaction {
    return $FeeEstimatedTransactionCompatCopyWith<$Res>(_value.transaction,
        (value) {
      return _then(_value.copyWith(transaction: value) as $Val);
    });
  }

  /// Create a copy of TxnDetailsCompat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TransactionFeeCompatCopyWith<$Res> get fee {
    return $TransactionFeeCompatCopyWith<$Res>(_value.fee, (value) {
      return _then(_value.copyWith(fee: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TxnDetailsCompatImplCopyWith<$Res>
    implements $TxnDetailsCompatCopyWith<$Res> {
  factory _$$TxnDetailsCompatImplCopyWith(_$TxnDetailsCompatImpl value,
          $Res Function(_$TxnDetailsCompatImpl) then) =
      __$$TxnDetailsCompatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {FeeEstimatedTransactionCompat transaction,
      String transactionHashToSign,
      TransactionFeeCompat fee});

  @override
  $FeeEstimatedTransactionCompatCopyWith<$Res> get transaction;
  @override
  $TransactionFeeCompatCopyWith<$Res> get fee;
}

/// @nodoc
class __$$TxnDetailsCompatImplCopyWithImpl<$Res>
    extends _$TxnDetailsCompatCopyWithImpl<$Res, _$TxnDetailsCompatImpl>
    implements _$$TxnDetailsCompatImplCopyWith<$Res> {
  __$$TxnDetailsCompatImplCopyWithImpl(_$TxnDetailsCompatImpl _value,
      $Res Function(_$TxnDetailsCompatImpl) _then)
      : super(_value, _then);

  /// Create a copy of TxnDetailsCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transaction = null,
    Object? transactionHashToSign = null,
    Object? fee = null,
  }) {
    return _then(_$TxnDetailsCompatImpl(
      transaction: null == transaction
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as FeeEstimatedTransactionCompat,
      transactionHashToSign: null == transactionHashToSign
          ? _value.transactionHashToSign
          : transactionHashToSign // ignore: cast_nullable_to_non_nullable
              as String,
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as TransactionFeeCompat,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TxnDetailsCompatImpl implements _TxnDetailsCompat {
  const _$TxnDetailsCompatImpl(
      {required this.transaction,
      required this.transactionHashToSign,
      required this.fee});

  factory _$TxnDetailsCompatImpl.fromJson(Map<String, dynamic> json) =>
      _$$TxnDetailsCompatImplFromJson(json);

  @override
  final FeeEstimatedTransactionCompat transaction;
  @override
  final String transactionHashToSign;
  @override
  final TransactionFeeCompat fee;

  @override
  String toString() {
    return 'TxnDetailsCompat(transaction: $transaction, transactionHashToSign: $transactionHashToSign, fee: $fee)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TxnDetailsCompatImpl &&
            (identical(other.transaction, transaction) ||
                other.transaction == transaction) &&
            (identical(other.transactionHashToSign, transactionHashToSign) ||
                other.transactionHashToSign == transactionHashToSign) &&
            (identical(other.fee, fee) || other.fee == fee));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, transaction, transactionHashToSign, fee);

  /// Create a copy of TxnDetailsCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TxnDetailsCompatImplCopyWith<_$TxnDetailsCompatImpl> get copyWith =>
      __$$TxnDetailsCompatImplCopyWithImpl<_$TxnDetailsCompatImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TxnDetailsCompatImplToJson(
      this,
    );
  }
}

abstract class _TxnDetailsCompat implements TxnDetailsCompat {
  const factory _TxnDetailsCompat(
      {required final FeeEstimatedTransactionCompat transaction,
      required final String transactionHashToSign,
      required final TransactionFeeCompat fee}) = _$TxnDetailsCompatImpl;

  factory _TxnDetailsCompat.fromJson(Map<String, dynamic> json) =
      _$TxnDetailsCompatImpl.fromJson;

  @override
  FeeEstimatedTransactionCompat get transaction;
  @override
  String get transactionHashToSign;
  @override
  TransactionFeeCompat get fee;

  /// Create a copy of TxnDetailsCompat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TxnDetailsCompatImplCopyWith<_$TxnDetailsCompatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UiFieldsCompat _$UiFieldsCompatFromJson(Map<String, dynamic> json) {
  return _UiFieldsCompat.fromJson(json);
}

/// @nodoc
mixin _$UiFieldsCompat {
  PrepareResponseAvailableCompat get routeResponse =>
      throw _privateConstructorUsedError;
  List<TxnDetailsCompat> get route => throw _privateConstructorUsedError;
  AmountCompat get localRouteTotal => throw _privateConstructorUsedError;
  List<TransactionFeeCompat> get bridge => throw _privateConstructorUsedError;
  AmountCompat get localBridgeTotal => throw _privateConstructorUsedError;
  TxnDetailsCompat get initial => throw _privateConstructorUsedError;
  AmountCompat get localTotal => throw _privateConstructorUsedError;

  /// Serializes this UiFieldsCompat to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UiFieldsCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UiFieldsCompatCopyWith<UiFieldsCompat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UiFieldsCompatCopyWith<$Res> {
  factory $UiFieldsCompatCopyWith(
          UiFieldsCompat value, $Res Function(UiFieldsCompat) then) =
      _$UiFieldsCompatCopyWithImpl<$Res, UiFieldsCompat>;
  @useResult
  $Res call(
      {PrepareResponseAvailableCompat routeResponse,
      List<TxnDetailsCompat> route,
      AmountCompat localRouteTotal,
      List<TransactionFeeCompat> bridge,
      AmountCompat localBridgeTotal,
      TxnDetailsCompat initial,
      AmountCompat localTotal});

  $PrepareResponseAvailableCompatCopyWith<$Res> get routeResponse;
  $AmountCompatCopyWith<$Res> get localRouteTotal;
  $AmountCompatCopyWith<$Res> get localBridgeTotal;
  $TxnDetailsCompatCopyWith<$Res> get initial;
  $AmountCompatCopyWith<$Res> get localTotal;
}

/// @nodoc
class _$UiFieldsCompatCopyWithImpl<$Res, $Val extends UiFieldsCompat>
    implements $UiFieldsCompatCopyWith<$Res> {
  _$UiFieldsCompatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UiFieldsCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? routeResponse = null,
    Object? route = null,
    Object? localRouteTotal = null,
    Object? bridge = null,
    Object? localBridgeTotal = null,
    Object? initial = null,
    Object? localTotal = null,
  }) {
    return _then(_value.copyWith(
      routeResponse: null == routeResponse
          ? _value.routeResponse
          : routeResponse // ignore: cast_nullable_to_non_nullable
              as PrepareResponseAvailableCompat,
      route: null == route
          ? _value.route
          : route // ignore: cast_nullable_to_non_nullable
              as List<TxnDetailsCompat>,
      localRouteTotal: null == localRouteTotal
          ? _value.localRouteTotal
          : localRouteTotal // ignore: cast_nullable_to_non_nullable
              as AmountCompat,
      bridge: null == bridge
          ? _value.bridge
          : bridge // ignore: cast_nullable_to_non_nullable
              as List<TransactionFeeCompat>,
      localBridgeTotal: null == localBridgeTotal
          ? _value.localBridgeTotal
          : localBridgeTotal // ignore: cast_nullable_to_non_nullable
              as AmountCompat,
      initial: null == initial
          ? _value.initial
          : initial // ignore: cast_nullable_to_non_nullable
              as TxnDetailsCompat,
      localTotal: null == localTotal
          ? _value.localTotal
          : localTotal // ignore: cast_nullable_to_non_nullable
              as AmountCompat,
    ) as $Val);
  }

  /// Create a copy of UiFieldsCompat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PrepareResponseAvailableCompatCopyWith<$Res> get routeResponse {
    return $PrepareResponseAvailableCompatCopyWith<$Res>(_value.routeResponse,
        (value) {
      return _then(_value.copyWith(routeResponse: value) as $Val);
    });
  }

  /// Create a copy of UiFieldsCompat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AmountCompatCopyWith<$Res> get localRouteTotal {
    return $AmountCompatCopyWith<$Res>(_value.localRouteTotal, (value) {
      return _then(_value.copyWith(localRouteTotal: value) as $Val);
    });
  }

  /// Create a copy of UiFieldsCompat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AmountCompatCopyWith<$Res> get localBridgeTotal {
    return $AmountCompatCopyWith<$Res>(_value.localBridgeTotal, (value) {
      return _then(_value.copyWith(localBridgeTotal: value) as $Val);
    });
  }

  /// Create a copy of UiFieldsCompat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TxnDetailsCompatCopyWith<$Res> get initial {
    return $TxnDetailsCompatCopyWith<$Res>(_value.initial, (value) {
      return _then(_value.copyWith(initial: value) as $Val);
    });
  }

  /// Create a copy of UiFieldsCompat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AmountCompatCopyWith<$Res> get localTotal {
    return $AmountCompatCopyWith<$Res>(_value.localTotal, (value) {
      return _then(_value.copyWith(localTotal: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UiFieldsCompatImplCopyWith<$Res>
    implements $UiFieldsCompatCopyWith<$Res> {
  factory _$$UiFieldsCompatImplCopyWith(_$UiFieldsCompatImpl value,
          $Res Function(_$UiFieldsCompatImpl) then) =
      __$$UiFieldsCompatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PrepareResponseAvailableCompat routeResponse,
      List<TxnDetailsCompat> route,
      AmountCompat localRouteTotal,
      List<TransactionFeeCompat> bridge,
      AmountCompat localBridgeTotal,
      TxnDetailsCompat initial,
      AmountCompat localTotal});

  @override
  $PrepareResponseAvailableCompatCopyWith<$Res> get routeResponse;
  @override
  $AmountCompatCopyWith<$Res> get localRouteTotal;
  @override
  $AmountCompatCopyWith<$Res> get localBridgeTotal;
  @override
  $TxnDetailsCompatCopyWith<$Res> get initial;
  @override
  $AmountCompatCopyWith<$Res> get localTotal;
}

/// @nodoc
class __$$UiFieldsCompatImplCopyWithImpl<$Res>
    extends _$UiFieldsCompatCopyWithImpl<$Res, _$UiFieldsCompatImpl>
    implements _$$UiFieldsCompatImplCopyWith<$Res> {
  __$$UiFieldsCompatImplCopyWithImpl(
      _$UiFieldsCompatImpl _value, $Res Function(_$UiFieldsCompatImpl) _then)
      : super(_value, _then);

  /// Create a copy of UiFieldsCompat
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? routeResponse = null,
    Object? route = null,
    Object? localRouteTotal = null,
    Object? bridge = null,
    Object? localBridgeTotal = null,
    Object? initial = null,
    Object? localTotal = null,
  }) {
    return _then(_$UiFieldsCompatImpl(
      routeResponse: null == routeResponse
          ? _value.routeResponse
          : routeResponse // ignore: cast_nullable_to_non_nullable
              as PrepareResponseAvailableCompat,
      route: null == route
          ? _value._route
          : route // ignore: cast_nullable_to_non_nullable
              as List<TxnDetailsCompat>,
      localRouteTotal: null == localRouteTotal
          ? _value.localRouteTotal
          : localRouteTotal // ignore: cast_nullable_to_non_nullable
              as AmountCompat,
      bridge: null == bridge
          ? _value._bridge
          : bridge // ignore: cast_nullable_to_non_nullable
              as List<TransactionFeeCompat>,
      localBridgeTotal: null == localBridgeTotal
          ? _value.localBridgeTotal
          : localBridgeTotal // ignore: cast_nullable_to_non_nullable
              as AmountCompat,
      initial: null == initial
          ? _value.initial
          : initial // ignore: cast_nullable_to_non_nullable
              as TxnDetailsCompat,
      localTotal: null == localTotal
          ? _value.localTotal
          : localTotal // ignore: cast_nullable_to_non_nullable
              as AmountCompat,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UiFieldsCompatImpl implements _UiFieldsCompat {
  const _$UiFieldsCompatImpl(
      {required this.routeResponse,
      required final List<TxnDetailsCompat> route,
      required this.localRouteTotal,
      required final List<TransactionFeeCompat> bridge,
      required this.localBridgeTotal,
      required this.initial,
      required this.localTotal})
      : _route = route,
        _bridge = bridge;

  factory _$UiFieldsCompatImpl.fromJson(Map<String, dynamic> json) =>
      _$$UiFieldsCompatImplFromJson(json);

  @override
  final PrepareResponseAvailableCompat routeResponse;
  final List<TxnDetailsCompat> _route;
  @override
  List<TxnDetailsCompat> get route {
    if (_route is EqualUnmodifiableListView) return _route;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_route);
  }

  @override
  final AmountCompat localRouteTotal;
  final List<TransactionFeeCompat> _bridge;
  @override
  List<TransactionFeeCompat> get bridge {
    if (_bridge is EqualUnmodifiableListView) return _bridge;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_bridge);
  }

  @override
  final AmountCompat localBridgeTotal;
  @override
  final TxnDetailsCompat initial;
  @override
  final AmountCompat localTotal;

  @override
  String toString() {
    return 'UiFieldsCompat(routeResponse: $routeResponse, route: $route, localRouteTotal: $localRouteTotal, bridge: $bridge, localBridgeTotal: $localBridgeTotal, initial: $initial, localTotal: $localTotal)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UiFieldsCompatImpl &&
            (identical(other.routeResponse, routeResponse) ||
                other.routeResponse == routeResponse) &&
            const DeepCollectionEquality().equals(other._route, _route) &&
            (identical(other.localRouteTotal, localRouteTotal) ||
                other.localRouteTotal == localRouteTotal) &&
            const DeepCollectionEquality().equals(other._bridge, _bridge) &&
            (identical(other.localBridgeTotal, localBridgeTotal) ||
                other.localBridgeTotal == localBridgeTotal) &&
            (identical(other.initial, initial) || other.initial == initial) &&
            (identical(other.localTotal, localTotal) ||
                other.localTotal == localTotal));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      routeResponse,
      const DeepCollectionEquality().hash(_route),
      localRouteTotal,
      const DeepCollectionEquality().hash(_bridge),
      localBridgeTotal,
      initial,
      localTotal);

  /// Create a copy of UiFieldsCompat
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UiFieldsCompatImplCopyWith<_$UiFieldsCompatImpl> get copyWith =>
      __$$UiFieldsCompatImplCopyWithImpl<_$UiFieldsCompatImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UiFieldsCompatImplToJson(
      this,
    );
  }
}

abstract class _UiFieldsCompat implements UiFieldsCompat {
  const factory _UiFieldsCompat(
      {required final PrepareResponseAvailableCompat routeResponse,
      required final List<TxnDetailsCompat> route,
      required final AmountCompat localRouteTotal,
      required final List<TransactionFeeCompat> bridge,
      required final AmountCompat localBridgeTotal,
      required final TxnDetailsCompat initial,
      required final AmountCompat localTotal}) = _$UiFieldsCompatImpl;

  factory _UiFieldsCompat.fromJson(Map<String, dynamic> json) =
      _$UiFieldsCompatImpl.fromJson;

  @override
  PrepareResponseAvailableCompat get routeResponse;
  @override
  List<TxnDetailsCompat> get route;
  @override
  AmountCompat get localRouteTotal;
  @override
  List<TransactionFeeCompat> get bridge;
  @override
  AmountCompat get localBridgeTotal;
  @override
  TxnDetailsCompat get initial;
  @override
  AmountCompat get localTotal;

  /// Create a copy of UiFieldsCompat
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UiFieldsCompatImplCopyWith<_$UiFieldsCompatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
