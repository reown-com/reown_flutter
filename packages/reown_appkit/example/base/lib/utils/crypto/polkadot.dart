import 'dart:convert';
import 'dart:typed_data';

import 'package:eth_sig_util/util/utils.dart';
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

  static Map<String, dynamic> hardcodedPayload(String address) => {
        'specVersion': 'c9550f00',
        'transactionVersion': '1a000000',
        'address': '15JBFhDp1rQycRFuCtkr2VouMiWyDzh3qRUPA8STY53mdRmM',
        'genesisHash':
            '91b171bb158e2d3848fa23a9f1c25182fb8e20313b2c1eb49219da7a70ce90c3',
        'blockHash':
            'd53fa10f943813266254b909220c8ab786f46ef1849ac265a7a87990405b824b',
        'era': 'e500',
        'method': bytesToHex([
          5,
          3,
          0,
          192,
          125,
          33,
          29,
          60,
          24,
          29,
          247,
          104,
          217,
          217,
          212,
          29,
          246,
          241,
          79,
          157,
          17,
          109,
          156,
          25,
          6,
          243,
          129,
          83,
          178,
          8,
          37,
          156,
          49,
          91,
          75,
          2,
          40,
          107,
          238
        ]),
        'nonce': '18',
        'tip': '00',
        'mode': '00',
        'metadataHash': '00',
        'version': 4,
      };

  static Future<dynamic> createTransferKeepAlive() async {
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

  // static Future<dynamic> createExtrinsic2(
  //   String address,
  //   ReownAppKitModalNetworkInfo chainData,
  // ) async {
  //   print('$address ${chainData.chainId}');
  //   final provider = polkadart.Provider.fromUri(Uri.parse(chainData.rpcUrl));
  //   final polkadotApi = polkadot.Polkadot(provider);
  //   final stateApi = dot_apis.StateApi(provider);
  //   final runtime = await stateApi.getRuntimeVersion();
  //   // final stateVersion = runtimeVersion.stateVersion;
  //   // print('stateVersion $stateVersion');
  //   // final specVersion = runtimeVersion.specVersion;
  //   // print('specVersion $specVersion');
  //   // final transactionVersion = runtimeVersion.transactionVersion;
  //   // print('transactionVersion $transactionVersion');
  //   final block = await provider.send('chain_getBlock', []);
  //   print('block ${jsonEncode(block.result)}');
  //   final blockNumber = int.parse(block.result['block']['header']['number']);
  //   print('blockNumber $blockNumber');

  //   final blockHash = (await provider.send('chain_getBlockHash', []))
  //       .result
  //       .replaceAll('0x', '');
  //   print('blockHash $blockHash');
  //   final genesisHash = (await provider.send('chain_getBlockHash', [0]))
  //       .result
  //       .replaceAll('0x', '');
  //   print('genesisHash $genesisHash');

  //   final authorApi = dot_apis.AuthorApi(provider);

  //   final publicKey = PolkadotChainUtils.ss58AddressToPublicKey(address);
  //   final multiAddress = multi_address.$MultiAddress().id(publicKey);

  //   final RuntimeCall call = polkadotApi.tx.balances.transferKeepAlive(
  //     dest: multiAddress,
  //     value: BigInt.from(1000000000000), // 1 DOT
  //   );
  //   final encodedCall = call.encode();
  //   print('encodedCall ${scale_codec.encodeHex(encodedCall)}');

  //   final systemApi = dot_apis.SystemApi(provider);
  //   final nonce1 = await systemApi.accountNextIndex(address);
  //   print('nonce1 $nonce1');

  //   final payloadToSign = polkadart.SigningPayload(
  //     method: encodedCall,
  //     specVersion: runtime.specVersion,
  //     transactionVersion: runtime.transactionVersion,
  //     genesisHash: genesisHash,
  //     blockHash: blockHash,
  //     blockNumber: blockNumber,
  //     eraPeriod: 64,
  //     nonce: nonce1,
  //     tip: BigInt.zero,
  //   );

  //   // Build payload and sign with sr25519 wallet
  //   final encodedPayload = payloadToSign.encode(polkadotApi.registry);
  //   print('Payload: ${scale_codec.encodeHex(encodedPayload)}');

  //   // final payloadMap = {
  //   //   'specVersion':
  //   //       '0x${payloadToSign.specVersion.toRadixString(16).padLeft(2, '0')}',
  //   //   'transactionVersion':
  //   //       '0x${payloadToSign.transactionVersion.toRadixString(16).padLeft(2, '0')}',
  //   //   'address': address,
  //   //   'blockHash': '0x${payloadToSign.blockHash}',
  //   //   'blockNumber':
  //   //       '0x${payloadToSign.blockNumber.toRadixString(16).padLeft(2, '0')}',
  //   //   'era': '0x${payloadToSign.eraPeriod.toRadixString(16).padLeft(2, '0')}',
  //   //   'genesisHash': '0x${payloadToSign.genesisHash}',
  //   //   'method': '0x${bytesToHex(payloadToSign.method)}',
  //   //   'nonce': '0x${payloadToSign.nonce.toRadixString(16).padLeft(2, '0')}',
  //   //   'signedExtensions': payloadToSign.customSignedExtensions,
  //   //   'tip': '0x${payloadToSign.tip.toRadixString(16).padLeft(2, '0')}',
  //   //   // 'version': 4,
  //   // };

  //   print(payloadToSign);
  //   // // Build extrinsic with sr25519 wallet
  //   // final srExtrinsic = polkadart.ExtrinsicPayload(
  //   //   signer: Uint8List.fromList(publicKey),
  //   //   method: encodedCall,
  //   //   signature: srSignature,
  //   //   eraPeriod: 64,
  //   //   blockNumber: blockNumber,
  //   //   nonce: nonce1,
  //   //   tip: 0,
  //   // ).encode(polkadotApi.registry, polkadart.SignatureType.sr25519);
  //   // // print('sr25519 wallet extrinsic: ${bytesToHex(srExtrinsic)}');

  //   // final srHash = await authorApi.submitExtrinsic(srExtrinsic);
  //   // print('Sr25519 extrinsic hash: ${bytesToHex(srHash)}');

  //   return scale_codec.encodeHex(encodedPayload);
  // }
}
