import 'package:freezed_annotation/freezed_annotation.dart';

part 'stacks.freezed.dart';
part 'stacks.g.dart';

@freezed
class TransferStxRequest with _$TransferStxRequest {
  const factory TransferStxRequest({
    required BigInt amount,
    required String sender,
    required String recipient,
    String? memo,
  }) = _TransferStxRequest;

  factory TransferStxRequest.fromJson(Map<String, dynamic> json) =>
      _$TransferStxRequestFromJson(json);
}

@freezed
class TransferStxResponse with _$TransferStxResponse {
  const factory TransferStxResponse({
    required String transaction,
    required String txid,
  }) = _TransferStxResponse;

  factory TransferStxResponse.fromJson(Map<String, dynamic> json) =>
      _$TransferStxResponseFromJson(json);
}

@freezed
class StacksAccount with _$StacksAccount {
  const factory StacksAccount({
    required String balance,
    required String locked,
    @JsonKey(name: 'unlock_height') required String unlockHeight,
    required String nonce,
    @JsonKey(name: 'balance_proof') required String balanceProof,
    @JsonKey(name: 'nonce_proof') required String nonceProof,
  }) = _StacksAccount;

  factory StacksAccount.fromJson(Map<String, dynamic> json) =>
      _$StacksAccountFromJson(json);
}

@freezed
class FeeEstimation with _$FeeEstimation {
  const factory FeeEstimation({
    @JsonKey(name: 'cost_scalar_change_by_byte')
    required double costScalarChangeByByte,
    @JsonKey(name: 'estimated_cost') required EstimatedCost estimatedCost,
    @JsonKey(name: 'estimated_cost_scalar') required int estimatedCostScalar,
    required List<Estimation> estimations,
  }) = _FeeEstimation;

  factory FeeEstimation.fromJson(Map<String, dynamic> json) =>
      _$FeeEstimationFromJson(json);
}

@freezed
class EstimatedCost with _$EstimatedCost {
  const factory EstimatedCost({
    @JsonKey(name: 'read_count') required int readCount,
    @JsonKey(name: 'read_length') required int readLength,
    required int runtime,
    @JsonKey(name: 'write_count') required int writeCount,
    @JsonKey(name: 'write_length') required int writeLength,
  }) = _EstimatedCost;

  factory EstimatedCost.fromJson(Map<String, dynamic> json) =>
      _$EstimatedCostFromJson(json);
}

@freezed
class Estimation with _$Estimation {
  const factory Estimation({
    required int fee,
    @JsonKey(name: 'fee_rate') required double feeRate,
  }) = _Estimation;

  factory Estimation.fromJson(Map<String, dynamic> json) =>
      _$EstimationFromJson(json);
}

enum StacksVersion {
  mainnet_p2pkh,
  mainnet_p2sh,
  testnet_p2pkh,
  testnet_p2sh;

  @override
  String toString() {
    switch (this) {
      case StacksVersion.mainnet_p2pkh:
        return 'mainnet-p2pkh';
      case StacksVersion.mainnet_p2sh:
        return 'mainnet-p2sh';
      case StacksVersion.testnet_p2pkh:
        return 'testnet-p2pkh';
      case StacksVersion.testnet_p2sh:
        return 'testnet-p2sh';
    }
  }
}
