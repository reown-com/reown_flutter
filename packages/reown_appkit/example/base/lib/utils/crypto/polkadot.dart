import 'dart:convert';
import 'dart:typed_data';

import 'package:polkadart/apis/apis.dart' as dot_apis;
import 'package:polkadart/polkadart.dart' as polkadart;
// import 'package:polkadart/primitives/primitives.dart';
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

  static Future<dynamic> createTransferKeepAlive(
      // String senderAddress,
      // ReownAppKitModalNetworkInfo chainData,
      // ReownAppKitModal appKitModal,
      ) async {
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
      final nonce1 = await systemApi.accountNextIndex(senderWallet.address);

      // Get SignedExtensions mapped with codecs Map<String, Codec<dynamic>>
      // final signedExtensions = registry.getSignedExtensionTypes();

      final payloadToSign = polkadart.SigningPayload(
        method: encodedCall,
        specVersion: specVersion,
        transactionVersion: transactionVersion,
        genesisHash: genesisHash,
        blockHash: blockHash,
        blockNumber: blockNumber,
        eraPeriod: 64,
        nonce: nonce1, // Supposing it is this wallet first transaction
        tip: BigInt.zero,
      );
      print(
        '[PolkadotTest] payloadToSign: ${jsonEncode(payloadToSign.toEncodedMap(polkadotApi.registry))}',
      );

      // Build payload and sign with sr25519 wallet
      final srPayload = payloadToSign.encode(polkadotApi.registry);
      print(
        '[PolkadotTest] Payload hex: ${scale_codec.encodeHex(srPayload)}',
      );

      final srSignature = senderWallet.sign(srPayload);
      print(
        '[PolkadotTest] Signature hex: ${scale_codec.encodeHex(srSignature)}',
      );

      // Build extrinsic with sr25519 wallet
      final srExtrinsicEncoded = polkadart.ExtrinsicPayload(
        signer: senderWallet.bytes(),
        method: encodedCall,
        signature: srSignature,
        eraPeriod: 64,
        blockNumber: blockNumber,
        nonce: nonce1,
        tip: BigInt.zero,
      ).encode(
        polkadotApi.registry,
        polkadart.SignatureType.sr25519,
      );
      final srExtrinsicHex = scale_codec.encodeHex(srExtrinsicEncoded);
      print('[PolkadotTest] srExtrinsic Hex: $srExtrinsicHex');

      final publicKey = PolkadotChainUtils.ss58AddressToPublicKey(
        senderWallet.address,
      );
      final utilExtrinsicEncoded = PolkadotChainUtils.addSignatureToExtrinsic(
        publicKey: Uint8List.fromList(publicKey),
        hexSignature: scale_codec.encodeHex(srSignature),
        payload: payloadToSign.toEncodedMap(polkadotApi.registry),
      );

      final utilExtrinsicHex = scale_codec.encodeHex(utilExtrinsicEncoded);
      print('[PolkadotTest] utilExtrinsic Hex: $utilExtrinsicHex');
      print('[PolkadotTest] ${srExtrinsicHex == utilExtrinsicHex}');

      final srHash = await authorApi.submitExtrinsic(srExtrinsicEncoded);
      print(
        '[PolkadotTest] Sr25519 extrinsic hash: ${scale_codec.encodeHex(srHash)}',
      );
    } catch (e, s) {
      print('[PolkadotTest] ❌ error: $e.\n$s');
    }
  }
}
