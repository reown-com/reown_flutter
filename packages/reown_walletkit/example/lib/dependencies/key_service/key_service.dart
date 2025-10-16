import 'dart:convert';
import 'dart:developer' as dev;

import 'package:bech32/bech32.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:eth_sig_util/util/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pointycastle/digests/ripemd160.dart';
import 'package:pointycastle/digests/keccak.dart';
import 'package:pointycastle/ecc/curves/secp256k1.dart';
import 'package:polkadart_keyring/polkadart_keyring.dart' as keyring;
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/dependencies/bip32/bip32_base.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/stacks/stacks_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/sui/sui_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/ton/ton_service.dart';
import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/chain_key.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/i_key_service.dart';
import 'package:reown_walletkit_wallet/models/chain_data.dart';
import 'package:reown_walletkit_wallet/dependencies/bip39/bip39_base.dart'
    as bip39;
import 'package:reown_walletkit_wallet/dependencies/bip32/bip32_base.dart'
    as bip32;
import 'package:reown_yttrium/reown_yttrium.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solana/solana.dart' as solana;
import 'package:bitcoin_base/bitcoin_base.dart' as bitcoin;
// ignore: depend_on_referenced_packages
import 'package:ed25519_hd_key/ed25519_hd_key.dart' as ed25519_hd_key;

class KeyService extends IKeyService {
  List<ChainKey> _keys = [];
  late final SharedPreferences _prefs;

  @override
  List<ChainKey> get keys => _keys;

  @override
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<void> clearAll() async {
    final keys = _prefs.getKeys();
    for (var key in keys) {
      if (key.startsWith('rwkt_')) {
        await _prefs.remove(key);
      }
    }
  }

  Future<(bool, int)> _isUpdated() async {
    final prevBuildNumber = _prefs.getString('rwkt_build_number') ?? '0';
    final packageInfo = await PackageInfo.fromPlatform();
    final currBuildNumber = packageInfo.buildNumber.toString();

    return (
      int.parse(currBuildNumber) > int.parse(prevBuildNumber),
      int.parse(currBuildNumber),
    );
  }

  @override
  Future<List<ChainKey>> loadKeys() async {
    // ⚠️ WARNING: SharedPreferences is not the best way to store your keys! This is just for example purposes!
    try {
      final isUpdated = await _isUpdated();
      if (isUpdated.$1) {
        // regenerate the wallet after an update
        await restoreWallet(mnemonicOrPrivate: getMnemonic());
        await _prefs.setString('rwkt_build_number', isUpdated.$2.toString());
      }
      final savedKeys = _prefs.getStringList('rwkt_chain_keys')!;
      final chainKeys = savedKeys.map((e) => ChainKey.fromJson(jsonDecode(e)));
      _keys = List<ChainKey>.from(chainKeys.toList());
      //
    } catch (_) {}

    dev.log('[$runtimeType] _keys ${_keys.map((k) => k.toString()).toList()}');
    return _keys;
  }

  @override
  List<String> getChains() {
    final List<String> chainIds = [];
    for (final ChainKey key in _keys) {
      chainIds.addAll(key.chains);
    }
    return chainIds;
  }

  @override
  List<ChainKey> getKeysForChain(String value) {
    String namespace = value;
    if (value.contains(':')) {
      namespace = NamespaceUtils.getNamespaceFromChain(value);
    }
    final keys = [
      ..._keys.where((e) => e.namespace == namespace),
      ..._keys.where((e) => e.namespace == '${namespace}_test'),
    ];
    try {
      return [keys.firstWhere((e) => e.chains.contains(value))];
    } catch (e) {
      return _keys.where((e) => e.namespace == namespace).toList();
    }
  }

  @override
  List<String> getAllAccounts() {
    final List<String> accounts = [];
    for (final ChainKey key in _keys) {
      for (final String chain in key.chains) {
        accounts.add('$chain:${key.address}');
      }
    }
    return accounts;
  }

  @override
  String getMnemonic() {
    final mnemonic = _prefs.getString('rwkt_mnemonic') ?? '';
    debugPrint('[$runtimeType] getMnemonic $mnemonic');
    return mnemonic;
  }

  // ** bip39/bip32 - EIP155 **

  @override
  Future<void> createRandomWallet() async {
    final mnemonic = bip39.generateMnemonic();
    await restoreWallet(mnemonicOrPrivate: mnemonic);
  }

  @override
  Future<void> regenerateStoredWallet() async {
    try {
      final mnemonic = getMnemonic();
      await clearAll();
      await restoreWallet(mnemonicOrPrivate: mnemonic);
    } catch (_) {}
  }

  @override
  Future<void> createAddressFromSeed() async {
    final mnemonic = getMnemonic();

    final chainKeys = getKeysForChain('eip155');
    final index = chainKeys.length;

    final keyPair = _keyPairFromMnemonic(mnemonic, index: index);
    final chainKey = _chainKeyFromPrivate(keyPair);

    _keys.add(chainKey!);

    await _saveKeys();
  }

  @override
  Future<void> restoreWallet({required String mnemonicOrPrivate}) async {
    _keys.clear();
    if (_isPrivateKey(mnemonicOrPrivate)) {
      await _restoreWalletFromPrivateKey(mnemonicOrPrivate);
    } else {
      await _restoreFromMnemonic(mnemonicOrPrivate);
    }
  }

  bool _isPrivateKey(String privateKeyHex) {
    final regex = RegExp(r'^[0-9a-fA-F]{64}$');
    return regex.hasMatch(privateKeyHex);
  }

  Future<void> _restoreWalletFromPrivateKey(privateKey) async {
    // ⚠️ WARNING: SharedPreferences is not the best way to store your keys! This is just for example purposes!
    await _prefs.remove('rwkt_chain_keys');
    await _prefs.remove('rwkt_mnemonic');
    debugPrint('[$runtimeType] _restoreWalletFromPrivateKey $privateKey');

    final ecDomain = ECCurve_secp256k1();
    final bigIntPrivateKey = BigInt.parse(privateKey, radix: 16);

    final ecPoint = ecDomain.G * bigIntPrivateKey;
    final public = ecPoint!.getEncoded(false);

    final publicKey = hex.encode(public);
    final chainKey = _chainKeyFromPrivate(CryptoKeyPair(privateKey, publicKey));

    _keys = List<ChainKey>.from([chainKey]);

    await _saveKeys();
  }

  Future<void> _restoreFromMnemonic(String mnemonic) async {
    // ⚠️ WARNING: SharedPreferences is not the best way to store your keys! This is just for example purposes!
    await _prefs.remove('rwkt_chain_keys');
    await _prefs.setString('rwkt_mnemonic', mnemonic);
    debugPrint('[$runtimeType] _restoreFromMnemonic $mnemonic');

    final eip155ChainKey = _evmChainKey(mnemonic);
    final solanaChainKey = await _solanaChainKey(mnemonic);
    final polkadotChainKey = await _polkadotChainKey(mnemonic);
    final polkadotTestChainKey = await _polkadotTestChainKey(mnemonic);
    final kadenaChainKey = _kadenaChainKey(mnemonic);
    final tronChainKey = _tronChainKey(mnemonic);
    final cosmosChainKey = _cosmosChainKey(mnemonic);
    final tonChainKey = await _tonChainKey(mnemonic);
    // final tonTestChainKey = await _tonTestChainKey(mnemonic);
    final stacksChainKey = await _stacksChainKey(mnemonic);
    final stacksTestChainKey = await _stacksTestChainKey(mnemonic);
    final suiChainKey = await _suiChainKey(mnemonic);
    // final bitcoinChainKeys = await _bitcoinChainKey(mnemonic);

    _keys = List<ChainKey>.from([
      if (eip155ChainKey != null) eip155ChainKey,
      if (solanaChainKey != null) solanaChainKey,
      if (polkadotChainKey != null) polkadotChainKey,
      if (polkadotTestChainKey != null) polkadotTestChainKey,
      if (kadenaChainKey != null) kadenaChainKey,
      if (tronChainKey != null) tronChainKey,
      if (cosmosChainKey != null) cosmosChainKey,
      if (tonChainKey != null) tonChainKey,
      if (stacksChainKey != null) stacksChainKey,
      if (stacksTestChainKey != null) stacksTestChainKey,
      if (suiChainKey != null) suiChainKey,
      // tonTestChainKey,
    ]);

    await _saveKeys();
  }

  Future<void> _saveKeys() async {
    final chainKeys = _keys.map((e) => jsonEncode(e.toJson())).toList();
    await _prefs.setStringList('rwkt_chain_keys', chainKeys);
  }

  ChainKey? _evmChainKey(String mnemonic) {
    final keyPair = _keyPairFromMnemonic(mnemonic);
    return _chainKeyFromPrivate(keyPair);
  }

  CryptoKeyPair _keyPairFromMnemonic(String mnemonic, {int index = 0}) {
    final isValidMnemonic = bip39.validateMnemonic(mnemonic);
    if (!isValidMnemonic) {
      throw 'Invalid mnemonic';
    }

    final seed = bip39.mnemonicToSeed(mnemonic);
    final root = bip32.BIP32.fromSeed(seed);

    final child = root.derivePath("m/44'/60'/0'/0/$index");
    final private = hex.encode(child.privateKey as List<int>);
    final public = hex.encode(child.publicKey);
    return CryptoKeyPair(private, public);
  }

  ChainKey? _chainKeyFromPrivate(CryptoKeyPair keyPair) {
    try {
      final private = EthPrivateKey.fromHex(keyPair.privateKey);
      final address = private.address.hex;
      final evmChainKey = ChainKey(
        chains: ChainsDataList.eip155Chains.map((e) => e.chainId).toList(),
        privateKey: keyPair.privateKey,
        publicKey: keyPair.publicKey,
        address: address,
        namespace: 'eip155',
      );
      return evmChainKey;
    } catch (e, s) {
      debugPrint('[$runtimeType] _chainKeyFromPrivate error: $e');
      debugPrint('[$runtimeType] _chainKeyFromPrivate error: $s');
      return null;
    }
  }

  Future<ChainKey?> _solanaChainKey(String mnemonic) async {
    try {
      final seed = bip39.mnemonicToSeed(mnemonic);

      final solanaKeyPair = await solana.Ed25519HDKeyPair.fromSeedWithHdPath(
        seed: seed,
        hdPath: "m/44'/501'/0'/0'",
      );
      final publicBytes = solanaKeyPair.publicKey.bytes;
      final privateBytes = (await solanaKeyPair.extract()).bytes;

      return ChainKey(
        chains: ChainsDataList.solanaChains.map((e) => e.chainId).toList(),
        privateKey:
            base58.encode(Uint8List.fromList(privateBytes + publicBytes)),
        publicKey: solanaKeyPair.publicKey.toString(),
        address: solanaKeyPair.address,
        namespace: 'solana',
      );
    } catch (e, s) {
      debugPrint('[$runtimeType] _solanaChainKey error: $e');
      debugPrint('[$runtimeType] _solanaChainKey error: $s');
      return null;
    }
  }

  Future<ChainKey?> _polkadotChainKey(String mnemonic) async {
    try {
      final dotkeyPair = await keyring.Keyring().fromMnemonic(
        mnemonic,
        keyPairType: keyring.KeyPairType.sr25519,
      );
      // adjust the default ss58Format for Polkadot https://github.com/paritytech/ss58-registry/blob/main/ss58-registry.json
      dotkeyPair.ss58Format = 0;

      final publicKey = bytesToHex(
        dotkeyPair.publicKey.bytes,
        include0x: true,
      );

      return ChainKey(
        chains: ChainsDataList.polkadotChains
            .where((c) => !c.isTestnet)
            .map((e) => e.chainId)
            .toList(),
        privateKey: mnemonic,
        publicKey: publicKey,
        address: dotkeyPair.address,
        namespace: 'polkadot',
      );
    } catch (e, s) {
      debugPrint('[$runtimeType] _polkadotChainKey error: $e');
      debugPrint('[$runtimeType] _polkadotChainKey error: $s');
      return null;
    }
  }

  Future<ChainKey?> _polkadotTestChainKey(String mnemonic) async {
    try {
      final dotkeyPair = await keyring.Keyring().fromMnemonic(mnemonic);

      final publicKey = bytesToHex(
        dotkeyPair.publicKey.bytes,
        include0x: true,
      );

      return ChainKey(
        chains: ChainsDataList.polkadotChains
            .where((c) => c.isTestnet)
            .map((e) => e.chainId)
            .toList(),
        privateKey: mnemonic,
        publicKey: publicKey,
        address: dotkeyPair.address,
        namespace: 'polkadot_test',
      );
    } catch (e, s) {
      debugPrint('[$runtimeType] _polkadotTestChainKey error: $e');
      debugPrint('[$runtimeType] _polkadotTestChainKey error: $s');
      return null;
    }
  }

  ChainKey? _kadenaChainKey(String mnemonic) {
    try {
      final seed = bip39.mnemonicToSeed(mnemonic);
      final root = bip32.BIP32.fromSeed(seed);
      // 626' is Kadena's BIP44 Coin Type
      final kadenaNode = root.derivePath("m/44'/626'/0'/0/0");

      // Step 4: Extract Private and Public Keys
      Uint8List privateKey = kadenaNode.privateKey!;
      Uint8List publicKey = kadenaNode.publicKey;

      // Step 5: Convert to String Formats
      String privateKeyHex = bytesToHex(privateKey);
      String publicKeyHex = bytesToHex(publicKey);

      return ChainKey(
        chains: ChainsDataList.kadenaChains.map((e) => e.chainId).toList(),
        privateKey: privateKeyHex,
        publicKey: publicKeyHex,
        address: publicKeyHex,
        namespace: 'kadena',
      );
    } catch (e, s) {
      debugPrint('[$runtimeType] _kadenaChainKey error: $e');
      debugPrint('[$runtimeType] _kadenaChainKey error: $s');
      return null;
    }
  }

  ChainKey? _cosmosChainKey(String mnemonic) {
    try {
      final seed = bip39.mnemonicToSeed(mnemonic);
      final root = bip32.BIP32.fromSeed(seed);
      final child = root.derivePath("m/44'/118'/0'/0/0");

      // Step 4: Extract Private and Public Keys
      Uint8List privateKey = child.privateKey!;
      Uint8List publicKey = child.publicKey;

      // 1. SHA256
      final sha256 = SHA256Digest().process(publicKey);
      // 2. RIPEMD160
      final ripemd160 = RIPEMD160Digest().process(sha256);
      // 3. Bech32 encode
      final words = _convertBits(ripemd160, 8, 5, true);
      final bech32Data = Bech32('cosmos', words);
      final address = bech32.encode(bech32Data);

      return ChainKey(
        chains: ChainsDataList.cosmosChains.map((e) => e.chainId).toList(),
        privateKey: base64.encode(privateKey),
        publicKey: base64.encode(publicKey),
        address: address,
        namespace: 'cosmos',
      );
    } catch (e, s) {
      debugPrint('[$runtimeType] _cosmosChainKey error: $e');
      debugPrint('[$runtimeType] _cosmosChainKey error: $s');
      return null;
    }
  }

  Future<ChainKey?> _tonChainKey(String mnemonic) async {
    try {
      final service = GetIt.I<IWalletKitService>();
      final chainIds = ChainsDataList.tonChains
          .where((c) => !c.isTestnet)
          .map((e) => e.chainId)
          .toList();
      final tonService = service.getChainService<TonService>(
        chainId: chainIds.first,
      );
      final keyPair = await tonService.generateKeypairFromBip39Mnemonic(
        mnemonic,
      );
      final address = await tonService.getAddressFromKeypair(
        keyPair,
      );

      return ChainKey(
        chains: chainIds,
        privateKey: keyPair.sk,
        publicKey: keyPair.pk,
        address: address.friendlyEq,
        namespace: 'ton',
      );
    } catch (e, s) {
      debugPrint('[$runtimeType] _tonChainKey error: $e');
      debugPrint('[$runtimeType] _tonChainKey error: $s');
      return null;
    }
  }

  // Future<ChainKey?> _tonTestChainKey(String mnemonic) async {
  //   try {
  //     final service = GetIt.I<IWalletKitService>();
  //     final chainIds = ChainsDataList.tonChains
  //         .where((c) => c.isTestnet)
  //         .map((e) => e.chainId)
  //         .toList();
  //     final tonService = service.getChainService<TonService>(
  //       chainId: chainIds.first,
  //     );
  //     final keyPair = await tonService.generateKeypairFromBip39Mnemonic(
  //       mnemonic,
  //     );
  //     final address = await tonService.getAddressFromKeypair(
  //       keyPair,
  //     );

  //     return ChainKey(
  //       chains: chainIds,
  //       privateKey: keyPair.sk,
  //       publicKey: keyPair.pk,
  //       address: address.friendlyEq,
  //       namespace: 'ton_test',
  //     );
  //   } catch (e, s) {
  //     debugPrint('[$runtimeType] _tonTestChainKey error: $e');
  //     debugPrint('[$runtimeType] _tonTestChainKey error: $s');
  //     return null;
  //   }
  // }

  ChainKey? _tronChainKey(String mnemonic) {
    try {
      final seed = bip39.mnemonicToSeed(mnemonic);
      final root = bip32.BIP32.fromSeed(seed);
      final tronNode = root.derivePath("m/44'/195'/0'/0/0");

      // Step 4: Extract Private and Public Keys
      Uint8List privateKey = tronNode.privateKey!;
      Uint8List publicKey = tronNode.publicKey;

      // Compute Keccak256 hash of public key (drop 0x04 byte if uncompressed)
      final keccak = KeccakDigest(256);
      final hashed = keccak.process(publicKey.sublist(1)); // remove 0x04 prefix

      // Get last 20 bytes of hash
      // Tron uses 0x41 prefix
      final addressBytes = Uint8List.fromList([0x41] + hashed.sublist(12));

      // Base58Check encode
      final address = _toTronAddress(addressBytes);

      return ChainKey(
        chains: ChainsDataList.tronChains.map((e) => e.chainId).toList(),
        privateKey: bytesToHex(privateKey, include0x: true),
        publicKey: bytesToHex(publicKey, include0x: true),
        address: address,
        namespace: 'tron',
      );
    } catch (e, s) {
      debugPrint('[$runtimeType] _tronChainKey error: $e');
      debugPrint('[$runtimeType] _tronChainKey error: $s');
      return null;
    }
  }

  // ignore: unused_element
  Future<ChainKey?> _bitcoinChainKey(String mnemonic) async {
    try {
      final mnemonic = getMnemonic();
      final seed = bip39.mnemonicToSeed(mnemonic);
      final root = bip32.BIP32.fromSeed(seed, BITCOIN);
      final bitcoinNode = root.derivePath("m/84'/0'/0'/0/0");

      final privateKeyBytes = bitcoinNode.privateKey!;
      final privateKey = bitcoin.ECPrivate.fromBytes(privateKeyBytes);
      final publicKey = privateKey.getPublic();
      final address = publicKey.toSegwitAddress().toAddress(
            bitcoin.BitcoinNetwork.mainnet,
          );

      return ChainKey(
        chains: ChainsDataList.bitcoinChains.map((e) => e.chainId).toList(),
        privateKey: privateKey.toWif(),
        publicKey: base58.encode(Uint8List.fromList(publicKey.toBytes())),
        address: address,
        namespace: 'bip122',
      );
    } catch (e, s) {
      debugPrint('[$runtimeType] _bitcoinChainKey error: $e');
      debugPrint('[$runtimeType] _bitcoinChainKey error: $s');
      return null;
    }
  }

  Future<ChainKey?> _stacksChainKey(String mnemonic) async {
    try {
      final service = GetIt.I<IWalletKitService>();
      final chainIds = ChainsDataList.stacksChains
          .where((c) => !c.isTestnet)
          .map((e) => e.chainId)
          .toList();
      final stacksService = service.getChainService<StacksService>(
        chainId: chainIds.first,
      );
      // final privateKey = await walletKit.stacksClient.generateWallet();
      final address = await stacksService.getAddress(
        wallet: mnemonic,
        version: StacksVersion.mainnet_p2pkh,
        networkId: chainIds.first,
      );

      return ChainKey(
        chains: chainIds,
        privateKey: mnemonic,
        publicKey: address,
        address: address,
        namespace: 'stacks',
      );
    } catch (e, s) {
      debugPrint('[$runtimeType] _stacksChainKey error: $e');
      debugPrint('[$runtimeType] _stacksChainKey error: $s');
      return null;
    }
  }

  Future<ChainKey?> _stacksTestChainKey(String mnemonic) async {
    try {
      final service = GetIt.I<IWalletKitService>();
      final chainIds = ChainsDataList.stacksChains
          .where((c) => c.isTestnet)
          .map((e) => e.chainId)
          .toList();
      final stacksService = service.getChainService<StacksService>(
        chainId: chainIds.first,
      );
      // final privateKey = await walletKit.stacksClient.generateWallet();
      final address = await stacksService.getAddress(
        wallet: mnemonic,
        version: StacksVersion.testnet_p2pkh,
        networkId: chainIds.first,
      );

      return ChainKey(
        chains: chainIds,
        privateKey: mnemonic,
        publicKey: address,
        address: address,
        namespace: 'stacks_test',
      );
    } catch (e, s) {
      debugPrint('[$runtimeType] _stacksTestChainKey error: $e');
      debugPrint('[$runtimeType] _stacksTestChainKey error: $s');
      return null;
    }
  }

  Future<ChainKey?> _suiChainKey(String mnemonic) async {
    try {
      final service = GetIt.I<IWalletKitService>();
      final chainIds = ChainsDataList.suiChains.map((e) => e.chainId).toList();
      final suiService = service.getChainService<SUIService>(
        chainId: chainIds.first,
      );

      final seed = bip39.mnemonicToSeed(mnemonic);
      final suiKeyPair = await ed25519_hd_key.ED25519_HD_KEY.derivePath(
        "m/44'/501'/0'/0'",
        seed,
      );

      // Prefix with Ed25519 scheme flag
      final suiPrivBytes = Uint8List(33)
        ..[0] = 0x00
        ..setRange(1, 33, suiKeyPair.key);

      // Convert to 5-bit words for bech32 encoding
      final words = _convertBits(suiPrivBytes, 8, 5, true);

      // Encode as bech32 string with prefix suiprivkey
      final bech32PrivKey = Bech32('suiprivkey', words);
      final privateKey = bech32.encode(bech32PrivKey);

      final publicKey = await suiService.getPublicKeyFromKeyPair(
        keyPair: privateKey,
        networkId: chainIds.first,
      );
      final address = await suiService.getAddressFromPublicKey(
        publicKey: publicKey,
        networkId: chainIds.first,
      );

      return ChainKey(
        chains: chainIds,
        privateKey: privateKey,
        publicKey: publicKey,
        address: address,
        namespace: 'sui',
      );
    } catch (e, s) {
      debugPrint('[$runtimeType] _suiChainKey error: $e');
      debugPrint('[$runtimeType] _suiChainKey error: $s');
      return null;
    }
  }

  List<int> _convertBits(Uint8List data, int fromBits, int toBits, bool pad) {
    int acc = 0;
    int bits = 0;
    final maxv = (1 << toBits) - 1;
    final result = <int>[];

    for (final byte in data) {
      acc = (acc << fromBits) | byte;
      bits += fromBits;
      while (bits >= toBits) {
        bits -= toBits;
        result.add((acc >> bits) & maxv);
      }
    }

    if (pad && bits > 0) {
      result.add((acc << (toBits - bits)) & maxv);
    }

    return result;
  }

  Uint8List _sha256Twice(Uint8List input) {
    final first = sha256.convert(input).bytes;
    final second = sha256.convert(first).bytes;
    return Uint8List.fromList(second);
  }

  String _toTronAddress(Uint8List addressBytesWith41Prefix) {
    final checksum = _sha256Twice(addressBytesWith41Prefix).sublist(0, 4);
    final full = Uint8List.fromList([...addressBytesWith41Prefix, ...checksum]);
    return base58.encode(full);
  }
}
