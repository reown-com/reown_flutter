/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/models.dart';
import 'package:reown_appkit/solana/solana_jsonrpc/jsonrpc.dart'
    show Commitment, JsonRpcMethod, JsonRpcRequest;

/// JSON RPC Params Mixin
/// ------------------------------------------------------------------------------------------------

/// Implements [JsonRpcMethod.params].
mixin JsonRpcParamsMixin<S, T> on JsonRpcMethod<S, T> {
  /// The ordered parameter values.
  List<Object?> get values;

  /// The parameter configurations object.
  Serializable? get config;

  @override
  Object? params([final Commitment? commitment]) {
    // Serialize the configurations object.
    final Map<String, dynamic> object = config?.toJson() ?? const {};

    // Methods that query bank state contain a commitment parameter.
    // Check if this method queries bank state and apply the provided commitment level as a default.
    if (object.containsKey(JsonRpcRequest.commitmentKey)) {
      object[JsonRpcRequest.commitmentKey] ??= commitment;
    }

    return object.isEmpty ? values : [...values, object];
  }
}
