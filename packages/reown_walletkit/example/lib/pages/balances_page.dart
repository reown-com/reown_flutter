import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/evm_service.dart';
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

    return Scaffold(
      body: chainKeys.isEmpty
          ? const Center(
              child: Text('No EVM accounts found'),
            )
          : RefreshIndicator(
              onRefresh: () => _updateBalance(showLoading: false),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Address display
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Wallet address',
                                  style: StyleConstants.wcpTextPrimaryStyle,
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  chainKeys.first.address,
                                  style: StyleConstants.wcpTextPrimaryStyle
                                      .copyWith(
                                    fontSize: 12,
                                  ),
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
                    const SizedBox(height: 12.0),
                    if (_isLoading)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24.0),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else if (_filteredBalances.isEmpty)
                      WCPTextField(
                        controller: TextEditingController(),
                        focusNode: FocusNode(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18.0,
                        ),
                        label: _balances.isEmpty
                            ? 'No balances found'
                            : 'No balances match selected filters',
                        enabled: false,
                      )
                    else
                      ..._filteredBalances.map(
                        (balance) {
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
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: WCPTextField(
                              controller: TextEditingController(
                                text:
                                    '${quantity.toStringAsFixed(6)} $symbol (${value.toStringAsFixed(2)} USD)',
                              ),
                              focusNode: FocusNode(),
                              textStyle:
                                  StyleConstants.wcpTextPrimaryStyle.copyWith(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18.0,
                              ),
                              label: '',
                              suffix: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 16,
                                    backgroundColor: Colors.white,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(16)),
                                      child: CachedNetworkImage(
                                        imageUrl: iconUrl,
                                        width: 32.0,
                                        height: 32.0,
                                        errorWidget: (context, url, error) =>
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
                                            Radius.circular(9)),
                                        child: CachedNetworkImage(
                                          imageUrl: chainData.logo,
                                          width: 18.0,
                                          height: 18.0,
                                          errorWidget: (context, url, error) =>
                                              const SizedBox.shrink(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              enabled: false,
                            ),
                          );
                        },
                      ),
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

    final isAllSelected = selectedSymbols.isEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Filter by token',
          style: StyleConstants.wcpTextPrimaryStyle.copyWith(
            fontSize: 14.0,
          ),
        ),
        const SizedBox(height: 8.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              FilterChip(
                label: const Text('All'),
                selected: isAllSelected,
                onSelected: (_) => onSelectAll(),
                selectedColor:
                    StyleConstants.accentPrimary.withValues(alpha: 0.2),
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
                            backgroundColor: StyleConstants.foregroundSecondary,
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
                    selectedColor:
                        StyleConstants.accentPrimary.withValues(alpha: 0.2),
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
