import 'package:collection/collection.dart';
import 'package:reown_appkit/modal/models/public/appkit_network_info.dart';

class AppKitModalNetworks {
  // https://github.com/WalletConnect/blockchain-api/blob/master/SUPPORTED_CHAINS.md
  static Map<String, List<AppKitModalNetworkInfo>> supported = {
    'eip155': [
      AppKitModalNetworkInfo(
        name: 'Ethereum',
        chainId: '1',
        chainIcon: chainImagesId['1'],
        currency: 'ETH',
        rpcUrl: 'https://ethereum-rpc.publicnode.com',
        explorerUrl: 'https://etherscan.io',
      ),
      AppKitModalNetworkInfo(
        name: 'Optimism',
        chainId: '10',
        chainIcon: chainImagesId['10'],
        currency: 'ETH',
        rpcUrl: 'https://mainnet.optimism.io/',
        explorerUrl: 'https://optimistic.etherscan.io',
      ),
      AppKitModalNetworkInfo(
        name: 'Binance Smart Chain',
        chainId: '56',
        chainIcon: chainImagesId['56'],
        currency: 'BNB',
        rpcUrl: 'https://bsc-dataseed.binance.org/',
        explorerUrl: 'https://bscscan.com',
      ),
      AppKitModalNetworkInfo(
        name: 'Gnosis Chain',
        chainId: '100',
        chainIcon: chainImagesId['100'],
        currency: 'xDAI',
        rpcUrl: 'https://rpc.gnosischain.com',
        explorerUrl: 'https://gnosis.blockscout.com',
      ),
      AppKitModalNetworkInfo(
        name: 'Polygon',
        chainId: '137',
        chainIcon: chainImagesId['137'],
        currency: 'MATIC',
        rpcUrl: 'https://polygon.drpc.org',
        explorerUrl: 'https://polygonscan.com',
      ),
      AppKitModalNetworkInfo(
        name: 'zkSync Era',
        chainId: '324',
        chainIcon: chainImagesId['324'],
        currency: 'ETH',
        rpcUrl: 'https://mainnet.era.zksync.io',
        explorerUrl: 'https://explorer.zksync.io',
      ),
      AppKitModalNetworkInfo(
        name: 'Polygon zkEVM',
        chainId: '1101',
        chainIcon: chainImagesId['1101'],
        currency: 'ETH',
        rpcUrl: 'https://rpc-mainnet.matic.network',
        explorerUrl: 'https://explorer-evm.polygon.technology',
      ),
      AppKitModalNetworkInfo(
        name: 'Mantle',
        chainId: '5000',
        chainIcon: chainImagesId['5000'],
        currency: 'BIT',
        rpcUrl: 'https://rpc.mantlenetwork.io',
        explorerUrl: 'https://explorer.mantlenetwork.io',
      ),
      AppKitModalNetworkInfo(
        name: 'Klaytn Mainnet',
        chainId: '8217',
        chainIcon: chainImagesId['8217'],
        currency: 'KLAY',
        rpcUrl: 'https://public-node-api.klaytnapi.com/v1/cypress',
        explorerUrl: 'https://scope.klaytn.com',
      ),
      AppKitModalNetworkInfo(
        name: 'Base',
        chainId: '8453',
        chainIcon: chainImagesId['8453'],
        currency: 'ETH',
        rpcUrl: 'https://mainnet.base.org',
        explorerUrl: 'https://basescan.org',
      ),
      AppKitModalNetworkInfo(
        name: 'Arbitrum',
        chainId: '42161',
        chainIcon: chainImagesId['42161'],
        currency: 'ETH',
        rpcUrl: 'https://arbitrum.blockpi.network/v1/rpc/public',
        explorerUrl: 'https://arbiscan.io/',
      ),
      AppKitModalNetworkInfo(
        name: 'Celo',
        chainId: '42220',
        chainIcon: chainImagesId['42220'],
        currency: 'CELO',
        rpcUrl: 'https://forno.celo.org',
        explorerUrl: 'https://explorer.celo.org/mainnet',
      ),
      AppKitModalNetworkInfo(
        name: 'Avalanche',
        chainId: '43114',
        chainIcon: chainImagesId['43114'],
        currency: 'AVAX',
        rpcUrl: 'https://api.avax.network/ext/bc/C/rpc',
        explorerUrl: 'https://snowtrace.io',
      ),
      AppKitModalNetworkInfo(
        name: 'Linea',
        chainId: '59144',
        chainIcon: chainImagesId['59144'],
        currency: 'ETH',
        rpcUrl: 'https://rpc.linea.build',
        explorerUrl: 'https://explorer.linea.build',
      ),
      AppKitModalNetworkInfo(
        name: 'Zora',
        chainId: '7777777',
        chainIcon: chainImagesId['7777777'],
        currency: 'ETH',
        rpcUrl: 'https://rpc.zora.energy',
        explorerUrl: 'https://explorer.zora.energy',
      ),
      AppKitModalNetworkInfo(
        name: 'Aurora',
        chainId: '1313161554',
        chainIcon: chainImagesId['1313161554'],
        currency: 'ETH',
        rpcUrl: 'https://mainnet.aurora.dev',
        explorerUrl: 'https://explorer.aurora.dev',
      ),
    ],
  };

  static Map<String, List<AppKitModalNetworkInfo>> extra = {
    'eip155': [
      AppKitModalNetworkInfo(
        name: 'Fantom',
        chainId: '250',
        chainIcon: chainImagesId['250'],
        currency: 'FTM',
        rpcUrl: 'https://rpc.ftm.tools/',
        explorerUrl: 'https://ftmscan.com',
      ),
      AppKitModalNetworkInfo(
        name: 'EVMos',
        chainId: '9001',
        chainIcon: chainImagesId['9001'],
        currency: 'EVMOS',
        rpcUrl: 'https://evmos-evm.publicnode.com',
        explorerUrl: '',
      ),
      AppKitModalNetworkInfo(
        name: 'Iotx',
        chainId: '4689',
        chainIcon: chainImagesId['4689'],
        currency: 'IOTX',
        rpcUrl: 'https://rpc.ankr.com/iotex',
        explorerUrl: 'https://iotexscan.io',
      ),
      AppKitModalNetworkInfo(
        name: 'Metis',
        chainId: '1088',
        chainIcon: chainImagesId['1088'],
        currency: 'METIS',
        rpcUrl: 'https://metis-mainnet.public.blastapi.io',
        explorerUrl: 'https://andromeda-explorer.metis.io',
      ),
    ]
  };

  static Map<String, List<AppKitModalNetworkInfo>> test = {
    'eip155': [
      AppKitModalNetworkInfo(
        name: 'Sepolia',
        chainId: '11155111',
        currency: 'SEP',
        rpcUrl: 'https://ethereum-sepolia.publicnode.com',
        explorerUrl: 'https://sepolia.etherscan.io/',
        isTestNetwork: true,
      ),
      AppKitModalNetworkInfo(
        name: 'Holesky',
        chainId: '17000',
        chainIcon: chainImagesId['17000'],
        currency: 'ETH',
        rpcUrl: 'https://rpc.holesky.test',
        explorerUrl: 'https://explorer.holesky.test',
        isTestNetwork: true,
      ),
      AppKitModalNetworkInfo(
        name: 'Mumbai',
        chainId: '80001',
        currency: 'MATIC',
        rpcUrl: 'https://polygon-mumbai-bor-rpc.publicnode.com',
        extraRpcUrls: [
          'https://rpc.ankr.com/polygon_mumbai',
          'https://polygon-testnet.public.blastapi.io',
          'https://polygon-mumbai.blockpi.network/v1/rpc/public',
        ],
        explorerUrl: 'https://mumbai.polygonscan.com',
        isTestNetwork: true,
      ),
      AppKitModalNetworkInfo(
        name: 'Amoy',
        chainId: '80002',
        currency: 'MATIC',
        rpcUrl: 'https://rpc-amoy.polygon.technology/',
        extraRpcUrls: [],
        explorerUrl: 'https://amoy.polygonscan.com',
        isTestNetwork: true,
      )
    ],
  };

  static Map<String, String> chainImagesId = {
    // Ethereum
    '1': 'ba0ba0cd-17c6-4806-ad93-f9d174f17900',
    // Optimism
    '10': 'ab9c186a-c52f-464b-2906-ca59d760a400',
    // Binance Smart Chain
    '56': '93564157-2e8e-4ce7-81df-b264dbee9b00',
    // Gnosis
    '100': '02b53f6a-e3d4-479e-1cb4-21178987d100',
    // Polygon
    '137': '41d04d42-da3b-4453-8506-668cc0727900',
    // Fantom
    '250': '06b26297-fe0c-4733-5d6b-ffa5498aac00',
    // Filecoin
    '314': '5a73b3dd-af74-424e-cae0-0de859ee9400',
    // ZkSync
    '324': 'b310f07f-4ef7-49f3-7073-2a0a39685800',
    // Polygon zkEVM
    '1101': '1f078e54-72f0-4b5b-89ca-11ea0483e900',
    // Metis,
    '1088': '3897a66d-40b9-4833-162f-a2c90531c900',
    // Moonbeam
    '1284': '161038da-44ae-4ec7-1208-0ea569454b00',
    // Moonriver
    '1285': 'f1d73bb6-5450-4e18-38f7-fb6484264a00',
    // Iotx
    '4689': '34e68754-e536-40da-c153-6ef2e7188a00',
    // Mantle
    '5000': 'f784171a-f4cf-4c4d-a0b0-faf2abf35b00',
    // Klaytn
    '8217': 'b1707ac9-94f1-4cd8-8e41-80af13cd5800',
    // Linea
    '59144': 'b6a252d9-b084-4bdc-e1ba-0d3186958700',
    // Base
    '8453': '7289c336-3981-4081-c5f4-efc26ac64a00',
    // EVMos
    '9001': 'f926ff41-260d-4028-635e-91913fc28e00',
    // Arbitrum
    '42161': '3bff954d-5cb0-47a0-9a23-d20192e74600',
    // Celo
    '42220': 'ab781bbc-ccc6-418d-d32d-789b15da1f00',
    // Avalanche
    '43114': '30c46e53-e989-45fb-4549-be3bd4eb3b00',
    // Zora
    '7777777': '845c60df-d429-4991-e687-91ae45791600',
    // Aurora
    '1313161554': '3ff73439-a619-4894-9262-4470c773a100',
  };

  static AppKitModalNetworkInfo? getNetworkById(
    String namespace,
    String chainId,
  ) {
    return supported[namespace]?.firstWhere((e) => e.chainId == chainId);
  }

  static List<AppKitModalNetworkInfo> getNetworks(String namespace) {
    return supported[namespace] ?? [];
  }

  static String? getNamespaceForChainId(String chainId) {
    // final allChains = supported.values.expand((e) => e).toList();
    String? namespace;
    final namespaces = supported.keys.toList();
    for (var ns in namespaces) {
      final found = supported[ns]!.firstWhereOrNull(
        (e) => e.chainId == chainId,
      );
      if (found != null) {
        namespace = ns;
        break;
      }
    }
    return namespace;
  }

  static String getNetworkIconId(String chainId) {
    return chainImagesId[chainId] ?? '';
  }
}
