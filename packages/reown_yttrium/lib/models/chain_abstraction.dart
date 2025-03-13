import 'package:freezed_annotation/freezed_annotation.dart';

part 'chain_abstraction.freezed.dart';
part 'chain_abstraction.g.dart';

enum Currency {
  usd,
  eur,
  gbp,
  aud,
  cad,
  inr,
  jpy,
  btc,
  eth,
  ;
}

enum BridgingError {
  noRoutesAvailable,
  insufficientFunds,
  insufficientGasFunds,
  unknown;

  factory BridgingError.fromString(String value) {
    if (value == 'noRoutesAvailable') {
      return BridgingError.noRoutesAvailable;
    } else if (value == 'insufficientFunds') {
      return BridgingError.insufficientFunds;
    } else if (value == 'insufficientGasFunds') {
      return BridgingError.insufficientGasFunds;
    }
    return BridgingError.unknown;
  }
}

/// Bridging check error response that should be returned as a normal HTTP 200
/// response
class PrepareResponseError {
  final BridgingError error;
  final String reason;

  const PrepareResponseError({
    required this.error,
    required this.reason,
  });

  @override
  int get hashCode => error.hashCode ^ reason.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrepareResponseError &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          reason == other.reason;
}

@freezed
class AmountCompat with _$AmountCompat {
  const factory AmountCompat({
    required String symbol,
    required String amount,
    required int unit,
    required String formatted,
    required String formattedAlt,
  }) = _AmountCompat;

  factory AmountCompat.fromJson(Map<String, dynamic> json) =>
      _$AmountCompatFromJson(json);
}

@freezed
class CallCompat with _$CallCompat {
  const factory CallCompat({
    required String to,
    required BigInt value,
    required String input,
  }) = _CallCompat;

  factory CallCompat.fromJson(Map<String, dynamic> json) =>
      _$CallCompatFromJson(json);
}

@freezed
class Eip1559EstimationCompat with _$Eip1559EstimationCompat {
  const factory Eip1559EstimationCompat({
    required String maxFeePerGas,
    required String maxPriorityFeePerGas,
  }) = _Eip1559EstimationCompat;

  factory Eip1559EstimationCompat.fromJson(Map<String, dynamic> json) =>
      _$Eip1559EstimationCompatFromJson(json);
}

@freezed
sealed class ErrorCompat with _$ErrorCompat {
  const ErrorCompat._();

  const factory ErrorCompat.general({
    required String message,
  }) = ErrorCompat_General;
}

@freezed
class ExecuteDetailsCompat with _$ExecuteDetailsCompat {
  const factory ExecuteDetailsCompat({
    // required TransactionReceiptCompat initialTxnReceipt,
    required String initialTxnReceipt,
    required String initialTxnHash,
  }) = _ExecuteDetailsCompat;

  factory ExecuteDetailsCompat.fromJson(Map<String, dynamic> json) =>
      _$ExecuteDetailsCompatFromJson(json);
}

@freezed
class FeeEstimatedTransactionCompat with _$FeeEstimatedTransactionCompat {
  const factory FeeEstimatedTransactionCompat({
    required String chainId,
    required String from,
    required String to,
    required String value,
    required String input,
    required String gasLimit,
    required String nonce,
    required String maxFeePerGas,
    required String maxPriorityFeePerGas,
  }) = _FeeEstimatedTransactionCompat;

  factory FeeEstimatedTransactionCompat.fromJson(Map<String, dynamic> json) =>
      _$FeeEstimatedTransactionCompatFromJson(json);
}

@freezed
class FundingMetadataCompat with _$FundingMetadataCompat {
  const factory FundingMetadataCompat({
    required String chainId,
    required String tokenContract,
    required String symbol,
    required String amount,
    required String bridgingFee,
    required int decimals,
  }) = _FundingMetadataCompat;

  factory FundingMetadataCompat.fromJson(Map<String, dynamic> json) =>
      _$FundingMetadataCompatFromJson(json);
}

@freezed
class InitialTransactionMetadataCompat with _$InitialTransactionMetadataCompat {
  const factory InitialTransactionMetadataCompat({
    required String transferTo,
    required String amount,
    required String tokenContract,
    required String symbol,
    required int decimals,
  }) = _InitialTransactionMetadataCompat;

  factory InitialTransactionMetadataCompat.fromJson(
          Map<String, dynamic> json) =>
      _$InitialTransactionMetadataCompatFromJson(json);
}

@freezed
class MetadataCompat with _$MetadataCompat {
  const factory MetadataCompat({
    required List<FundingMetadataCompat> fundingFrom,
    required InitialTransactionMetadataCompat initialTransaction,
    required BigInt checkIn,
  }) = _MetadataCompat;

  factory MetadataCompat.fromJson(Map<String, dynamic> json) =>
      _$MetadataCompatFromJson(json);
}

@freezed
sealed class PrepareDetailedResponseCompat
    with _$PrepareDetailedResponseCompat {
  const PrepareDetailedResponseCompat._();

  const factory PrepareDetailedResponseCompat.success({
    required PrepareDetailedResponseSuccessCompat value,
  }) = PrepareDetailedResponseCompat_Success;
  const factory PrepareDetailedResponseCompat.error({
    required PrepareResponseError value,
  }) = PrepareDetailedResponseCompat_Error;
}

@freezed
sealed class PrepareDetailedResponseSuccessCompat
    with _$PrepareDetailedResponseSuccessCompat {
  const PrepareDetailedResponseSuccessCompat._();

  const factory PrepareDetailedResponseSuccessCompat.available({
    required UiFieldsCompat value,
  }) = PrepareDetailedResponseSuccessCompat_Available;
  const factory PrepareDetailedResponseSuccessCompat.notRequired({
    required PrepareResponseNotRequiredCompat value,
  }) = PrepareDetailedResponseSuccessCompat_NotRequired;

  factory PrepareDetailedResponseSuccessCompat.fromJson(
          Map<String, dynamic> json) =>
      _$PrepareDetailedResponseSuccessCompatFromJson(json);
}

@freezed
class PrepareResponseAvailableCompat with _$PrepareResponseAvailableCompat {
  const factory PrepareResponseAvailableCompat({
    required String orchestrationId,
    required TransactionCompat initialTransaction,
    required List<TransactionCompat> transactions,
    required MetadataCompat metadata,
  }) = _PrepareResponseAvailableCompat;

  factory PrepareResponseAvailableCompat.fromJson(Map<String, dynamic> json) =>
      _$PrepareResponseAvailableCompatFromJson(json);
}

@freezed
class PrepareResponseNotRequiredCompat with _$PrepareResponseNotRequiredCompat {
  const factory PrepareResponseNotRequiredCompat({
    required TransactionCompat initialTransaction,
    required List<TransactionCompat> transactions,
  }) = _PrepareResponseNotRequiredCompat;

  factory PrepareResponseNotRequiredCompat.fromJson(
          Map<String, dynamic> json) =>
      _$PrepareResponseNotRequiredCompatFromJson(json);
}

class PrimitiveSignatureCompat {
  final bool yParity;
  final String r;
  final String s;

  // Not originally included in Yttrium but added for usage with Swift's pod
  final String hexValue;

  const PrimitiveSignatureCompat({
    required this.yParity,
    required this.r,
    required this.s,
    required this.hexValue,
  });

  @override
  int get hashCode => yParity.hashCode ^ r.hashCode ^ s.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrimitiveSignatureCompat &&
          runtimeType == other.runtimeType &&
          yParity == other.yParity &&
          r == other.r &&
          s == other.s;

  // Not originally included in Yttrium but added for usage with Swift's pod
  Map<String, dynamic> toJson() => {
        'yParity': yParity,
        'r': r,
        's': s,
        'hexValue': hexValue,
      };
}

@freezed
class PulseMetadataCompat with _$PulseMetadataCompat {
  const factory PulseMetadataCompat({
    String? url,
    String? bundleId,
    String? packageName,
    required String sdkVersion,
    required String sdkPlatform,
  }) = _PulseMetadataCompat;

  factory PulseMetadataCompat.fromJson(Map<String, dynamic> json) =>
      _$PulseMetadataCompatFromJson(json);
}

@freezed
class TransactionCompat with _$TransactionCompat {
  const factory TransactionCompat({
    required String chainId,
    required String from,
    required String to,
    required String value,
    required String input,
    required BigInt gasLimit,
    required BigInt nonce,
  }) = _TransactionCompat;

  factory TransactionCompat.fromJson(Map<String, dynamic> json) =>
      _$TransactionCompatFromJson(json);
}

@freezed
class TransactionFeeCompat with _$TransactionFeeCompat {
  const factory TransactionFeeCompat({
    required AmountCompat fee,
    required AmountCompat localFee,
  }) = _TransactionFeeCompat;

  factory TransactionFeeCompat.fromJson(Map<String, dynamic> json) =>
      _$TransactionFeeCompatFromJson(json);
}

@freezed
class TransactionReceiptCompat with _$TransactionReceiptCompat {
  const factory TransactionReceiptCompat({
    required String transactionHash,
    BigInt? transactionIndex,
    String? blockHash,
    BigInt? blockNumber,
    required BigInt gasUsed,
    required String effectiveGasPrice,
    BigInt? blobGasUsed,
    String? blobGasPrice,
    required String from,
    String? to,
    String? contractAddress,
  }) = _TransactionReceiptCompat;

  factory TransactionReceiptCompat.fromJson(Map<String, dynamic> json) =>
      _$TransactionReceiptCompatFromJson(json);
}

@freezed
class TxnDetailsCompat with _$TxnDetailsCompat {
  const factory TxnDetailsCompat({
    required FeeEstimatedTransactionCompat transaction,
    required String transactionHashToSign,
    required TransactionFeeCompat fee,
  }) = _TxnDetailsCompat;

  factory TxnDetailsCompat.fromJson(Map<String, dynamic> json) =>
      _$TxnDetailsCompatFromJson(json);
}

@freezed
class UiFieldsCompat with _$UiFieldsCompat {
  const factory UiFieldsCompat({
    required PrepareResponseAvailableCompat routeResponse,
    required List<TxnDetailsCompat> route,
    required AmountCompat localRouteTotal,
    required List<TransactionFeeCompat> bridge,
    required AmountCompat localBridgeTotal,
    required TxnDetailsCompat initial,
    required AmountCompat localTotal,
  }) = _UiFieldsCompat;

  factory UiFieldsCompat.fromJson(Map<String, dynamic> json) =>
      _$UiFieldsCompatFromJson(json);
}
