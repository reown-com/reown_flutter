import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/models/chain_metadata.dart';

typedef ISS = String;
typedef AuthMessage = String;
typedef AuthRequest = SessionAuthPayload;

abstract class IWalletKitService extends Disposable {
  abstract final ValueNotifier<ChainMetadata?> currentSelectedChain;
  ReownWalletKit get walletKit;
  IPairingStore? get pairings;

  Future<void> create();
  Future<void> setUpAccounts();
  Future<List<String>> getWalletAccounts([String namespace = '']);
  Future<void> init();
  Future<dynamic> pair(String uri);

  T getChainService<T extends Object>({required String chainId});

  // (iss, message, request)
  List<(ISS, AuthMessage, AuthRequest)> prepareAuthenticationMessages(
    List<SessionAuthPayload>? authenticationRequests,
    Map<String, Namespace>? generatedNamespaces,
  );

  Future<PaymentOptionsResponse> getPaymentOptions(
    GetPaymentOptionsRequest request,
  );
  Future<List<Action>> getRequiredPaymentActions(
    String optionId,
    String paymentId,
  );
  Future<ConfirmPaymentResponse> confirmPayment(ConfirmPaymentRequest payment);
}
