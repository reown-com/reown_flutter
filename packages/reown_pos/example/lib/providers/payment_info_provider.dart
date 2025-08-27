import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reown_pos/models/pos_models.dart';

/// PaymentIntent state provider
final paymentInfoProvider =
    StateNotifierProvider<PaymentInfoNotifier, PaymentIntent>(
      (ref) => PaymentInfoNotifier(),
    );

class PaymentInfoNotifier extends StateNotifier<PaymentIntent> {
  PaymentInfoNotifier()
    : super(
        PaymentIntent(
          token: '',
          amount: '',
          chainId: '',
          recipient: '0xD6d146ec0FA91C790737cFB4EE3D7e965a51c340',
        ),
      );

  void update({
    String? token,
    String? amount,
    String? chainId,
    String? recipient,
  }) {
    state = state.copyWith(
      token: token ?? state.token,
      amount: amount ?? state.amount,
      chainId: chainId ?? state.chainId,
      recipient: recipient ?? state.recipient,
    );
  }

  void clear() {
    state = PaymentIntent(
      token: '',
      amount: '',
      chainId: '',
      recipient: '0xD6d146ec0FA91C790737cFB4EE3D7e965a51c340',
    );
  }
}
