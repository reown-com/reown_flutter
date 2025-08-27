import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TokenListNotifier extends StateNotifier<List<AvailableToken>> {
  TokenListNotifier()
    : super([
        const AvailableToken(Colors.green, 'USDC Coin', 'usdc', false),
        const AvailableToken(Colors.orange, 'DAI Stablecoin', 'dai', false),
        const AvailableToken(Colors.blue, 'Tether', 'usdt', false),
        const AvailableToken(Colors.blue, 'ETH Sep', 'eth', false),
      ]);

  void select(String symbol) {
    state = [
      for (final token in state)
        token.copyWith(selected: token.symbol == symbol),
    ];
  }
}

final availableTokensProvider =
    StateNotifierProvider<TokenListNotifier, List<AvailableToken>>(
      (ref) => TokenListNotifier(),
    );

class AvailableToken {
  final Color color;
  final String name;
  final String symbol;
  final bool selected;

  const AvailableToken(this.color, this.name, this.symbol, this.selected);

  AvailableToken copyWith({bool? selected}) {
    return AvailableToken(color, name, symbol, selected ?? this.selected);
  }
}
