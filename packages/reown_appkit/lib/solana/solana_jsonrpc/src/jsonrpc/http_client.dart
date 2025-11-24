/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:http/http.dart' as http;
import '../converters/json_to_bytes_codec.dart';
import '../models/health_status.dart';
import 'client.dart';
import 'client_config.dart';

/// JSON RPC HTTP Client
/// ------------------------------------------------------------------------------------------------

/// A JSON RPC Client for HTTP methods.
class JsonRpcHttpClient extends Client<List<int>> {
  /// Creates a JSON RPC Client for HTTP methods.
  JsonRpcHttpClient(
    super.uri, {
    super.timeLimit,
    this.headers,
    super.encoder = const JsonToBytesEncoder(),
    super.decoder = const JsonToBytesDecoder(),
  });

  /// HTTP client (persistent connection).
  final http.Client _client = http.Client();

  /// The default request headers applied to all methods. Headers can be provided per request using
  /// the [send] or [sendAll] method's [JsonRpcClientConfig] paramter.
  ///
  /// The `Content-Type: application/json` header is applied to all requests by default.
  final Map<String, String>? headers;

  @override
  void dispose() => _client.close();

  /// Creates the HTTP headers for a request.
  Map<String, String> _headers(final Map<String, String>? headers) =>
      (headers ?? this.headers ?? {})
        ..addAll({'Content-Type': 'application/json'});

  /// Returns the health status of an RPC node.
  Future<HealthStatus> health() async {
    final http.Response response = await _client.get(
      uri.replace(path: 'health'),
    );
    return HealthStatus.fromJson(response.body);
  }

  @override
  Future<T> handler<T>(
    final List<int> encoded, {
    final JsonRpcClientConfig? config,
    final int? id,
  }) async {
    final Future<http.Response> request = _client.post(
      uri,
      body: encoded,
      headers: _headers(config?.headers),
    );
    final http.Response response = await timeout(request, config?.timeLimit);
    return decoder.convert(response.bodyBytes) as T;
  }
}
