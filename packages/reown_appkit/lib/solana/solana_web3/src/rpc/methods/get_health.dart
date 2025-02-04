/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_jsonrpc/models.dart';
import '../interfaces/json_rpc_method.dart';

/// Get Health
/// ------------------------------------------------------------------------------------------------

/// A codec for `getHealth` JSON RPC methods.
class GetHealth extends JsonRpcMethod<String, HealthStatus> {
  /// Creates a codec for `getHealth` JSON RPC methods.
  GetHealth() : super('getHealth');

  @override
  HealthStatus decoder(final String value) => HealthStatus.fromJson(value);
}
