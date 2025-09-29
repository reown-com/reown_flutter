import 'package:flutter/material.dart';
import 'package:pos_client/models/pos_models.dart';

class AvailableToken {
  final int index;
  final Color color;
  final PosToken posToken;
  final bool selected;

  const AvailableToken({
    required this.index,
    required this.color,
    required this.posToken,
    this.selected = false,
  });

  AvailableToken copyWith({bool? selected}) {
    return AvailableToken(
      index: index,
      color: color,
      posToken: posToken,
      selected: selected ?? this.selected,
    );
  }
}
