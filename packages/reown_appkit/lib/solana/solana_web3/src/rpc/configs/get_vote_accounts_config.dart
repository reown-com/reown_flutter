/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_jsonrpc/jsonrpc.dart'
    show CommitmentConfig;
import '../../crypto/pubkey.dart';

/// Get Vote Accounts Config
/// ------------------------------------------------------------------------------------------------

class GetVoteAccountsConfig extends CommitmentConfig {
  /// JSON RPC configurations for `getVoteAccounts` methods.
  const GetVoteAccountsConfig({
    super.commitment,
    this.votePubkey,
    this.keepUnstakedDelinquents,
  });

  /// If set, only return results for this validator vote address.
  final Pubkey? votePubkey;

  /// If true, do not filter out delinquent validators with no stake.
  final bool? keepUnstakedDelinquents;

  @override
  Map<String, dynamic> toJson() => {
        'commitment': commitment?.name,
        'votePubkey': votePubkey?.toBase58(),
        'keepUnstakedDelinquents': keepUnstakedDelinquents,
      };
}
