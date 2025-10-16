/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
import 'package:reown_appkit/solana/solana_common/exceptions.dart';

part 'transaction_block_height_exceeded_exception.g.dart';

/// Transaction Block Height Exceeded Exception
/// ------------------------------------------------------------------------------------------------

@JsonSerializable(createToJson: false)
class TransactionBlockHeightExceededException extends SolanaException {
  /// Creates an exception for block height expiration.
  const TransactionBlockHeightExceededException(super.message, {super.code});

  /// {@macro solana_common.Serializable.fromJson}
  factory TransactionBlockHeightExceededException.fromJson(
    final Map<String, dynamic> json,
  ) => _$TransactionBlockHeightExceededExceptionFromJson(json);
}
