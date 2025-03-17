import 'package:flutter/material.dart';
import 'package:reown_walletkit_wallet/models/chain_metadata.dart';

class ChainsDataList {
  static final List<ChainMetadata> eip155Chains = [
    ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:1',
      name: 'Ethereum',
      logo: 'https://cryptologos.cc/logos/ethereum-eth-logo.png',
      color: Colors.blue.shade300,
      rpc: ['https://eth.drpc.org'],
    ),
    ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:137',
      name: 'Polygon',
      logo: 'https://cryptologos.cc/logos/polygon-matic-logo.png',
      color: Colors.purple.shade300,
      rpc: ['https://polygon-rpc.com/'],
    ),
    const ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:42161',
      name: 'Arbitrum',
      logo: 'https://cryptologos.cc/logos/arbitrum-arb-logo.png',
      color: Colors.blue,
      rpc: ['https://arbitrum.blockpi.network/v1/rpc/public'],
    ),
    const ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:10',
      name: 'OP Mainnet',
      logo: 'https://cryptologos.cc/logos/optimism-ethereum-op-logo.png',
      color: Colors.red,
      rpc: ['https://mainnet.optimism.io/'],
    ),
    const ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:8453',
      name: 'Base',
      logo:
          'https://images.mirror-media.xyz/publication-images/cgqxxPdUFBDjgKna_dDir.png',
      color: Colors.lightBlue,
      rpc: ['https://mainnet.base.org'],
    ),
    const ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:43114',
      name: 'Avalanche',
      logo: 'https://cryptologos.cc/logos/avalanche-avax-logo.png',
      color: Colors.orange,
      rpc: ['https://api.avax.network/ext/bc/C/rpc'],
    ),
    const ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:56',
      name: 'BNB Smart Chain',
      logo: 'https://cryptologos.cc/logos/bnb-bnb-logo.png',
      color: Colors.orange,
      rpc: ['https://bsc-dataseed1.bnbchain.org'],
    ),
    const ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:42220',
      name: 'Celo',
      logo: 'https://cryptologos.cc/logos/celo-celo-logo.png',
      color: Colors.green,
      rpc: ['https://forno.celo.org/'],
    ),
    const ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:100',
      name: 'Gnosis',
      logo: 'https://cryptologos.cc/logos/gnosis-gno-gno-logo.png',
      color: Colors.greenAccent,
      rpc: ['https://rpc.gnosischain.com/'],
    ),
    const ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:324',
      name: 'zkSync',
      logo: 'https://avatars.githubusercontent.com/u/179229932?s=200&v=4',
      color: Colors.black,
      rpc: ['https://mainnet.era.zksync.io'],
    ),
    ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:11155111',
      name: 'Eth Sepolia',
      logo: 'https://avatars.githubusercontent.com/u/179229932?s=200&v=4',
      color: Colors.blue.shade300,
      isTestnet: true,
      rpc: ['https://ethereum-sepolia.publicnode.com'],
    ),
    ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:84531',
      name: 'Base Sepolia',
      logo: 'https://avatars.githubusercontent.com/u/179229932?s=200&v=4',
      color: Colors.blue.shade300,
      isTestnet: true,
      rpc: ['https://sepolia.base.org'],
    ),
    ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:80001',
      name: 'Polygon Mumbai',
      logo: 'https://avatars.githubusercontent.com/u/179229932?s=200&v=4',
      color: Colors.purple.shade300,
      isTestnet: true,
      rpc: ['https://matic-mumbai.chainstacklabs.com'],
    ),
  ];

  static final List<ChainMetadata> solanaChains = [
    const ChainMetadata(
      type: ChainType.solana,
      chainId: 'solana:5eykt4UsFv8P8NJdTREpY1vzqKqZKvdp',
      name: 'Solana',
      logo: 'https://cryptologos.cc/logos/solana-sol-logo.png',
      color: Color.fromARGB(255, 247, 0, 255),
      rpc: ['https://api.mainnet-beta.solana.com'],
    ),
    const ChainMetadata(
      type: ChainType.solana,
      chainId: 'solana:EtWTRABZaYq6iMfeYKouRu166VU2xqa1',
      name: 'Solana Devnet',
      logo: 'https://avatars.githubusercontent.com/u/179229932?s=200&v=4',
      color: Color.fromARGB(255, 247, 0, 255),
      rpc: ['https://api.devnet.solana.com'],
    ),
    const ChainMetadata(
      type: ChainType.solana,
      chainId: 'solana:4uhcVJyU9pJkvQyS88uRDiswHXSCkY3z',
      name: 'Solana Testnet',
      logo: 'https://avatars.githubusercontent.com/u/179229932?s=200&v=4',
      color: Colors.black,
      isTestnet: true,
      rpc: ['https://api.testnet.solana.com'],
    ),
  ];

  static final List<ChainMetadata> cosmosChains = [
    // TODO TO BE SUPPORTED
    const ChainMetadata(
      type: ChainType.cosmos,
      chainId: 'cosmos:cosmoshub-4',
      name: 'Cosmos Mainnet',
      logo: 'https://cryptologos.cc/logos/cosmos-atom-logo.png',
      color: Colors.purple,
      rpc: [
        'https://cosmos-rpc.polkachu.com:443',
        'https://rpc-cosmoshub-ia.cosmosia.notional.ventures:443',
        'https://rpc.cosmos.network:443',
      ],
    ),
  ];

  static final List<ChainMetadata> kadenaChains = [
    const ChainMetadata(
      type: ChainType.kadena,
      chainId: 'kadena:mainnet01',
      name: 'Kadena Mainnet',
      logo: 'https://avatars.githubusercontent.com/u/179229932?s=200&v=4',
      color: Colors.green,
      rpc: [
        'https://api.chainweb.com',
      ],
    ),
    const ChainMetadata(
      type: ChainType.kadena,
      chainId: 'kadena:testnet04',
      name: 'Kadena Testnet',
      logo: 'https://avatars.githubusercontent.com/u/179229932?s=200&v=4',
      color: Colors.green,
      isTestnet: true,
      rpc: [
        'https://api.chainweb.com',
      ],
    ),
  ];

  static final List<ChainMetadata> polkadotChains = [
    const ChainMetadata(
      type: ChainType.polkadot,
      chainId: 'polkadot:91b171bb158e2d3848fa23a9f1c25182',
      name: 'Polkadot Mainnet',
      logo: 'https://avatars.githubusercontent.com/u/179229932?s=200&v=4',
      color: Color.fromARGB(255, 174, 57, 220),
      rpc: [
        'wss://rpc.polkadot.io',
        // 'wss://rpc.matrix.canary.enjin.io'
      ],
    ),
    const ChainMetadata(
      type: ChainType.polkadot,
      chainId: 'polkadot:e143f23803ac50e8f6f8e62695d1ce9e',
      name: 'Polkadot Testnet (Westend)',
      logo: 'https://avatars.githubusercontent.com/u/179229932?s=200&v=4',
      color: Color.fromARGB(255, 174, 57, 220),
      isTestnet: true,
      rpc: [
        'wss://westend-rpc.polkadot.io',
      ],
    ),
  ];
}
