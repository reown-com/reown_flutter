/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
import 'package:reown_appkit/solana/solana_common/models.dart';
import 'message.dart';

part 'message_instruction.g.dart';

/// Message Instruction
/// ------------------------------------------------------------------------------------------------

@JsonSerializable()
class MessageInstruction extends Serializable {
  /// An instruction to execute by a program.
  const MessageInstruction({
    required this.programIdIndex,
    required this.accounts,
    required this.data,
  });

  /// Index into the [Message.accountKeys] array indicating the program account that executes this
  /// instruction.
  final int programIdIndex;

  /// List of ordered indices into the message.accountKeys array indicating which accounts to pass
  /// to the program.
  final Iterable<int> accounts;

  /// The program's input data encoded as a `base-58` string.
  final String data;

  /// {@macro solana_common.Serializable.fromJson}
  factory MessageInstruction.fromJson(final Map<String, dynamic> json) =>
      _$MessageInstructionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MessageInstructionToJson(this);
}
