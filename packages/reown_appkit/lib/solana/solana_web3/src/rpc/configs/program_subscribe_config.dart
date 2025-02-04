/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/extensions.dart';
import 'package:reown_appkit/solana/solana_jsonrpc/jsonrpc.dart'
    show CommitmentConfig;
import 'package:reown_appkit/solana/solana_jsonrpc/models.dart';
import '../../encodings/account_encoding.dart';

/// Program Subscribe Config
/// ------------------------------------------------------------------------------------------------

class ProgramSubscribeConfig extends CommitmentConfig {
  /// Creates a config object for JSON RPC `ProgramSubscribe` requests.
  const ProgramSubscribeConfig({
    super.commitment,
    this.filters,
    this.encoding = AccountEncoding.base64,
  });

  /// The filters applied to the results. An account must meet all filter criteria to be included in
  /// results.
  final List<Filter>? filters;

  /// The Program data's encoding (default: [AccountEncoding.base64]).
  final AccountEncoding encoding;

  @override
  Map<String, dynamic> toJson() => {
        'commitment': commitment?.name,
        'filters': filters?.toJson(),
        'encoding': encoding.name,
      };
}
