/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/types.dart' show usize;
import '../interfaces/json_rpc_list_method.dart';
import '../models/performance_sample.dart';

/// Get Recent Performance Samples
/// ------------------------------------------------------------------------------------------------

/// A codec for `getRecentPerformanceSamples` JSON RPC methods.
class GetRecentPerformanceSamples
    extends JsonRpcListMethod<Map<String, dynamic>, PerformanceSample> {
  /// Creates a codec for `getRecentPerformanceSamples` JSON RPC methods.
  GetRecentPerformanceSamples({final usize? limit})
    : super(
        'getRecentPerformanceSamples',
        values: limit != null ? [limit] : const [],
      );

  @override
  PerformanceSample itemDecoder(final Map<String, dynamic> item) =>
      PerformanceSample.fromJson(item);
}
