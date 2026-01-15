import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reown_appkit/base/services/models/asset_models.dart';
import 'package:reown_appkit/modal/utils/core_utils.dart';

part 'quote_models.freezed.dart';
part 'quote_models.g.dart';

@freezed
sealed class QuoteFee with _$QuoteFee {
  const factory QuoteFee({
    required String id,
    required String label,
    required String amount,
    required ExchangeAsset currency,
  }) = _QuoteFee;

  factory QuoteFee.fromJson(Map<String, dynamic> json) =>
      _$QuoteFeeFromJson(json);
}

enum QuoteStatus {
  @JsonValue('waiting')
  waiting, // waiting to receive the funds in deposit address
  @JsonValue('pending')
  pending, // no more waiting
  @JsonValue('success')
  success, // success = submitted (last step)
  @JsonValue('submitted')
  submitted, // success = submitted (last step)
  @JsonValue('failure')
  failure, // failure status
  @JsonValue('refund')
  refund, // failure status
  @JsonValue('timeout')
  timeout; // failure status;

  // happy path
  // waiting => pending => success|submitted
  //
  // waiting: loaders on every state
  // pending: check on 1st, loaders on the other ones
  // success|submitted: check on everyone

  // unhappy path
  // waiting => (error)
  // waiting => pending => (error)
  //
  // waiting: loaders on every state
  // failuer: red cross on everyone
  //
  // waiting: loaders on every state
  // pending: check on 1st, and loaders on every other one
  // failure: red cross on everything

  factory QuoteStatus.fromStatus(String status) {
    switch (status.toLowerCase()) {
      case 'in_progress':
        return QuoteStatus.waiting;
      case 'unknown':
        return QuoteStatus.waiting;
      case 'success':
        return QuoteStatus.success;
      case 'failed':
        return QuoteStatus.failure;
      case 'waiting':
        return QuoteStatus.waiting;
      case 'pending':
        return QuoteStatus.pending;
      case 'failure':
        return QuoteStatus.failure;
      case 'refund':
        return QuoteStatus.refund;
      case 'timeout':
        return QuoteStatus.timeout;
      case 'submitted':
        return QuoteStatus.submitted;
      default:
        return QuoteStatus.waiting;
    }
  }

  bool get isError {
    return this == QuoteStatus.failure ||
        this == QuoteStatus.refund ||
        this == QuoteStatus.timeout;
  }

  bool get isSuccess {
    return this == QuoteStatus.success || this == QuoteStatus.submitted;
  }
}

enum QuoteType {
  @JsonValue('direct-transfer')
  directTransfer,
}

@freezed
sealed class QuoteAmount with _$QuoteAmount {
  const factory QuoteAmount({
    required String amount,
    required ExchangeAsset currency,
  }) = _QuoteAmount;

  factory QuoteAmount.fromJson(Map<String, dynamic> json) =>
      _$QuoteAmountFromJson(json);
}

@freezed
sealed class QuoteDeposit with _$QuoteDeposit {
  const factory QuoteDeposit({
    required String amount,
    required String currency,
    required String receiver,
  }) = _QuoteDeposit;

  factory QuoteDeposit.fromJson(Map<String, dynamic> json) =>
      _$QuoteDepositFromJson(json);
}

@Freezed(unionKey: 'type')
sealed class QuoteStep with _$QuoteStep {
  const factory QuoteStep.deposit({
    required String requestId,
    required QuoteDeposit deposit,
  }) = QuoteStepDeposit;

  const factory QuoteStep.transaction({
    required String requestId,
    required dynamic transaction,
  }) = QuoteStepTransaction;

  factory QuoteStep.fromJson(Map<String, dynamic> json) =>
      _$QuoteStepFromJson(json);
}

extension QuoteStepExtension on QuoteStep {
  bool get isDeposit => this is QuoteStepDeposit;
  bool get isTransaction => this is QuoteStepTransaction;
}

@freezed
sealed class Quote with _$Quote {
  const factory Quote({
    @JsonKey(includeIfNull: false) QuoteType? type,
    required QuoteAmount origin,
    required QuoteAmount destination,
    required List<QuoteStep> steps,
    required List<QuoteFee> fees,
    required int timeInSeconds, // seconds for receiving the assets
  }) = _Quote;

  factory Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);
}

extension QuoteFeeExtension on QuoteFee {
  String get formattedFee {
    final decimals = currency.metadata.decimals;
    final symbol = currency.metadata.symbol;
    final doubleAmount = CoreUtils.stringAmountToDouble(amount, decimals);
    return CoreUtils.toPrecision(doubleAmount, withSymbol: symbol, decimals: 6);
  }
}

extension QuoteExtension on Quote? {
  String formattedAmount({bool withSymbol = true}) {
    final amount = this?.origin.amount ?? '0';
    final decimals = this?.origin.currency.metadata.decimals ?? 0;
    final doubleAmount = CoreUtils.stringAmountToDouble(amount, decimals);
    if (withSymbol) {
      final symbol = this?.origin.currency.metadata.symbol ?? '';
      return CoreUtils.toPrecision(
        doubleAmount,
        withSymbol: symbol,
        decimals: 6,
      );
    }

    return CoreUtils.toPrecision(
      doubleAmount,
      withSymbol: '',
      decimals: 6,
    ).trim();
  }
}
