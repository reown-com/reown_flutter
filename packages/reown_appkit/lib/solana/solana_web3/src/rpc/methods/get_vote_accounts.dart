/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../configs/get_vote_accounts_config.dart';
import '../interfaces/json_rpc_method.dart';
import '../models/vote_account_status.dart';

/// Get Vote Accounts
/// ------------------------------------------------------------------------------------------------

/// A codec for `getVoteAccounts` JSON RPC methods.
class GetVoteAccounts
    extends JsonRpcMethod<Map<String, dynamic>, VoteAccountStatus> {
  /// Creates a codec for `getVoteAccounts` JSON RPC methods.
  GetVoteAccounts({final GetVoteAccountsConfig? config})
    : super('getVoteAccounts', config: config ?? const GetVoteAccountsConfig());

  @override
  VoteAccountStatus decoder(final Map<String, dynamic> value) =>
      VoteAccountStatus.fromJson(value);
}
