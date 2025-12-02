/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'json_rpc_context_method.dart';

/// JSON RPC Type Context Method
/// ------------------------------------------------------------------------------------------------

/// A JSON RPC handler for context methods that return basic data types (e.g. [int], [String]).
abstract class JsonRpcTypeContextMethod<T> extends JsonRpcContextMethod<T, T> {
  /// Creates a JSON RPC handler for context methods that return basic data types (e.g. [int],
  /// [String]).
  const JsonRpcTypeContextMethod(super.method, {super.values, super.config});

  @override
  T valueDecoder(final T value) => value;
}
