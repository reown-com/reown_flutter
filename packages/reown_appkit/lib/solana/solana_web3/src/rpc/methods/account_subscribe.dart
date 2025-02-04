/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_jsonrpc/types.dart'
    show SubscriptionId;
import '../../crypto/pubkey.dart';
import '../configs/account_subscribe_config.dart';
import '../interfaces/json_rpc_type_method.dart';

/// Account Subscribe
/// ------------------------------------------------------------------------------------------------

/// A method handler for `accountSubscribe`.
class AccountSubscribe extends JsonRpcTypeMethod<SubscriptionId> {
  /// Creates a method handler for `accountSubscribe`.
  AccountSubscribe(
    final Pubkey pubkey, {
    final AccountSubscribeConfig? config,
  }) : super(
          'accountSubscribe',
          values: [pubkey.toBase58()],
          config: config ?? const AccountSubscribeConfig(),
        );
}
