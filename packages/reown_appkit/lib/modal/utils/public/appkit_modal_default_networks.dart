import 'package:collection/collection.dart';
import 'package:reown_appkit/reown_appkit.dart';

class ReownAppKitModalNetworks {
  // https://github.com/WalletConnect/blockchain-api/blob/master/SUPPORTED_CHAINS.md
  static final Map<String, List<ReownAppKitModalNetworkInfo>> _mainnets = {
    NetworkUtils.eip155: [
      ReownAppKitModalNetworkInfo(
        name: 'Ethereum',
        chainId: '1',
        chainIcon: _networkIcons['eip155:1'],
        currency: 'ETH',
        rpcUrl: 'https://ethereum-rpc.publicnode.com',
        explorerUrl: 'https://etherscan.io',
      ),
      ReownAppKitModalNetworkInfo(
        name: 'Optimism',
        chainId: '10',
        chainIcon: _networkIcons['eip155:10'],
        currency: 'ETH',
        rpcUrl: 'https://mainnet.optimism.io/',
        explorerUrl: 'https://optimistic.etherscan.io',
      ),
      ReownAppKitModalNetworkInfo(
        name: 'Binance Smart Chain',
        chainId: '56',
        chainIcon: _networkIcons['eip155:56'],
        currency: 'BNB',
        rpcUrl: 'https://bsc-dataseed.binance.org/',
        explorerUrl: 'https://bscscan.com',
      ),
      ReownAppKitModalNetworkInfo(
        name: 'Gnosis Chain',
        chainId: '100',
        chainIcon: _networkIcons['eip155:100'],
        currency: 'xDAI',
        rpcUrl: 'https://rpc.gnosischain.com',
        explorerUrl: 'https://gnosis.blockscout.com',
      ),
      ReownAppKitModalNetworkInfo(
        name: 'Polygon',
        chainId: '137',
        chainIcon: _networkIcons['eip155:137'],
        currency: 'POL',
        rpcUrl: 'https://polygon.drpc.org',
        explorerUrl: 'https://polygonscan.com',
      ),
      ReownAppKitModalNetworkInfo(
        name: 'zkSync Era',
        chainId: '324',
        chainIcon: _networkIcons['eip155:324'],
        currency: 'ETH',
        rpcUrl: 'https://mainnet.era.zksync.io',
        explorerUrl: 'https://explorer.zksync.io',
      ),
      ReownAppKitModalNetworkInfo(
        name: 'Polygon zkEVM',
        chainId: '1101',
        chainIcon: _networkIcons['eip155:1101'],
        currency: 'ETH',
        rpcUrl: 'https://rpc-mainnet.matic.network',
        explorerUrl: 'https://explorer-evm.polygon.technology',
      ),
      ReownAppKitModalNetworkInfo(
        name: 'Mantle',
        chainId: '5000',
        chainIcon: _networkIcons['eip155:5000'],
        currency: 'BIT',
        rpcUrl: 'https://rpc.mantlenetwork.io',
        explorerUrl: 'https://explorer.mantlenetwork.io',
      ),
      ReownAppKitModalNetworkInfo(
        name: 'Klaytn Mainnet',
        chainId: '8217',
        chainIcon: _networkIcons['eip155:8217'],
        currency: 'KLAY',
        rpcUrl: 'https://public-node-api.klaytnapi.com/v1/cypress',
        explorerUrl: 'https://scope.klaytn.com',
      ),
      ReownAppKitModalNetworkInfo(
        name: 'Base',
        chainId: '8453',
        chainIcon: _networkIcons['eip155:8453'],
        currency: 'ETH',
        rpcUrl: 'https://mainnet.base.org',
        explorerUrl: 'https://basescan.org',
      ),
      ReownAppKitModalNetworkInfo(
        name: 'Arbitrum',
        chainId: '42161',
        chainIcon: _networkIcons['eip155:42161'],
        currency: 'ETH',
        rpcUrl: 'https://arbitrum.blockpi.network/v1/rpc/public',
        explorerUrl: 'https://arbiscan.io/',
      ),
      ReownAppKitModalNetworkInfo(
        name: 'Celo',
        chainId: '42220',
        chainIcon: _networkIcons['eip155:42220'],
        currency: 'CELO',
        rpcUrl: 'https://forno.celo.org',
        explorerUrl: 'https://explorer.celo.org/mainnet',
      ),
      ReownAppKitModalNetworkInfo(
        name: 'Avalanche',
        chainId: '43114',
        chainIcon: _networkIcons['eip155:43114'],
        currency: 'AVAX',
        rpcUrl: 'https://api.avax.network/ext/bc/C/rpc',
        explorerUrl: 'https://snowtrace.io',
      ),
      ReownAppKitModalNetworkInfo(
        name: 'Linea',
        chainId: '59144',
        chainIcon: _networkIcons['eip155:59144'],
        currency: 'ETH',
        rpcUrl: 'https://rpc.linea.build',
        explorerUrl: 'https://explorer.linea.build',
      ),
      ReownAppKitModalNetworkInfo(
        name: 'Zora',
        chainId: '7777777',
        chainIcon: _networkIcons['eip155:7777777'],
        currency: 'ETH',
        rpcUrl: 'https://rpc.zora.energy',
        explorerUrl: 'https://explorer.zora.energy',
      ),
      ReownAppKitModalNetworkInfo(
        name: 'Aurora',
        chainId: '1313161554',
        chainIcon: _networkIcons['eip155:1313161554'],
        currency: 'ETH',
        rpcUrl: 'https://mainnet.aurora.dev',
        explorerUrl: 'https://explorer.aurora.dev',
      ),
    ],
    NetworkUtils.solana: [
      ReownAppKitModalNetworkInfo(
        name: 'Solana',
        chainId: '5eykt4UsFv8P8NJdTREpY1vzqKqZKvdp',
        chainIcon: _networkIcons['solana::5eykt4UsFv8P8NJdTREpY1vzqKqZKvdp'],
        currency: 'SOL',
        rpcUrl: 'https://api.mainnet-beta.solana.com',
        explorerUrl: 'https://solscan.io',
      ),
    ],
  };

  static final Map<String, List<ReownAppKitModalNetworkInfo>> _testnets = {
    NetworkUtils.eip155: [
      ReownAppKitModalNetworkInfo(
        name: 'Sepolia',
        chainId: '11155111',
        currency: 'SEP',
        rpcUrl: 'https://ethereum-sepolia.publicnode.com',
        explorerUrl: 'https://sepolia.etherscan.io/',
        isTestNetwork: true,
      ),
      ReownAppKitModalNetworkInfo(
        name: 'Holesky',
        chainId: '17000',
        currency: 'ETH',
        rpcUrl: 'https://rpc.holesky.test',
        explorerUrl: 'https://explorer.holesky.test',
        isTestNetwork: true,
      ),
      ReownAppKitModalNetworkInfo(
        name: 'Mumbai',
        chainId: '80001',
        currency: 'POL',
        rpcUrl: 'https://polygon-mumbai-bor-rpc.publicnode.com',
        extraRpcUrls: [
          'https://rpc.ankr.com/polygon_mumbai',
          'https://polygon-testnet.public.blastapi.io',
          'https://polygon-mumbai.blockpi.network/v1/rpc/public',
        ],
        explorerUrl: 'https://mumbai.polygonscan.com',
        isTestNetwork: true,
      ),
      ReownAppKitModalNetworkInfo(
        name: 'Amoy',
        chainId: '80002',
        currency: 'POL',
        rpcUrl: 'https://rpc-amoy.polygon.technology/',
        explorerUrl: 'https://amoy.polygonscan.com',
        isTestNetwork: true,
      ),
      ReownAppKitModalNetworkInfo(
        name: 'BSC Testnet',
        chainId: '97',
        currency: 'tBNB',
        rpcUrl: 'https://data-seed-prebsc-1-s1.binance.org:8545/',
        explorerUrl: 'https://testnet.bscscan.com',
        isTestNetwork: true,
      ),
    ],
    NetworkUtils.solana: [
      ReownAppKitModalNetworkInfo(
        name: 'Solana Testnet',
        chainId: '4uhcVJyU9pJkvQyS88uRDiswHXSCkY3z',
        currency: 'SOL',
        rpcUrl: 'https://api.testnet.solana.com',
        explorerUrl: 'https://explorer.solana.com/?cluster=testnet',
        isTestNetwork: true,
      ),
      ReownAppKitModalNetworkInfo(
        name: 'Solana Devnet',
        chainId: 'EtWTRABZaYq6iMfeYKouRu166VU2xqa1',
        currency: 'SOL',
        rpcUrl: 'https://api.devnet.solana.com',
        explorerUrl: 'https://explorer.solana.com/?cluster=devnet',
        isTestNetwork: true,
      ),
    ],
  };

  @Deprecated('use getNetworkInfo()')
  static ReownAppKitModalNetworkInfo? getNetworkById(
    String namespace,
    String chainId,
  ) {
    return getNetworkInfo(namespace, chainId);
  }

  static ReownAppKitModalNetworkInfo? getNetworkInfo(
    String namespace,
    String chainId,
  ) {
    if (namespace.isEmpty) {
      throw ReownAppKitModalException('`namespace` can not be empty');
    }
    if (chainId.isEmpty) {
      throw ReownAppKitModalException('`chainId` can not be empty');
    }
    if (NamespaceUtils.isValidChainId(chainId)) {
      final namespace = NamespaceUtils.getNamespaceFromChain(chainId);
      return getAllSupportedNetworks(namespace: namespace).firstWhereOrNull(
        (e) => e.chainId == chainId,
      );
    }
    return getAllSupportedNetworks(namespace: namespace).firstWhereOrNull(
      (e) => e.chainId == '$namespace:$chainId',
    );
  }

  static void removeSupportedNetworks(
    String namespace, {
    List<String> chainIds = const [],
    bool includeTestnets = true,
  }) {
    if (namespace.isEmpty) {
      throw ReownAppKitModalException('`namespace` can not be empty');
    }
    _mainnets[namespace]?.removeWhere((chain) {
      if (chainIds.isEmpty || chainIds.contains(chain.chainId)) {
        return true;
      }
      return false;
    });
    if (includeTestnets) {
      _testnets[namespace]?.removeWhere((chain) {
        if (chainIds.isEmpty || chainIds.contains(chain.chainId)) {
          return true;
        }
        return false;
      });
    }
  }

  static void removeTestNetworks() {
    for (var key in _testnets.keys) {
      _testnets[key]!.clear();
    }
  }

  static void addSupportedNetworks(
    String namespace,
    List<ReownAppKitModalNetworkInfo> chainsToAdd,
  ) {
    if (namespace.isEmpty) {
      throw ReownAppKitModalException('`namespace` can not be empty');
    }

    // clean chains
    final parsedChainsToAdd = chainsToAdd.map((e) {
      if (e.chainId.contains(':')) {
        final cid = getIdFromChain(e.chainId);
        return e.copyWith(chainId: cid);
      }
      return e;
    }).toList();

    final List<ReownAppKitModalNetworkInfo> mainnets = [
      ...List.from(_mainnets[namespace] ?? []),
      ...(parsedChainsToAdd.where((e) => e.isTestNetwork == false)),
    ];
    _mainnets[namespace] = mainnets;

    final List<ReownAppKitModalNetworkInfo> testnets = [
      ...List.from(_testnets[namespace] ?? []),
      ...(parsedChainsToAdd.where((e) => e.isTestNetwork == true)),
    ];
    _testnets[namespace] = testnets;
  }

  static List<String> getAllSupportedNamespaces() {
    final mainNamespaces =
        _mainnets.keys.where((key) => _mainnets[key]!.isNotEmpty).toList();
    final testNamespaces =
        _testnets.keys.where((key) => _mainnets[key]!.isNotEmpty).toList();
    return <String>{...mainNamespaces, ...testNamespaces}.toList();
  }

  static List<ReownAppKitModalNetworkInfo> getAllSupportedNetworks({
    String? namespace,
  }) {
    final mainnets = _mainnets.entries
        .map((e) {
          final ns = e.key;
          final chains = e.value;
          return chains.map(
            (c) => c.copyWith(
              chainId: '$ns:${c.chainId}',
            ),
          );
        })
        .expand((e) => e)
        .where((e) {
          if (namespace != null) {
            final ns = NamespaceUtils.getNamespaceFromChain(e.chainId);
            return !e.isTestNetwork && ns == namespace;
          }
          return !e.isTestNetwork;
        })
        .toList();

    final testnets = _testnets.entries
        .map((e) {
          final ns = e.key;
          final chains = e.value;
          return chains.map(
            (c) => c.copyWith(
              chainId: '$ns:${c.chainId}',
            ),
          );
        })
        .expand((e) => e)
        .where((e) {
          if (namespace != null) {
            final ns = NamespaceUtils.getNamespaceFromChain(e.chainId);
            return e.isTestNetwork && ns == namespace;
          }
          return e.isTestNetwork;
        })
        .toList();

    //
    return [...mainnets, ...testnets].toList();
  }

  @Deprecated('use NamespaceUtils.getNamespaceFromChain()')
  static String getNamespaceForChainId(String chainId) {
    return NamespaceUtils.getNamespaceFromChain(chainId);
  }

  static String getIdFromChain(String chainId) {
    if (!NamespaceUtils.isValidChainId(chainId)) {
      throw Errors.getSdkError(
        Errors.UNSUPPORTED_CHAINS,
        context: 'chainId should conform to "CAIP-2" format',
      ).toSignError();
    }

    return chainId.split(':').last;
  }

  static String getNetworkIconId(String chainId) {
    try {
      final namespace = NamespaceUtils.getNamespaceFromChain(chainId);
      final network = getNetworkInfo(namespace, chainId);
      if ((network?.chainIcon ?? '').isNotEmpty) {
        return network!.chainIcon!;
      }
      return _networkIcons[chainId]!;
    } catch (e) {
      return '';
    }
  }

  @Deprecated('`chainId` from ReownAppKitModalNetworkInfo is already CAIP-2')
  static String getCaip2Chain(String chainId) {
    return chainId;
  }

  static final Map<String, String> _networkIcons = {
    // Ethereum
    'eip155:1': 'ba0ba0cd-17c6-4806-ad93-f9d174f17900',
    // Optimism
    'eip155:10': 'ab9c186a-c52f-464b-2906-ca59d760a400',
    // Binance Smart Chain
    'eip155:56': '93564157-2e8e-4ce7-81df-b264dbee9b00',
    // Gnosis
    'eip155:100': '02b53f6a-e3d4-479e-1cb4-21178987d100',
    // Polygon
    'eip155:137': '41d04d42-da3b-4453-8506-668cc0727900',
    // Fantom
    'eip155:250': '06b26297-fe0c-4733-5d6b-ffa5498aac00',
    // Filecoin
    'eip155:314': '5a73b3dd-af74-424e-cae0-0de859ee9400',
    // ZkSync
    'eip155:324': 'b310f07f-4ef7-49f3-7073-2a0a39685800',
    // Polygon zkEVM
    'eip155:1101': '1f078e54-72f0-4b5b-89ca-11ea0483e900',
    // Metis,
    'eip155:1088': '3897a66d-40b9-4833-162f-a2c90531c900',
    // Moonbeam
    'eip155:1284': '161038da-44ae-4ec7-1208-0ea569454b00',
    // Moonriver
    'eip155:1285': 'f1d73bb6-5450-4e18-38f7-fb6484264a00',
    // Iotx
    'eip155:4689': '34e68754-e536-40da-c153-6ef2e7188a00',
    // Mantle
    'eip155:5000': 'f784171a-f4cf-4c4d-a0b0-faf2abf35b00',
    // Klaytn
    'eip155:8217': 'b1707ac9-94f1-4cd8-8e41-80af13cd5800',
    // Linea
    'eip155:59144': 'b6a252d9-b084-4bdc-e1ba-0d3186958700',
    // Base
    'eip155:8453': '7289c336-3981-4081-c5f4-efc26ac64a00',
    // EVMos
    'eip155:9001': 'f926ff41-260d-4028-635e-91913fc28e00',
    // Arbitrum
    'eip155:42161': '3bff954d-5cb0-47a0-9a23-d20192e74600',
    // Celo
    'eip155:42220': 'ab781bbc-ccc6-418d-d32d-789b15da1f00',
    // Avalanche
    'eip155:43114': '30c46e53-e989-45fb-4549-be3bd4eb3b00',
    // Zora
    'eip155:7777777': '845c60df-d429-4991-e687-91ae45791600',
    // Aurora
    'eip155:1313161554': '3ff73439-a619-4894-9262-4470c773a100',
    // Solana
    'solana:5eykt4UsFv8P8NJdTREpY1vzqKqZKvdp':
        'a1b58899-f671-4276-6a5e-56ca5bd59700',
    // Near
    'near:mainnet': 'ab3d4dee-e416-4d8d-226c-4c131b8b7600',
  };
}
