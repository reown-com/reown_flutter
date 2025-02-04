/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
import 'package:reown_appkit/solana/solana_common/models.dart';
import '../transactions/transaction.dart';
import 'message.dart';

part 'message_header.g.dart';

/// Message Header
/// ------------------------------------------------------------------------------------------------

@JsonSerializable()
class MessageHeader extends Serializable {
  /// Details the account types and signatures required by the transaction (signed and read-only
  /// accounts).
  const MessageHeader({
    required this.numRequiredSignatures,
    required this.numReadonlySignedAccounts,
    required this.numReadonlyUnsignedAccounts,
  });

  /// The total number of signatures required to make the transaction valid. The signatures must
  /// match the first `numRequiredSignatures` of [Message.accountKeys].
  ///
  /// ### Example:
  ///
  ///   If [Transaction.signatures] = `['signature1', 'signature0', 'signature2']`,
  ///
  ///   then [numRequiredSignatures] must = `3`,
  ///
  ///   and the first `3` public keys in [Message.accountKeys] will be the [Transaction.signatures]'
  ///   corresponding public keys in the same order `['pk1', 'pk0', 'pk2', ...]`.
  final int numRequiredSignatures;

  /// The last `numReadonlySignedAccounts` of the signed keys are read-only accounts.
  final int numReadonlySignedAccounts;

  /// The last `numReadonlyUnsignedAccounts` of the unsigned keys are read-only accounts.
  final int numReadonlyUnsignedAccounts;

  /// {@macro solana_common.Serializable.fromJson}
  factory MessageHeader.fromJson(final Map<String, dynamic> json) =>
      _$MessageHeaderFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MessageHeaderToJson(this);
}
