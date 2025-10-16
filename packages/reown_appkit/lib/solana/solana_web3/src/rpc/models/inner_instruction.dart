/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/extensions.dart';
import 'package:reown_appkit/solana/solana_common/models.dart';
import '../../messages/message_instruction.dart';

/// Inner Instruction
/// ------------------------------------------------------------------------------------------------

class InnerInstruction extends Serializable {
  /// The Solana runtime records the cross-program instructions that are invoked during transaction
  /// processing and makes these available for greater transparency of what was executed on-chain
  /// per transaction instruction.
  const InnerInstruction({required this.index, required this.instructions});

  /// The index of the transaction instruction from which the inner instruction(s) originated.
  final num index;

  /// An ordered list of inner program instructions that were invoked during a single transaction
  /// instruction.
  final List<MessageInstruction> instructions;

  /// {@macro solana_common.Serializable.fromJson}
  factory InnerInstruction.fromJson(final Map<String, dynamic> json) =>
      InnerInstruction(
        index: json['index'],
        instructions: IterableSerializable.fromJson(
          json['instructions'],
          MessageInstruction.fromJson,
        ),
      );

  @override
  Map<String, dynamic> toJson() => {
    'index': index,
    'instructions': instructions.toJson(),
  };
}
