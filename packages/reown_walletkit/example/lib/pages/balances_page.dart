import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/evm_service.dart';
import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/i_key_service.dart';
import 'package:reown_walletkit_wallet/models/chain_data.dart';
import 'package:reown_walletkit_wallet/theme/app_colors.dart';
import 'package:reown_walletkit_wallet/theme/app_spacing.dart';

class BalancesPage extends StatefulWidget {
  const BalancesPage({super.key});

  @override
  State<BalancesPage> createState() => _BalancesPageState();
}

class _BalancesPageState extends State<BalancesPage> {
  final _walletKitService = GetIt.I<IWalletKitService>();
  final _keysService = GetIt.I<IKeyService>();
  final List<Map<String, dynamic>> _balances = [];
  bool _isLoading = false;
  final Set<String> _selectedSymbols = {};

  Map<String, String> get _symbolsWithIcons {
    final result = <String, String>{};
    for (final balance in _balances) {
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

  List<Map<String, dynamic>> get _filteredBalances {
    if (_selectedSymbols.isEmpty) {
      return _balances;
    }
    return _balances.where((balance) {
      final symbol = balance['symbol'] as String? ?? '';
      return _selectedSymbols.contains(symbol);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _updateBalance();
  }

  Future<void> _updateBalance({bool showLoading = true}) async {
    if (!mounted) return;
    if (showLoading) {
      setState(() => _isLoading = true);
    }

    try {
      final chainKeys = _keysService.getKeysForChain('eip155');
      if (chainKeys.isEmpty) {
        setState(() {
          _balances.clear();
          _isLoading = false;
        });
        return;
      }

      final selectedChain = _walletKitService.currentSelectedChain.value ??
          ChainsDataList.eip155Chains.first;
      final chainKey = chainKeys.first;
      final evmService = _walletKitService.getChainService<EVMService>(
        chainId: selectedChain.chainId,
      );

      final balances = await evmService.getBalance(address: chainKey.address);

      if (!mounted) return;
      setState(() {
        _balances
          ..clear()
          ..addAll(balances);
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _balances.clear();
        _isLoading = false;
      });
      debugPrint('Error in _updateBalance: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final chainKeys = _keysService.getKeysForChain('eip155');
    final colors = context.colors;

    return Scaffold(
      body: chainKeys.isEmpty
          ? Center(
              child: Text(
                'No EVM accounts found',
                style: TextStyle(color: colors.textPrimary),
              ),
            )
          : RefreshIndicator(
              onRefresh: () => _updateBalance(showLoading: false),
              color: colors.accent,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(AppSpacing.s4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Address display
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(
                              bottom: AppSpacing.s3,
                              left: AppSpacing.s3,
                              right: AppSpacing.s3,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Wallet address',
                                  style: TextStyle(
                                    color: colors.textPrimary,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: AppSpacing.s1),
                                Text(
                                  chainKeys.first.address,
                                  style: TextStyle(
                                    color: colors.textSecondary,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 1.0, color: colors.divider),
                    const SizedBox(height: AppSpacing.s3),
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
                    const SizedBox(height: AppSpacing.s3),
                    if (_isLoading)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.s6),
                          child: CircularProgressIndicator(color: colors.accent),
                        ),
                      )
                    else if (_filteredBalances.isEmpty)
                      Container(
                        height: 64.0,
                        decoration: BoxDecoration(
                          color: colors.backgroundSecondary,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Text(
                          _balances.isEmpty
                              ? 'No balances found'
                              : 'No balances match selected filters',
                          style: TextStyle(color: colors.textTertiary),
                        ),
                      )
                    else
                      ..._filteredBalances.map((balance) {
                        final symbol = balance['symbol'] as String? ?? '';
                        final value = balance['value'] as num? ?? 0.0;
                        final quantity =
                            double.tryParse(balance['quantity']['numeric']) ??
                                0.0;
                        final chainId = balance['chainId'] as String? ?? '';
                        final iconUrl = balance['iconUrl'] as String? ?? '';
                        final selectedChain =
                            _walletKitService.currentSelectedChain.value ??
                                ChainsDataList.eip155Chains.first;
                        final chainData = ChainsDataList.allChains.firstWhere(
                          (e) => e.chainId == chainId,
                          orElse: () => selectedChain,
                        );

                        return Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.s2),
                          child: Container(
                            height: 64.0,
                            decoration: BoxDecoration(
                              color: colors.backgroundSecondary,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18.0,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${quantity.toStringAsFixed(6)} $symbol (${value.toStringAsFixed(2)} USD)',
                                    style: TextStyle(
                                      color: colors.textPrimary,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 16,
                                      backgroundColor:
                                          colors.backgroundTertiary,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(16),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: iconUrl,
                                          width: 32.0,
                                          height: 32.0,
                                          errorWidget:
                                              (context, url, error) =>
                                                  const SizedBox.shrink(),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: CircleAvatar(
                                        radius: 9,
                                        backgroundColor: Colors.transparent,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(9),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: chainData.logo,
                                            width: 18.0,
                                            height: 18.0,
                                            errorWidget:
                                                (context, url, error) =>
                                                    const SizedBox.shrink(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                  ],
                ),
              ),
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
    if (symbolsWithIcons.isEmpty) {
      return const SizedBox.shrink();
    }

    final colors = context.colors;
    final isAllSelected = selectedSymbols.isEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Filter by token',
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 14.0,
          ),
        ),
        const SizedBox(height: AppSpacing.s2),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              FilterChip(
                label: const Text('All'),
                selected: isAllSelected,
                onSelected: (_) => onSelectAll(),
                selectedColor: colors.accent.withValues(alpha: 0.2),
                showCheckmark: false,
                backgroundColor: colors.backgroundSecondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(
                    color: isAllSelected ? colors.accent : colors.inputBorder,
                  ),
                ),
                labelStyle: TextStyle(
                  fontSize: 13.0,
                  color: isAllSelected ? colors.accent : colors.textPrimary,
                ),
              ),
              ...symbolsWithIcons.entries.map((entry) {
                final symbol = entry.key;
                final iconUrl = entry.value;
                final isSelected = selectedSymbols.contains(symbol);
                return Padding(
                  padding: const EdgeInsets.only(left: AppSpacing.s2),
                  child: FilterChip(
                    avatar: iconUrl.isNotEmpty
                        ? CircleAvatar(
                            backgroundColor: colors.backgroundTertiary,
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
                    selectedColor: colors.accent.withValues(alpha: 0.2),
                    showCheckmark: false,
                    backgroundColor: colors.backgroundSecondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      side: BorderSide(
                        color:
                            isSelected ? colors.accent : colors.inputBorder,
                      ),
                    ),
                    labelStyle: TextStyle(
                      fontSize: 13.0,
                      color:
                          isSelected ? colors.accent : colors.textPrimary,
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
