/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/extensions.dart';
import '../../crypto/pubkey.dart';
import '../configs/get_multiple_accounts_config.dart';
import '../interfaces/json_rpc_list_context_method.dart';
import '../models/account_info.dart';

/// Get Multiple Accounts
/// ------------------------------------------------------------------------------------------------

/// A codec for `getMultipleAccounts` JSON RPC methods.
class GetMultipleAccounts
    extends JsonRpcListContextMethod<Map<String, dynamic>?, AccountInfo?> {
  /// Creates a codec for `getMultipleAccounts` JSON RPC methods.
  GetMultipleAccounts(
    final List<String> pubkeys, {
    final GetMultipleAccountsConfig? config,
  }) : super(
          'getMultipleAccounts',
          values: [pubkeys],
          config: config ?? GetMultipleAccountsConfig(),
        );

  factory GetMultipleAccounts.map(
    final Iterable<Pubkey> pubkeys, {
    final GetMultipleAccountsConfig? config,
  }) =>
      GetMultipleAccounts(
        pubkeys.toJson(),
        config: config,
      );

  @override
  AccountInfo? itemDecoder(
    final Map<String, dynamic>? item,
  ) =>
      item != null ? AccountInfo.fromJson(item) : null;
}
