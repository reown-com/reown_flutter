/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../interfaces/json_rpc_type_method.dart';

/// Get Genesis Hash
/// ------------------------------------------------------------------------------------------------

/// A codec for `getGenesisHash` JSON RPC methods.
class GetGenesisHash extends JsonRpcTypeMethod<String> {
  /// Creates a codec for `getGenesisHash` JSON RPC methods.
  GetGenesisHash() : super('getGenesisHash');
}
