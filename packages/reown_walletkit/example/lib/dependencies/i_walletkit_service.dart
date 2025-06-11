import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/models/chain_metadata.dart';

abstract class IWalletKitService extends Disposable {
  Future<void> create();
  Future<void> setUpAccounts();
  Future<void> init();

  abstract final ValueNotifier<ChainMetadata?> currentSelectedChain;
  ReownWalletKit get walletKit;
}
