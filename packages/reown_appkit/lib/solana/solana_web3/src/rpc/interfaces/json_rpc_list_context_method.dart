/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'json_rpc_context_method.dart';

/// JSON RPC List Context Method
/// ------------------------------------------------------------------------------------------------

/// A JSON RPC handler for context methods that return a [List].
abstract class JsonRpcListContextMethod<S, T>
    extends JsonRpcContextMethod<List, List<T>> {
  /// Creates a JSON RPC handler for context methods that return a [List].
  const JsonRpcListContextMethod(super.method, {super.values, super.config});

  @override
  List<T> valueDecoder(final List value) =>
      value.cast<S>().map(itemDecoder).toList(growable: false);

  /// Decodes an item in the JSON RPC List response.
  T itemDecoder(final S item);
}
