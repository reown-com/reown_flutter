/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../configs/get_epoch_info_config.dart';
import '../interfaces/json_rpc_method.dart';
import '../models/epoch_info.dart';

/// Get Epoch Info
/// ------------------------------------------------------------------------------------------------

/// A codec for `getEpochInfo` JSON RPC methods.
class GetEpochInfo extends JsonRpcMethod<Map<String, dynamic>, EpochInfo> {
  /// Creates a codec for `getEpochInfo` JSON RPC methods.
  GetEpochInfo({
    final GetEpochInfoConfig? config,
  }) : super(
          'getEpochInfo',
          config: config ?? const GetEpochInfoConfig(),
        );

  @override
  EpochInfo decoder(final Map<String, dynamic> value) =>
      EpochInfo.fromJson(value);
}
