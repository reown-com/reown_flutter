/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../configs/get_transaction_config.dart';
import '../interfaces/json_rpc_method.dart';
import '../models/transaction_info.dart';

/// Get Transaction
/// ------------------------------------------------------------------------------------------------

/// A codec for `getTransaction` JSON RPC methods.
class GetTransaction
    extends JsonRpcMethod<Map<String, dynamic>?, TransactionInfo?> {
  /// Creates a codec for `getTransaction` JSON RPC methods.
  GetTransaction(final String signature, {final GetTransactionConfig? config})
    : super(
        'getTransaction',
        values: [signature],
        config: config ?? GetTransactionConfig(),
      );

  @override
  TransactionInfo? decoder(final Map<String, dynamic>? value) =>
      value != null ? TransactionInfo.fromJson(value) : null;
}
