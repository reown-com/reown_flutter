/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:typed_data';
import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
import 'package:reown_appkit/solana/solana_common/models.dart';
import 'package:reown_core/reown_core.dart';
import '../crypto/pubkey.dart';
import '../encodings/unit8_list_json_converter.dart';
import '../messages/message_instruction.dart';
import 'account_meta.dart';

part 'transaction_instruction.g.dart';

/// Transaction Instruction
/// ------------------------------------------------------------------------------------------------

@JsonSerializable(explicitToJson: true)
class TransactionInstruction extends Serializable {
  /// A TransactionInstruction object.
  TransactionInstruction({
    required this.keys,
    required this.programId,
    required this.data,
  });

  /// Public keys to include in this transaction.
  final List<AccountMeta> keys;

  //// Program Id to execute
  final Pubkey programId;

  /// Program input
  @Uint8ListJsonConverter()
  final Uint8List data;

  /// {@macro solana_common.Serializable.fromJson}
  factory TransactionInstruction.fromJson(final Map<String, dynamic> json) =>
      _$TransactionInstructionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TransactionInstructionToJson(this);

  /// Converts this [TransactionInstruction] into an [MessageInstruction]. The [keys] are an ordered
  /// list of `all` public keys referenced by this transaction.
  MessageInstruction toMessageInstruction(final List<Pubkey> keys) =>
      MessageInstruction(
        programIdIndex: keys.indexOf(programId),
        accounts: this.keys.map(
          (final AccountMeta meta) => keys.indexOf(meta.pubkey),
        ),
        data: base58.encode(Uint8List.fromList(data)),
      );
}
