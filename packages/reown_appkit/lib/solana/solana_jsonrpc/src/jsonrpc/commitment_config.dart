/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
import 'package:reown_appkit/solana/solana_common/models.dart';
import '../jsonrpc/commitment.dart';

part 'commitment_config.g.dart';

/// Commitment Config
/// ------------------------------------------------------------------------------------------------

@JsonSerializable(explicitToJson: true)
class CommitmentConfig extends Serializable {
  /// JSON RPC configurations for `commitment`.
  const CommitmentConfig({
    this.commitment,
  });

  /// The type of block to query for the request. If commitment is not provided, the node will
  /// default to [Commitment.finalized].
  final Commitment? commitment;

  /// {@macro solana_common.Serializable.fromJson}
  factory CommitmentConfig.fromJson(final Map<String, dynamic> json) =>
      _$CommitmentConfigFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CommitmentConfigToJson(this);
}
