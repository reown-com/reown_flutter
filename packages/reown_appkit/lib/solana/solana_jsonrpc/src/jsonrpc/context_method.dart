/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'method.dart';
import 'response_context.dart';

/// JSON RPC Context Method Decoder
/// ------------------------------------------------------------------------------------------------

/// An interface for [JsonRpcMethod]s that return a `response-context`.
///
/// The [valueDecoder] defines how the `value` property of a successful JSON RPC response-context is
/// mapped from [S] to [T].
///
/// ## Example
/// ```
/// class GetBalance extends JsonRpcContextMethod<int, int> {
///   GetBalance(this.pubkey): super('getBalance');
///   final String pubkey; // base-58 address.
///   @override int valueDecoder(final int value) => value;
///   @override Object? params([final Commitment? commitment]) => [pubkey];
/// }
///
/// final client = JsonRpcHttpClient(Cluster.devnet.uri);
/// final method = GetBalance('83astBRguLMdt2h5U1Tpdq5tjFoJ6noeGwaY3mDLVcri');
/// final response = await client.send(method.request(), method.response);
/// print(jsonEncode(response)); // {"jsonrpc":"2.0","result":{"context":{"slot":1},"value":0},"id":1}
/// ```
abstract class JsonRpcContextMethod<S, T>
    extends JsonRpcMethod<Map<String, dynamic>, JsonRpcResponseContext<T>> {
  /// Creates a JSON RPC response-context decoder.
  const JsonRpcContextMethod(super.method);

  /// Decodes the `value` property of a successful JSON RPC response-context.
  ///
  /// ```
  /// final response = {"jsonrpc":"2.0", "result":{"context": {"slot": 1}, "value": 0}, "id":1}
  /// decoder(response["result"]["value"])
  /// ```
  T valueDecoder(final S value);

  @override
  JsonRpcResponseContext<T> decoder(final Map<String, dynamic> value) =>
      JsonRpcResponseContext.decode(value, valueDecoder);
}
