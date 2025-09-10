import 'package:event/event.dart';
import 'package:reown_pos/models/events.dart';
import 'package:reown_pos/models/pos_models.dart';
import 'package:reown_sign/i_sign_engine.dart';

abstract class IReownPos {
  abstract IReownSign? reOwnSign;
  abstract final Event<PosEvent> onPosEvent;

  abstract final List<PosToken> configuredTokens;

  ///
  /// ℹ️
  /// init the SDK
  ///
  Future<void> init();

  ///
  /// ℹ️
  /// configure available tokens on your POS app
  ///
  void setTokens({required List<PosToken> tokens});

  ///
  /// ℹ️
  /// Initiates the payment flow. Best practice is to wrap it with try/catch
  ///
  Future<void> createPaymentIntent({
    required List<PaymentIntent> paymentIntents,
  });

  ///
  /// ℹ️
  /// To be called when you want to abort an ongoing intent or restart the flow when a payment finished.
  /// With reinit = true will clear the instance meaning that init() and setTokens() will have to be called again
  ///
  Future<void> restart({bool reinit = false});
}
