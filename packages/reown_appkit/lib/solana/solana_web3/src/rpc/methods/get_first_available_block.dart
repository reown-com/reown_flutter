/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/types.dart' show u64;
import '../interfaces/json_rpc_type_method.dart';

/// Get First Available Block
/// ------------------------------------------------------------------------------------------------

/// A codec for `getFirstAvailableBlock` JSON RPC methods.
class GetFirstAvailableBlock extends JsonRpcTypeMethod<u64> {
  /// Creates a codec for `getFirstAvailableBlock` JSON RPC methods.
  GetFirstAvailableBlock() : super('getFirstAvailableBlock');
}
