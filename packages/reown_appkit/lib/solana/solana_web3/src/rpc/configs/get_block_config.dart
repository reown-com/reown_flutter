/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/types.dart' show u64;
import 'package:reown_appkit/solana/solana_jsonrpc/jsonrpc.dart'
    show Commitment, CommitmentConfig;
import '../../encodings/transaction_encoding.dart';
import '../models/transaction_detail.dart';

/// Get Block Config
/// ------------------------------------------------------------------------------------------------

class GetBlockConfig extends CommitmentConfig {
  /// JSON RPC configurations for `getBlock` methods.
  GetBlockConfig({
    super.commitment,
    this.encoding,
    this.transactionDetails,
    this.maxSupportedTransactionVersion,
    this.rewards,
  }) : assert(
         maxSupportedTransactionVersion == null ||
             maxSupportedTransactionVersion >= 0,
       ),
       assert(
         commitment != Commitment.processed,
         'The commitment "processed" is not supported.',
       );

  /// The encoding for each returned transaction (default: [TransactionEncoding.json]).
  final TransactionEncoding? encoding;

  /// The level of transaction details to return (default: [TransactionDetail.full]).
  final TransactionDetail? transactionDetails;

  /// If true, populate the response's rewards array (default: `true`).
  final bool? rewards;

  /// The max transaction version to return in responses. If the requested block contains a
  /// transaction with a higher version, an error will be returned.
  final u64? maxSupportedTransactionVersion;

  @override
  Map<String, dynamic> toJson() => {
    'encoding': encoding?.name,
    'transactionDetails': transactionDetails?.name,
    'rewards': rewards,
    'commitment': commitment?.name,
    'maxSupportedTransactionVersion': maxSupportedTransactionVersion,
  };
}
