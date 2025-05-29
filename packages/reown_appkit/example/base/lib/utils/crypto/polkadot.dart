import 'dart:convert';
import 'dart:typed_data';

import 'package:polkadart/apis/apis.dart' as dot_apis;
import 'package:polkadart/polkadart.dart' as polkadart;
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
  //   print('encodedCall ${bytesToHex(encodedCall)}');

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
  //   print('Payload: ${bytesToHex(encodedPayload)}');

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

  //   return bytesToHex(encodedPayload);
  // }

  static Future<dynamic> createTransferKeepAlive(
    String senderAddress,
    ReownAppKitModalNetworkInfo chainData,
    ReownAppKitModal appKitModal,
  ) async {
    try {
      final provider = polkadart.Provider.fromUri(Uri.parse(chainData.rpcUrl));
      final polkadotApi = polkadot.Polkadot(provider);
      final stateApi = dot_apis.StateApi(provider);
      final systemApi = dot_apis.SystemApi(provider);

      // Get Runtime version
      final runtimeVersion = await stateApi.getRuntimeVersion();
      final specVersion = runtimeVersion.specVersion;
      final transactionVersion = runtimeVersion.transactionVersion;

      // Get Metadata
      final customMetadata = await stateApi.getMetadata();
      final registry = customMetadata.chainInfo.scaleCodec.registry;

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

      // Construct call
      final destAddress = '15MPNB1h2aaDg1ys2ZPEvVEhoyt78xUNPKwD5XfPpdJeoQ6H';
      final destPubKey = PolkadotChainUtils.ss58AddressToPublicKey(destAddress);
      final destination = multi_address.$MultiAddress().id(destPubKey);
      final RuntimeCall call = polkadotApi.tx.balances.transferKeepAlive(
        dest: destination,
        value: BigInt.parse('11000000000'), // 1.1 DOT
      );
      final encodedCall = call.encode();

      // Get nonce
      final senderNonce = await systemApi.accountNextIndex(senderAddress);
      // Sender public key
      final publicKey = PolkadotChainUtils.ss58AddressToPublicKey(
        senderAddress,
      );

      // Get SignedExtensions mapped with codecs Map<String, Codec<dynamic>>
      // final signedExtensions = registry.getSignedExtensionTypes();

      final payloadToSign = polkadart.SigningPayload(
        method: encodedCall,
        specVersion: specVersion,
        transactionVersion: transactionVersion,
        genesisHash: genesisHash,
        blockHash: blockHash,
        blockNumber: blockNumber,
        eraPeriod: 0,
        nonce: senderNonce,
        tip: BigInt.zero,
        // A custom Signed Extensions
        // customSignedExtensions: {
        //   'ChargeAssetTxPayment': {
        //     'tip': BigInt.zero,
        //     'asset_id': scale_codec.Option.none(),
        //   },
        // },
      );

      final customSignedExtensions = payloadToSign.customSignedExtensions.keys
          .map((e) => e.toString())
          .toList();

      final payloadData = payloadToSign.toEncodedMap(registry);
      final transactionPayload = {
        ...payloadData, // specVersion, transactionVersion, era, nonce, tip, blockHash, genesisHash
        'address': senderAddress,
        'blockNumber': scale_codec.encodeHex(scale_codec.U32Codec.codec.encode(
          payloadToSign.blockNumber,
        )),
        'method': scale_codec.encodeHex(payloadToSign.method),
        'signedExtensions': customSignedExtensions,
        'version': 4,
      };

      // Send request through walletconnect
      final topic = appKitModal.session!.topic ?? '';
      final chainId = appKitModal.selectedChain?.chainId ?? '';
      final requestParams = SessionRequestParams(
        method: 'polkadot_signTransaction',
        params: {
          'address': senderAddress,
          'transactionPayload': transactionPayload,
        },
      );
      print(
          '[PolkadotTest] requestParams ${jsonEncode(requestParams.toJson())}');
      final result = await appKitModal.request(
        topic: topic,
        chainId: chainId,
        request: requestParams,
      );

      final String? signature = ReownCoreUtils.recursiveSearchForMapKey(
        result,
        'signature',
      );
      print('[PolkadotTest] signature $signature');
      if (signature != null) {
        // final id = response.id;
        // final requestParams = pendingTVFRequests[id]!.requestParams;
        // final params = requestParams as Map<String, dynamic>;
        // final payload = ReownCoreUtils.recursiveSearchForMapKey(
        //   params,
        //   'transactionPayload',
        // );
        // final ss58Address = ReownCoreUtils.recursiveSearchForMapKey(
        //   transactionPayload,
        //   'address',
        // );
        // final publicKey = PolkadotChainUtils.ss58AddressToPublicKey(
        //   ss58Address,
        // );
        final signedHex = PolkadotChainUtils.addSignatureToExtrinsic(
          publicKey: publicKey,
          hexSignature: signature,
          payload: transactionPayload,
        );
        final derivedHash = PolkadotChainUtils.deriveExtrinsicHash(signedHex);
        print('[PolkadotTest] deriveExtrinsicHash $derivedHash');

        // FROM NOVA WALLET
        // {
        //   "signature": "0x0180a67697a21c77959be2933ffbd1b5bb8901364d051a47d563b5dbfdd381886e7f71190dcc7bc5d04e7127e955e40ef250ac731f55278fb15d305f7eeb82f98c",
        //   "id": 2600629445
        // }

        // final customExtensionPayload = payloadToSign.encode(registry);
        // print('Encoded Payload: ${hex.encode(customExtensionPayload)}');

        // final customSignature = sr25519Wallet.sign(customExtensionPayload);
        // print('Signature: ${hex.encode(customSignature)}');

        final customExtrinsic = polkadart.ExtrinsicPayload(
          signer: Uint8List.fromList(publicKey),
          method: payloadToSign.method,
          signature: scale_codec.decodeHex(signature),
          eraPeriod: payloadToSign.eraPeriod,
          blockNumber: payloadToSign.blockNumber,
          nonce: payloadToSign.nonce,
          tip: payloadToSign.tip,
          customSignedExtensions: payloadToSign.customSignedExtensions,
        ).encode(
          registry,
          polkadart.SignatureType.sr25519,
        );
        print(
            '[PolkadotTest] extrinsic payload: ${scale_codec.encodeHex(customExtrinsic)}');

        final authorAssetHub = dot_apis.AuthorApi(provider);
        final txHash = await authorAssetHub.submitExtrinsic(customExtrinsic);
        print(
            '[PolkadotTest] Extrinsic Hash: ${scale_codec.encodeHex(txHash)}');
      }
    } catch (e, s) {
      print('[PolkadotTest] error: $e.\n$s');
    }
  }
}
