/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/types.dart' show u64;
import '../../crypto/pubkey.dart';
import '../configs/request_airdrop_config.dart';
import '../interfaces/json_rpc_type_method.dart';

/// Request Airdrop
/// ------------------------------------------------------------------------------------------------

/// A codec for `requestAirdrop` JSON RPC methods.
class RequestAirdrop extends JsonRpcTypeMethod<String> {
  /// Creates a codec for `requestAirdrop` JSON RPC methods.
  RequestAirdrop(
    final Pubkey pubkey,
    final u64 lamports, {
    final RequestAirdropConfig? config,
  }) : super(
         'requestAirdrop',
         values: [pubkey.toBase58(), lamports],
         config: config ?? const RequestAirdropConfig(),
       );
}
