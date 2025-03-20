import 'package:reown_walletkit_wallet/dependencies/key_service/chain_key.dart';

abstract class IKeyService {
  Future<void> clearAll();

  /// Returns a list of all the keys.
  Future<List<ChainKey>> loadKeys();

  /// Returns a list of all the chain ids.
  List<String> getChains();

  /// Returns a list of all the keys for a given chain id.
  /// If the chain is not found, returns an empty list.
  ///  - [chain]: The chain to get the keys for.
  List<ChainKey> getKeysForChain(String value);

  /// Returns a list of all the accounts in namespace:chainId:address format.
  List<String> getAllAccounts();

  Future<void> createAddressFromSeed();

  Future<void> createRandomWallet();

  Future<String> getMnemonic();

  Future<void> restoreWalletFromSeed({required String mnemonic});
}
