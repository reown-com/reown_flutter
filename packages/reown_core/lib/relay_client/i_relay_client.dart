import 'package:event/event.dart';
import 'package:reown_core/relay_client/relay_client_models.dart';

class PublishOptions {
  final Relay? relay;
  final int? ttl;
  final bool? prompt;
  final int? tag;

  PublishOptions(this.relay, this.ttl, this.prompt, this.tag);
}

abstract class IRelayClient {
  /// Relay Client Events
  abstract final Event onRelayClientConnect;
  abstract final Event onRelayClientDisconnect;
  abstract final Event<ErrorEvent> onRelayClientError;
  abstract final Event<MessageEvent> onRelayClientMessage;

  /// LinkMode Events
  abstract final Event<MessageEvent> onLinkModeMessage;

  /// JSON RPC Events
  // Event<EventArgs> onJsonRpcPayload();
  // Event<EventArgs> onJsonRpcConnect();
  // Event<EventArgs> onJsonRpcDisconnect();
  // Event<ErrorEvent> onJsonRpcError();

  /// Subscriber Events
  abstract final Event<SubscriptionEvent> onSubscriptionCreated;
  abstract final Event<SubscriptionDeletionEvent> onSubscriptionDeleted;
  // Event<EventArgs> onSubscriptionExpired();
  // Event<EventArgs> onSubscriptionDisabled();
  abstract final Event onSubscriptionSync;
  abstract final Event onSubscriptionResubscribed;

  /// Returns true if the client is connected to a relay server
  bool get isConnected;

  Future<void> init();

  Future<void> publish({
    required String topic,
    required String message,
    required int ttl,
    required int tag,
    int? correlationId,
    Map<String, dynamic>? tvf,
  });

  Future<String> subscribe({
    required String topic,
    required TransportType transportType,
  });

  Future<void> unsubscribe({required String topic});

  Future<void> connect({String? relayUrl});

  Future<bool> handleLinkModeMessage(String topic, String message);

  Future<void> disconnect();
}
