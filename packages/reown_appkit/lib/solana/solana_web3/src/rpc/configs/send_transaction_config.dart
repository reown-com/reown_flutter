/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/models.dart';
import 'package:reown_appkit/solana/solana_common/types.dart' show usize;
import 'package:reown_appkit/solana/solana_jsonrpc/jsonrpc.dart'
    show Commitment;
import '../../encodings/transaction_encoding.dart';

/// Send Transaction Config
/// ------------------------------------------------------------------------------------------------

class SendTransactionConfig extends Serializable {
  /// JSON RPC configurations for `sendTransaction` methods.
  const SendTransactionConfig({
    this.skipPreflight = false,
    this.preflightCommitment,
    this.encoding = TransactionEncoding.base64,
    this.maxRetries,
    this.minContextSlot,
  }) : assert(encoding == TransactionEncoding.base64);

  /// If true, skip the preflight transaction checks (default: `false`).
  final bool skipPreflight;

  /// The type of block to query for the request.
  final Commitment? preflightCommitment;

  /// The transaction data encoding (must be 'base64').
  final TransactionEncoding encoding;

  /// The maximum number of times for the RPC node to retry sending the transaction to the leader.
  /// If this parameter not provided, the RPC node will retry the transaction until it is finalized
  /// or until the blockhash expires.
  final usize? maxRetries;

  /// The minimum slot that the request can be evaluated at.
  final int? minContextSlot;

  @override
  Map<String, dynamic> toJson() => {
    'skipPreflight': skipPreflight,
    'preflightCommitment': preflightCommitment?.name,
    'encoding': encoding.name,
    'maxRetries': maxRetries,
    'minContextSlot': minContextSlot,
  };
}
