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
        AvailableToken(
          index: 1,
          color: Colors.blue,
          posToken: PosToken(
            network: SupportedNetwork.ethereum.posNetwork,
            symbol: 'USDC',
            standard: 'erc20',
            address: '0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48',
          ),
          selected: false,
        ),
        // USDT on ETHEREUM
        AvailableToken(
          index: 2,
          color: Colors.green,
          posToken: PosToken(
            network: SupportedNetwork.ethereum.posNetwork,
            symbol: 'USDT',
            standard: 'erc20',
            address: '0xdAC17F958D2ee523a2206206994597C13D831ec7',
          ),
          selected: false,
        ),
        // USDC on ARBITRUM
        AvailableToken(
          index: 3,
          color: Colors.blue,
          posToken: PosToken(
            network: SupportedNetwork.arbitrum.posNetwork,
            symbol: 'USDC',
            standard: 'erc20',
            address: '0xaf88d065e77c8cC2239327C5EDb3A432268e5831',
          ),
          selected: false,
        ),
        // USDC on BASE
        AvailableToken(
          index: 4,
          color: Colors.blue,
          posToken: PosToken(
            network: SupportedNetwork.base.posNetwork,
            symbol: 'USDC',
            standard: 'erc20',
            address: '0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913',
          ),
          selected: false,
        ),
        // USDC on SEPOLIA
        AvailableToken(
          index: 4,
          color: Colors.blue,
          posToken: PosToken(
            network: SupportedNetwork.sepolia.posNetwork,
            symbol: 'USDC',
            standard: 'erc20',
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

enum SupportedNetwork {
  ethereum,
  polygon,
  binanceSmartChain,
  avalanche,
  arbitrum,
  optimism,
  base,
  fantom,
  cronos,
  polygonZkEVM,
  sepolia,
  gnosis,
  zkSyncEra,
  mantle,
  klaytn,
  celo,
  linea,
  baseSepolia;

  PosNetwork get posNetwork {
    switch (this) {
      case SupportedNetwork.ethereum:
        return PosNetwork(name: 'Ethereum', chainId: 'eip155:1');
      case SupportedNetwork.polygon:
        return PosNetwork(name: 'Polygon', chainId: 'eip155:137');
      case SupportedNetwork.binanceSmartChain:
        return PosNetwork(name: 'BNB Smart Chain', chainId: 'eip155:56');
      case SupportedNetwork.avalanche:
        return PosNetwork(name: 'Avalanche', chainId: 'eip155:43114');
      case SupportedNetwork.arbitrum:
        return PosNetwork(name: 'Arbitrum One', chainId: 'eip155:42161');
      case SupportedNetwork.optimism:
        return PosNetwork(name: 'Optimism', chainId: 'eip155:10');
      case SupportedNetwork.base:
        return PosNetwork(name: 'Base', chainId: 'eip155:8453');
      case SupportedNetwork.fantom:
        return PosNetwork(name: 'Fantom', chainId: 'eip155:250');
      case SupportedNetwork.cronos:
        return PosNetwork(name: 'Cronos', chainId: 'eip155:25');
      case SupportedNetwork.polygonZkEVM:
        return PosNetwork(name: 'Polygon zkEVM', chainId: 'eip155:1101');
      case SupportedNetwork.sepolia:
        return PosNetwork(name: 'Sepolia ETH', chainId: 'eip155:11155111');
      case SupportedNetwork.gnosis:
        return PosNetwork(name: 'Gnosis Chain', chainId: 'eip155:100');
      case SupportedNetwork.zkSyncEra:
        return PosNetwork(name: 'zkSync Era', chainId: 'eip155:324');
      case SupportedNetwork.mantle:
        return PosNetwork(name: 'Mantle', chainId: 'eip155:5000');
      case SupportedNetwork.klaytn:
        return PosNetwork(name: 'Klaytn Mainnet', chainId: 'eip155:8217');
      case SupportedNetwork.celo:
        return PosNetwork(name: 'Celo', chainId: 'eip155:42220');
      case SupportedNetwork.linea:
        return PosNetwork(name: 'Linea', chainId: 'eip155:59144');
      case SupportedNetwork.baseSepolia:
        return PosNetwork(name: 'Base Sepolia', chainId: 'eip155:84531');
    }
  }
}
