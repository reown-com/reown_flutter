/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/models.dart';

/// Get Signature Statuses Config
/// ------------------------------------------------------------------------------------------------

class GetSignatureStatusesConfig extends Serializable {
  /// JSON RPC configurations for `getLeaderSchedule` methods.
  const GetSignatureStatusesConfig({
    this.searchTransactionHistory = false,
  });

  /// If true, a Solana node will search its ledger cache for any signatures not found in the recent
  /// status cache.
  final bool searchTransactionHistory;

  @override
  Map<String, dynamic> toJson() => {
        'searchTransactionHistory': searchTransactionHistory,
      };
}
