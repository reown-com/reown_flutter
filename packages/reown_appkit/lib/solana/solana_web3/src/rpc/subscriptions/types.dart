/// Types
/// ------------------------------------------------------------------------------------------------
library;

/// A notification data decoder.
typedef JsonRpcNotificationDecoder<T> = T Function(Map<String, dynamic> result);

/// The websocket data handler.
typedef WebsocketOnDataHandler<T> = void Function(T data);

/// The websocket error handler.
typedef WebsocketOnErrorHandler = void Function(Object error,
    [StackTrace? stackTrace]);

/// The websocket done handler.
typedef WebsocketOnDoneHandler = void Function();
