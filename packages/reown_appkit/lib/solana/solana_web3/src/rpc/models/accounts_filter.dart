/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/extensions.dart';
import 'package:reown_appkit/solana/solana_common/models.dart';
import '../../crypto/pubkey.dart';
import '../../encodings/account_encoding.dart';

/// Accounts Filter
/// ------------------------------------------------------------------------------------------------

class AccountsFilter extends Serializable {
  /// JSON RPC parameters for `simulateTransaction` methods.
  AccountsFilter({
    this.encoding,
    this.addresses = const [],
  }) : assert(encoding == null || encoding != AccountEncoding.base58);

  /// The returned account data's encoding (default: [AccountEncoding.base64]).
  final AccountEncoding? encoding;

  /// An array of accounts to return.
  final List<Pubkey> addresses;

  @override
  Map<String, dynamic> toJson() => {
        'encoding': encoding?.name,
        'addresses': addresses.toJson(),
      };
}
