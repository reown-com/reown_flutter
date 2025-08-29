import 'package:event/event.dart';
import 'package:reown_pos/models/events.dart';
import 'package:reown_pos/models/pos_models.dart';
import 'package:reown_sign/i_sign_engine.dart';

abstract class IReownPos {
  abstract IReownSign? reOwnSign;
  abstract final Event<PosEvent> onPosEvent;

  abstract final List<PosToken> configuredTokens;

  Future<void> init();

  void setTokens({required List<PosToken> tokens});

  Future<void> createPaymentIntent({
    required List<PaymentIntent> paymentIntents,
  });

  Future<void> dispose();
}
