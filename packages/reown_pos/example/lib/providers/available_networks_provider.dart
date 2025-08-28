// import 'package:example/models/available_network.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:reown_pos/models/pos_models.dart';

// final availableNetworksProvider =
//     StateNotifierProvider<NetworkListNotifier, List<AvailableNetwork>>(
//       (ref) => NetworkListNotifier(),
//     );

// class NetworkListNotifier extends StateNotifier<List<AvailableNetwork>> {
//   NetworkListNotifier()
//     : super([
//         const AvailableNetwork(
//           index: 1,
//           color: Colors.black,
//           network: PosNetwork.ethereum,
//         ),
//         const AvailableNetwork(
//           index: 2,
//           color: Colors.blue,
//           network: PosNetwork.base,
//         ),
//         const AvailableNetwork(
//           index: 3,
//           color: Colors.white,
//           network: PosNetwork.arbitrum,
//         ),
//       ]);

//   void select(String id) {
//     state = [
//       for (final network in state)
//         network.copyWith(selected: network.network.networkData.chainId == id),
//     ];
//   }
// }
