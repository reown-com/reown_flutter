import 'package:flutter_test/flutter_test.dart';
import 'package:reown_core/models/json_rpc_models.dart';
import 'package:reown_pos/utils/errors.dart';

void main() {
  group('EVM JsonRpcError parsing', () {
    final evmErrors = [
      JsonRpcError(
        code: -9,
        message:
            'wc_pos_buildTransactions: Validation error: Failed to estimate gas: server returned an error response: error code -32000: insufficient funds for transfer',
      ),
      JsonRpcError(
        code: -9,
        message:
            'wc_pos_buildTransactions: Validation error: Failed to estimate gas: server returned an error response: error code 3: execution reverted: ERC20: transfer amount exceeds balance, data: "0x08c379a00000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000002645524332303a207472616e7366657220616d6f756e7420657863656564732062616c616e63650000000000000000000000000000000000000000000000000000"',
      ),
      JsonRpcError(
        code: -9,
        message:
            'wc_pos_buildTransactions: Validation error: Invalid Recipient: Address format is not supported: 0x.........',
      ),
      JsonRpcError(
        code: -9,
        message:
            'wc_pos_buildTransactions: Validation error: Unable to parse amount with 6 decimals: digit 10 is out of range for base 10',
      ),
      JsonRpcError(
        code: -9,
        message:
            'wc_pos_buildTransactions: Validation error: Invalid Asset: Address format is not supported: ssssss',
      ),
      JsonRpcError(
        code: -9,
        message:
            'wc_pos_buildTransactions: Validation error: Invalid Sender: Wrong CAIP-10 format: sender',
      ),
      JsonRpcError(
        code: -9,
        message:
            'wc_pos_buildTransactions: Validation error: Failed to estimate gas: server returned an error response: error code -32000: asdasdasdas',
      ),
      JsonRpcError(
        code: -9,
        message:
            'wc_pos_buildTransactions: Validation error: Failed to estimate gas: server returned an error response: error code 3: execution reverted: ERC20: data: "0x08c379a00000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000002645524332303a207472616e7366657220616d6f756e7420657863656564732062616c616e63650000000000000000000000000000000000000000000000000000"',
      ),
    ];
    test('should parse from JSON correctly', () {
      for (var i = 0; i < evmErrors.length; i++) {
        final JsonRpcError error = evmErrors[i];
        final PosApiError posApiError = PosApiError.fromJsonRpcError(error);

        if (i == 0) {
          expect(posApiError, PosApiError.insufficientFundsForTransfer);
        }
        if (i == 1) {
          expect(posApiError, PosApiError.transferAmountExceedsBalance);
        }
        if (i == 2) {
          expect(posApiError, PosApiError.invalidRecipient);
        }
        if (i == 3) {
          expect(posApiError, PosApiError.unableToParseAmountWith6Decimals);
        }
        if (i == 4) {
          expect(posApiError, PosApiError.invalidAsset);
        }
        if (i == 5) {
          expect(posApiError, PosApiError.invalidSender);
        }
        if (i == 6) {
          expect(posApiError, PosApiError.failedToEstimateGas);
        }
        if (i == 7) {
          expect(posApiError, PosApiError.failedToEstimateGas);
        }
      }
    });
  });

  group('Solana JsonRpcError parsing', () {
    final solanaErrors = [
      JsonRpcError(
        code: -9,
        message:
            'wc_pos_buildTransactions: Validation error: Invalid Recipient: Wrong CAIP-10 format: intent.caip10Recipient',
      ),
      JsonRpcError(
        code: -9,
        message:
            'wc_pos_buildTransactions: Validation error: Unable to parse amount with 6 decimals: digit 18 is out of range for base 10',
      ),
      JsonRpcError(
        code: -9,
        message:
            'wc_pos_buildTransactions: Validation error: Invalid token mint address: String is the wrong size',
      ),
      JsonRpcError(
        code: -9,
        message:
            'wc_pos_buildTransactions: Validation error: Invalid Sender: Wrong CAIP-10 format: sender',
      ),
      JsonRpcError(
        code: -9,
        message:
            'wc_pos_buildTransactions: Validation error: Invalid mint account owner: 11111111111111111111111111111111. Expected SPL Token program.',
      ),
    ];
    test('should parse from JSON correctly', () {
      for (var i = 0; i < solanaErrors.length; i++) {
        final JsonRpcError error = solanaErrors[i];
        final PosApiError posApiError = PosApiError.fromJsonRpcError(error);

        if (i == 0) {
          expect(posApiError, PosApiError.invalidRecipient);
        }
        if (i == 1) {
          expect(posApiError, PosApiError.unableToParseAmountWith6Decimals);
        }
        if (i == 2) {
          expect(posApiError, PosApiError.invalidTokenMintAddress);
        }
        if (i == 3) {
          expect(posApiError, PosApiError.invalidSender);
        }
        if (i == 4) {
          expect(posApiError, PosApiError.invalidMintAccountOwner);
        }
      }
    });
  });
}
