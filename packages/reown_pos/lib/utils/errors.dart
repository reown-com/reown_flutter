import 'package:reown_core/models/json_rpc_models.dart';
import 'package:reown_pos/utils/helpers.dart';

enum PosApiError {
  failedToEstimateGas, // EVM specific
  insufficientFundsForTransfer, // EVM specific
  transferAmountExceedsBalance, // EVM specific
  invalidRecipient, // EVM and Solana. i.e non CAIP-10 account or some other wrong format
  invalidAmount, // EVM and Solana
  invalidAsset, // EVM specific, Invalid Contract Address, non CAIP-19 or some other wrong format
  invalidSender, // EVM and Solana. i.e non CAIP-10 account or some other wrong format
  broadcastFailed,
  unknown;

  static PosApiError? _fromName(String name) {
    try {
      return PosApiError.values.firstWhere((e) => e.name == name);
    } catch (e) {
      return null;
    }
  }

  static PosApiError fromJsonRpcError(JsonRpcError error) {
    final errorParts = splitComplex(error.message ?? '');
    final extraTypes = [
      'unableToParseAmountWith6Decimals',
      'invalidTokenMintAddress',
      'invalidMintAccountOwner',
    ];
    final errorTypes = [
      ...PosApiError.values.map((e) => e.name),
      ...extraTypes,
    ];

    String? checkExtraType(String part) {
      if (extraTypes.contains(part)) {
        if (part == 'invalidTokenMintAddress' ||
            part == 'invalidMintAccountOwner') {
          return 'invalidAsset';
        }
        return 'invalidAmount';
      }
      return null;
    }

    PosApiError? checkFailedToEstimateGasType(PosApiError? posApiError) {
      if (posApiError == PosApiError.failedToEstimateGas) {
        final insufficientFunds = PosApiError.insufficientFundsForTransfer;
        if (errorParts.contains(insufficientFunds.name)) {
          return insufficientFunds;
        }
        final exceedsBalance = PosApiError.transferAmountExceedsBalance;
        if (errorParts.contains(exceedsBalance.name)) {
          return exceedsBalance;
        }
      }
      return null;
    }

    for (var part in errorParts) {
      if (errorTypes.contains(part)) {
        part = checkExtraType(part) ?? part;
        PosApiError? posApiError = PosApiError._fromName(part);
        posApiError = checkFailedToEstimateGasType(posApiError) ?? posApiError;
        return posApiError ?? PosApiError.unknown;
      }
    }
    return PosApiError.unknown;
  }

  String get shortMessage => camelToSentence(name);
}
