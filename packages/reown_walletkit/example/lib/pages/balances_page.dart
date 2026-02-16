import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/cosmos_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/evm_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/kadena_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/polkadot_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/solana_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/stacks/stacks_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/sui/sui_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/ton/ton_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/tron_service.dart';
import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/i_key_service.dart';
import 'package:reown_walletkit_wallet/models/chain_data.dart';
import 'package:reown_walletkit_wallet/utils/constants.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_shared_widgets.dart';

class BalancesPage extends StatefulWidget {
  const BalancesPage({super.key});

  @override
  State<BalancesPage> createState() => _BalancesPageState();
}

class _BalancesPageState extends State<BalancesPage> {
  static const _cacheKey = 'balances_cache';
  static const _cacheTimestampKey = 'balances_cache_timestamp';
  static const _cacheDuration = Duration(minutes: 30);

  final _walletKitService = GetIt.I<IWalletKitService>();
  final _keysService = GetIt.I<IKeyService>();
  final List<Map<String, dynamic>> _mainnetBalances = [];
  final List<Map<String, dynamic>> _testnetBalances = [];
  bool _isLoading = false;
  final Set<String> _selectedSymbols = {};

  List<Map<String, dynamic>> get _allBalances => [
        ..._mainnetBalances,
        ..._testnetBalances,
      ];

  Map<String, String> get _symbolsWithIcons {
    final result = <String, String>{};
    for (final balance in _allBalances) {
      final symbol = balance['symbol'] as String? ?? '';
      final iconUrl = balance['iconUrl'] as String? ?? '';
      if (symbol.isNotEmpty && !result.containsKey(symbol)) {
        result[symbol] = iconUrl;
      }
    }
    return Map.fromEntries(
      result.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
    );
  }

  List<Map<String, dynamic>> _filterBalances(
      List<Map<String, dynamic>> balances) {
    if (_selectedSymbols.isEmpty) {
      return balances;
    }
    return balances.where((balance) {
      final symbol = balance['symbol'] as String? ?? '';
      return _selectedSymbols.contains(symbol);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _updateBalance();
  }

  Future<void> _updateBalance({
    bool showLoading = true,
    bool forceRefresh = false,
  }) async {
    if (!mounted) return;
    if (showLoading) {
      setState(() => _isLoading = true);
    }

    try {
      // Try to load from cache if not forcing refresh
      if (!forceRefresh) {
        final cached = await _loadFromCache();
        if (cached != null) {
          _mainnetBalances.clear();
          _testnetBalances.clear();
          _mainnetBalances.addAll(cached['mainnet']!);
          _testnetBalances.addAll(cached['testnet']!);
          _isLoading = false;
          setState(() {});
          debugPrint('[BalancesPage] Loaded balances from cache');
          return;
        }
      }

      _mainnetBalances.clear();
      _testnetBalances.clear();

      // Fetch mainnet and testnet balances in parallel
      final results = await Future.wait([
        _fetchAllBalances(isTestnet: false),
        _fetchAllBalances(isTestnet: true),
      ]);

      _mainnetBalances.addAll(results[0]);
      _testnetBalances.addAll(results[1]);

      // Save to cache
      await _saveToCache(_mainnetBalances, _testnetBalances);
      debugPrint('[BalancesPage] Saved balances to cache');

      _isLoading = false;
      setState(() {});
    } catch (e) {
      debugPrint('Error in _updateBalance: $e');
      _mainnetBalances.clear();
      _testnetBalances.clear();
      _isLoading = false;
      setState(() {});
    }
  }

  /// Loads balances from cache if valid (less than 30 minutes old)
  Future<Map<String, List<Map<String, dynamic>>>?> _loadFromCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final timestampStr = prefs.getString(_cacheTimestampKey);
      if (timestampStr == null) return null;

      final timestamp = DateTime.parse(timestampStr);
      final now = DateTime.now();

      // Check if cache is still valid
      if (now.difference(timestamp) > _cacheDuration) {
        debugPrint('[BalancesPage] Cache expired');
        return null;
      }

      final cacheStr = prefs.getString(_cacheKey);
      if (cacheStr == null) return null;

      final cacheData = jsonDecode(cacheStr) as Map<String, dynamic>;
      final mainnet = (cacheData['mainnet'] as List<dynamic>)
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList();
      final testnet = (cacheData['testnet'] as List<dynamic>)
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList();

      return {'mainnet': mainnet, 'testnet': testnet};
    } catch (e) {
      debugPrint('[BalancesPage] Error loading from cache: $e');
      return null;
    }
  }

  /// Saves balances to cache with current timestamp
  Future<void> _saveToCache(
    List<Map<String, dynamic>> mainnet,
    List<Map<String, dynamic>> testnet,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cacheData = {
        'mainnet': mainnet,
        'testnet': testnet,
      };
      await prefs.setString(_cacheKey, jsonEncode(cacheData));
      await prefs.setString(
          _cacheTimestampKey, DateTime.now().toIso8601String());
    } catch (e) {
      debugPrint('[BalancesPage] Error saving to cache: $e');
    }
  }

  Future<List<Map<String, dynamic>>> _fetchAllBalances({
    required bool isTestnet,
  }) async {
    final allBalances = await Future.wait([
      isTestnet ? getEvmTestBalances() : getEvmBalances(),
      getTronBalances(isTestnet),
      getSolanaBalances(isTestnet),
      getCosmosBalances(isTestnet),
      getKadenaBalances(isTestnet),
      getPolkadotBalances(isTestnet),
      getTonBalances(isTestnet),
      getStacksBalances(isTestnet),
      getSuiBalances(isTestnet),
    ]);
    return allBalances.expand((a) => a).toList();
  }

  Future<List<Map<String, dynamic>>> getEvmBalances() async {
    try {
      final evmChains = ChainsDataList.eip155Chains.where(
        (e) => !e.isTestnet,
      );
      final evmChain = evmChains.first;
      final evmService = _walletKitService.getChainService<EVMService>(
        chainId: evmChain.chainId,
      );
      final evmChainKeys = _keysService.getKeysForChain('eip155');

      final evmAddress = evmChainKeys.first.address;
      return await evmService.getBalances(address: evmAddress);
    } catch (e) {
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getEvmTestBalances() async {
    try {
      final evmChains = ChainsDataList.eip155Chains.where(
        (e) => e.isTestnet,
      );
      final futures = evmChains.map((evmChain) {
        final evmService = _walletKitService.getChainService<EVMService>(
          chainId: evmChain.chainId,
        );
        final evmChainKeys = _keysService.getKeysForChain('eip155');
        final evmAddress = evmChainKeys.first.address;
        return evmService.getBalances(address: evmAddress, byChain: true);
      });
      final balances = await Future.wait(futures);
      return balances.expand((a) => a).toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getTronBalances([
    bool isTestnet = false,
  ]) async {
    try {
      final tronChains = ChainsDataList.tronChains.where(
        (e) => e.isTestnet == isTestnet,
      );
      if (tronChains.isEmpty) return [];

      final tronChain = tronChains.first;
      final tronService = _walletKitService.getChainService<TronService>(
        chainId: tronChain.chainId,
      );
      final tronChainKeys = _keysService.getKeysForChain('tron');
      if (tronChainKeys.isEmpty) return [];

      final tronAddress = tronChainKeys.first.address;
      return await tronService.tronApi.getTokens(address: tronAddress);
    } catch (e) {
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getSolanaBalances([
    bool isTestnet = false,
  ]) async {
    try {
      final solanaChains = ChainsDataList.solanaChains.where(
        (e) => e.isTestnet == isTestnet,
      );
      if (solanaChains.isEmpty) return [];

      final solanaChain = solanaChains.first;
      final solanaService = _walletKitService.getChainService<SolanaService>(
        chainId: solanaChain.chainId,
      );
      final solanaChainKeys = _keysService.getKeysForChain('solana');
      if (solanaChainKeys.isEmpty) return [];

      final solanaAddress = solanaChainKeys.first.address;
      return await solanaService.getTokens(address: solanaAddress);
    } catch (e) {
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getCosmosBalances([
    bool isTestnet = false,
  ]) async {
    try {
      final cosmosChains = ChainsDataList.cosmosChains.where(
        (e) => e.isTestnet == isTestnet,
      );
      if (cosmosChains.isEmpty) return [];

      final cosmosChain = cosmosChains.first;
      final cosmosService = _walletKitService.getChainService<CosmosService>(
        chainId: cosmosChain.chainId,
      );
      final cosmosChainKeys = _keysService.getKeysForChain('cosmos');
      if (cosmosChainKeys.isEmpty) return [];

      final cosmosAddress = cosmosChainKeys.first.address;
      return await cosmosService.getTokens(address: cosmosAddress);
    } catch (e) {
      debugPrint('Error in getCosmosBalances: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getKadenaBalances([
    bool isTestnet = false,
  ]) async {
    try {
      final kadenaChains = ChainsDataList.kadenaChains.where(
        (e) => e.isTestnet == isTestnet,
      );
      if (kadenaChains.isEmpty) return [];

      final kadenaChain = kadenaChains.first;
      final kadenaService = _walletKitService.getChainService<KadenaService>(
        chainId: kadenaChain.chainId,
      );
      final kadenaChainKeys = _keysService.getKeysForChain('kadena');
      if (kadenaChainKeys.isEmpty) return [];

      final kadenaAddress = kadenaChainKeys.first.address;
      return await kadenaService.getTokens(address: kadenaAddress);
    } catch (e) {
      debugPrint('Error in getKadenaBalances: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getPolkadotBalances([
    bool isTestnet = false,
  ]) async {
    try {
      final polkadotChains = ChainsDataList.polkadotChains.where(
        (e) => e.isTestnet == isTestnet,
      );
      if (polkadotChains.isEmpty) return [];

      final polkadotChain = polkadotChains.first;
      final polkadotService =
          _walletKitService.getChainService<PolkadotService>(
        chainId: polkadotChain.chainId,
      );
      final polkadotChainKeys = _keysService.getKeysForChain('polkadot');
      if (polkadotChainKeys.isEmpty) return [];

      final polkadotAddress = polkadotChainKeys.first.address;
      return await polkadotService.getTokens(address: polkadotAddress);
    } catch (e) {
      debugPrint('Error in getPolkadotBalances: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getTonBalances([
    bool isTestnet = false,
  ]) async {
    try {
      final tonChains = ChainsDataList.tonChains.where(
        (e) => e.isTestnet == isTestnet,
      );
      if (tonChains.isEmpty) return [];

      final tonChain = tonChains.first;
      final tonService = _walletKitService.getChainService<TonService>(
        chainId: tonChain.chainId,
      );
      final tonChainKeys = _keysService.getKeysForChain('ton');
      if (tonChainKeys.isEmpty) return [];

      final tonAddress = tonChainKeys.first.address;
      return await tonService.getTokens(address: tonAddress);
    } catch (e) {
      debugPrint('Error in getTonBalances: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getStacksBalances([
    bool isTestnet = false,
  ]) async {
    try {
      final stacksChains = ChainsDataList.stacksChains.where(
        (e) => e.isTestnet == isTestnet,
      );
      if (stacksChains.isEmpty) return [];

      final stacksChain = stacksChains.first;
      final stacksService = _walletKitService.getChainService<StacksService>(
        chainId: stacksChain.chainId,
      );
      final stacksChainKeys = _keysService.getKeysForChain('stacks');
      if (stacksChainKeys.isEmpty) return [];

      final stacksAddress = stacksChainKeys.first.address;
      return await stacksService.getTokens(address: stacksAddress);
    } catch (e) {
      debugPrint('Error in getStacksBalances: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getSuiBalances([
    bool isTestnet = false,
  ]) async {
    try {
      final suiChains = ChainsDataList.suiChains.where(
        (e) => e.isTestnet == isTestnet,
      );
      if (suiChains.isEmpty) return [];

      final suiChain = suiChains.first;
      final suiService = _walletKitService.getChainService<SUIService>(
        chainId: suiChain.chainId,
      );
      final suiChainKeys = _keysService.getKeysForChain('sui');
      if (suiChainKeys.isEmpty) return [];

      final suiAddress = suiChainKeys.first.address;
      return await suiService.getTokens(address: suiAddress);
    } catch (e) {
      debugPrint('Error in getSuiBalances: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final chainKeys = _keysService.getKeysForChain('eip155');

    return Scaffold(
      body: chainKeys.isEmpty
          ? const Center(child: Text('No EVM accounts found'))
          : RefreshIndicator(
              onRefresh: () => _updateBalance(
                showLoading: false,
                forceRefresh: true,
              ),
              child: _isLoading
                  ? FutureBuilder(
                      future: Future.delayed(const Duration(milliseconds: 100)),
                      initialData: null,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(24.0),
                                  child: CircularProgressIndicator(),
                                ),
                                Text('Loading balances...'),
                              ],
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      })
                  : SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    bottom: 12.0,
                                    left: 12.0,
                                    right: 12.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Wallet address',
                                        style:
                                            StyleConstants.wcpTextPrimaryStyle,
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        chainKeys.first.address,
                                        style: StyleConstants
                                            .wcpTextPrimaryStyle
                                            .copyWith(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(height: 1.0, color: StyleConstants.neutrals),
                          const SizedBox(height: 12.0),
                          // Filter widgets
                          _BalancesFilterWidget(
                            symbolsWithIcons: _symbolsWithIcons,
                            selectedSymbols: _selectedSymbols,
                            onSelectionChanged: (symbol, selected) {
                              setState(() {
                                if (selected) {
                                  _selectedSymbols.add(symbol);
                                } else {
                                  _selectedSymbols.remove(symbol);
                                }
                              });
                            },
                            onSelectAll: () {
                              setState(() => _selectedSymbols.clear());
                            },
                          ),
                          const SizedBox(height: 16.0),
                          // Mainnet Balances
                          _BalancesListWidget(
                            title: 'Mainnet',
                            balances: _filterBalances(_mainnetBalances),
                            emptyMessage: 'No mainnet balances found',
                          ),
                          // Testnet Balances
                          const SizedBox(height: 24.0),
                          _BalancesListWidget(
                            title: 'Testnet',
                            balances: _filterBalances(_testnetBalances),
                            emptyMessage: 'No testnet balances found',
                            isTestnet: true,
                          ),
                        ],
                      ),
                    ),
            ),
    );
  }
}

class _BalancesListWidget extends StatelessWidget {
  const _BalancesListWidget({
    required this.title,
    required this.balances,
    required this.emptyMessage,
    this.isTestnet = false,
  });

  final String title;
  final List<Map<String, dynamic>> balances;
  final String emptyMessage;
  final bool isTestnet;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: isTestnet
                    ? Colors.orange.withValues(alpha: 0.2)
                    : Colors.green.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                title,
                style: StyleConstants.wcpTextPrimaryStyle.copyWith(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: isTestnet ? Colors.orange : Colors.green,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              '(${balances.length} tokens)',
              style: StyleConstants.wcpTextPrimaryStyle.copyWith(
                fontSize: 12.0,
                color: StyleConstants.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        if (balances.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              emptyMessage,
              style: StyleConstants.wcpTextPrimaryStyle.copyWith(
                fontSize: 14.0,
                color: StyleConstants.textSecondary,
              ),
            ),
          )
        else
          ...balances.map((balance) => _BalanceItemWidget(balance: balance)),
      ],
    );
  }
}

class _BalanceItemWidget extends StatelessWidget {
  const _BalanceItemWidget({required this.balance});

  final Map<String, dynamic> balance;

  @override
  Widget build(BuildContext context) {
    final symbol = balance['symbol'] as String? ?? '';
    final value = balance['value'] as num? ?? 0.0;
    final quantity =
        double.tryParse(balance['quantity']['numeric'].toString()) ?? 0.0;
    final chainId = balance['chainId'] as String? ?? '';
    final iconUrl = balance['iconUrl'] as String? ?? '';
    final chainData = ChainsDataList.allChains.firstWhere(
      (e) => e.chainId == chainId,
      orElse: () => ChainsDataList.eip155Chains.first,
    );
    String title = '${quantity.toStringAsPrecision(6)} $symbol';
    if (!chainData.isTestnet) {
      title += ' (${value.toStringAsFixed(2)} USD)';
    } else {
      title += ' (${chainData.name})';
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Stack(
        children: [
          WCPTextField(
            controller: TextEditingController(
              text: title,
            ),
            focusNode: FocusNode(),
            textStyle: StyleConstants.wcpTextPrimaryStyle.copyWith(
              fontSize: 15.0,
              fontWeight:
                  chainData.isTestnet ? FontWeight.normal : FontWeight.w600,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            label: '',
            suffix: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: iconUrl,
                  width: 32.0,
                  height: 32.0,
                  errorWidget: (context, url, error) => const SizedBox.shrink(),
                ),
              ),
            ),
            enabled: false,
          ),
          Positioned(
            right: 12,
            bottom: 10,
            child: Container(
              width: 20.0,
              height: 20.0,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2.0,
                  color: StyleConstants.foregroundPrimary,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: CachedNetworkImage(
                  imageUrl: chainData.logo,
                  width: 20.0,
                  height: 20.0,
                  errorWidget: (context, url, error) => const SizedBox.shrink(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BalancesFilterWidget extends StatelessWidget {
  const _BalancesFilterWidget({
    required this.symbolsWithIcons,
    required this.selectedSymbols,
    required this.onSelectionChanged,
    required this.onSelectAll,
  });

  final Map<String, String> symbolsWithIcons;
  final Set<String> selectedSymbols;
  final void Function(String symbol, bool selected) onSelectionChanged;
  final VoidCallback onSelectAll;

  @override
  Widget build(BuildContext context) {
    final isAllSelected = selectedSymbols.isEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Filter by token',
          style: StyleConstants.wcpTextPrimaryStyle.copyWith(fontSize: 14.0),
        ),
        const SizedBox(height: 8.0),
        if (symbolsWithIcons.isEmpty)
          const SizedBox.shrink()
        else
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                FilterChip(
                  label: const Text('All'),
                  selected: isAllSelected,
                  onSelected: (_) => onSelectAll(),
                  selectedColor: StyleConstants.accentPrimary.withValues(
                    alpha: 0.2,
                  ),
                  showCheckmark: false,
                  backgroundColor: StyleConstants.foregroundPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(
                      color: isAllSelected
                          ? StyleConstants.accentPrimary
                          : StyleConstants.foregroundSecondary,
                    ),
                  ),
                  labelStyle: StyleConstants.wcpTextPrimaryStyle.copyWith(
                    fontSize: 13.0,
                    color: isAllSelected
                        ? StyleConstants.accentPrimary
                        : StyleConstants.textPrimary,
                  ),
                ),
                ...symbolsWithIcons.entries.map((entry) {
                  final symbol = entry.key;
                  final iconUrl = entry.value;
                  final isSelected = selectedSymbols.contains(symbol);
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: FilterChip(
                      avatar: iconUrl.isNotEmpty
                          ? CircleAvatar(
                              backgroundColor:
                                  StyleConstants.foregroundSecondary,
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: iconUrl,
                                  width: 20.0,
                                  height: 20.0,
                                  errorWidget: (context, url, error) =>
                                      const SizedBox.shrink(),
                                ),
                              ),
                            )
                          : null,
                      label: Text(symbol),
                      selected: isSelected,
                      onSelected: (selected) =>
                          onSelectionChanged(symbol, selected),
                      selectedColor: StyleConstants.accentPrimary.withValues(
                        alpha: 0.2,
                      ),
                      showCheckmark: false,
                      backgroundColor: StyleConstants.foregroundPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(
                          color: isSelected
                              ? StyleConstants.accentPrimary
                              : StyleConstants.foregroundSecondary,
                        ),
                      ),
                      labelStyle: StyleConstants.wcpTextPrimaryStyle.copyWith(
                        fontSize: 13.0,
                        color: isSelected
                            ? StyleConstants.accentPrimary
                            : StyleConstants.textPrimary,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
      ],
    );
  }
}
