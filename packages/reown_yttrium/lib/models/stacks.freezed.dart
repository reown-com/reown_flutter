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
  String get sender => throw _privateConstructorUsedError;
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
  $Res call({BigInt amount, String sender, String recipient, String? memo});
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
    Object? sender = null,
    Object? recipient = null,
    Object? memo = freezed,
  }) {
    return _then(_value.copyWith(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as BigInt,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
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
  $Res call({BigInt amount, String sender, String recipient, String? memo});
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
    Object? sender = null,
    Object? recipient = null,
    Object? memo = freezed,
  }) {
    return _then(_$TransferStxRequestImpl(
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as BigInt,
      sender: null == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String,
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
      {required this.amount,
      required this.sender,
      required this.recipient,
      this.memo});

  factory _$TransferStxRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransferStxRequestImplFromJson(json);

  @override
  final BigInt amount;
  @override
  final String sender;
  @override
  final String recipient;
  @override
  final String? memo;

  @override
  String toString() {
    return 'TransferStxRequest(amount: $amount, sender: $sender, recipient: $recipient, memo: $memo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransferStxRequestImpl &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.recipient, recipient) ||
                other.recipient == recipient) &&
            (identical(other.memo, memo) || other.memo == memo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, amount, sender, recipient, memo);

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
      required final String sender,
      required final String recipient,
      final String? memo}) = _$TransferStxRequestImpl;

  factory _TransferStxRequest.fromJson(Map<String, dynamic> json) =
      _$TransferStxRequestImpl.fromJson;

  @override
  BigInt get amount;
  @override
  String get sender;
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

StacksAccount _$StacksAccountFromJson(Map<String, dynamic> json) {
  return _StacksAccount.fromJson(json);
}

/// @nodoc
mixin _$StacksAccount {
  String get balance => throw _privateConstructorUsedError;
  String get locked => throw _privateConstructorUsedError;
  @JsonKey(name: 'unlock_height')
  String get unlockHeight => throw _privateConstructorUsedError;
  String get nonce => throw _privateConstructorUsedError;
  @JsonKey(name: 'balance_proof')
  String get balanceProof => throw _privateConstructorUsedError;
  @JsonKey(name: 'nonce_proof')
  String get nonceProof => throw _privateConstructorUsedError;

  /// Serializes this StacksAccount to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StacksAccount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StacksAccountCopyWith<StacksAccount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StacksAccountCopyWith<$Res> {
  factory $StacksAccountCopyWith(
          StacksAccount value, $Res Function(StacksAccount) then) =
      _$StacksAccountCopyWithImpl<$Res, StacksAccount>;
  @useResult
  $Res call(
      {String balance,
      String locked,
      @JsonKey(name: 'unlock_height') String unlockHeight,
      String nonce,
      @JsonKey(name: 'balance_proof') String balanceProof,
      @JsonKey(name: 'nonce_proof') String nonceProof});
}

/// @nodoc
class _$StacksAccountCopyWithImpl<$Res, $Val extends StacksAccount>
    implements $StacksAccountCopyWith<$Res> {
  _$StacksAccountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StacksAccount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? balance = null,
    Object? locked = null,
    Object? unlockHeight = null,
    Object? nonce = null,
    Object? balanceProof = null,
    Object? nonceProof = null,
  }) {
    return _then(_value.copyWith(
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as String,
      locked: null == locked
          ? _value.locked
          : locked // ignore: cast_nullable_to_non_nullable
              as String,
      unlockHeight: null == unlockHeight
          ? _value.unlockHeight
          : unlockHeight // ignore: cast_nullable_to_non_nullable
              as String,
      nonce: null == nonce
          ? _value.nonce
          : nonce // ignore: cast_nullable_to_non_nullable
              as String,
      balanceProof: null == balanceProof
          ? _value.balanceProof
          : balanceProof // ignore: cast_nullable_to_non_nullable
              as String,
      nonceProof: null == nonceProof
          ? _value.nonceProof
          : nonceProof // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StacksAccountImplCopyWith<$Res>
    implements $StacksAccountCopyWith<$Res> {
  factory _$$StacksAccountImplCopyWith(
          _$StacksAccountImpl value, $Res Function(_$StacksAccountImpl) then) =
      __$$StacksAccountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String balance,
      String locked,
      @JsonKey(name: 'unlock_height') String unlockHeight,
      String nonce,
      @JsonKey(name: 'balance_proof') String balanceProof,
      @JsonKey(name: 'nonce_proof') String nonceProof});
}

/// @nodoc
class __$$StacksAccountImplCopyWithImpl<$Res>
    extends _$StacksAccountCopyWithImpl<$Res, _$StacksAccountImpl>
    implements _$$StacksAccountImplCopyWith<$Res> {
  __$$StacksAccountImplCopyWithImpl(
      _$StacksAccountImpl _value, $Res Function(_$StacksAccountImpl) _then)
      : super(_value, _then);

  /// Create a copy of StacksAccount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? balance = null,
    Object? locked = null,
    Object? unlockHeight = null,
    Object? nonce = null,
    Object? balanceProof = null,
    Object? nonceProof = null,
  }) {
    return _then(_$StacksAccountImpl(
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as String,
      locked: null == locked
          ? _value.locked
          : locked // ignore: cast_nullable_to_non_nullable
              as String,
      unlockHeight: null == unlockHeight
          ? _value.unlockHeight
          : unlockHeight // ignore: cast_nullable_to_non_nullable
              as String,
      nonce: null == nonce
          ? _value.nonce
          : nonce // ignore: cast_nullable_to_non_nullable
              as String,
      balanceProof: null == balanceProof
          ? _value.balanceProof
          : balanceProof // ignore: cast_nullable_to_non_nullable
              as String,
      nonceProof: null == nonceProof
          ? _value.nonceProof
          : nonceProof // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StacksAccountImpl implements _StacksAccount {
  const _$StacksAccountImpl(
      {required this.balance,
      required this.locked,
      @JsonKey(name: 'unlock_height') required this.unlockHeight,
      required this.nonce,
      @JsonKey(name: 'balance_proof') required this.balanceProof,
      @JsonKey(name: 'nonce_proof') required this.nonceProof});

  factory _$StacksAccountImpl.fromJson(Map<String, dynamic> json) =>
      _$$StacksAccountImplFromJson(json);

  @override
  final String balance;
  @override
  final String locked;
  @override
  @JsonKey(name: 'unlock_height')
  final String unlockHeight;
  @override
  final String nonce;
  @override
  @JsonKey(name: 'balance_proof')
  final String balanceProof;
  @override
  @JsonKey(name: 'nonce_proof')
  final String nonceProof;

  @override
  String toString() {
    return 'StacksAccount(balance: $balance, locked: $locked, unlockHeight: $unlockHeight, nonce: $nonce, balanceProof: $balanceProof, nonceProof: $nonceProof)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StacksAccountImpl &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.locked, locked) || other.locked == locked) &&
            (identical(other.unlockHeight, unlockHeight) ||
                other.unlockHeight == unlockHeight) &&
            (identical(other.nonce, nonce) || other.nonce == nonce) &&
            (identical(other.balanceProof, balanceProof) ||
                other.balanceProof == balanceProof) &&
            (identical(other.nonceProof, nonceProof) ||
                other.nonceProof == nonceProof));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, balance, locked, unlockHeight,
      nonce, balanceProof, nonceProof);

  /// Create a copy of StacksAccount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StacksAccountImplCopyWith<_$StacksAccountImpl> get copyWith =>
      __$$StacksAccountImplCopyWithImpl<_$StacksAccountImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StacksAccountImplToJson(
      this,
    );
  }
}

abstract class _StacksAccount implements StacksAccount {
  const factory _StacksAccount(
          {required final String balance,
          required final String locked,
          @JsonKey(name: 'unlock_height') required final String unlockHeight,
          required final String nonce,
          @JsonKey(name: 'balance_proof') required final String balanceProof,
          @JsonKey(name: 'nonce_proof') required final String nonceProof}) =
      _$StacksAccountImpl;

  factory _StacksAccount.fromJson(Map<String, dynamic> json) =
      _$StacksAccountImpl.fromJson;

  @override
  String get balance;
  @override
  String get locked;
  @override
  @JsonKey(name: 'unlock_height')
  String get unlockHeight;
  @override
  String get nonce;
  @override
  @JsonKey(name: 'balance_proof')
  String get balanceProof;
  @override
  @JsonKey(name: 'nonce_proof')
  String get nonceProof;

  /// Create a copy of StacksAccount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StacksAccountImplCopyWith<_$StacksAccountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FeeEstimation _$FeeEstimationFromJson(Map<String, dynamic> json) {
  return _FeeEstimation.fromJson(json);
}

/// @nodoc
mixin _$FeeEstimation {
  @JsonKey(name: 'cost_scalar_change_by_byte')
  double get costScalarChangeByByte => throw _privateConstructorUsedError;
  @JsonKey(name: 'estimated_cost')
  EstimatedCost get estimatedCost => throw _privateConstructorUsedError;
  @JsonKey(name: 'estimated_cost_scalar')
  int get estimatedCostScalar => throw _privateConstructorUsedError;
  List<Estimation> get estimations => throw _privateConstructorUsedError;

  /// Serializes this FeeEstimation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FeeEstimation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeeEstimationCopyWith<FeeEstimation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeeEstimationCopyWith<$Res> {
  factory $FeeEstimationCopyWith(
          FeeEstimation value, $Res Function(FeeEstimation) then) =
      _$FeeEstimationCopyWithImpl<$Res, FeeEstimation>;
  @useResult
  $Res call(
      {@JsonKey(name: 'cost_scalar_change_by_byte')
      double costScalarChangeByByte,
      @JsonKey(name: 'estimated_cost') EstimatedCost estimatedCost,
      @JsonKey(name: 'estimated_cost_scalar') int estimatedCostScalar,
      List<Estimation> estimations});

  $EstimatedCostCopyWith<$Res> get estimatedCost;
}

/// @nodoc
class _$FeeEstimationCopyWithImpl<$Res, $Val extends FeeEstimation>
    implements $FeeEstimationCopyWith<$Res> {
  _$FeeEstimationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeeEstimation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? costScalarChangeByByte = null,
    Object? estimatedCost = null,
    Object? estimatedCostScalar = null,
    Object? estimations = null,
  }) {
    return _then(_value.copyWith(
      costScalarChangeByByte: null == costScalarChangeByByte
          ? _value.costScalarChangeByByte
          : costScalarChangeByByte // ignore: cast_nullable_to_non_nullable
              as double,
      estimatedCost: null == estimatedCost
          ? _value.estimatedCost
          : estimatedCost // ignore: cast_nullable_to_non_nullable
              as EstimatedCost,
      estimatedCostScalar: null == estimatedCostScalar
          ? _value.estimatedCostScalar
          : estimatedCostScalar // ignore: cast_nullable_to_non_nullable
              as int,
      estimations: null == estimations
          ? _value.estimations
          : estimations // ignore: cast_nullable_to_non_nullable
              as List<Estimation>,
    ) as $Val);
  }

  /// Create a copy of FeeEstimation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $EstimatedCostCopyWith<$Res> get estimatedCost {
    return $EstimatedCostCopyWith<$Res>(_value.estimatedCost, (value) {
      return _then(_value.copyWith(estimatedCost: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FeeEstimationImplCopyWith<$Res>
    implements $FeeEstimationCopyWith<$Res> {
  factory _$$FeeEstimationImplCopyWith(
          _$FeeEstimationImpl value, $Res Function(_$FeeEstimationImpl) then) =
      __$$FeeEstimationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'cost_scalar_change_by_byte')
      double costScalarChangeByByte,
      @JsonKey(name: 'estimated_cost') EstimatedCost estimatedCost,
      @JsonKey(name: 'estimated_cost_scalar') int estimatedCostScalar,
      List<Estimation> estimations});

  @override
  $EstimatedCostCopyWith<$Res> get estimatedCost;
}

/// @nodoc
class __$$FeeEstimationImplCopyWithImpl<$Res>
    extends _$FeeEstimationCopyWithImpl<$Res, _$FeeEstimationImpl>
    implements _$$FeeEstimationImplCopyWith<$Res> {
  __$$FeeEstimationImplCopyWithImpl(
      _$FeeEstimationImpl _value, $Res Function(_$FeeEstimationImpl) _then)
      : super(_value, _then);

  /// Create a copy of FeeEstimation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? costScalarChangeByByte = null,
    Object? estimatedCost = null,
    Object? estimatedCostScalar = null,
    Object? estimations = null,
  }) {
    return _then(_$FeeEstimationImpl(
      costScalarChangeByByte: null == costScalarChangeByByte
          ? _value.costScalarChangeByByte
          : costScalarChangeByByte // ignore: cast_nullable_to_non_nullable
              as double,
      estimatedCost: null == estimatedCost
          ? _value.estimatedCost
          : estimatedCost // ignore: cast_nullable_to_non_nullable
              as EstimatedCost,
      estimatedCostScalar: null == estimatedCostScalar
          ? _value.estimatedCostScalar
          : estimatedCostScalar // ignore: cast_nullable_to_non_nullable
              as int,
      estimations: null == estimations
          ? _value._estimations
          : estimations // ignore: cast_nullable_to_non_nullable
              as List<Estimation>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FeeEstimationImpl implements _FeeEstimation {
  const _$FeeEstimationImpl(
      {@JsonKey(name: 'cost_scalar_change_by_byte')
      required this.costScalarChangeByByte,
      @JsonKey(name: 'estimated_cost') required this.estimatedCost,
      @JsonKey(name: 'estimated_cost_scalar') required this.estimatedCostScalar,
      required final List<Estimation> estimations})
      : _estimations = estimations;

  factory _$FeeEstimationImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeeEstimationImplFromJson(json);

  @override
  @JsonKey(name: 'cost_scalar_change_by_byte')
  final double costScalarChangeByByte;
  @override
  @JsonKey(name: 'estimated_cost')
  final EstimatedCost estimatedCost;
  @override
  @JsonKey(name: 'estimated_cost_scalar')
  final int estimatedCostScalar;
  final List<Estimation> _estimations;
  @override
  List<Estimation> get estimations {
    if (_estimations is EqualUnmodifiableListView) return _estimations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_estimations);
  }

  @override
  String toString() {
    return 'FeeEstimation(costScalarChangeByByte: $costScalarChangeByByte, estimatedCost: $estimatedCost, estimatedCostScalar: $estimatedCostScalar, estimations: $estimations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeeEstimationImpl &&
            (identical(other.costScalarChangeByByte, costScalarChangeByByte) ||
                other.costScalarChangeByByte == costScalarChangeByByte) &&
            (identical(other.estimatedCost, estimatedCost) ||
                other.estimatedCost == estimatedCost) &&
            (identical(other.estimatedCostScalar, estimatedCostScalar) ||
                other.estimatedCostScalar == estimatedCostScalar) &&
            const DeepCollectionEquality()
                .equals(other._estimations, _estimations));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      costScalarChangeByByte,
      estimatedCost,
      estimatedCostScalar,
      const DeepCollectionEquality().hash(_estimations));

  /// Create a copy of FeeEstimation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeeEstimationImplCopyWith<_$FeeEstimationImpl> get copyWith =>
      __$$FeeEstimationImplCopyWithImpl<_$FeeEstimationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeeEstimationImplToJson(
      this,
    );
  }
}

abstract class _FeeEstimation implements FeeEstimation {
  const factory _FeeEstimation(
      {@JsonKey(name: 'cost_scalar_change_by_byte')
      required final double costScalarChangeByByte,
      @JsonKey(name: 'estimated_cost')
      required final EstimatedCost estimatedCost,
      @JsonKey(name: 'estimated_cost_scalar')
      required final int estimatedCostScalar,
      required final List<Estimation> estimations}) = _$FeeEstimationImpl;

  factory _FeeEstimation.fromJson(Map<String, dynamic> json) =
      _$FeeEstimationImpl.fromJson;

  @override
  @JsonKey(name: 'cost_scalar_change_by_byte')
  double get costScalarChangeByByte;
  @override
  @JsonKey(name: 'estimated_cost')
  EstimatedCost get estimatedCost;
  @override
  @JsonKey(name: 'estimated_cost_scalar')
  int get estimatedCostScalar;
  @override
  List<Estimation> get estimations;

  /// Create a copy of FeeEstimation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeeEstimationImplCopyWith<_$FeeEstimationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EstimatedCost _$EstimatedCostFromJson(Map<String, dynamic> json) {
  return _EstimatedCost.fromJson(json);
}

/// @nodoc
mixin _$EstimatedCost {
  @JsonKey(name: 'read_count')
  int get readCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'read_length')
  int get readLength => throw _privateConstructorUsedError;
  int get runtime => throw _privateConstructorUsedError;
  @JsonKey(name: 'write_count')
  int get writeCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'write_length')
  int get writeLength => throw _privateConstructorUsedError;

  /// Serializes this EstimatedCost to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EstimatedCost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EstimatedCostCopyWith<EstimatedCost> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EstimatedCostCopyWith<$Res> {
  factory $EstimatedCostCopyWith(
          EstimatedCost value, $Res Function(EstimatedCost) then) =
      _$EstimatedCostCopyWithImpl<$Res, EstimatedCost>;
  @useResult
  $Res call(
      {@JsonKey(name: 'read_count') int readCount,
      @JsonKey(name: 'read_length') int readLength,
      int runtime,
      @JsonKey(name: 'write_count') int writeCount,
      @JsonKey(name: 'write_length') int writeLength});
}

/// @nodoc
class _$EstimatedCostCopyWithImpl<$Res, $Val extends EstimatedCost>
    implements $EstimatedCostCopyWith<$Res> {
  _$EstimatedCostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EstimatedCost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? readCount = null,
    Object? readLength = null,
    Object? runtime = null,
    Object? writeCount = null,
    Object? writeLength = null,
  }) {
    return _then(_value.copyWith(
      readCount: null == readCount
          ? _value.readCount
          : readCount // ignore: cast_nullable_to_non_nullable
              as int,
      readLength: null == readLength
          ? _value.readLength
          : readLength // ignore: cast_nullable_to_non_nullable
              as int,
      runtime: null == runtime
          ? _value.runtime
          : runtime // ignore: cast_nullable_to_non_nullable
              as int,
      writeCount: null == writeCount
          ? _value.writeCount
          : writeCount // ignore: cast_nullable_to_non_nullable
              as int,
      writeLength: null == writeLength
          ? _value.writeLength
          : writeLength // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EstimatedCostImplCopyWith<$Res>
    implements $EstimatedCostCopyWith<$Res> {
  factory _$$EstimatedCostImplCopyWith(
          _$EstimatedCostImpl value, $Res Function(_$EstimatedCostImpl) then) =
      __$$EstimatedCostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'read_count') int readCount,
      @JsonKey(name: 'read_length') int readLength,
      int runtime,
      @JsonKey(name: 'write_count') int writeCount,
      @JsonKey(name: 'write_length') int writeLength});
}

/// @nodoc
class __$$EstimatedCostImplCopyWithImpl<$Res>
    extends _$EstimatedCostCopyWithImpl<$Res, _$EstimatedCostImpl>
    implements _$$EstimatedCostImplCopyWith<$Res> {
  __$$EstimatedCostImplCopyWithImpl(
      _$EstimatedCostImpl _value, $Res Function(_$EstimatedCostImpl) _then)
      : super(_value, _then);

  /// Create a copy of EstimatedCost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? readCount = null,
    Object? readLength = null,
    Object? runtime = null,
    Object? writeCount = null,
    Object? writeLength = null,
  }) {
    return _then(_$EstimatedCostImpl(
      readCount: null == readCount
          ? _value.readCount
          : readCount // ignore: cast_nullable_to_non_nullable
              as int,
      readLength: null == readLength
          ? _value.readLength
          : readLength // ignore: cast_nullable_to_non_nullable
              as int,
      runtime: null == runtime
          ? _value.runtime
          : runtime // ignore: cast_nullable_to_non_nullable
              as int,
      writeCount: null == writeCount
          ? _value.writeCount
          : writeCount // ignore: cast_nullable_to_non_nullable
              as int,
      writeLength: null == writeLength
          ? _value.writeLength
          : writeLength // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EstimatedCostImpl implements _EstimatedCost {
  const _$EstimatedCostImpl(
      {@JsonKey(name: 'read_count') required this.readCount,
      @JsonKey(name: 'read_length') required this.readLength,
      required this.runtime,
      @JsonKey(name: 'write_count') required this.writeCount,
      @JsonKey(name: 'write_length') required this.writeLength});

  factory _$EstimatedCostImpl.fromJson(Map<String, dynamic> json) =>
      _$$EstimatedCostImplFromJson(json);

  @override
  @JsonKey(name: 'read_count')
  final int readCount;
  @override
  @JsonKey(name: 'read_length')
  final int readLength;
  @override
  final int runtime;
  @override
  @JsonKey(name: 'write_count')
  final int writeCount;
  @override
  @JsonKey(name: 'write_length')
  final int writeLength;

  @override
  String toString() {
    return 'EstimatedCost(readCount: $readCount, readLength: $readLength, runtime: $runtime, writeCount: $writeCount, writeLength: $writeLength)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EstimatedCostImpl &&
            (identical(other.readCount, readCount) ||
                other.readCount == readCount) &&
            (identical(other.readLength, readLength) ||
                other.readLength == readLength) &&
            (identical(other.runtime, runtime) || other.runtime == runtime) &&
            (identical(other.writeCount, writeCount) ||
                other.writeCount == writeCount) &&
            (identical(other.writeLength, writeLength) ||
                other.writeLength == writeLength));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, readCount, readLength, runtime, writeCount, writeLength);

  /// Create a copy of EstimatedCost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EstimatedCostImplCopyWith<_$EstimatedCostImpl> get copyWith =>
      __$$EstimatedCostImplCopyWithImpl<_$EstimatedCostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EstimatedCostImplToJson(
      this,
    );
  }
}

abstract class _EstimatedCost implements EstimatedCost {
  const factory _EstimatedCost(
          {@JsonKey(name: 'read_count') required final int readCount,
          @JsonKey(name: 'read_length') required final int readLength,
          required final int runtime,
          @JsonKey(name: 'write_count') required final int writeCount,
          @JsonKey(name: 'write_length') required final int writeLength}) =
      _$EstimatedCostImpl;

  factory _EstimatedCost.fromJson(Map<String, dynamic> json) =
      _$EstimatedCostImpl.fromJson;

  @override
  @JsonKey(name: 'read_count')
  int get readCount;
  @override
  @JsonKey(name: 'read_length')
  int get readLength;
  @override
  int get runtime;
  @override
  @JsonKey(name: 'write_count')
  int get writeCount;
  @override
  @JsonKey(name: 'write_length')
  int get writeLength;

  /// Create a copy of EstimatedCost
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EstimatedCostImplCopyWith<_$EstimatedCostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Estimation _$EstimationFromJson(Map<String, dynamic> json) {
  return _Estimation.fromJson(json);
}

/// @nodoc
mixin _$Estimation {
  int get fee => throw _privateConstructorUsedError;
  @JsonKey(name: 'fee_rate')
  double get feeRate => throw _privateConstructorUsedError;

  /// Serializes this Estimation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Estimation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EstimationCopyWith<Estimation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EstimationCopyWith<$Res> {
  factory $EstimationCopyWith(
          Estimation value, $Res Function(Estimation) then) =
      _$EstimationCopyWithImpl<$Res, Estimation>;
  @useResult
  $Res call({int fee, @JsonKey(name: 'fee_rate') double feeRate});
}

/// @nodoc
class _$EstimationCopyWithImpl<$Res, $Val extends Estimation>
    implements $EstimationCopyWith<$Res> {
  _$EstimationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Estimation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fee = null,
    Object? feeRate = null,
  }) {
    return _then(_value.copyWith(
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as int,
      feeRate: null == feeRate
          ? _value.feeRate
          : feeRate // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EstimationImplCopyWith<$Res>
    implements $EstimationCopyWith<$Res> {
  factory _$$EstimationImplCopyWith(
          _$EstimationImpl value, $Res Function(_$EstimationImpl) then) =
      __$$EstimationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int fee, @JsonKey(name: 'fee_rate') double feeRate});
}

/// @nodoc
class __$$EstimationImplCopyWithImpl<$Res>
    extends _$EstimationCopyWithImpl<$Res, _$EstimationImpl>
    implements _$$EstimationImplCopyWith<$Res> {
  __$$EstimationImplCopyWithImpl(
      _$EstimationImpl _value, $Res Function(_$EstimationImpl) _then)
      : super(_value, _then);

  /// Create a copy of Estimation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fee = null,
    Object? feeRate = null,
  }) {
    return _then(_$EstimationImpl(
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as int,
      feeRate: null == feeRate
          ? _value.feeRate
          : feeRate // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EstimationImpl implements _Estimation {
  const _$EstimationImpl(
      {required this.fee, @JsonKey(name: 'fee_rate') required this.feeRate});

  factory _$EstimationImpl.fromJson(Map<String, dynamic> json) =>
      _$$EstimationImplFromJson(json);

  @override
  final int fee;
  @override
  @JsonKey(name: 'fee_rate')
  final double feeRate;

  @override
  String toString() {
    return 'Estimation(fee: $fee, feeRate: $feeRate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EstimationImpl &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.feeRate, feeRate) || other.feeRate == feeRate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, fee, feeRate);

  /// Create a copy of Estimation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EstimationImplCopyWith<_$EstimationImpl> get copyWith =>
      __$$EstimationImplCopyWithImpl<_$EstimationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EstimationImplToJson(
      this,
    );
  }
}

abstract class _Estimation implements Estimation {
  const factory _Estimation(
          {required final int fee,
          @JsonKey(name: 'fee_rate') required final double feeRate}) =
      _$EstimationImpl;

  factory _Estimation.fromJson(Map<String, dynamic> json) =
      _$EstimationImpl.fromJson;

  @override
  int get fee;
  @override
  @JsonKey(name: 'fee_rate')
  double get feeRate;

  /// Create a copy of Estimation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EstimationImplCopyWith<_$EstimationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
