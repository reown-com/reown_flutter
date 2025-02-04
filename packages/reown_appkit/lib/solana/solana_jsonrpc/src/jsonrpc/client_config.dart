/// JSON RPC Client Config
/// ------------------------------------------------------------------------------------------------
library;

/// A JSON RPC client request configurations.
class JsonRpcClientConfig {
  /// Creates a JSON RPC client request configurations.
  const JsonRpcClientConfig({
    this.timeLimit,
    this.headers,
  });

  /// The request's timeout duration.
  final Duration? timeLimit;

  /// The request's additional HTTP headers.
  final Map<String, String>? headers;
}
