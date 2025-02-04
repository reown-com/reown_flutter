/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../interfaces/json_rpc_method.dart';
import '../models/identity.dart';

/// Get Identity
/// ------------------------------------------------------------------------------------------------

/// A codec for `getIdentity` JSON RPC methods.
class GetIdentity extends JsonRpcMethod<Map<String, dynamic>, Identity> {
  /// Creates a codec for `getIdentity` JSON RPC methods.
  GetIdentity() : super('getIdentity');

  @override
  Identity decoder(final Map<String, dynamic> value) =>
      Identity.fromJson(value);
}
