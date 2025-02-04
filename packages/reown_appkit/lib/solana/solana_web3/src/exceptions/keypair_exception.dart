/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
import 'package:reown_appkit/solana/solana_common/exceptions.dart';

part 'keypair_exception.g.dart';

/// Keypair Exception
/// ------------------------------------------------------------------------------------------------

@JsonSerializable(createToJson: false)
class KeypairException extends SolanaException {
  /// Creates an exception for an invalid keypair.
  const KeypairException(
    super.message, {
    super.code,
  });

  /// {@macro solana_common.Serializable.fromJson}
  factory KeypairException.fromJson(final Map<String, dynamic> json) =>
      _$KeypairExceptionFromJson(json);
}
