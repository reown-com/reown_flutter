/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/models.dart';
import 'package:reown_appkit/solana/solana_common/types.dart' show u64;
import 'account_info.dart';

/// Transaction Status
/// ------------------------------------------------------------------------------------------------

class TransactionStatus extends Serializable {
  /// Transaction status.
  const TransactionStatus({
    required this.err,
    required this.logs,
    required this.accounts,
    required this.unitsConsumed,
  });

  /// The error if transaction failed, null if transaction succeeded.
  ///
  /// TODO: check error definitions.
  final dynamic err;

  /// An array of log messages the transaction instructions output during execution, null if
  /// simulation failed before the transaction was able to execute (for example due to an invalid
  /// blockhash or signature verification failure).
  final List? logs;

  /// An array of accounts with the same length as the accounts.addresses array in the request.
  final List<AccountInfo?>? accounts;

  /// The number of compute budget units consumed during the processing of this transaction.
  final u64? unitsConsumed;

  /// {@macro solana_common.Serializable.fromJson}
  factory TransactionStatus.fromJson(final Map<String, dynamic> json) =>
      TransactionStatus(
        err: json['err'],
        logs: json['logs'],
        accounts: json['accounts'],
        unitsConsumed: json['unitsConsumed'],
      );

  /// {@macro solana_common.Serializable.tryFromJson}
  static TransactionStatus? tryFromJson(final Map<String, dynamic>? json) =>
      json != null ? TransactionStatus.fromJson(json) : null;

  @override
  Map<String, dynamic> toJson() => {
        'err': err,
        'logs': logs,
        'accounts': accounts,
        'unitsConsumed': unitsConsumed,
      };
}
