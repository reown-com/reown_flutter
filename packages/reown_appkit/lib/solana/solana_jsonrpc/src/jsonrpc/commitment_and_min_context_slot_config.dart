/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
import '../jsonrpc/commitment.dart';
import 'commitment_config.dart';

part 'commitment_and_min_context_slot_config.g.dart';

/// Commitment and Min Context Slot Config
/// ------------------------------------------------------------------------------------------------

@JsonSerializable(explicitToJson: true)
class CommitmentAndMinContextSlotConfig extends CommitmentConfig {
  /// JSON RPC configurations for `commitment`.
  const CommitmentAndMinContextSlotConfig({
    super.commitment,
    this.minContextSlot,
  });

  /// The minimum slot that the request can be evaluated at.
  final int? minContextSlot;

  /// {@macro solana_common.Serializable.fromJson}
  factory CommitmentAndMinContextSlotConfig.fromJson(
          final Map<String, dynamic> json) =>
      _$CommitmentAndMinContextSlotConfigFromJson(json);

  @override
  Map<String, dynamic> toJson() =>
      _$CommitmentAndMinContextSlotConfigToJson(this);
}
