import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos_client/models/pos_models.dart';
import 'package:example/providers/multi_wallet_address_provider.dart';

/// PaymentIntent state provider
final paymentInfoProvider =
    StateNotifierProvider<PaymentInfoNotifier, PaymentIntent>(
      (ref) => PaymentInfoNotifier(ref),
    );

class PaymentInfoNotifier extends StateNotifier<PaymentIntent> {
  final Ref _ref;

  // initial state
  static const _initialPaymentIntent = PaymentIntent(
    token: PosToken(
      network: PosNetwork(name: '', chainId: ''),
      symbol: '',
      standard: '',
      address: '',
    ),
    amount: '',
    recipient: '',
  );

  PaymentInfoNotifier(this._ref) : super(_initialPaymentIntent);

  void update({
    PosToken? token,
    String? amount,
    PosNetwork? network,
    String? recipient,
  }) {
    // If token is being updated, automatically set the appropriate recipient address
    String? newRecipient = recipient;
    if (token != null && recipient == null) {
      final multiWalletAddresses = _ref.read(multiWalletAddressProvider);
      newRecipient = multiWalletAddresses.getRecipientForChain(token.network);
    }

    state = state.copyWith(
      token: token ?? state.token,
      amount: amount ?? state.amount,
      recipient: newRecipient ?? state.recipient,
    );
  }

  void clear() => state = _initialPaymentIntent;
}
