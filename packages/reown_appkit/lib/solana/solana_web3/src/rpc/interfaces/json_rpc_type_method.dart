/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'json_rpc_method.dart';

/// JSON RPC Type Method
/// ------------------------------------------------------------------------------------------------

/// A JSON RPC handler for methods that return basic data types (e.g. [int], [String]).
abstract class JsonRpcTypeMethod<T> extends JsonRpcMethod<T, T> {
  /// Creates a JSON RPC handler for methods that return basic data types (e.g. [int], [String]).
  const JsonRpcTypeMethod(super.method, {super.values, super.config});

  @override
  T decoder(final T value) => value;
}
