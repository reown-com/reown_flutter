// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stacks.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TransferStxRequest _$TransferStxRequestFromJson(Map<String, dynamic> json) {
  return _TransferStxRequest.fromJson(json);
}

/// @nodoc
mixin _$TransferStxRequest {
  BigInt get amount => throw _privateConstructorUsedError;
  String get recipient => throw _privateConstructorUsedError;
  String? get memo => throw _privateConstructorUsedError;

  /// Serializes this TransferStxRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TransferStxRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransferStxRequestCopyWith<TransferStxRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferStxRequestCopyWith<$Res> {
  factory $TransferStxRequestCopyWith(
          TransferStxRequest value, $Res Function(TransferStxRequest) then) =
      _$TransferStxRequestCopyWithImpl<$Res, TransferStxRequest>;
  @useResult
  $Res call({BigInt amount, String recipient, String? memo});
}

/// @nodoc
class _$TransferStxRequestCopyWithImpl<$Res, $Val extends TransferStxRequest>
    implements $TransferStxRequestCopyWith<$Res> {
  _$TransferStxRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransferStxRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? recipient = null,
    Object? memo = freezed,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as BigInt,
      recipient: null == recipient
          ? _value.recipient
          : recipient // ignore: cast_nullable_to_non_nullable
              as String,
      memo: freezed == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransferStxRequestImplCopyWith<$Res>
    implements $TransferStxRequestCopyWith<$Res> {
  factory _$$TransferStxRequestImplCopyWith(_$TransferStxRequestImpl value,
          $Res Function(_$TransferStxRequestImpl) then) =
      __$$TransferStxRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({BigInt amount, String recipient, String? memo});
}

/// @nodoc
class __$$TransferStxRequestImplCopyWithImpl<$Res>
    extends _$TransferStxRequestCopyWithImpl<$Res, _$TransferStxRequestImpl>
    implements _$$TransferStxRequestImplCopyWith<$Res> {
  __$$TransferStxRequestImplCopyWithImpl(_$TransferStxRequestImpl _value,
      $Res Function(_$TransferStxRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransferStxRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? amount = null,
    Object? recipient = null,
    Object? memo = freezed,
  }) {
    return _then(_$TransferStxRequestImpl(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as BigInt,
      recipient: null == recipient
          ? _value.recipient
          : recipient // ignore: cast_nullable_to_non_nullable
              as String,
      memo: freezed == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransferStxRequestImpl implements _TransferStxRequest {
  const _$TransferStxRequestImpl(
      {required this.amount, required this.recipient, this.memo});

  factory _$TransferStxRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransferStxRequestImplFromJson(json);

  @override
  final BigInt amount;
  @override
  final String recipient;
  @override
  final String? memo;

  @override
  String toString() {
    return 'TransferStxRequest(amount: $amount, recipient: $recipient, memo: $memo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferStxRequestImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.recipient, recipient) ||
                other.recipient == recipient) &&
            (identical(other.memo, memo) || other.memo == memo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, amount, recipient, memo);

  /// Create a copy of TransferStxRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferStxRequestImplCopyWith<_$TransferStxRequestImpl> get copyWith =>
      __$$TransferStxRequestImplCopyWithImpl<_$TransferStxRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransferStxRequestImplToJson(
      this,
    );
  }
}

abstract class _TransferStxRequest implements TransferStxRequest {
  const factory _TransferStxRequest(
      {required final BigInt amount,
      required final String recipient,
      final String? memo}) = _$TransferStxRequestImpl;

  factory _TransferStxRequest.fromJson(Map<String, dynamic> json) =
      _$TransferStxRequestImpl.fromJson;

  @override
  BigInt get amount;
  @override
  String get recipient;
  @override
  String? get memo;

  /// Create a copy of TransferStxRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransferStxRequestImplCopyWith<_$TransferStxRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TransferStxResponse _$TransferStxResponseFromJson(Map<String, dynamic> json) {
  return _TransferStxResponse.fromJson(json);
}

/// @nodoc
mixin _$TransferStxResponse {
  String get transaction => throw _privateConstructorUsedError;
  String get txid => throw _privateConstructorUsedError;

  /// Serializes this TransferStxResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TransferStxResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransferStxResponseCopyWith<TransferStxResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferStxResponseCopyWith<$Res> {
  factory $TransferStxResponseCopyWith(
          TransferStxResponse value, $Res Function(TransferStxResponse) then) =
      _$TransferStxResponseCopyWithImpl<$Res, TransferStxResponse>;
  @useResult
  $Res call({String transaction, String txid});
}

/// @nodoc
class _$TransferStxResponseCopyWithImpl<$Res, $Val extends TransferStxResponse>
    implements $TransferStxResponseCopyWith<$Res> {
  _$TransferStxResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransferStxResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transaction = null,
    Object? txid = null,
  }) {
    return _then(_value.copyWith(
      transaction: null == transaction
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as String,
      txid: null == txid
          ? _value.txid
          : txid // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransferStxResponseImplCopyWith<$Res>
    implements $TransferStxResponseCopyWith<$Res> {
  factory _$$TransferStxResponseImplCopyWith(_$TransferStxResponseImpl value,
          $Res Function(_$TransferStxResponseImpl) then) =
      __$$TransferStxResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String transaction, String txid});
}

/// @nodoc
class __$$TransferStxResponseImplCopyWithImpl<$Res>
    extends _$TransferStxResponseCopyWithImpl<$Res, _$TransferStxResponseImpl>
    implements _$$TransferStxResponseImplCopyWith<$Res> {
  __$$TransferStxResponseImplCopyWithImpl(_$TransferStxResponseImpl _value,
      $Res Function(_$TransferStxResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransferStxResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transaction = null,
    Object? txid = null,
  }) {
    return _then(_$TransferStxResponseImpl(
      transaction: null == transaction
          ? _value.transaction
          : transaction // ignore: cast_nullable_to_non_nullable
              as String,
      txid: null == txid
          ? _value.txid
          : txid // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransferStxResponseImpl implements _TransferStxResponse {
  const _$TransferStxResponseImpl(
      {required this.transaction, required this.txid});

  factory _$TransferStxResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransferStxResponseImplFromJson(json);

  @override
  final String transaction;
  @override
  final String txid;

  @override
  String toString() {
    return 'TransferStxResponse(transaction: $transaction, txid: $txid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferStxResponseImpl &&
            (identical(other.transaction, transaction) ||
                other.transaction == transaction) &&
            (identical(other.txid, txid) || other.txid == txid));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, transaction, txid);

  /// Create a copy of TransferStxResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransferStxResponseImplCopyWith<_$TransferStxResponseImpl> get copyWith =>
      __$$TransferStxResponseImplCopyWithImpl<_$TransferStxResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransferStxResponseImplToJson(
      this,
    );
  }
}

abstract class _TransferStxResponse implements TransferStxResponse {
  const factory _TransferStxResponse(
      {required final String transaction,
      required final String txid}) = _$TransferStxResponseImpl;

  factory _TransferStxResponse.fromJson(Map<String, dynamic> json) =
      _$TransferStxResponseImpl.fromJson;

  @override
  String get transaction;
  @override
  String get txid;

  /// Create a copy of TransferStxResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransferStxResponseImplCopyWith<_$TransferStxResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
