import 'package:event/event.dart';
import 'package:pos_client/utils/errors.dart';

abstract class PosEvent extends EventArgs {}

abstract class PosErrorEvent extends PosEvent {}

class InitializedEvent extends PosEvent {}

// connection events

///
/// ℹ️
/// Pairing URI is created, QR is ready to be displayed
///
class QrReadyEvent extends PosEvent {
  final Uri uri;
  QrReadyEvent(this.uri);
}

///
/// ℹ️
/// Wallet is connected
///
class ConnectedEvent extends PosEvent {}

class ConnectRejectedEvent extends PosErrorEvent {}

class ConnectFailedEvent extends PosErrorEvent {
  final String message;
  ConnectFailedEvent(this.message);
}

// payment request events

///
/// ℹ️
/// Payment was sent to wallet
///
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

///
/// ℹ️
/// Payment was sent to blockchain
///
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

///
/// ℹ️
/// Wallet/POS session got disconnected
///
class DisconnectedEvent extends PosEvent {}
