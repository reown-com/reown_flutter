/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'json_rpc_context_method.dart';

/// JSON RPC List Type Context Method
/// ------------------------------------------------------------------------------------------------

/// A JSON RPC handler for context methods that return a [List] of basic data types (e.g. [int],
/// [String]).
abstract class JsonRpcListTypeContextMethod<T>
    extends JsonRpcContextMethod<List, List<T>> {
  /// Creates a JSON RPC handler for context methods that return a [List] of basic data types (e.g.
  /// [int], [String]).
  const JsonRpcListTypeContextMethod(
    super.method, {
    super.values,
    super.config,
  });

  @override
  List<T> valueDecoder(final List value) => value.cast<T>();
}
