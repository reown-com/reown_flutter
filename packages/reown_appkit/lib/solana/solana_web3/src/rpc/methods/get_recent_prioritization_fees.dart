/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/extensions.dart';
import '../../crypto/pubkey.dart';
import '../interfaces/json_rpc_list_method.dart';
import '../models/prioritization_fee.dart';

/// Get Recent Performance Samples
/// ------------------------------------------------------------------------------------------------

/// A codec for `getRecentPrioritizationFees` JSON RPC methods.
class GetRecentPrioritizationFees
    extends JsonRpcListMethod<Map<String, dynamic>, PrioritizationFee> {
  /// Creates a codec for `getRecentPrioritizationFees` JSON RPC methods.
  GetRecentPrioritizationFees(final List<String>? addresses)
    : assert(addresses == null || addresses.length <= 128),
      super('getRecentPrioritizationFees', values: [addresses]);

  factory GetRecentPrioritizationFees.map(final Iterable<Pubkey>? addresses) =>
      GetRecentPrioritizationFees(addresses?.toJson());

  @override
  PrioritizationFee itemDecoder(final Map<String, dynamic> item) =>
      PrioritizationFee.fromJson(item);
}
