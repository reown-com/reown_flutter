import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// An implementation of [ReownWalletkitPlatform] that uses event channels.
/// This class only handles event streaming and should not be used directly.
class EventChannelReownWalletkit {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final eventChannel = const EventChannel('reown_walletkit/events');

  // @override
  void init() {
    debugPrint('[$runtimeType] init');
    eventChannel.receiveBroadcastStream().listen(_onEvent);
  }

  void _onEvent(dynamic event) {
    try {
      debugPrint('[$runtimeType] _onEvent $event');
    } catch (e, s) {
      debugPrint('[$runtimeType] _onEvent error: $e, $s');
    }
  }

  /// Public getter for the event stream
  Stream<dynamic> get eventStream => eventChannel.receiveBroadcastStream();
}
