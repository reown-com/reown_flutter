/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
import 'package:reown_appkit/solana/solana_common/exceptions.dart';

part 'ed25519_exception.g.dart';

/// ED25519 Exception
/// ------------------------------------------------------------------------------------------------

@JsonSerializable(createToJson: false)
class ED25519Exception extends SolanaException {
  /// Creates an exception for the `ed25519` public key signature system.
  const ED25519Exception(super.message, {super.code});

  /// {@macro solana_common.Serializable.fromJson}
  factory ED25519Exception.fromJson(final Map<String, dynamic> json) =>
      _$ED25519ExceptionFromJson(json);
}
