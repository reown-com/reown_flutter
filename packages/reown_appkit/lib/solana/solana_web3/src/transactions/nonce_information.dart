/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
import 'package:reown_appkit/solana/solana_common/models.dart';
import '../types.dart';
import 'transaction_instruction.dart';

part 'nonce_information.g.dart';

/// Nonce Information
/// ------------------------------------------------------------------------------------------------

@JsonSerializable(explicitToJson: true)
class NonceInformation extends Serializable {
  /// Nonce information to be used to build an offline Transaction.
  const NonceInformation({required this.nonce, required this.nonceInstruction});

  /// The current blockhash stored in the nonce.
  final Blockhash nonce;

  /// AdvanceNonceAccount Instruction
  final TransactionInstruction nonceInstruction;

  /// {@macro solana_common.Serializable.fromJson}
  factory NonceInformation.fromJson(final Map<String, dynamic> json) =>
      _$NonceInformationFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$NonceInformationToJson(this);
}
