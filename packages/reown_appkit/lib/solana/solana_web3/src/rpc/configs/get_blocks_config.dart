/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_jsonrpc/jsonrpc.dart'
    show Commitment, CommitmentConfig;

/// Get Blocks Config
/// ------------------------------------------------------------------------------------------------

class GetBlocksConfig extends CommitmentConfig {
  /// JSON RPC configurations for `getBlocks` methods.
  const GetBlocksConfig({
    super.commitment,
  }) : assert(commitment != Commitment.processed,
            'The commitment "processed" is not supported.');
}
