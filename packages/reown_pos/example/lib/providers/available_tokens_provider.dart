import 'package:example/models/available_token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reown_pos/models/pos_models.dart';

final availableTokensProvider =
    StateNotifierProvider<TokenListNotifier, List<AvailableToken>>(
      (ref) => TokenListNotifier(),
    );

class TokenListNotifier extends StateNotifier<List<AvailableToken>> {
  TokenListNotifier()
    : super([
        // USDC on ETHEREUM
        const AvailableToken(
          index: 1,
          color: Colors.blue,
          token: PosToken(
            network: PosNetwork.ethereum,
            symbol: 'USDC',
            address: '0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48',
          ),
          selected: false,
        ),
        // USDT on ETHEREUM
        const AvailableToken(
          index: 2,
          color: Colors.green,
          token: PosToken(
            network: PosNetwork.ethereum,
            symbol: 'USDT',
            address: '0xdAC17F958D2ee523a2206206994597C13D831ec7',
          ),
          selected: false,
        ),
        // USDC on ARBITRUM
        const AvailableToken(
          index: 3,
          color: Colors.blue,
          token: PosToken(
            network: PosNetwork.arbitrum,
            symbol: 'USDC',
            address: '0xaf88d065e77c8cC2239327C5EDb3A432268e5831',
          ),
          selected: false,
        ),
        // USDC on BASE
        const AvailableToken(
          index: 4,
          color: Colors.blue,
          token: PosToken(
            network: PosNetwork.base,
            symbol: 'USDC',
            address: '0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913',
          ),
          selected: false,
        ),
        // USDC on SEPOLIA
        const AvailableToken(
          index: 4,
          color: Colors.blue,
          token: PosToken(
            network: PosNetwork.sepolia,
            symbol: 'USDC',
            address: '0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238',
          ),
          selected: false,
        ),
      ]);

  void select(AvailableToken selected) {
    state = [
      for (final token in state)
        token.copyWith(selected: token.index == selected.index),
    ];
  }
}
