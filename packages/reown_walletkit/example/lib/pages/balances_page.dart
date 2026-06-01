import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/i_key_service.dart';
import 'package:reown_walletkit_wallet/models/chain_data.dart';
import 'package:reown_walletkit_wallet/theme/app_colors.dart';
import 'package:reown_walletkit_wallet/theme/app_spacing.dart';
import 'package:reown_walletkit_wallet/utils/blockchain_api_utils.dart';
import 'package:toastification/toastification.dart';

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

  // Namespaces whose balances we fetch, in the order their addresses appear.
  static const _supportedNamespaces = [
    'eip155',
    'solana',
    'sui',
    'ton',
    'tron'
  ];

  // Mainnet native tokens that should always be shown (so the user can see
  // their address even at a 0 balance). chainId -> symbol.
  static const _mainnetNatives = {
    'eip155:1': 'ETH',
    'solana:5eykt4UsFv8P8NJdTREpY1vzqKqZKvdp': 'SOL',
    'sui:mainnet': 'SUI',
    'ton:-239': 'TON',
    'tron:0x2b6653dc': 'TRX',
  };

  /// Address for [namespace], or null if the wallet has no keys for it.
  String? _addressFor(String namespace) {
    final keys = _keysService.getKeysForChain(namespace);
    return keys.isEmpty ? null : keys.first.address;
  }

  /// namespace -> address, only for namespaces the wallet supports.
  Map<String, String> get _addresses => {
        for (final ns in _supportedNamespaces)
          if (_addressFor(ns) != null) ns: _addressFor(ns)!,
      };

  /// A balance is native when it carries no token contract address.
  bool _isNative(Map<String, dynamic> b) {
    final address = b['address'] as String?;
    return address == null || address.isEmpty;
  }

  // Symbols of known spam/airdrop tokens to hide, matched case-insensitively
  // against the trimmed token symbol.
  static const _spamSymbols = {
    'MANTRA POS',
    'AMPAR',
    'ACHIVX',
    'BASED',
    'GT',
    'MY',
    'GORE',
    'MFERS',
    'TLBC',
  };

  // Domain-like segment, e.g. "2base.cfd", "gftpepe.com". Legitimate token
  // symbols never contain a "name.tld" segment, so this is safe and
  // TLD-agnostic.
  static final _domainRegExp = RegExp(
    r'[a-z0-9][a-z0-9-]*\.[a-z]{2,}',
    caseSensitive: false,
  );

  /// Detects scam/airdrop tokens that abuse the symbol field to advertise a
  /// website (e.g. "USD0 [www.usual.finance]", "ecAVAX - https://invest...",
  /// "www.2base.cfd"), use bracketed advertising, or match a known spam symbol
  /// blocklist.
  bool _isSpam(Map<String, dynamic> b) {
    final symbol = b['symbol'] as String? ?? '';
    final lower = symbol.toLowerCase();

    // Explicit URLs embedded in the symbol.
    if (lower.contains('http://') ||
        lower.contains('https://') ||
        lower.contains('www.') ||
        lower.contains('://')) {
      return true;
    }

    // Any domain-like token.
    if (_domainRegExp.hasMatch(symbol)) return true;

    // Bracketed advertising, e.g. "USD0 [ ... ]".
    if (symbol.contains('[') || symbol.contains(']')) return true;

    // Known spam symbol blocklist.
    final normalized = symbol.trim().toUpperCase();
    return _spamSymbols.contains(normalized);
  }

  String _shortAddress(String a) =>
      a.length < 10 ? a : '${a.substring(0, 6)}...${a.substring(a.length - 6)}';

  /// Compact balance label, mirroring the RN TokenBalanceCard `formatBalance`:
  /// no USD value, fixed precision by magnitude, thousands-grouped above 1000.
  String _formatAmount(double value, String symbol) {
    if (value == 0) return '0 $symbol';
    if (value < 0.0001) return '<0.0001 $symbol';
    if (value < 1) return '${value.toStringAsFixed(4)} $symbol';
    if (value < 1000) return '${value.toStringAsFixed(2)} $symbol';

    // >= 1000: group thousands, up to 2 fraction digits, trailing zeros dropped.
    final parts = value.toStringAsFixed(2).split('.');
    final intPart = parts[0].replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (_) => ',',
    );
    final fracPart = parts[1].replaceFirst(RegExp(r'0+$'), '');
    return fracPart.isEmpty
        ? '$intPart $symbol'
        : '$intPart.$fracPart $symbol';
  }

  /// Copies [address] to the clipboard and shows a confirmation toast.
  void _copyAddress(String address, String chainName) {
    Clipboard.setData(ClipboardData(text: address));
    HapticFeedback.selectionClick();
    if (!mounted) return;
    toastification.show(
      title: Text('$chainName address copied'),
      context: context,
      autoCloseDuration: const Duration(seconds: 2),
      alignment: Alignment.bottomCenter,
    );
  }

  /// Fetches balances for [address], returning `null` on failure so a single
  /// chain error doesn't wipe the others (mirrors Promise.allSettled). When
  /// [chainId] is omitted the API returns all EVM chains in one call.
  Future<List<Map<String, dynamic>>?> _safeBalance(
    String address, {
    String? chainId,
  }) {
    return BlockchainApiUtils.getBalance(address: address, chainId: chainId)
        .then<List<Map<String, dynamic>>?>((b) => b)
        .catchError((_) => null);
  }

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
      final addresses = _addresses;
      if (addresses.isEmpty) {
        setState(() {
          _balances.clear();
          _isLoading = false;
        });
        return;
      }

      // Fetch balances per namespace, in parallel. For EVM we omit the chainId
      // so the API returns every supported EVM chain in a single call; the
      // non-EVM namespaces each fetch their one mainnet.
      final tasks = <Future<List<Map<String, dynamic>>?>>[];
      addresses.forEach((namespace, address) {
        if (namespace == 'eip155') {
          tasks.add(_safeBalance(address));
        } else {
          // Non-EVM namespaces have one mainnet entry in _mainnetNatives.
          final chainId = _mainnetNatives.keys.firstWhere(
            (id) => id.startsWith('$namespace:'),
            orElse: () => '',
          );
          if (chainId.isNotEmpty) {
            tasks.add(_safeBalance(address, chainId: chainId));
          }
        }
      });

      final results = await Future.wait(tasks, eagerError: false);
      final anySuccess = results.any((r) => r != null);

      // Resilience: a total failure shouldn't wipe existing balances.
      if (!anySuccess) {
        if (!mounted) return;
        setState(() => _isLoading = false);
        return;
      }

      final combined = results
          .whereType<List<Map<String, dynamic>>>()
          .expand((r) => r)
          .toList();
      final processed = _processBalances(combined, addresses);

      if (!mounted) return;
      setState(() {
        _balances
          ..clear()
          ..addAll(processed);
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

  /// Filters out 0-value tokens (keeping mainnet natives and any token with a
  /// non-zero quantity), guarantees a row for each supported mainnet native,
  /// then sorts by USD value desc then chainId.
  List<Map<String, dynamic>> _processBalances(
    List<Map<String, dynamic>> apiBalances,
    Map<String, String> addresses,
  ) {
    final result = apiBalances.where((b) {
      // Drop scam/airdrop tokens (URLs/domains/brackets in symbol, blocklist).
      if (_isSpam(b)) return false;
      final value = (b['value'] as num?)?.toDouble() ?? 0.0;
      if (value > 0) return true;
      final chainId = b['chainId'] as String? ?? '';
      if (_mainnetNatives.containsKey(chainId) && _isNative(b)) return true;
      final numeric =
          double.tryParse(b['quantity']?['numeric']?.toString() ?? '') ?? 0.0;
      return numeric > 0;
    }).toList();

    // Ensure each supported mainnet native is present even at 0 balance.
    _mainnetNatives.forEach((chainId, symbol) {
      final namespace = chainId.split(':').first;
      if (!addresses.containsKey(namespace)) return;
      final present = result.any(
        (b) => b['chainId'] == chainId && _isNative(b),
      );
      if (present) return;

      final chainData = ChainsDataList.allChains.firstWhere(
        (e) => e.chainId == chainId,
        orElse: () => ChainsDataList.eip155Chains.first,
      );
      result.add({
        'name': chainData.name,
        'symbol': symbol,
        'chainId': chainId,
        'value': 0.0,
        'price': 0.0,
        'quantity': {'decimals': '0', 'numeric': '0'},
        'iconUrl': chainData.logo,
      });
    });

    result.sort((a, b) {
      final bValue = (b['value'] as num?)?.toDouble() ?? 0.0;
      final aValue = (a['value'] as num?)?.toDouble() ?? 0.0;
      if (aValue != bValue) return bValue.compareTo(aValue);
      final aChain = a['chainId'] as String? ?? '';
      final bChain = b['chainId'] as String? ?? '';
      return aChain.compareTo(bChain);
    });

    return result;
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
                          child:
                              CircularProgressIndicator(color: colors.accent),
                        ),
                      )
                    else if (_filteredBalances.isEmpty)
                      Container(
                        height: 64.0,
                        decoration: BoxDecoration(
                          color: colors.foregroundPrimary,
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
                        final namespace = chainId.split(':').first;
                        final rowAddress = _addresses[namespace] ?? '';

                        return Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.s2),
                          child: GestureDetector(
                            onTap: rowAddress.isEmpty
                                ? null
                                : () =>
                                    _copyAddress(rowAddress, chainData.name),
                            child: Container(
                              height: 86.0,
                              decoration: BoxDecoration(
                                color: colors.foregroundPrimary,
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.s6,
                              ),
                              child: Row(
                                children: [
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      CircleAvatar(
                                        radius: 19,
                                        backgroundColor:
                                            colors.backgroundTertiary,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(19),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: iconUrl,
                                            width: 38.0,
                                            height: 38.0,
                                            errorWidget:
                                                (context, url, error) =>
                                                    const SizedBox.shrink(),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: -2,
                                        bottom: -2,
                                        child: CircleAvatar(
                                          radius: 9,
                                          backgroundColor: colors.background,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(7),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl: chainData.logo,
                                              width: 14.0,
                                              height: 14.0,
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const SizedBox.shrink(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: AppSpacing.s3),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          _formatAmount(quantity, symbol),
                                          style: TextStyle(
                                            color: colors.textPrimary,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        if (rowAddress.isNotEmpty) ...[
                                          const SizedBox(
                                            height: AppSpacing.s05,
                                          ),
                                          Text(
                                            _shortAddress(rowAddress),
                                            style: TextStyle(
                                              color: colors.textSecondary,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.all(AppSpacing.s2),
                                    child: SvgPicture.asset(
                                      'assets/CopySimple.svg',
                                      width: 20.0,
                                      height: 20.0,
                                      colorFilter: ColorFilter.mode(
                                        colors.textPrimary,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
                        color: isSelected ? colors.accent : colors.inputBorder,
                      ),
                    ),
                    labelStyle: TextStyle(
                      fontSize: 13.0,
                      color: isSelected ? colors.accent : colors.textPrimary,
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
