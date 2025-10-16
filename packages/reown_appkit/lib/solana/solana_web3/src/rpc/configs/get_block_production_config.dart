/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_jsonrpc/jsonrpc.dart'
    show CommitmentConfig;
import '../../crypto/pubkey.dart';
import '../models/slot_range.dart';

/// Get Block Production Config
/// ------------------------------------------------------------------------------------------------

class GetBlockProductionConfig extends CommitmentConfig {
  /// JSON RPC configurations for `getBlockProduction` methods.
  const GetBlockProductionConfig({super.commitment, this.range, this.identity});

  /// The slot range to return block production for. If omitted, it defaults to the current epoch.
  final SlotRange? range;

  /// If set, return results for this validator identity only.
  final Pubkey? identity;

  @override
  Map<String, dynamic> toJson() => {
    'commitment': commitment?.name,
    'range': range?.toJson(),
    'identity': identity?.toBase58(),
  };
}
