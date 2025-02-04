/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_jsonrpc/jsonrpc.dart'
    show Commitment, CommitmentConfig;
import '../../encodings/transaction_encoding.dart';

/// Get Transaction Config
/// ------------------------------------------------------------------------------------------------

class GetTransactionConfig extends CommitmentConfig {
  /// JSON RPC configurations for `getTransaction` methods.
  GetTransactionConfig({
    this.encoding = TransactionEncoding.base64,
    super.commitment,
    this.maxSupportedTransactionVersion,
  })  : assert(maxSupportedTransactionVersion == null ||
            maxSupportedTransactionVersion >= 0),
        assert(commitment != Commitment.processed,
            'The commitment "processed" is not supported.');

  /// The transaction data's encoding (default: [TransactionEncoding.json]).
  final TransactionEncoding? encoding;

  /// The max transaction version to return in responses. If the requested transaction is a higher
  /// version, an error will be returned. If this parameter is omitted, only legacy transactions
  /// will be returned, and any versioned transaction will prompt the error.
  final int? maxSupportedTransactionVersion;

  @override
  Map<String, dynamic> toJson() => {
        'encoding': encoding?.name,
        'commitment': commitment?.name,
        'maxSupportedTransactionVersion': maxSupportedTransactionVersion,
      };
}
