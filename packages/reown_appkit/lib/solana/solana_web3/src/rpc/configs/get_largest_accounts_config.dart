/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_jsonrpc/jsonrpc.dart'
    show CommitmentConfig;
import '../models/account_filter.dart';

/// Get Largest Accounts Config
/// ------------------------------------------------------------------------------------------------

class GetLargestAccountsConfig extends CommitmentConfig {
  /// JSON RPC configurations for `getLargeAccounts` methods.
  const GetLargestAccountsConfig({
    super.commitment,
    this.filter,
  });

  /// Filter results by account type.
  final AccountFilter? filter;

  @override
  Map<String, dynamic> toJson() => {
        'commitment': commitment?.name,
        'filter': filter?.name,
      };
}
