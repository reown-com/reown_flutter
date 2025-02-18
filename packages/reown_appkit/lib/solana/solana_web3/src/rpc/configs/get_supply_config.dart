/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_jsonrpc/jsonrpc.dart'
    show CommitmentConfig;

/// Get Supply Config
/// ------------------------------------------------------------------------------------------------

class GetSupplyConfig extends CommitmentConfig {
  /// JSON RPC configurations for `getSupply` methods.
  const GetSupplyConfig({
    super.commitment,
    this.excludeNonCirculatingAccountsList = false,
  });

  /// If true, exclude the list of non circulating accounts from the response.
  final bool excludeNonCirculatingAccountsList;

  @override
  Map<String, dynamic> toJson() => {
        'commitment': commitment?.name,
        'excludeNonCirculatingAccountsList': excludeNonCirculatingAccountsList,
      };
}
