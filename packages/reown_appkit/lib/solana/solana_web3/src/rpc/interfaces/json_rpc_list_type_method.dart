/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'json_rpc_method.dart';

/// JSON RPC List Type Method
/// ------------------------------------------------------------------------------------------------

/// A JSON RPC handler for methods that return a [List] of basic data types (e.g. [int], [String]).
abstract class JsonRpcListTypeMethod<T> extends JsonRpcMethod<List, List<T>> {
  /// Creates a JSON RPC handler for methods that return a [List] of basic data types (e.g. [int],
  /// [String]).
  const JsonRpcListTypeMethod(
    super.method, {
    super.values,
    super.config,
  });

  @override
  List<T> decoder(final List value) => value.cast<T>();
}
