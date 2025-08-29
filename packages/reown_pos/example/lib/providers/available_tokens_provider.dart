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
        // USDC on SEPOLIA
        AvailableToken(
          index: 4,
          color: Colors.blue,
          posToken: PosToken(
            network: SupportedPosNetwork.sepolia.networkData,
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

enum SupportedPosNetwork {
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

  PosNetwork get networkData {
    switch (this) {
      case SupportedPosNetwork.ethereum:
        return PosNetwork(name: 'Ethereum', chainId: 'eip155:1');
      case SupportedPosNetwork.polygon:
        return PosNetwork(name: 'Polygon', chainId: 'eip155:137');
      case SupportedPosNetwork.binanceSmartChain:
        return PosNetwork(name: 'BNB Smart Chain', chainId: 'eip155:56');
      case SupportedPosNetwork.avalanche:
        return PosNetwork(name: 'Avalanche', chainId: 'eip155:43114');
      case SupportedPosNetwork.arbitrum:
        return PosNetwork(name: 'Arbitrum One', chainId: 'eip155:42161');
      case SupportedPosNetwork.optimism:
        return PosNetwork(name: 'Optimism', chainId: 'eip155:10');
      case SupportedPosNetwork.base:
        return PosNetwork(name: 'Base', chainId: 'eip155:8453');
      case SupportedPosNetwork.fantom:
        return PosNetwork(name: 'Fantom', chainId: 'eip155:250');
      case SupportedPosNetwork.cronos:
        return PosNetwork(name: 'Cronos', chainId: 'eip155:25');
      case SupportedPosNetwork.polygonZkEVM:
        return PosNetwork(name: 'Polygon zkEVM', chainId: 'eip155:1101');
      case SupportedPosNetwork.sepolia:
        return PosNetwork(name: 'Sepolia ETH', chainId: 'eip155:11155111');
      case SupportedPosNetwork.gnosis:
        return PosNetwork(name: 'Gnosis Chain', chainId: 'eip155:100');
      case SupportedPosNetwork.zkSyncEra:
        return PosNetwork(name: 'zkSync Era', chainId: 'eip155:324');
      case SupportedPosNetwork.mantle:
        return PosNetwork(name: 'Mantle', chainId: 'eip155:5000');
      case SupportedPosNetwork.klaytn:
        return PosNetwork(name: 'Klaytn Mainnet', chainId: 'eip155:8217');
      case SupportedPosNetwork.celo:
        return PosNetwork(name: 'Celo', chainId: 'eip155:42220');
      case SupportedPosNetwork.linea:
        return PosNetwork(name: 'Linea', chainId: 'eip155:59144');
      case SupportedPosNetwork.baseSepolia:
        return PosNetwork(name: 'Base Sepolia', chainId: 'eip155:84531');
    }
  }
}
