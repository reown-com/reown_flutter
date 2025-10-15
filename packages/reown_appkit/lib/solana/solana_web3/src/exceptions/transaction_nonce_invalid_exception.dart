/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
import 'package:reown_appkit/solana/solana_common/exceptions.dart';

part 'transaction_nonce_invalid_exception.g.dart';

/// Transaction Nonce Invalid Exception
/// ------------------------------------------------------------------------------------------------

@JsonSerializable(createToJson: false)
class TransactionNonceInvalidException extends SolanaException {
  /// Creates an exception for an invalid nonce.
  const TransactionNonceInvalidException(super.message, {this.slot});

  ///
  final int? slot;

  /// {@macro solana_common.Serializable.fromJson}
  factory TransactionNonceInvalidException.fromJson(
    final Map<String, dynamic> json,
  ) => _$TransactionNonceInvalidExceptionFromJson(json);
}
