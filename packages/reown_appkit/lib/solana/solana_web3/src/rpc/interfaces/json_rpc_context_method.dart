/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/models.dart';
import 'package:reown_appkit/solana/solana_jsonrpc/jsonrpc.dart' as jsonrpc;
import 'json_rpc_params_mixin.dart';

/// JSON RPC Context Method
/// ------------------------------------------------------------------------------------------------

/// A JSON RPC handler for context methods.
abstract class JsonRpcContextMethod<S, T>
    extends jsonrpc.JsonRpcContextMethod<S, T>
    with JsonRpcParamsMixin {
  /// Creates a JSON RPC handler for context methods.
  const JsonRpcContextMethod(
    super.method, {
    final List<Object?>? values,
    this.config,
  }) : values = values ?? const [];

  @override
  final List<Object?> values;

  @override
  final Serializable? config;
}
