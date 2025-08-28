import 'package:flutter/material.dart';
import 'package:reown_pos/models/pos_models.dart';

class AvailableNetwork {
  final int index;
  final Color color;
  final PosNetwork network;
  final bool selected;

  const AvailableNetwork({
    required this.index,
    required this.color,
    required this.network,
    this.selected = false,
  });

  AvailableNetwork copyWith({bool? selected}) {
    return AvailableNetwork(
      index: index,
      color: color,
      network: network,
      selected: selected ?? this.selected,
    );
  }
}
