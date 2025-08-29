import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reown_pos/models/pos_models.dart';

/// PaymentIntent state provider
final paymentInfoProvider =
    StateNotifierProvider<PaymentInfoNotifier, PaymentIntent>(
      (ref) => PaymentInfoNotifier(),
    );

class PaymentInfoNotifier extends StateNotifier<PaymentIntent> {
  // initial state
  static const _initialPaymentIntent = PaymentIntent(
    token: PosToken(
      network: PosNetwork(name: '', chainId: ''),
      symbol: '',
      standard: '',
      address: '',
    ),
    amount: '',
    network: PosNetwork(name: '', chainId: ''),
    // Currently only EVM supported so we can hardcode it here
    // when non-EVM chains are available developer will have to write logic to pass the proper address based on the network
    recipient: '0xD6d146ec0FA91C790737cFB4EE3D7e965a51c340',
  );

  PaymentInfoNotifier() : super(_initialPaymentIntent);

  void update({
    PosToken? token,
    String? amount,
    PosNetwork? network,
    String? recipient,
  }) => state = state.copyWith(
    token: token ?? state.token,
    amount: amount ?? state.amount,
    network: network ?? state.network,
    recipient: recipient ?? state.recipient,
  );

  void clear() => state = _initialPaymentIntent;
}
