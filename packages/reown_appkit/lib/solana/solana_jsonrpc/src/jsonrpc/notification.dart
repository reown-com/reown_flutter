/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/models.dart'
    show Serializable;

/// JSON RPC Notification
/// ------------------------------------------------------------------------------------------------

/// A JSON RPC notification `params` property.
class JsonRpcNotification<T> extends Serializable {
  /// Creates a JSON RPC notification `params` object.
  const JsonRpcNotification({
    required this.result,
    required this.subscription,
  });

  /// The JSON RPC protocol version.
  final T result;

  /// A JSON object ([List] or [Map]) of ordered parameter values.
  final int subscription;

  /// {@macro solana_common.Serializable.fromJson}
  factory JsonRpcNotification.fromJson(final Map<String, dynamic> json) =>
      JsonRpcNotification(
        result: json['result'],
        subscription: json['subscription'],
      );

  @override
  Map<String, dynamic> toJson() => {
        'result': result,
        'subscription': subscription,
      };
}
