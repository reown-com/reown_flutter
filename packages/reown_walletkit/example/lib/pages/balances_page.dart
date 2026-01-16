import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/evm_service.dart';
import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/i_key_service.dart';
import 'package:reown_walletkit_wallet/models/chain_data.dart';
import 'package:reown_walletkit_wallet/utils/constants.dart';

class BalancesPage extends StatefulWidget {
  const BalancesPage({
    super.key,
    required this.isDarkMode,
  });
  final bool isDarkMode;

  @override
  State<BalancesPage> createState() => _BalancesPageState();
}

class _BalancesPageState extends State<BalancesPage> {
  final _walletKitService = GetIt.I<IWalletKitService>();
  final _keysService = GetIt.I<IKeyService>();
  int _currentAccountIndex = 0;
  final List<Map<String, dynamic>> _balances = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _updateBalance();
  }

  Future<void> _updateBalance() async {
    if (!mounted) return;
    setState(() => _isLoading = true);

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
      final chainKey = chainKeys[_currentAccountIndex];
      final evmService = _walletKitService.getChainService<EVMService>(
        chainId: selectedChain.chainId,
      );

      evmService.getBalance(address: chainKey.address).then((balances) {
        if (!mounted) return;
        setState(() {
          _balances
            ..clear()
            ..addAll(balances);
          _isLoading = false;
        });
      }).onError((error, stackTrace) {
        if (!mounted) return;
        setState(() {
          _balances.clear();
          _isLoading = false;
        });
        debugPrint('Error fetching balance: $error');
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
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Address display
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color:
                                StyleConstants.neutrals.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(
                              StyleConstants.linear16,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Address',
                                style:
                                    StyleConstants.wcpTextPrimaryStyle.copyWith(
                                  color: StyleConstants.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                chainKeys[_currentAccountIndex].address,
                                style:
                                    StyleConstants.wcpTextPrimaryStyle.copyWith(
                                  color: StyleConstants.textPrimary,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  if (_isLoading)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else if (_balances.isEmpty)
                    Container(
                      padding: const EdgeInsets.all(24.0),
                      decoration: BoxDecoration(
                        color: StyleConstants.neutrals.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(
                          StyleConstants.linear16,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'No balances found',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    )
                  else
                    ..._balances.map((balance) {
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

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12.0),
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: StyleConstants.neutrals.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(
                            StyleConstants.linear16,
                          ),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.white,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                child: CachedNetworkImage(
                                  imageUrl: iconUrl,
                                  width: 32.0,
                                  height: 32.0,
                                  errorWidget: (context, url, error) =>
                                      const SizedBox.shrink(),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '${quantity.toStringAsFixed(6)} $symbol',
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        ' (${value.toStringAsFixed(2)} USD)',
                                        style: const TextStyle(
                                          fontSize: 13.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    chainData.name,
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      color: StyleConstants.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12.0),
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.transparent,
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                child: CachedNetworkImage(
                                  imageUrl: chainData.logo,
                                  width: 32.0,
                                  height: 32.0,
                                  errorWidget: (context, url, error) =>
                                      const SizedBox.shrink(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                ],
              ),
            ),
    );
  }
}
