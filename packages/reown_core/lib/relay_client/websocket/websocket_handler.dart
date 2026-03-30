import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:reown_core/models/basic_models.dart';
import 'package:reown_core/relay_client/websocket/i_websocket_handler.dart';
import 'package:stream_channel/stream_channel.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketHandler implements IWebSocketHandler {
  String? _url;
  @override
  String? get url => _url;

  WebSocketChannel? _socket;

  @override
  int? get closeCode => _socket?.closeCode;
  @override
  String? get closeReason => _socket?.closeReason;

  StreamChannel<String>? _channel;
  @override
  StreamChannel<String>? get channel => _channel;

  StreamController<String>? _inputController;
  StreamController<String>? _outputController;
  StreamSubscription<String>? _inputSubscription;
  StreamSubscription<String>? _outputSubscription;

  @override
  Future<void> setup({required String url}) async {
    _url = url;

    await close();
  }

  @override
  Future<void> connect() async {
    // print('connecting');
    try {
      _socket = WebSocketChannel.connect(
        Uri.parse('$url&useOnCloseEvent=true'),
      );
    } catch (e) {
      throw ReownCoreError(
        code: -1,
        message: 'No internet connection: ${e.toString()}',
      );
    }

    // Create a multi-subscription capable stream channel using stream splitting
    // This approach enables multiple listeners without broadcast streams
    _inputController = StreamController<String>.broadcast(sync: true);
    _outputController = StreamController<String>.broadcast(sync: true);

    // Split the incoming stream to support multiple listeners
    _inputSubscription = _socket!.stream.cast<String>().listen(
      (data) => _inputController?.add(data),
      onError: (error) {
        try {
          _inputController?.addError(error);
        } catch (e) {
          debugPrint('[WebSocketHandler] inputController.addError failed: $e');
        }
      },
      onDone: () {
        try {
          _inputController?.close();
        } catch (e) {
          debugPrint('[WebSocketHandler] inputController.close failed: $e');
        }
      },
    );

    // Route outgoing messages through the output controller
    _outputSubscription = _outputController!.stream.listen(
      (data) {
        try {
          _socket?.sink.add(data);
        } catch (e) {
          debugPrint('[WebSocketHandler] sink.add failed: $e');
        }
      },
      onError: (error) {
        try {
          _socket?.sink.addError(error);
        } catch (e) {
          debugPrint('[WebSocketHandler] sink.addError failed: $e');
        }
      },
      onDone: () {
        try {
          _socket?.sink.close();
        } catch (e) {
          debugPrint('[WebSocketHandler] sink.close failed: $e');
        }
      },
    );

    _channel = StreamChannel(_inputController!.stream, _outputController!.sink);

    if (_channel == null) {
      // print('Socket channel is null, waiting...');
      await Future.delayed(const Duration(milliseconds: 500));
      if (_channel == null) {
        // print('Socket channel is still null, throwing ');
        throw Exception('Socket channel is null');
      }
    }

    try {
      await _socket?.ready;
    } catch (e) {
      await close();
      throw ReownCoreError(
        code: -1,
        message: 'WebSocket connection failed: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> close() async {
    // Cancel subscriptions first to prevent writes to closed sinks
    try {
      await _inputSubscription?.cancel();
    } catch (e) {
      debugPrint('[WebSocketHandler] inputSubscription.cancel failed: $e');
    }
    try {
      await _outputSubscription?.cancel();
    } catch (e) {
      debugPrint('[WebSocketHandler] outputSubscription.cancel failed: $e');
    }
    _inputSubscription = null;
    _outputSubscription = null;

    try {
      await _socket?.sink.close();
    } catch (e) {
      debugPrint('[WebSocketHandler] socket.sink.close failed: $e');
    }

    // Close the controllers to prevent further messages and race conditions
    try {
      await _inputController?.close();
    } catch (e) {
      debugPrint('[WebSocketHandler] inputController.close failed: $e');
    }
    try {
      await _outputController?.close();
    } catch (e) {
      debugPrint('[WebSocketHandler] outputController.close failed: $e');
    }

    _inputController = null;
    _outputController = null;
    _channel = null;
    _socket = null;
  }

  @override
  String toString() {
    return 'WebSocketHandler{url: $url, _socket: $_socket, _channel: $_channel}';
  }
}
