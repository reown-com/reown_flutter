import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:eth_sig_util/util/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:pointycastle/ecc/curves/secp256k1.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/chain_key.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/i_key_service.dart';
import 'package:reown_walletkit_wallet/models/chain_data.dart';
import 'package:reown_walletkit_wallet/dependencies/bip39/bip39_base.dart'
    as bip39;
import 'package:reown_walletkit_wallet/dependencies/bip32/bip32_base.dart'
    as bip32;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solana/solana.dart' as solana;

class KeyService extends IKeyService {
  List<ChainKey> _keys = [];

  @override
  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    for (var key in keys) {
      if (key.startsWith('rwkt_')) {
        await prefs.remove(key);
      }
    }
  }

  @override
  Future<List<ChainKey>> loadKeys() async {
    // ⚠️ WARNING: SharedPreferences is not the best way to store your keys! This is just for example purposes!
    final prefs = await SharedPreferences.getInstance();
    try {
      final savedKeys = prefs.getStringList('rwkt_chain_keys')!;
      final chainKeys = savedKeys.map((e) => ChainKey.fromJson(jsonDecode(e)));
      _keys = List<ChainKey>.from(chainKeys.toList());
      //
      final extraKeys = await _extraChainKeys();
      _keys.addAll(extraKeys);
    } catch (_) {}

    debugPrint('[$runtimeType] _keys $_keys');
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
    return _keys.where((e) => e.namespace == namespace).toList();
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
  Future<String> getMnemonic() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('rwkt_mnemonic') ?? '';
  }

  // ** bip39/bip32 - EIP155 **

  @override
  Future<void> createRandomWallet() async {
    final mnemonic = bip39.generateMnemonic();
    await restoreWallet(mnemonicOrPrivate: mnemonic);
  }

  @override
  Future<void> createAddressFromSeed() async {
    final prefs = await SharedPreferences.getInstance();
    final mnemonic = prefs.getString('rwkt_mnemonic')!;

    final chainKeys = getKeysForChain('eip155');
    final index = chainKeys.length;

    final keyPair = _keyPairFromMnemonic(mnemonic, index: index);
    final chainKey = _eip155ChainKey(keyPair);

    _keys.add(chainKey);

    await _saveKeys();
  }

  bool _isPrivateKey(String privateKeyHex) {
    final regex = RegExp(r'^[0-9a-fA-F]{64}$');
    return regex.hasMatch(privateKeyHex);
  }

  @override
  Future<void> restoreWallet({required String mnemonicOrPrivate}) async {
    if (_isPrivateKey(mnemonicOrPrivate)) {
      await _restoreWalletFromPrivateKey(mnemonicOrPrivate);
    } else {
      await _restoreFromMnemonic(mnemonicOrPrivate);
    }
  }

  Future<void> _restoreWalletFromPrivateKey(privateKey) async {
    // ⚠️ WARNING: SharedPreferences is not the best way to store your keys! This is just for example purposes!
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('rwkt_chain_keys');
    await prefs.remove('rwkt_mnemonic');

    final ecDomain = ECCurve_secp256k1();
    final bigIntPrivateKey = BigInt.parse(privateKey, radix: 16);

    final ecPoint = ecDomain.G * bigIntPrivateKey;
    final public = ecPoint!.getEncoded(false);

    final publicKey = hex.encode(public);
    final chainKey = _eip155ChainKey(CryptoKeyPair(privateKey, publicKey));

    _keys = List<ChainKey>.from([chainKey]);

    await _saveKeys();
  }

  Future<void> _restoreFromMnemonic(String mnemonic) async {
    // ⚠️ WARNING: SharedPreferences is not the best way to store your keys! This is just for example purposes!
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('rwkt_chain_keys');
    await prefs.setString('rwkt_mnemonic', mnemonic);

    final keyPair = _keyPairFromMnemonic(mnemonic);
    final chainKey = _eip155ChainKey(keyPair);

    _keys = List<ChainKey>.from([chainKey]);

    await _saveKeys();
  }

  Future<void> _saveKeys() async {
    final prefs = await SharedPreferences.getInstance();
    // Store only eip155 keys
    final chainKeys = _keys
        .where((k) => k.namespace == 'eip155')
        .map((e) => jsonEncode(e.toJson()))
        .toList();
    await prefs.setStringList('rwkt_chain_keys', chainKeys);
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

  ChainKey _eip155ChainKey(CryptoKeyPair keyPair) {
    final private = EthPrivateKey.fromHex(keyPair.privateKey);
    final address = private.address.hex;
    final evmChainKey = ChainKey(
      chains: ChainsDataList.eip155Chains.map((e) => e.chainId).toList(),
      privateKey: keyPair.privateKey,
      publicKey: keyPair.publicKey,
      address: address,
    );
    debugPrint('[SampleWallet] evmChainKey ${evmChainKey.toString()}');
    return evmChainKey;
  }

  // ** extra derivations **

  Future<List<ChainKey>> _extraChainKeys() async {
    // final bitcoinChainKeys = await _bitcoinChainKey();
    final solanaChainKeys = await _solanaChainKey();
    final polkadotChainKey = await _polkadotChainKey();
    final kadenaChainKey = await _kadenaChainKey();
    //
    return [
      // bitcoinChainKeys,
      solanaChainKeys,
      polkadotChainKey,
      kadenaChainKey,
    ];
  }

  Future<ChainKey> _solanaChainKey() async {
    final mnemonic = await getMnemonic();
    final seed = bip39.mnemonicToSeed(mnemonic);
    final root = bip32.BIP32.fromSeed(seed);
    final solanaNode = root.derivePath("m/44'/501'/0'/0'");

    Uint8List privateKey = solanaNode.privateKey!;
    final solanaKeyPair = await solana.Ed25519HDKeyPair.fromPrivateKeyBytes(
      privateKey: privateKey,
    );
    return ChainKey(
      chains: ChainsDataList.solanaChains.map((e) => e.chainId).toList(),
      privateKey: base58.encode(privateKey),
      publicKey: solanaKeyPair.publicKey.toString(),
      address: solanaKeyPair.address,
    );
  }

  Future<ChainKey> _polkadotChainKey() async {
    final mnemonic = await getMnemonic();
    final seed = bip39.mnemonicToSeed(mnemonic);
    final root = bip32.BIP32.fromSeed(seed);
    final polkadotNode = root.derivePath("m/44'/354'/0'/0'");

    // Step 4: Extract Private and Public Keys
    Uint8List privateKey = polkadotNode.privateKey!;
    Uint8List publicKey = polkadotNode.publicKey;

    // Step 5: Manually Encode SS58 Address
    final ss58Address = _encodeSS58(publicKey, prefix: 0); // 0 = Polkadot

    return ChainKey(
      chains: ChainsDataList.polkadotChains.map((e) => e.chainId).toList(),
      privateKey: base58.encode(privateKey),
      publicKey: base58.encode(publicKey),
      address: ss58Address,
    );
  }

  Future<ChainKey> _kadenaChainKey() async {
    final mnemonic = await getMnemonic();
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
    );
  }

  // Future<ChainKey> _bitcoinChainKey() async {
  //   final mnemonic = await getMnemonic();
  //   final seed = bip39.mnemonicToSeed(mnemonic);
  //   final root = bip32.BIP32.fromSeed(seed);
  //   final bitcoinNode = root.derivePath("m/84'/0'/0'/0/0");

  //   Uint8List privateKey = bitcoinNode.privateKey!;
  //   Uint8List publicKey = bitcoinNode.publicKey;

  //   String address = BitcoinAddress.generateSegwitAddress(publicKey);

  //   return ChainKey(
  //     chains: ChainsDataList.solanaChains.map((e) => e.chainId).toList(),
  //     privateKey: base58.encode(privateKey),
  //     publicKey: base58.encode(publicKey),
  //     address: address,
  //   );
  // }

  // Function to encode a public key into an SS58 address (Pure Dart Implementation)
  String _encodeSS58(Uint8List publicKey, {int prefix = 0}) {
    // Step 1: Prefix + Public Key
    final List<int> data = [prefix, ...publicKey];

    // Step 2: Compute the Blake2b hash manually (checksum)
    final checksum = _blake2bMini(Uint8List.fromList(data));
    final List<int> checksumPrefix = checksum.sublist(0, 2); // First 2 bytes

    // Step 3: Concatenate Data + Checksum
    final List<int> addressBytes = [...data, ...checksumPrefix];

    // Step 4: Encode in Base58
    return base58.encode(Uint8List.fromList(addressBytes));
  }

  // Minimal Blake2b Implementation in Pure Dart
  Uint8List _blake2bMini(Uint8List input) {
    final h = utf8.encode('SS58PRE'); // Prefix for Blake2b
    final combined = Uint8List.fromList([...h, ...input]);

    // Using SHA-256 as a simplified Blake2b substitute
    final hash = _sha256Hash(combined);
    return Uint8List.fromList(hash);
  }

  // SHA-256 hash function (acts as a placeholder for Blake2b)
  List<int> _sha256Hash(Uint8List data) {
    int hash = 0;
    for (int byte in data) {
      hash = (hash * 31 + byte) & 0xFFFFFFFF; // Simple hash function
    }
    final hashBytes = ByteData(32);
    hashBytes.setUint32(0, hash, Endian.little);
    return hashBytes.buffer.asUint8List();
  }
}
