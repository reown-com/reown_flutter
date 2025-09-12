// EVM
// JsonRpcError(code: -9, message: wc_pos_buildTransactions: Validation error: Failed to estimate gas: server returned an error response: error code -32000: insufficient funds for transfer)
// JsonRpcError(code: -9, message: wc_pos_buildTransactions: Validation error: Failed to estimate gas: server returned an error response: error code 3: execution reverted: ERC20: transfer amount exceeds balance, data: "0x08c379a00000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000002645524332303a207472616e7366657220616d6f756e7420657863656564732062616c616e63650000000000000000000000000000000000000000000000000000")
// JsonRpcError(code: -9, message: wc_pos_buildTransactions: Validation error: Invalid Recipient: Address format is not supported: 0x.........)
// JsonRpcError(code: -9, message: wc_pos_buildTransactions: Validation error: Unable to parse amount with 6 decimals: digit 10 is out of range for base 10)
// JsonRpcError(code: -9, message: wc_pos_buildTransactions: Validation error: Invalid Asset: Address format is not supported: ssssss)
// JsonRpcError(code: -9, message: wc_pos_buildTransactions: Validation error: Invalid Sender: Wrong CAIP-10 format: sender)

// SOLANA
// Failed to estimate gas? Does exists? Unable to reproduce
// transfer amount exceeds balance error doesn't exist apparently, when this happens it fails on check endpoint.
// JsonRpcError(code: -9, message: wc_pos_buildTransactions: Validation error: Invalid Recipient: Wrong CAIP-10 format: intent.caip10Recipient)
// JsonRpcError(code: -9, message: wc_pos_buildTransactions: Validation error: Unable to parse amount with 6 decimals: digit 18 is out of range for base 10)
// JsonRpcError(code: -9, message: wc_pos_buildTransactions: Validation error: Invalid token mint address: String is the wrong size)
// JsonRpcError(code: -9, message: wc_pos_buildTransactions: Validation error: Invalid Sender: Wrong CAIP-10 format: sender)
// JsonRpcError(code: -9, message: wc_pos_buildTransactions: Validation error: Invalid mint account owner: 11111111111111111111111111111111. Expected SPL Token program.)

// TRON
// JsonRpcError(code: -9, message: wc_pos_buildTransactions: Internal error: Failed to parse response from /wallet/estimateenergy: error decoding response body) // We get this when amount is bigger than balance. Kind of difficult to associate to an "insufficient funds" error.

import 'package:reown_core/models/json_rpc_models.dart';
import 'package:reown_pos/utils/helpers.dart';

enum PosApiError {
  failedToEstimateGas, // EVM specific
  insufficientFundsForTransfer, // EVM specific
  transferAmountExceedsBalance, // EVM specific
  invalidRecipient, // EVM and Solana
  unableToParseAmountWith6Decimals, // EVM and Solana
  invalidAsset, // EVM specific
  invalidSender, // EVM and Solana
  invalidTokenMintAddress, // Solana specific
  invalidMintAccountOwner, // Solana specific
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
    final errorTypes = PosApiError.values.map((e) => e.name).toList();

    for (var part in errorParts) {
      if (errorTypes.contains(part)) {
        PosApiError? posApiError = PosApiError._fromName(part);
        if (posApiError == PosApiError.failedToEstimateGas) {
          if (errorParts.contains(
            PosApiError.insufficientFundsForTransfer.name,
          )) {
            return PosApiError.insufficientFundsForTransfer;
          }
          if (errorParts.contains(
            PosApiError.transferAmountExceedsBalance.name,
          )) {
            return PosApiError.transferAmountExceedsBalance;
          }
        }
        return posApiError ?? PosApiError.unknown;
      }
    }
    return PosApiError.unknown;
  }

  String get shortMessage {
    return camelToSentence(name);
  }
}

String cleanErrorMessage(JsonRpcError error) {
  return error.message
          ?.replaceAll('wc_pos_buildTransactions: Validation error: ', '')
          .replaceAll('wc_pos_buildTransactions: Internal error: ', '') ??
      '';
}
