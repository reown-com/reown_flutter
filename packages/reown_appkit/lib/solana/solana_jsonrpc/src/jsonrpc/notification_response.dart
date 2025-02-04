/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
import 'package:reown_appkit/solana/solana_common/models.dart'
    show Serializable;
import 'notification.dart';
import 'request.dart';

part 'notification_response.g.dart';

/// JSON RPC Notification
/// ------------------------------------------------------------------------------------------------

/// A JSON RPC notification.
@JsonSerializable(explicitToJson: true)
class JsonRpcNotificationResponse<T> extends Serializable {
  /// Creates a JSON RPC notification.
  ///
  /// ```
  /// {
  ///   'jsonrpc': '2.0',
  ///   'method': [method],
  ///   'params': <T>,
  /// }
  /// ```
  const JsonRpcNotificationResponse({
    this.jsonrpc = JsonRpcRequest.version,
    required this.method,
    required this.params,
  });

  /// The JSON RPC protocol version.
  final String jsonrpc;

  /// The method to be invoked.
  final String method;

  /// A JSON object ([List] or [Map]) of ordered parameter values.
  final JsonRpcNotification<T> params;

  /// {@macro solana_common.Serializable.fromJson}
  factory JsonRpcNotificationResponse.fromJson(
          final Map<String, dynamic> json) =>
      _$JsonRpcNotificationResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$JsonRpcNotificationResponseToJson(this);
}
