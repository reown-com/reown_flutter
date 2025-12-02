/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../configs/send_transaction_config.dart';
import '../interfaces/json_rpc_type_method.dart';

/// Send Transaction
/// ------------------------------------------------------------------------------------------------

/// A codec for `sendTransaction` JSON RPC methods.
class SendTransaction extends JsonRpcTypeMethod<String> {
  /// Creates a codec for `sendTransaction` JSON RPC methods.
  SendTransaction(
    final String signedTransaction, {
    final SendTransactionConfig? config,
  }) : super(
         'sendTransaction',
         values: [signedTransaction],
         config: config ?? SendTransactionConfig(),
       );
}
