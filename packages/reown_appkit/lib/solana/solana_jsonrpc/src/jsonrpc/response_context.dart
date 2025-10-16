/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/models.dart';

import 'client.dart';
import 'context.dart';

/// JSON RPC Response Context
/// ------------------------------------------------------------------------------------------------

/// A JSON RPC Response-Context result.
class JsonRpcResponseContext<T> extends Serializable {
  /// Creates a JSON RPC response-context result.
  const JsonRpcResponseContext({required this.context, required this.value});

  /// The slot at which the operation was evaluated.
  final JsonRpcContext context;

  /// The response value.
  final T? value;

  /// The `context` property key.
  static const String contextKey = 'context';

  /// The `value` property key.
  static const String valueKey = 'value';

  /// Decodes a response context.
  static JsonRpcResponseContext<T> decode<S, T>(
    final Map<String, dynamic> response,
    final JsonRpcResponseDecoder<S, T> decoder,
  ) {
    return JsonRpcResponseContext<T>(
      context: JsonRpcContext.fromJson(response[contextKey]),
      value: decoder(response[valueKey]),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    'context': context.toJson(),
    'value': value,
  };
}
