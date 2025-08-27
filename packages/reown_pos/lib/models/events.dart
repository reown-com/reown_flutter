import 'package:event/event.dart';

abstract class PosEvent extends EventArgs {}

abstract class ErrorEvent extends PosEvent {}

class QrReadyEvent extends PosEvent {
  final Uri uri;
  QrReadyEvent(this.uri);

  @override
  String toString() => 'QrReadyEvent(uri: $uri)';
}

class ConnectedEvent extends PosEvent {}

class ConnectRejectedEvent extends ErrorEvent {}

class ConnectFailedEvent extends ErrorEvent {
  final String error;
  ConnectFailedEvent(this.error);

  @override
  String toString() => 'ConnectFailedEvent(error: $error)';
}

class PaymentRequestedEvent extends PosEvent {}

class PaymentBroadcastedEvent extends PosEvent {}

class PaymentRejectedEvent extends ErrorEvent {}

class PaymentSuccessfulEvent extends PosEvent {
  final String txHash;
  final String receipt;
  PaymentSuccessfulEvent(this.txHash, this.receipt);

  @override
  String toString() =>
      'PaymentSuccessfulEvent(txHash: $txHash, receipt: $receipt)';
}

class PaymentFailedEvent extends ErrorEvent {
  final String message;
  PaymentFailedEvent(this.message);

  @override
  String toString() => 'PaymentFailedEvent(message: $message)';
}

class DisconnectedEvent extends PosEvent {}

// class ErrorEvent extends PosEvent {
//   final String error;
//   ErrorEvent(this.error);

//   @override
//   String toString() => 'ErrorEvent(error: $error)';
// }
