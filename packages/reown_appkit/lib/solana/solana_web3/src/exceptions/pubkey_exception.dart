/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
import 'package:reown_appkit/solana/solana_common/exceptions.dart';
import '../crypto/nacl.dart' as nacl show pubkeyLength;

part 'pubkey_exception.g.dart';

/// Public Key Exception
/// ------------------------------------------------------------------------------------------------

@JsonSerializable(createToJson: false)
class PubkeyException extends SolanaException {
  /// Creates an exception for an invalid public key.
  const PubkeyException(
    super.message, {
    super.code,
  });

  /// Creates an exception for an invalid public key length.
  ///
  /// The error [message] is constructed from the invalid key's [length] and the [maxLength] of a
  /// public key.
  ///
  /// ```
  ///   /// [message] = 'Invalid public key length of 16, expected 32.'
  ///   throw PubkeyException.length(16, maxLength: 32);
  /// ```
  factory PubkeyException.length(
    final int length, {
    final int maxLength = nacl.pubkeyLength,
  }) =>
      PubkeyException(
          'Invalid public key length of $length, expected $maxLength.');

  /// {@macro solana_common.Serializable.fromJson}
  factory PubkeyException.fromJson(final Map<String, dynamic> json) =>
      _$PubkeyExceptionFromJson(json);
}
