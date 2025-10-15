/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_jsonrpc/types.dart'
    show SubscriptionId;
import 'package:reown_appkit/solana/solana_web3/src/crypto/pubkey.dart';
import '../configs/program_subscribe_config.dart';
import '../interfaces/json_rpc_type_method.dart';

/// Program Subscribe
/// ------------------------------------------------------------------------------------------------

/// A method handler for `programSubscribe`.
class ProgramSubscribe extends JsonRpcTypeMethod<SubscriptionId> {
  /// Creates a method handler for `programSubscribe`.
  ProgramSubscribe(
    final Pubkey programId, {
    final ProgramSubscribeConfig? config,
  }) : super(
         'programSubscribe',
         values: [programId.toBase58()],
         config: config ?? const ProgramSubscribeConfig(),
       );
}
