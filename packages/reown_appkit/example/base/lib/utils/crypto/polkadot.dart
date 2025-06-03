import 'dart:convert';
import 'dart:typed_data';

import 'package:polkadart/apis/apis.dart' as dot_apis;
import 'package:polkadart/polkadart.dart' as polkadart;
// import 'package:polkadart/primitives/primitives.dart';
// ignore: depend_on_referenced_packages
import 'package:polkadart_keyring/polkadart_keyring.dart' as keyring;
import 'package:polkadart/scale_codec.dart' as scale_codec;

import 'package:reown_appkit/reown_appkit.dart';

import 'package:reown_appkit_dapp/generated/polkadot/polkadot.dart' as polkadot;
import 'package:reown_appkit_dapp/generated/polkadot/types/polkadot_runtime/runtime_call.dart';

import 'package:reown_appkit_dapp/generated/polkadot/types/sp_runtime/multiaddress/multi_address.dart'
    as multi_address;

enum PolkadotMethods {
  polkadotSignTransaction,
  polkadotSignMessage,
}

enum PolkadotEvents {
  none,
}

class Polkadot {
  static final Map<PolkadotMethods, String> methods = {
    PolkadotMethods.polkadotSignTransaction: 'polkadot_signTransaction',
    PolkadotMethods.polkadotSignMessage: 'polkadot_signMessage'
  };

  static final Map<PolkadotEvents, String> events = {};

  static Future<dynamic> walletToWalletExample() async {
    try {
      // Create sr25519 wallet
      final senderWallet = await keyring.KeyPair.sr25519.fromMnemonic('//');
      senderWallet.ss58Format = 0;
      print('[PolkadotTest] senderWallet: ${senderWallet.address}');

      // Create ecdsa wallet
      final receiverWallet = await keyring.KeyPair.sr25519.fromMnemonic('//');
      receiverWallet.ss58Format = 0;
      print('[PolkadotTest] receiverWallet: ${receiverWallet.address}');

      final provider = polkadart.Provider.fromUri(
        Uri.parse('wss://rpc.polkadot.io'),
      );
      final polkadotApi = polkadot.Polkadot(provider);
      final stateApi = dot_apis.StateApi(provider);
      final systemApi = dot_apis.SystemApi(provider);
      final authorApi = dot_apis.AuthorApi(provider);

      // Get Runtime version
      final runtimeVersion = await stateApi.getRuntimeVersion();
      final specVersion = runtimeVersion.specVersion;
      final transactionVersion = runtimeVersion.transactionVersion;

      // // Get Metadata
      // final customMetadata = await stateApi.getMetadata();
      // final registry = customMetadata.chainInfo.scaleCodec.registry;

      // Get Block number
      final getBlock = await provider.send('chain_getBlock', []);
      final blockNumber =
          int.parse(getBlock.result['block']['header']['number']);

      // Get Block hash
      final getBlockHash = await provider.send('chain_getBlockHash', []);
      final blockHash = getBlockHash.result;

      // Get genesis hash
      final getGenesisHash = await provider.send('chain_getBlockHash', [0]);
      final genesisHash = getGenesisHash.result;

      // Destination
      final destAddress = receiverWallet.address;
      final destPubKey = PolkadotChainUtils.ss58AddressToPublicKey(destAddress);
      final destination = multi_address.$MultiAddress().id(destPubKey);

      // Construct call
      final RuntimeCall call = polkadotApi.tx.balances.transferKeepAlive(
        dest: destination,
        value: BigInt.parse('1000000000'), // 0.1 DOT
      );
      final encodedCall = call.encode();

      // Get nonce
      final nonce = await systemApi.accountNextIndex(senderWallet.address);
      final int eraPeriod = 64;

      // Get SignedExtensions mapped with codecs Map<String, Codec<dynamic>>
      // final signedExtensions = registry.getSignedExtensionTypes();

      final payloadToSign = polkadart.SigningPayload(
        method: encodedCall,
        specVersion: specVersion,
        transactionVersion: transactionVersion,
        genesisHash: genesisHash,
        blockHash: blockHash,
        blockNumber: blockNumber,
        eraPeriod: eraPeriod,
        nonce: nonce,
        tip: BigInt.zero,
      );
      final payloadToSignMap = payloadToSign.toEncodedMap(polkadotApi.registry);
      print('[PolkadotTest] payloadToSign: ${jsonEncode(payloadToSignMap)}');

      // SIGNING PHASE -->
      // Build payload and sign with sr25519 wallet
      final payloadToSignBytes = payloadToSign.encode(polkadotApi.registry);
      final payloadToSignHex = scale_codec.encodeHex(payloadToSignBytes);
      print('[PolkadotTest] Payload hex: $payloadToSignHex');

      final payloadSignatureBytes = senderWallet.sign(payloadToSignBytes);
      final payloadSignatureHex = scale_codec.encodeHex(payloadSignatureBytes);
      print('[PolkadotTest] Signature hex: $payloadSignatureHex');
      // <-- SIGNING PHASE

      // // Build extrinsic with sr25519 wallet
      // final extrinsicPayload = polkadart.ExtrinsicPayload(
      //   signer: senderWallet.bytes(),
      //   method: encodedCall,
      //   signature: payloadSignature,
      //   eraPeriod: eraPeriod,
      //   blockNumber: blockNumber,
      //   nonce: nonce,
      //   tip: BigInt.zero,
      // );
      // final extrinsicPayloadBytes = extrinsicPayload.encode(
      //   polkadotApi.registry,
      //   polkadart.SignatureType.sr25519,
      // );
      // final extrinsicPayloadHex = scale_codec.encodeHex(extrinsicPayloadBytes);
      // print('[PolkadotTest] srExtrinsic Hex: $extrinsicPayloadHex');

      final publicKey = PolkadotChainUtils.ss58AddressToPublicKey(
        senderWallet.address,
      );
      print(
        '[PolkadotTest] matches public key: ${scale_codec.encodeHex(publicKey) == scale_codec.encodeHex(senderWallet.bytes())}',
      );

      final signedExtrinsicBytes = PolkadotChainUtils.addSignatureToExtrinsic(
        publicKey: Uint8List.fromList(publicKey),
        hexSignature: payloadSignatureHex,
        payload: payloadToSignMap,
      );
      final signedExtrinsicHex = scale_codec.encodeHex(signedExtrinsicBytes);
      print('[PolkadotTest] utilExtrinsic Hex: $signedExtrinsicHex');
      // print(
      //   '[PolkadotTest] matches extrinsics ${signedExtrinsicHex == extrinsicPayloadHex}',
      // );

      final hashBytes = await authorApi.submitExtrinsic(signedExtrinsicBytes);
      final hashHex = scale_codec.encodeHex(hashBytes);
      print('[PolkadotTest] extrinsic hash: $hashHex');
      final hash1 = PolkadotChainUtils.deriveExtrinsicHash(signedExtrinsicHex);
      // final hash2 = PolkadotChainUtils.deriveExtrinsicHash(extrinsicPayloadHex);
      print('[PolkadotTest] matches hash: ${hashHex == hash1}');
      // print('[PolkadotTest] matches hash: ${hash1 == hash2}');
      //
    } catch (e, s) {
      print('[PolkadotTest] ❌ error: $e.\n$s');
    }
  }

  static Future<dynamic> createAndSubmitTransferAll(
    ReownAppKitModal appKitModal,
  ) async {
    try {
      final senderAddress = _senderAddress(appKitModal);
      final destAddress = '15JBFhDp1r............TY53mdRmM';
      final chainData = appKitModal.selectedChain!;

      final provider = polkadart.Provider.fromUri(Uri.parse(chainData.rpcUrl));

      final transactionPayload = await transferAllPayload(
        senderAddress,
        destAddress,
        appKitModal.selectedChain!,
      );
      print(
          '[PolkadotTest] transactionPayload: ${jsonEncode(transactionPayload)}');

      // SIGNING PHASE -->
      final result = await appKitModal.request(
        topic: appKitModal.session!.topic,
        chainId: appKitModal.selectedChain!.chainId,
        request: SessionRequestParams(
          method: 'polkadot_signTransaction',
          params: {
            'address': senderAddress,
            'transactionPayload': transactionPayload,
          },
        ),
      );

      final String signatureHex = ReownCoreUtils.recursiveSearchForMapKey(
        result,
        'signature',
      );
      print('[PolkadotTest] signature from wallet: $signatureHex');
      // final payloadSignatureBytes = scale_codec.decodeHex(signatureHex);
      // <-- SIGNING PHASE

      final publicKey = PolkadotChainUtils.ss58AddressToPublicKey(
        senderAddress,
      );
      final signedExtrinsicBytes = PolkadotChainUtils.addSignatureToExtrinsic(
        publicKey: Uint8List.fromList(publicKey),
        hexSignature: signatureHex,
        payload: transactionPayload,
      );
      final signedExtrinsicHex = scale_codec.encodeHex(signedExtrinsicBytes);

      final txHash = await _submitExtrinsic(provider, signedExtrinsicHex);
      return txHash;
    } catch (e, s) {
      print('[PolkadotTest] ❌ createTransferKeepAlive error: $e.\n$s');
    }
  }

  static Future<dynamic> createAndSubmitTransferKeepAlive(
    ReownAppKitModal appKitModal,
  ) async {
    try {
      final senderAddress = _senderAddress(appKitModal);
      final chainData = appKitModal.selectedChain!;

      final provider = polkadart.Provider.fromUri(Uri.parse(chainData.rpcUrl));

      final transactionPayload = await transferKeepAlivePayload(
        senderAddress, // sender
        senderAddress, // destination
        appKitModal.selectedChain!,
      );
      print(
          '[PolkadotTest] transactionPayload: ${jsonEncode(transactionPayload)}');

      // SIGNING PHASE -->
      final result = await appKitModal.request(
        topic: appKitModal.session!.topic,
        chainId: appKitModal.selectedChain!.chainId,
        request: SessionRequestParams(
          method: 'polkadot_signTransaction',
          params: {
            'address': senderAddress,
            'transactionPayload': transactionPayload,
          },
        ),
      );

      final String signatureHex = ReownCoreUtils.recursiveSearchForMapKey(
        result,
        'signature',
      );
      print('[PolkadotTest] signature from wallet: $signatureHex');
      // final payloadSignatureBytes = scale_codec.decodeHex(signatureHex);
      // <-- SIGNING PHASE

      final publicKey = PolkadotChainUtils.ss58AddressToPublicKey(
        senderAddress,
      );
      final signedExtrinsicBytes = PolkadotChainUtils.addSignatureToExtrinsic(
        publicKey: Uint8List.fromList(publicKey),
        hexSignature: signatureHex,
        payload: transactionPayload,
      );
      final signedExtrinsicHex = scale_codec.encodeHex(signedExtrinsicBytes);

      final txHash = await _submitExtrinsic(provider, signedExtrinsicHex);
      return txHash;
    } catch (e, s) {
      print('[PolkadotTest] ❌ createTransferKeepAlive error: $e.\n$s');
    }
  }

  // Will create transactionPayload to send 0.01 DOT
  static Future<Map<String, dynamic>> transferKeepAlivePayload(
    String senderAddress,
    String destAddress,
    ReownAppKitModalNetworkInfo chainData,
  ) async {
    try {
      final provider = polkadart.Provider.fromUri(Uri.parse(chainData.rpcUrl));

      final runtimeVersion = await _runtimeVersions(provider);
      final specVersion = runtimeVersion.$1;
      final transactionVersion = runtimeVersion.$2;

      // Get Metadata
      // final customMetadata = await stateApi.getMetadata();
      // final registry = customMetadata.chainInfo.scaleCodec.registry;

      final blockNumber = await _blockNumber(provider);
      final blockHash = await _blockHash(provider);
      final genesisHash = await _genesisHash(provider);

      final encodedCall = _transferKeepAliveCall(
        provider,
        destAddress,
        '100000000', // 0.01 DOT
      );

      // Get nonce
      final systemApi = dot_apis.SystemApi(provider);
      final nonce = await systemApi.accountNextIndex(senderAddress);

      final int eraPeriod = 64;

      // Get SignedExtensions
      final polkadotApi = polkadot.Polkadot(provider);
      final signedExtensions = polkadotApi.registry.getSignedExtensionTypes();

      final payloadToSign = polkadart.SigningPayload(
        method: encodedCall,
        specVersion: specVersion,
        transactionVersion: transactionVersion,
        genesisHash: genesisHash,
        blockHash: blockHash,
        blockNumber: blockNumber,
        eraPeriod: eraPeriod,
        nonce: nonce,
        tip: BigInt.zero,
      );
      final transactionPayload = {
        ...payloadToSign.toEncodedMap(polkadotApi.registry),
        'method': scale_codec.encodeHex(encodedCall),
        'blockNumber': blockNumber.toRadixString(16),
        'address': senderAddress,
        'signedExtensions': signedExtensions,
        'version': 4,
      };
      return transactionPayload;
    } catch (e, s) {
      print('[PolkadotTest] ❌ createTransferKeepAlive error: $e.\n$s');
      rethrow;
    }
  }

  // Will create transactionPayload to transfer all funds
  static Future<Map<String, dynamic>> transferAllPayload(
    String senderAddress,
    String destAddress,
    ReownAppKitModalNetworkInfo chainData,
  ) async {
    try {
      final provider = polkadart.Provider.fromUri(Uri.parse(chainData.rpcUrl));

      final runtimeVersion = await _runtimeVersions(provider);
      final specVersion = runtimeVersion.$1;
      final transactionVersion = runtimeVersion.$2;

      // Get Metadata
      // final customMetadata = await stateApi.getMetadata();
      // final registry = customMetadata.chainInfo.scaleCodec.registry;

      final blockNumber = await _blockNumber(provider);
      final blockHash = await _blockHash(provider);
      final genesisHash = await _genesisHash(provider);

      final encodedCall = _transferAllCall(
        provider,
        destAddress,
      );

      // Get nonce
      final systemApi = dot_apis.SystemApi(provider);
      final nonce = await systemApi.accountNextIndex(senderAddress);

      final int eraPeriod = 64;

      // Get SignedExtensions
      final polkadotApi = polkadot.Polkadot(provider);
      final signedExtensions = polkadotApi.registry.getSignedExtensionTypes();

      final payloadToSign = polkadart.SigningPayload(
        method: encodedCall,
        specVersion: specVersion,
        transactionVersion: transactionVersion,
        genesisHash: genesisHash,
        blockHash: blockHash,
        blockNumber: blockNumber,
        eraPeriod: eraPeriod,
        nonce: nonce,
        tip: BigInt.zero,
      );
      final transactionPayload = {
        ...payloadToSign.toEncodedMap(polkadotApi.registry),
        'method': scale_codec.encodeHex(encodedCall),
        'blockNumber': blockNumber.toRadixString(16),
        'address': senderAddress,
        'signedExtensions': signedExtensions,
        'version': 4,
      };
      return transactionPayload;
    } catch (e, s) {
      print('[PolkadotTest] ❌ createTransferKeepAlive error: $e.\n$s');
      rethrow;
    }
  }

  static Uint8List _transferKeepAliveCall(
    polkadart.Provider provider,
    String destAddress,
    String plankValue,
  ) {
    final polkadotApi = polkadot.Polkadot(provider);

    // Construct call
    final destPubKey = PolkadotChainUtils.ss58AddressToPublicKey(destAddress);
    final destination = multi_address.$MultiAddress().id(destPubKey);
    final RuntimeCall call = polkadotApi.tx.balances.transferKeepAlive(
      dest: destination,
      value: BigInt.parse(plankValue),
    );
    return call.encode();
  }

  static Uint8List _transferAllCall(
    polkadart.Provider provider,
    String destAddress,
  ) {
    final polkadotApi = polkadot.Polkadot(provider);

    // Construct call
    final destPubKey = PolkadotChainUtils.ss58AddressToPublicKey(destAddress);
    final destination = multi_address.$MultiAddress().id(destPubKey);
    final RuntimeCall call = polkadotApi.tx.balances.transferAll(
      dest: destination,
      keepAlive: true,
    );

    return call.encode();
  }

  static Future<dynamic> _genesisHash(polkadart.Provider provider) async {
    // Get genesis hash
    final getGenesisHash = await provider.send('chain_getBlockHash', [0]);
    return getGenesisHash.result;
  }

  static Future<dynamic> _blockHash(polkadart.Provider provider) async {
    // Get Block hash
    final getBlockHash = await provider.send('chain_getBlockHash', []);
    return getBlockHash.result;
  }

  static Future<int> _blockNumber(polkadart.Provider provider) async {
    // Get Block number
    final getBlock = await provider.send('chain_getBlock', []);
    return int.parse(getBlock.result['block']['header']['number']);
  }

  static Future<(int, int)> _runtimeVersions(
    polkadart.Provider provider,
  ) async {
    // Get Runtime version
    final stateApi = dot_apis.StateApi(provider);
    final runtimeVersion = await stateApi.getRuntimeVersion();
    final specVersion = runtimeVersion.specVersion;
    final transactionVersion = runtimeVersion.transactionVersion;
    return (specVersion, transactionVersion);
  }

  static String _senderAddress(ReownAppKitModal appKitModal) {
    final chainId = appKitModal.selectedChain?.chainId ?? '';
    final namespace = NamespaceUtils.getNamespaceFromChain(chainId);
    return appKitModal.session!.getAddress(namespace)!;
  }

  static Future<String> _submitExtrinsic(
    polkadart.Provider provider,
    String signedExtrinsicHex,
  ) async {
    final authorApi = dot_apis.AuthorApi(provider);
    final signedExtrinsicBytes = scale_codec.decodeHex(signedExtrinsicHex);
    final hashBytes = await authorApi.submitExtrinsic(signedExtrinsicBytes);
    final hashHex = scale_codec.encodeHex(hashBytes);
    print('[PolkadotTest] extrinsic hash: $hashHex');
    final hash1 = PolkadotChainUtils.deriveExtrinsicHash(signedExtrinsicHex);
    print('[PolkadotTest] matches hash: ${hashHex == hash1}');

    return '0x$hash1';
  }
}
