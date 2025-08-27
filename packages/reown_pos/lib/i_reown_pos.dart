import 'package:event/event.dart';
import 'package:reown_pos/models/events.dart';
import 'package:reown_pos/models/pos_models.dart';
import 'package:reown_sign/i_sign_engine.dart';

abstract class IReownPos {
  abstract final Event<PosEvent> onPosEvent;

  Future<void> init();
  Future<void> dispose();

  void setChains({required List<String> chainIds});

  Future<void> createPaymentIntent({
    required List<PaymentIntent> paymentIntents,
  });

  abstract final IReownSign reOwnSign;
}
