/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
import 'package:reown_appkit/solana/solana_common/models.dart'
    show Serializable;

part 'context.g.dart';

/// JSON RPC Context
/// ------------------------------------------------------------------------------------------------

/// A JSON RPC response context.
@JsonSerializable()
class JsonRpcContext extends Serializable {
  /// Creates a JSON RPC response context.
  const JsonRpcContext({
    required this.slot,
  });

  /// The slot at which the operation was evaluated.
  final int slot;

  /// {@macro solana_common.Serializable.fromJson}
  factory JsonRpcContext.fromJson(final Map<String, dynamic> json) =>
      _$JsonRpcContextFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$JsonRpcContextToJson(this);
}
