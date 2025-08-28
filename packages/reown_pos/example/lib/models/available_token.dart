import 'package:flutter/material.dart';
import 'package:reown_pos/models/pos_models.dart';

class AvailableToken {
  final int index;
  final Color color;
  final PosToken token;
  final bool selected;

  const AvailableToken({
    required this.index,
    required this.color,
    required this.token,
    this.selected = false,
  });

  AvailableToken copyWith({bool? selected}) {
    return AvailableToken(
      index: index,
      color: color,
      token: token,
      selected: selected ?? this.selected,
    );
  }
}
