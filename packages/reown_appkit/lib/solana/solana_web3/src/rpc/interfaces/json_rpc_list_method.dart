/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'json_rpc_method.dart';

/// JSON RPC List Method
/// ------------------------------------------------------------------------------------------------

/// A JSON RPC handler for methods that return a [List].
abstract class JsonRpcListMethod<S, T> extends JsonRpcMethod<List, List<T>> {
  /// Creates a JSON RPC handler for methods that return a [List].
  const JsonRpcListMethod(
    super.method, {
    super.values,
    super.config,
  });

  @override
  List<T> decoder(final List value) =>
      value.cast<S>().map(itemDecoder).toList(growable: false);

  /// Decodes an item in the JSON RPC List response.
  T itemDecoder(final S item);
}
