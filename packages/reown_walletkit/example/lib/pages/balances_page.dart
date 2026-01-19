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
                    if (_isLoading)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24.0),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else if (_balances.isEmpty)
                      WCPTextField(
                        controller: TextEditingController(),
                        focusNode: FocusNode(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18.0,
                        ),
                        label: 'No balances found',
                        enabled: false,
                      )
                    else
                      ..._balances.map(
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
