import 'dart:convert';
import 'dart:typed_data';

import 'package:eth_sig_util/util/utils.dart';
import 'package:polkadart/apis/apis.dart' as dot_apis;
import 'package:polkadart/polkadart.dart' as polkadart;
// import 'package:polkadart/primitives/primitives.dart';
// import 'package:polkadart_keyring/polkadart_keyring.dart' as keyring;
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
        'specVersion': '0x00002468',
        'transactionVersion': '0x0000000e',
        'address': address,
        'blockHash':
            '0x554d682a74099d05e8b7852d19c93b527b5fae1e9e1969f6e1b82a2f09a14cc9',
        'blockNumber': '0x00cb539c',
        'era': '0xc501',
        'genesisHash':
            '0xe143f23803ac50e8f6f8e62695d1ce9e4e1d68aa36c1cd2cfd15340213f3423e',
        'method':
            '0x0001784920616d207369676e696e672074686973207472616e73616374696f6e21',
        'nonce': '0x00000000',
        'signedExtensions': [
          'CheckNonZeroSender',
          'CheckSpecVersion',
          'CheckTxVersion',
          'CheckGenesis',
          'CheckMortality',
          'CheckNonce',
          'CheckWeight',
          'ChargeTransactionPayment',
        ],
        'tip': '0x00000000000000000000000000000000',
        'version': 4,
      };

  static Future<dynamic> createTransferKeepAlive(
    String senderAddress,
    String destAddress,
    ReownAppKitModal appKitModal,
  ) async {
    try {
      final provider = polkadart.Provider.fromUri(
        Uri.parse(appKitModal.selectedChain!.rpcUrl),
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
      final customMetadata = await stateApi.getMetadata();
      final registry = customMetadata
          .chainInfo.scaleCodec.registry; // or polkadotApi.registry

      // Get Block number
      final getBlock = await provider.send('chain_getBlock', []);
      final blockNumber =
          int.parse(getBlock.result['block']['header']['number']);

      // Get Block hash
      final getBlockHash = await provider.send('chain_getBlockHash', []);
      final blockHash = getBlockHash.result;

      // Get genesis hash
      final getGenesisHash = await provider.send('chain_getBlockHash', []);
      final genesisHash = getGenesisHash.result;

      // Destination
      final destPubKey = PolkadotChainUtils.ss58AddressToPublicKey(destAddress);
      final destination = multi_address.$MultiAddress().id(destPubKey);

      // Construct call
      final RuntimeCall call = polkadotApi.tx.balances.transferKeepAlive(
        dest: destination,
        value: BigInt.parse('1000000000'), // 0.1 DOT
      );
      final encodedCall = call.encode();

      // Get nonce
      final nonce = await systemApi.accountNextIndex(senderAddress);

      // Get SignedExtensions mapped with codecs Map<String, Codec<dynamic>>
      final signedExtensions = registry.getSignedExtensionTypes().keys.toList();

      final payloadToSign = polkadart.SigningPayload(
        method: encodedCall,
        specVersion: specVersion,
        transactionVersion: transactionVersion,
        genesisHash: genesisHash,
        blockHash: blockHash,
        blockNumber: blockNumber,
        eraPeriod: 0,
        nonce: nonce, // Supposing it is this wallet first transaction
        tip: BigInt.zero,
      );

      final requestParams = SessionRequestParams(
        method: 'polkadot_signTransaction',
        params: {
          'address': senderAddress,
          'transactionPayload': {
            ...payloadToSign.toEncodedMap(registry),
            'blockNumber': blockNumber.toRadixString(16),
            'address': senderAddress,
            'method': bytesToHex(encodedCall),
            'signedExtensions': signedExtensions,
            'version': 4,
          },
        },
      );
      print('[PolkadotTest] requestParams ${jsonEncode(requestParams)}');
      final result = await appKitModal.request(
        topic: appKitModal.session!.topic,
        chainId: appKitModal.selectedChain!.chainId,
        request: requestParams,
      );

      final String signature = ReownCoreUtils.recursiveSearchForMapKey(
        result,
        'signature',
      );
      print('[PolkadotTest] signature $signature');

      final srSignature = scale_codec.decodeHex(signature);

      // Build extrinsic with sr25519 wallet;
      final publicKey = PolkadotChainUtils.ss58AddressToPublicKey(
        senderAddress,
      );

      // final srExtrinsicEncoded = polkadart.ExtrinsicPayload(
      //   signer: Uint8List.fromList(publicKey),
      //   method: encodedCall,
      //   signature: srSignature,
      //   eraPeriod: 0,
      //   blockNumber: blockNumber,
      //   nonce: nonce,
      //   tip: BigInt.zero,
      // ).encode(
      //   registry,
      //   polkadart.SignatureType.sr25519,
      // );
      // final srExtrinsicHex = scale_codec.encodeHex(srExtrinsicEncoded);
      // print('[PolkadotTest] srExtrinsic Hex: $srExtrinsicHex');

      final utilExtrinsicEncoded = PolkadotChainUtils.addSignatureToExtrinsic(
        publicKey: Uint8List.fromList(publicKey),
        hexSignature: scale_codec.encodeHex(srSignature),
        payload: payloadToSign.toEncodedMap(registry),
      );

      final utilExtrinsicHex = scale_codec.encodeHex(utilExtrinsicEncoded);
      print('[PolkadotTest] utilExtrinsic Hex: $utilExtrinsicHex');

      // print(
      //     '[PolkadotTest] match extrinsics ${srExtrinsicHex == utilExtrinsicHex}');

      final srHash = await authorApi.submitExtrinsic(utilExtrinsicEncoded);
      final derivedhash = PolkadotChainUtils.deriveExtrinsicHash(
        utilExtrinsicHex,
      );
      print(
        '[PolkadotTest] match hashes: ${(scale_codec.encodeHex(srHash) == derivedhash)}',
      );
    } catch (e, s) {
      print('[PolkadotTest] ❌ error: $e.\n$s');
    }
  }
}
