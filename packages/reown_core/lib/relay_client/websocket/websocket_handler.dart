import 'dart:async';

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

  @override
  Future<void> get ready => _socket!.ready;

  // const WebSocketHandler();

  @override
  Future<void> setup({
    required String url,
  }) async {
    _url = url;

    await close();
  }

  @override
  Future<void> connect() async {
    // print('connecting');
    try {
      _socket = WebSocketChannel.connect(
        Uri.parse(
          '$url&useOnCloseEvent=true',
        ),
      );
    } catch (e) {
      throw ReownCoreError(
        code: -1,
        message: 'No internet connection: ${e.toString()}',
      );
    }

    _channel = StreamChannel(
      _socket!.stream.asBroadcastStream().cast(),
      StreamController.broadcast(sync: true)..stream.cast().pipe(_socket!.sink),
    );
    if (_channel == null) {
      // print('Socket channel is null, waiting...');
      await Future.delayed(const Duration(milliseconds: 500));
      if (_channel == null) {
        // print('Socket channel is still null, throwing ');
        throw Exception('Socket channel is null');
      }
    }

    await _socket!.ready;

    // Check if the request was successful (status code 200)
    // try {} catch (e) {
    //   throw ReownCoreError(
    //     code: 400,
    //     message: 'WebSocket connection failed, missing or invalid project id.',
    //   );
    // }
  }

  @override
  Future<void> close() async {
    try {
      if (_socket != null) {
        await _socket?.sink.close();
      }
    } catch (_) {}
    _socket = null;
  }

  @override
  String toString() {
    return 'WebSocketHandler{url: $url, _socket: $_socket, _channel: $_channel}';
  }
}
