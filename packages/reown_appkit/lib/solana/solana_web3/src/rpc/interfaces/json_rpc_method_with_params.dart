/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/models.dart';
import 'package:reown_appkit/solana/solana_jsonrpc/jsonrpc.dart'
    show JsonRpcMethod;
import 'package:reown_appkit/solana/solana_web3/src/rpc/interfaces/json_rpc_params_mixin.dart';

/// JSON RPC Method with Params Mixin
/// ------------------------------------------------------------------------------------------------

/// A [JsonRpcMethod] with [JsonRpcParamsMixin].
abstract class JsonRpcMethodWithParams<S, T> extends JsonRpcMethod<S, T>
    with JsonRpcParamsMixin {
  const JsonRpcMethodWithParams(
    super.method, {
    final List<Object?>? values,
    this.config,
  }) : values = values ?? const [];

  @override
  final List<Object?> values;

  @override
  final Serializable? config;
}
