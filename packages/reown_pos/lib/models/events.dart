import 'package:event/event.dart';
import 'package:reown_pos/utils/errors.dart';

abstract class PosEvent extends EventArgs {}

abstract class PosErrorEvent extends PosEvent {}

// connection events

///
/// ℹ️
/// Pairing URI is created, QR is ready to be displayed
///
class QrReadyEvent extends PosEvent {
  final Uri uri;
  QrReadyEvent(this.uri);
}

class ConnectedEvent extends PosEvent {}

class ConnectRejectedEvent extends PosErrorEvent {}

class ConnectFailedEvent extends PosErrorEvent {
  final String message;
  ConnectFailedEvent(this.message);
}

// payment request events
class PaymentRequestedEvent extends PosEvent {}

class PaymentRequestRejectedEvent extends PosErrorEvent {}

class PaymentRequestFailedEvent extends PosErrorEvent {
  final String message;
  final PosApiError apiError;
  final String shortMessage;
  PaymentRequestFailedEvent(
    this.message, [
    this.apiError = PosApiError.unknown,
    this.shortMessage = '',
  ]);
}

// payments checking events
class PaymentBroadcastedEvent extends PosEvent {}

class PaymentSuccessfulEvent extends PosEvent {
  final String txHash;
  PaymentSuccessfulEvent(this.txHash);
}

class PaymentFailedEvent extends PosErrorEvent {
  final String message;
  final PosApiError apiError;
  final String shortMessage;
  PaymentFailedEvent(
    this.message, [
    this.apiError = PosApiError.unknown,
    this.shortMessage = '',
  ]);
}

class DisconnectedEvent extends PosEvent {}
