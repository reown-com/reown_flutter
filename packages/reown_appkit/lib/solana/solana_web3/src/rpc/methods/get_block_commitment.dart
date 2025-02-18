/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/types.dart' show u64;
import '../interfaces/json_rpc_method.dart';
import '../models/block_commitment.dart';

/// Get Block Commitment
/// ------------------------------------------------------------------------------------------------

/// A codec for `getBlockCommitment` JSON RPC methods.
class GetBlockCommitment
    extends JsonRpcMethod<Map<String, dynamic>, BlockCommitment> {
  /// Creates a codec for `getBlockCommitment` JSON RPC methods.
  GetBlockCommitment(
    final u64 block,
  ) : super(
          'getBlockCommitment',
          values: [block],
        );

  @override
  BlockCommitment decoder(final Map<String, dynamic> value) =>
      BlockCommitment.fromJson(value);
}
