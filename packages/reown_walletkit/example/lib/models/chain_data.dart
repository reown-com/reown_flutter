import 'package:flutter/material.dart';
import 'package:reown_walletkit_wallet/models/chain_metadata.dart';

class ChainsDataList {
  // https://github.com/reown-com/blockchain-api/blob/master/SUPPORTED_CHAINS.md

  static final List<ChainMetadata> eip155Chains = [
    ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:1',
      name: 'Ethereum',
      currency: 'ETH',
      logo:
          'https://pbs.twimg.com/profile_images/1878738447067652096/tXQbWfpf_400x400.jpg',
      color: Colors.blue.shade300,
      rpc: [
        'https://rpc.walletconnect.org/v1',
      ],
    ),
    ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:137',
      name: 'Polygon',
      currency: 'POL',
      logo:
          'https://pbs.twimg.com/profile_images/1947285584679936001/x0yfJ9e__400x400.jpg',
      color: Colors.purple.shade300,
      rpc: [
        'https://rpc.walletconnect.org/v1',
      ],
    ),
    ...chainAbstraction,
    const ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:43114',
      name: 'Avalanche',
      currency: 'AVAX',
      logo:
          'https://pbs.twimg.com/profile_images/1970156760116944897/06WZz7t4_400x400.jpg',
      color: Colors.orange,
      rpc: [
        'https://rpc.walletconnect.org/v1',
      ],
    ),
    const ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:56',
      name: 'BNB Smart Chain',
      currency: 'BNB',
      logo:
          'https://pbs.twimg.com/profile_images/1876286110071975936/HvkhyFZg_400x400.jpg',
      color: Colors.orange,
      rpc: [
        'https://rpc.walletconnect.org/v1',
      ],
    ),
    const ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:42220',
      name: 'Celo',
      currency: 'CELO',
      logo:
          'https://pbs.twimg.com/profile_images/1613170131491848195/InjXBNx9_400x400.jpg',
      color: Colors.green,
      rpc: [
        'https://rpc.walletconnect.org/v1',
      ],
    ),
    const ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:100',
      name: 'Gnosis',
      currency: 'XDAI',
      logo:
          'https://pbs.twimg.com/profile_images/1846528977428480001/h_MlabDj_400x400.jpg',
      color: Colors.greenAccent,
      rpc: [
        'https://rpc.walletconnect.org/v1',
      ],
    ),
    const ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:324',
      name: 'zkSync',
      currency: 'ETH',
      logo:
          'https://pbs.twimg.com/profile_images/1835668010951950336/Aq1Kg1p0_400x400.jpg',
      color: Colors.black,
      rpc: [
        'https://rpc.walletconnect.org/v1',
      ],
    ),
    ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:11155111',
      name: 'Eth Sepolia',
      currency: 'ETH',
      logo: 'https://avatars.githubusercontent.com/u/179229932?s=200&v=4',
      color: const Color.fromARGB(255, 0, 0, 0),
      isTestnet: true,
      rpc: [
        'https://rpc.walletconnect.org/v1',
      ],
    ),
    ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:84531',
      name: 'Base Sepolia',
      currency: 'ETH',
      logo: 'https://avatars.githubusercontent.com/u/179229932?s=200&v=4',
      color: const Color.fromARGB(255, 0, 0, 0),
      isTestnet: true,
      rpc: ['https://sepolia.base.org'],
    ),
    ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:80001',
      name: 'Polygon Mumbai',
      currency: 'MATIC',
      logo: 'https://avatars.githubusercontent.com/u/179229932?s=200&v=4',
      color: const Color.fromARGB(255, 0, 0, 0),
      isTestnet: true,
      rpc: ['https://matic-mumbai.chainstacklabs.com'],
    ),
  ];

  static final List<ChainMetadata> chainAbstraction = [
    const ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:42161',
      name: 'Arbitrum',
      currency: 'ETH',
      logo:
          'https://pbs.twimg.com/profile_images/1952411676621295616/KUOmiy3l_400x400.jpg',
      color: Colors.blue,
      rpc: [
        'https://rpc.walletconnect.org/v1',
      ],
    ),
    const ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:10',
      name: 'OP Mainnet',
      currency: 'ETH',
      logo:
          'https://pbs.twimg.com/profile_images/1734354549496836096/-laoU9C9_400x400.jpg',
      color: Colors.red,
      rpc: [
        'https://rpc.walletconnect.org/v1',
      ],
    ),
    const ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:8453',
      name: 'Base',
      currency: 'ETH',
      logo:
          'https://pbs.twimg.com/profile_images/1840800810571350019/1pCjLY5q_400x400.jpg',
      color: Colors.lightBlue,
      rpc: [
        'https://rpc.walletconnect.org/v1',
      ],
    ),
  ];

  static final List<ChainMetadata> solanaChains = [
    const ChainMetadata(
      type: ChainType.solana,
      chainId: 'solana:5eykt4UsFv8P8NJdTREpY1vzqKqZKvdp',
      name: 'Solana',
      currency: 'SOL',
      logo:
          'https://pbs.twimg.com/profile_images/1472933274209107976/6u-LQfjG_400x400.jpg',
      color: Color.fromARGB(255, 247, 0, 255),
      rpc: [
        'https://rpc.walletconnect.org/v1',
      ],
    ),
    const ChainMetadata(
      type: ChainType.solana,
      chainId: 'solana:EtWTRABZaYq6iMfeYKouRu166VU2xqa1',
      name: 'Solana Devnet',
      currency: 'SOL',
      logo: 'https://avatars.githubusercontent.com/u/179229932?s=200&v=4',
      color: Color.fromARGB(255, 247, 0, 255),
      rpc: [
        'https://rpc.walletconnect.org/v1',
      ],
    ),
    const ChainMetadata(
      type: ChainType.solana,
      chainId: 'solana:4uhcVJyU9pJkvQyS88uRDiswHXSCkY3z',
      name: 'Solana Testnet',
      currency: 'SOL',
      logo: 'https://avatars.githubusercontent.com/u/179229932?s=200&v=4',
      color: Colors.black,
      isTestnet: true,
      rpc: [
        'https://rpc.walletconnect.org/v1',
      ],
    ),
  ];

  static final List<ChainMetadata> bitcoinChains = [
    const ChainMetadata(
      type: ChainType.bitcoin,
      chainId: 'bip122:000000000019d6689c085ae165831e93',
      name: 'Bitcoin Mainnet',
      currency: 'BTC',
      logo: 'https://cryptologos.cc/logos/bitcoin-btc-logo.png?v=040',
      color: Color.fromARGB(255, 255, 157, 0),
      rpc: [
        'https://rpc.walletconnect.org/v1',
      ],
    ),
    const ChainMetadata(
      type: ChainType.bitcoin,
      chainId: 'bip122:000000000933ea01ad0ee984209779ba',
      name: 'Bitcoin Testnet',
      currency: 'BTC',
      logo: 'https://cryptologos.cc/logos/bitcoin-btc-logo.png?v=040',
      color: Color.fromARGB(255, 255, 157, 0),
      rpc: [
        'https://rpc.walletconnect.org/v1',
      ],
      isTestnet: true,
    ),
  ];

  static final List<ChainMetadata> cosmosChains = [
    // TODO TO BE SUPPORTED
    const ChainMetadata(
      type: ChainType.cosmos,
      chainId: 'cosmos:cosmoshub-4',
      name: 'Cosmos Mainnet',
      currency: 'ATOM',
      logo:
          'https://pbs.twimg.com/profile_images/1910273399282159616/OLSiIjEx_400x400.png',
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
      currency: 'KDA',
      logo:
          'https://pbs.twimg.com/profile_images/1820556208455172096/PQHyA3TU_400x400.jpg',
      color: Colors.green,
      rpc: [
        'https://api.chainweb.com',
      ],
    ),
    const ChainMetadata(
      type: ChainType.kadena,
      chainId: 'kadena:testnet04',
      name: 'Kadena Testnet',
      currency: 'KDA',
      logo:
          'https://pbs.twimg.com/profile_images/1820556208455172096/PQHyA3TU_400x400.jpg',
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
      currency: 'DOT',
      logo:
          'https://pbs.twimg.com/profile_images/1944665239502323712/0FMaAZ31_400x400.jpg',
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
      currency: 'DOT',
      logo:
          'https://pbs.twimg.com/profile_images/1944665239502323712/0FMaAZ31_400x400.jpg',
      color: Color.fromARGB(255, 174, 57, 220),
      isTestnet: true,
      rpc: [
        'wss://westend-asset-hub-rpc.polkadot.io',
      ],
    ),
  ];

  static final List<ChainMetadata> tronChains = [
    const ChainMetadata(
      type: ChainType.tron,
      chainId: 'tron:0x2b6653dc',
      name: 'Tron Mainnet',
      currency: 'TRX',
      logo:
          'https://pbs.twimg.com/profile_images/1970541264568520704/J6wYDxYk_400x400.jpg',
      color: Color.fromARGB(255, 223, 0, 0),
      rpc: [
        'https://rpc.walletconnect.org/v1',
      ],
    ),
    const ChainMetadata(
      type: ChainType.tron,
      chainId: 'tron:0xcd8690dc',
      name: 'Tron Nile',
      currency: 'TRX',
      logo:
          'https://pbs.twimg.com/profile_images/1970541264568520704/J6wYDxYk_400x400.jpg',
      color: Color.fromARGB(255, 223, 0, 0),
      rpc: [
        'https://nile.trongrid.io',
      ],
      isTestnet: true,
    ),
  ];

  static final List<ChainMetadata> tonChains = [
    const ChainMetadata(
      type: ChainType.ton,
      chainId: 'ton:-239',
      name: 'Ton Mainnet',
      currency: 'TON',
      logo:
          'https://pbs.twimg.com/profile_images/1931243733439115264/HfLnjCPR_400x400.jpg',
      color: Color.fromARGB(255, 48, 207, 255),
      rpc: [
        'https://rpc.walletconnect.org/v1',
      ],
    ),
    // const ChainMetadata(
    //   type: ChainType.ton,
    //   chainId: 'ton:-3',
    //   name: 'Ton Testnet',
    //   logo:
    //       'https://pbs.twimg.com/profile_images/1931243733439115264/HfLnjCPR_400x400.jpg',
    //   color: Color.fromARGB(255, 48, 207, 255),
    //   rpc: [
    //     'https://rpc.walletconnect.org/v1',
    //   ],
    //   isTestnet: true,
    // ),
  ];

  static final List<ChainMetadata> stacksChains = [
    const ChainMetadata(
      type: ChainType.stacks,
      chainId: 'stacks:1',
      name: 'Stacks Mainnet',
      currency: 'STX',
      logo:
          'https://pbs.twimg.com/profile_images/1764968185399267328/lrmnHOuN_400x400.jpg',
      color: Colors.orange,
      rpc: [
        'https://rpc.walletconnect.org/v1',
      ],
    ),
    const ChainMetadata(
      type: ChainType.stacks,
      chainId: 'stacks:2147483648',
      name: 'Stacks Testnet',
      currency: 'STX',
      logo:
          'https://pbs.twimg.com/profile_images/1764968185399267328/lrmnHOuN_400x400.jpg',
      color: Colors.orange,
      rpc: [
        'https://rpc.walletconnect.org/v1',
      ],
      isTestnet: true,
    ),
  ];

  static final List<ChainMetadata> suiChains = [
    const ChainMetadata(
      type: ChainType.sui,
      chainId: 'sui:mainnet',
      name: 'Sui Mainnet',
      currency: 'SUI',
      logo:
          'https://pbs.twimg.com/profile_images/1966183924880572416/__KrQPZP_400x400.jpg',
      color: Colors.blue,
      rpc: ['https://fullnode.mainnet.sui.io:443'],
    ),
    const ChainMetadata(
      type: ChainType.sui,
      chainId: 'sui:testnet',
      name: 'Sui Testnet',
      currency: 'SUI',
      logo:
          'https://pbs.twimg.com/profile_images/1966183924880572416/__KrQPZP_400x400.jpg',
      color: Colors.blue,
      rpc: [
        'https://rpc.walletconnect.org/v1',
      ],
      isTestnet: true,
    ),
    const ChainMetadata(
      type: ChainType.sui,
      chainId: 'sui:devnet',
      name: 'Sui Devnet',
      currency: 'SUI',
      logo:
          'https://pbs.twimg.com/profile_images/1928528183466373120/4xpp6RSr_400x400.jpg',
      color: Colors.blue,
      rpc: [
        'https://rpc.walletconnect.org/v1',
      ],
      isTestnet: true,
    ),
  ];

  static final List<ChainMetadata> allChains = [
    ...eip155Chains,
    ...chainAbstraction,
    ...solanaChains,
    ...bitcoinChains,
    ...cosmosChains,
    ...kadenaChains,
    ...polkadotChains,
    ...tronChains,
    ...tonChains,
    ...stacksChains,
    ...suiChains,
  ];
}
