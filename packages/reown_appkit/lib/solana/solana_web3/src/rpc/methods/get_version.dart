/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../interfaces/json_rpc_method.dart';
import '../models/version.dart';

/// Get Version
/// ------------------------------------------------------------------------------------------------

/// A codec for `getVersion` JSON RPC methods.
class GetVersion extends JsonRpcMethod<Map<String, dynamic>, Version> {
  /// Creates a codec for `getVersion` JSON RPC methods.
  GetVersion() : super('getVersion');

  @override
  Version decoder(
    final Map<String, dynamic> value,
  ) =>
      Version.fromJson(value);
}
