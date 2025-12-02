// import 'package:flutter/foundation.dart';
// import 'package:reown_walletkit/reown_walletkit.dart';
// import 'package:reown_walletkit/version.dart' as wk;

// import 'package:reown_yttrium_utils/reown_yttrium_utils.dart';

// class TonClient {
//   final String projectId;
//   final String networkId;

//   TonClient({
//     required this.projectId,
//     required this.networkId,
//   });

//   Future<void> init() async {
//     try {
//       final packageName = await ReownCoreUtils.getPackageName();
//       await ReownYttriumUtils.tonClient.init(
//         projectId: projectId,
//         networkId: networkId,
//         pulseMetadata: PulseMetadataCompat(
//           sdkVersion: wk.packageVersion,
//           sdkPlatform: ReownCoreUtils.getId(),
//           bundleId: packageName,
//         ),
//       );
//     } catch (e) {
//       debugPrint('❌ [$runtimeType] $e');
//     }
//   }

//   Future<TonKeyPair> generateKeypair() async {
//     return await ReownYttriumUtils.tonClient
//         .generateKeypair(networkId: networkId);
//   }

//   Future<TonKeyPair> generateKeypairFromBip39Mnemonic(String mnemonic) async {
//     return await ReownYttriumUtils.tonClient.generateKeypairFromBip39Mnemonic(
//       networkId: networkId,
//       mnemonic: mnemonic,
//     );
//   }

//   Future<TonIdentity> getAddressFromKeypair(TonKeyPair keyPair) async {
//     return await ReownYttriumUtils.tonClient.getAddressFromKeypair(
//       networkId: networkId,
//       keyPair: keyPair,
//     );
//   }

//   Future<String> signData({
//     required String text,
//     required TonKeyPair keyPair,
//   }) async {
//     return await ReownYttriumUtils.tonClient.signData(
//       networkId: networkId,
//       text: text,
//       keyPair: keyPair,
//     );
//   }

//   Future<String> sendMessage({
//     required String networkId,
//     required String from,
//     required int validUntil,
//     required List<TonMessage> messages,
//     required TonKeyPair keyPair,
//   }) async {
//     return await ReownYttriumUtils.tonClient.sendMessage(
//       networkId: networkId,
//       from: from,
//       validUntil: validUntil,
//       messages: messages,
//       keyPair: keyPair,
//     );
//   }

//   Future<String> broadcastMessage({
//     required String networkId,
//     required String from,
//     required int validUntil,
//     required List<TonMessage> messages,
//     required TonKeyPair keyPair,
//   }) async {
//     return await ReownYttriumUtils.tonClient.broadcastMessage(
//       networkId: networkId,
//       from: from,
//       validUntil: validUntil,
//       messages: messages,
//       keyPair: keyPair,
//     );
//   }
// }
