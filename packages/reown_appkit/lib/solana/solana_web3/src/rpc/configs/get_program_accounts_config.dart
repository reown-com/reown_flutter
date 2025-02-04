/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/extensions.dart';
import 'package:reown_appkit/solana/solana_common/types.dart' show u64;
import 'package:reown_appkit/solana/solana_jsonrpc/jsonrpc.dart'
    show CommitmentConfig;
import 'package:reown_appkit/solana/solana_jsonrpc/models.dart' show Filter;
import '../../encodings/account_encoding.dart';
import '../models/data_slice.dart';

/// Get Program Accounts Config
/// ------------------------------------------------------------------------------------------------

class GetProgramAccountsConfig extends CommitmentConfig {
  /// JSON RPC configurations for `getProgramAccounts` methods.
  GetProgramAccountsConfig({
    super.commitment,
    this.encoding = AccountEncoding.base64,
    this.dataSlice,
    this.filters,
    this.minContextSlot,
  })  : assert(dataSlice == null || encoding.isBinary,
            'Must use binary encoding for [DataSlice].'),
        assert(minContextSlot == null || minContextSlot >= 0);

  /// The account data's encoding (default: [AccountEncoding.base64]).
  ///
  /// If [dataSlice] is provided, encoding is limited to `base58`, `base64` or `base64+zstd`.
  final AccountEncoding encoding;

  /// Limit the returned account data to the range [DataSlice.offset] : [DataSlice.offset] +
  /// [DataSlice.length].
  final DataSlice? dataSlice;

  /// The filters applied to the results. An account must meet all filter criteria to be included in
  /// results.
  final List<Filter>? filters;

  /// The minimum slot that the request can be evaluated at.
  final u64? minContextSlot;

  @override
  Map<String, dynamic> toJson() => {
        'commitment': commitment?.name,
        'encoding': encoding.name,
        'dataSlice': dataSlice?.toJson(),
        'filters': filters?.toJson(),
        'minContextSlot': minContextSlot,
      };
}
