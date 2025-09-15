import 'package:reown_core/models/json_rpc_models.dart';
import 'package:reown_pos/utils/helpers.dart';

const _posApiErrorsCodeMap = {
  -18901: PosApiError.invalidAsset,
  -18902: PosApiError.invalidRecipient,
  -18903: PosApiError.invalidSender,
  -18904: PosApiError.invalidAmount,
  -18905: PosApiError.invalidAddress,
  -18906: PosApiError.invalidWalletResponse,
  -18907: PosApiError.invalidTransactionId,
  // GasEstimation is parsed as `failedToEstimateGas`, which then is converted internally to `insufficientFundsForTransfer` or `transferAmountExceedsBalance` if possible
  -18920: PosApiError.failedToEstimateGas,
  -18940: PosApiError.invalidProviderUrl,
  -18941: PosApiError.rpcError,
  -18942: PosApiError.internal,
  -18970: PosApiError.invalidFormat,
  -18971: PosApiError.invalidChainId,
};

enum PosApiError {
  invalidAsset, // EVM specific, Invalid Contract Address, non CAIP-19 or some other wrong format
  invalidRecipient, // EVM and Solana. i.e non CAIP-10 account or some other wrong format
  invalidSender, // EVM and Solana. i.e non CAIP-10 account or some other wrong format
  invalidAmount,
  invalidAddress,
  invalidWalletResponse,
  invalidTransactionId,
  failedToEstimateGas,
  invalidProviderUrl,
  rpcError,
  internal,
  invalidFormat,
  invalidChainId,
  insufficientFundsForTransfer,
  transferAmountExceedsBalance,
  broadcastFailed,
  unknown;

  static PosApiError? _fromName(String name) {
    try {
      return PosApiError.values.firstWhere((e) => e.name == name);
    } catch (e) {
      return null;
    }
  }

  static PosApiError? _fromErrorCode(int? errorCode) {
    if (errorCode != null) {
      return _posApiErrorsCodeMap[errorCode];
    }
    return null;
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

    PosApiError? checkFailedToEstimateGasReason(PosApiError? posApiError) {
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

    // Fist try to parse the error from its code
    PosApiError? apiErrorFromCode = _fromErrorCode(error.code);
    if (apiErrorFromCode != null) {
      if (apiErrorFromCode == PosApiError.failedToEstimateGas) {
        return checkFailedToEstimateGasReason(apiErrorFromCode) ??
            apiErrorFromCode;
      }
      // rpcError and internal will be identified by message value
      if (apiErrorFromCode != PosApiError.rpcError &&
          apiErrorFromCode != PosApiError.internal) {
        return apiErrorFromCode;
      }
    }

    String? mergeTypes(String part) {
      if (extraTypes.contains(part)) {
        // invalidTokenMintAddress and invalidMintAccountOwner are merged with invalidAsset
        if (part == 'invalidTokenMintAddress' ||
            part == 'invalidMintAccountOwner') {
          return 'invalidAsset';
        }
        // unableToParseAmountWith6Decimals is merged with invalidAmount
        return 'invalidAmount';
      }
      return null;
    }

    // if _fromErrorCode gives null error then parse the message value
    for (var part in errorParts) {
      if (errorTypes.contains(part)) {
        part = mergeTypes(part) ?? part;
        PosApiError? posApiError = PosApiError._fromName(part);
        posApiError =
            checkFailedToEstimateGasReason(posApiError) ?? posApiError;
        return posApiError ?? PosApiError.unknown;
      }
    }

    // if everything fails return unknown
    return PosApiError.unknown;
  }

  String get shortMessage => camelToSentence(name);
}
