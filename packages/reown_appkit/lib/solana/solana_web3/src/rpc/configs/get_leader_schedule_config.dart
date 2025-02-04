/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_jsonrpc/jsonrpc.dart'
    show CommitmentConfig;
import '../../crypto/pubkey.dart';

/// Get Leader Schedule Config
/// ------------------------------------------------------------------------------------------------

class GetLeaderScheduleConfig extends CommitmentConfig {
  /// JSON RPC configurations for `getLeaderSchedule` methods.
  const GetLeaderScheduleConfig({
    super.commitment,
    this.identity,
  });

  /// If set, only return results for this validator identity.
  final Pubkey? identity;

  @override
  Map<String, dynamic> toJson() => {
        'commitment': commitment?.name,
        'identity': identity?.toBase58(),
      };
}
