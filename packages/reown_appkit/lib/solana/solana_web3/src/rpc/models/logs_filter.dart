/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/models.dart';
import '../../crypto/pubkey.dart';

/// Logs Filter
/// ------------------------------------------------------------------------------------------------

class LogsFilter<T extends Object> extends Serializable {
  /// The filter criteria for the logs to receive results by account type.
  const LogsFilter(this.value);

  /// Raw value.
  final T value;

  /// Subscribes to all transactions except for simple vote transactions.
  static LogsFilter all() => const LogsFilter('all');

  /// Subscribes to all transactions including simple vote transactions.
  static LogsFilter allWithVotes() => const LogsFilter('allWithVotes');

  /// Subscribes to all transactions that mention the provided [Pubkey].
  static LogsFilter mentions(final List<Pubkey> accounts) {
    final mentions = accounts.map((final Pubkey account) => account.toBase58());
    return LogsFilter({'mentions': mentions});
  }

  @override
  dynamic toJson() => value;
}
