import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/models/chain_metadata.dart';

typedef ISS = String;
typedef AuthMessage = String;
typedef AuthRequest = SessionAuthPayload;

abstract class IWalletKitService extends Disposable {
  Future<void> create();
  Future<void> setUpAccounts();
  Future<void> init();
  T getChainService<T extends Object>({required String chainId});

  // (iss, message, request)
  Future<List<(ISS, AuthMessage, AuthRequest)>> prepareAuthenticationMessages(
    List<SessionAuthPayload>? authenticationRequests,
    Map<String, Namespace>? generatedNamespaces,
  );

  abstract final ValueNotifier<ChainMetadata?> currentSelectedChain;
  ReownWalletKit get walletKit;
}
