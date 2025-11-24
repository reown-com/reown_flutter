/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
import 'package:reown_appkit/solana/solana_common/exceptions.dart';

part 'transaction_exception.g.dart';

/// Transaction Exception
/// ------------------------------------------------------------------------------------------------

@JsonSerializable(createToJson: false)
class TransactionException extends SolanaException {
  /// Creates an exception for an invalid transaction.
  const TransactionException(super.message, {super.code});

  /// {@macro solana_common.Serializable.fromJson}
  factory TransactionException.fromJson(final Map<String, dynamic> json) =>
      _$TransactionExceptionFromJson(json);
}
