/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/types.dart' show usize;
import 'package:reown_appkit/solana/solana_jsonrpc/jsonrpc.dart'
    show Commitment, CommitmentConfig;
import '../../encodings/transaction_encoding.dart';
import 'confirm_transaction_config.dart';
import 'send_transaction_config.dart';

/// Send And Confirm Transaction Config
/// ------------------------------------------------------------------------------------------------

class SendAndConfirmTransactionConfig extends CommitmentConfig {
  /// JSON RPC configurations for `sendAndConfirmTransaction` methods.
  const SendAndConfirmTransactionConfig({
    this.skipPreflight = false,
    this.preflightCommitment,
    super.commitment,
    this.encoding = TransactionEncoding.base64,
    this.maxRetries,
    this.minContextSlot,
  }) : assert(encoding == TransactionEncoding.base64);

  /// If true, skip the preflight transaction checks (default: `false`).
  final bool skipPreflight;

  /// The type of block to query for the request (default: [commitment]).
  final Commitment? preflightCommitment;

  /// The transaction data encoding (must be 'base64').
  final TransactionEncoding encoding;

  /// The maximum number of times for the RPC node to retry sending the transaction to the leader.
  /// If this parameter not provided, the RPC node will retry the transaction until it is finalised
  /// or until the blockhash expires.
  final usize? maxRetries;

  /// The minimum slot that the request can be evaluated at.
  final int? minContextSlot;

  SendTransactionConfig? toSendTransactionConfig() {
    return SendTransactionConfig(
      skipPreflight: skipPreflight,
      preflightCommitment: preflightCommitment ?? commitment,
      encoding: encoding,
      maxRetries: maxRetries,
      minContextSlot: minContextSlot,
    );
  }

  ConfirmTransactionConfig? toConfirmTransactionConfig() {
    return ConfirmTransactionConfig(commitment: commitment);
  }

  @override
  Map<String, dynamic> toJson() => {
    'skipPreflight': skipPreflight,
    'commitment': commitment?.name,
    'preflightCommitment': preflightCommitment?.name,
    'encoding': encoding.name,
    'maxRetries': maxRetries,
    'minContextSlot': minContextSlot,
  };
}
