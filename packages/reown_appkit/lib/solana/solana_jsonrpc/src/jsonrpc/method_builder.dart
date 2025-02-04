/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'commitment.dart';
import 'request.dart';
import 'method.dart';
import 'response.dart';

/// JSON RPC Method Builder
/// ------------------------------------------------------------------------------------------------

/// A JSON RPC method handler for batch requests.
///
/// A batch request contains multiple JSON RPC requests and returns a response for each request.
///
/// Use [add] to append a method to the [request].
///
/// For methods with different response types use `JsonRpcMethodBuilder<dynamic, dynamic>`.
///
/// ## Example
/// ```
/// class GetBlockHeight extends JsonRpcMethod<int, int> {
///   GetBlockHeight(): super('getBlockHeight');
///   @override int decoder(final int value) => value;
/// }
///
/// class GetBalance extends JsonRpcContextMethod<int, int> {
///   GetBalance(final String pubkey): super('getBalance', values: [pubkey]);
///   @override int valueDecoder(final int value) => value;
/// }
///
/// final client = JsonRpcHttpClient(Cluster.devnet.uri);
/// final method = JsonRpcMethodBuilder<dynamic, dynamic>([
///   GetBlockHeight(),
///   GetBalance('83astBRguLMdt2h5U1Tpdq5tjFoJ6noeGwaY3mDLVcri')
/// ]);
/// final response = await client.sendAll(method.request(), method.response);
/// print(jsonEncode(response));  // [
///                               //    {"jsonrpc":"2.0","result":1,"id":1},
///                               //    {"jsonrpc":"2.0","result":{"context":{"slot":1},"value":0},"id":1}
///                               //  ]
/// ```
class JsonRpcMethodBuilder<S, T> {
  /// An additive method builder.
  JsonRpcMethodBuilder([final List<JsonRpcMethod<S, T>>? methods])
      : _methods = methods ?? [];

  /// The JSON RPC methods.
  final List<JsonRpcMethod<S, T>> _methods;

  /// Returns the number of methods in the request.
  int get length => _methods.length;

  /// Adds a method handler.
  void add(final JsonRpcMethod<S, T> method) => _methods.add(method);

  /// Creates a batch [JsonRpcRequest] to invoke multiple methods in a single request. The
  /// [commitment] level is applied as the default value to all methods that query bank state.
  List<JsonRpcRequest> request([
    final Commitment? commitment,
  ]) =>
      [
        for (final JsonRpcMethod<S, T> method in _methods)
          method.request(commitment)
      ];

  /// Parses the [json] RPC response and returns the batch result.
  List<JsonRpcResponse<T>> response(
    final List<Map<String, dynamic>> json,
  ) {
    assert(json.length == _methods.length);
    return [
      for (int i = 0; i < json.length; ++i) _methods[i].response(json[i])
    ];
  }
}
