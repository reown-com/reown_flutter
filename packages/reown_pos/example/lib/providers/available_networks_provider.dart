import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NetworkListNotifier extends StateNotifier<List<AvailableNetwork>> {
  NetworkListNotifier()
    : super([
        const AvailableNetwork(
          color: Colors.black,
          name: 'Ethereum',
          fee: '\$2.50',
          id: 'eip155:11155111',
        ),
        const AvailableNetwork(
          color: Colors.blue,
          name: 'Base',
          fee: '\$0.05',
          id: 'eip155:8453',
        ),
        const AvailableNetwork(
          color: Colors.white,
          name: 'Arbitrum',
          fee: '\$0.01',
          id: 'eip155:42161',
        ),
      ]);

  void select(String id) {
    state = [
      for (final network in state) network.copyWith(selected: network.id == id),
    ];
  }
}

final availableNetworksProvider =
    StateNotifierProvider<NetworkListNotifier, List<AvailableNetwork>>(
      (ref) => NetworkListNotifier(),
    );

class AvailableNetwork {
  final Color color;
  final String name;
  final String fee;
  final String id;
  final bool selected;

  const AvailableNetwork({
    required this.color,
    required this.name,
    required this.fee,
    required this.id,
    this.selected = false,
  });

  AvailableNetwork copyWith({bool? selected}) {
    return AvailableNetwork(
      color: color,
      name: name,
      fee: fee,
      id: id,
      selected: selected ?? this.selected,
    );
  }
}
