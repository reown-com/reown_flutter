/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../configs/simulate_transaction_config.dart';
import '../interfaces/json_rpc_context_method.dart';
import '../models/transaction_status.dart';

/// Simulate Transaction
/// ------------------------------------------------------------------------------------------------

/// A codec for `simulateTransaction` JSON RPC methods.
class SimulateTransaction
    extends JsonRpcContextMethod<Map<String, dynamic>, TransactionStatus> {
  /// Creates a codec for `simulateTransaction` JSON RPC methods.
  SimulateTransaction(
    final String signedTransaction, {
    final SimulateTransactionConfig? config,
  }) : super(
         'simulateTransaction',
         values: [signedTransaction],
         config: config ?? SimulateTransactionConfig(),
       );

  @override
  TransactionStatus valueDecoder(final Map<String, dynamic> value) =>
      TransactionStatus.fromJson(value);
}
