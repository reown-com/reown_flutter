/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:json_annotation/json_annotation.dart'
    show JsonKey, JsonSerializable;
import 'package:reown_appkit/solana/solana_common/models.dart'
    show Serializable;

part 'request.g.dart';

/// JSON RPC Request
/// ------------------------------------------------------------------------------------------------

/// A JSON RPC Request.
@JsonSerializable()
class JsonRpcRequest extends Serializable {
  /// Creates a JSON RPC request to invoke [method] with [params].
  ///
  /// ```
  /// {
  ///   'jsonrpc': '2.0',
  ///   'method': [method],
  ///   'params': [params],
  ///   'id': [id],
  /// }
  /// ```
  const JsonRpcRequest({
    this.jsonrpc = version,
    required this.method,
    this.params,
    this.id,
  }) : assert(params == null || params is List || params is Map),
       assert(id == null || id >= 0),
       assert(jsonrpc == version);

  /// The JSON RPC protocol version.
  @JsonKey(defaultValue: version)
  final String jsonrpc;

  /// The method to be invoked.
  final String method;

  /// A JSON object ([List] or [Map]) of ordered parameter values.
  final Object? params;

  /// A unique client-generated identifier.
  final int? id;

  /// The JSON RPC version.
  static const String version = '2.0';

  /// The [params] configuration object's commitment key.
  static const String commitmentKey = 'commitment';

  // /// Generates a hash that uniquely identifies this request's method invocation.
  // ///
  // /// The [hash] is derived by JSON encoding the request's [method] and [params]. Two
  // /// [JsonRpcRequest]s will produce the same hash if they contain the same [method] and `ordered`
  // /// [params].
  // ///
  // /// ```
  // /// final p0 = ['Gr54...5Fd5', { 'encoding': 'base64', 'commitment': 'finalized' }];
  // /// final r0 = JsonRpcRequest(Method.getAccountInfo, params: p0, id: 0);
  // ///
  // /// final p1 = ['Gr54...5Fd5', { 'encoding': 'base64', 'commitment': 'finalized' }];
  // /// final r1 = JsonRpcRequest(Method.getAccountInfo, params: p1, id: 1);
  // ///
  // /// final p2 = ['Gr54...5Fd5', { 'commitment': 'finalized', 'encoding': 'base64' }];
  // /// final r2 = JsonRpcRequest(Method.getAccountInfo, params: p2, id: 1);
  // ///
  // /// assert(r0.hash() == r1.hash()); // true
  // /// assert(r1.hash() == r2.hash()); // false, the configuration values are ordered differently.
  // ///
  // /// TODO: Sort by keys, then hash.
  // /// ```
  // String hash() => json.encode([method, params]);

  /// {@macro solana_common.Serializable.fromJson}
  factory JsonRpcRequest.fromJson(final Map<String, dynamic> json) =>
      _$JsonRpcRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$JsonRpcRequestToJson(this);
}
