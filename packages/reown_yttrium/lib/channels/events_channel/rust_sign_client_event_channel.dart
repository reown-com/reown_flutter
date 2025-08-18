// import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:reown_yttrium/clients/models/rust_sign_client.dart';
import 'package:reown_yttrium/utils/channel_utils.dart';

class EventChannelSign {
  final _eventChannel = const EventChannel('reown_yttrium/session_requests');

  late final Function(SessionRequestNativeEvent data) onEvent;

  void init() {
    // TODO implement
    // debugPrint('☢️ [$runtimeType] init');
    // _eventChannel.receiveBroadcastStream().listen(_onEvent);
  }

  void _onEvent(dynamic event) {
    try {
      final result = ChannelUtils.handlePlatformResult(event);
      onEvent.call(
        SessionRequestNativeEvent.fromJson(
          result,
        ),
      );
    } catch (e, s) {
      debugPrint('☢️ [$runtimeType] _onEvent error: $e, $s');
    }
  }
}
