/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
import 'package:reown_appkit/solana/solana_common/exceptions.dart';

part 'transaction_signature_exception.g.dart';

/// Transaction Signature Exception
/// ------------------------------------------------------------------------------------------------

@JsonSerializable(createToJson: false)
class TransactionSignatureException extends SolanaException {
  /// Creates an exception for block height expiration.
  const TransactionSignatureException(super.message, {super.code});

  /// {@macro solana_common.Serializable.fromJson}
  factory TransactionSignatureException.fromJson(
    final Map<String, dynamic> json,
  ) => _$TransactionSignatureExceptionFromJson(json);
}
