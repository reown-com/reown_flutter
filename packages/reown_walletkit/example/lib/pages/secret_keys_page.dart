import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/evm_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/tron_service.dart';
import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/chain_key.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/i_key_service.dart';
import 'package:reown_walletkit_wallet/models/chain_data.dart';
import 'package:reown_walletkit_wallet/models/chain_metadata.dart';
import 'package:reown_walletkit_wallet/theme/app_colors.dart';
import 'package:reown_walletkit_wallet/theme/app_radius.dart';
import 'package:reown_walletkit_wallet/theme/app_spacing.dart';
import 'package:toastification/toastification.dart';

class SecretKeysPage extends StatelessWidget {
  const SecretKeysPage({super.key});

  @override
  Widget build(BuildContext context) {
    final keysService = GetIt.I<IKeyService>();
    final colors = context.colors;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Secret Keys & Phrases',
          style: TextStyle(color: colors.textPrimary),
        ),
        backgroundColor: colors.background,
        iconTheme: IconThemeData(color: colors.textPrimary),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<List<ChainKey>>(
          future: keysService.loadKeys(),
          initialData: keysService.keys,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox.shrink();
            }
            return Column(
              children: snapshot.data!.map((e) {
                if (e.namespace == 'eip155') {
                  return _EVMAccounts();
                }
                if (e.namespace == 'solana') {
                  return _SolanaAccounts();
                }
                return _ChainKeyView(chain: e.namespace);
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}

class _EVMAccounts extends StatefulWidget {
  @override
  State<_EVMAccounts> createState() => _EVMAccountsState();
}

class _EVMAccountsState extends State<_EVMAccounts> {
  final _walletKitService = GetIt.I<IWalletKitService>();
  final _walletKit = GetIt.I<IWalletKitService>().walletKit;
  final _keysService = GetIt.I<IKeyService>();
  late final PageController _pageController;
  late ChainMetadata _selectedChain;

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _selectedChain = _walletKitService.currentSelectedChain.value!;
    _walletKitService.currentSelectedChain.addListener(_onChainChanged);
    _updateBalance();
  }

  @override
  void dispose() {
    _walletKitService.currentSelectedChain.removeListener(_onChainChanged);
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onChainChanged() async {
    final chain = _walletKitService.currentSelectedChain.value;
    await _switchToChain(chain);
  }

  Future<void> _switchToChain(ChainMetadata? chainMetadata) async {
    try {
      final sessions = _walletKit.sessions.getAll();
      final chainId = chainMetadata!.chainId.split(':').last;
      for (var session in sessions) {
        await _walletKit.emitSessionEvent(
          topic: session.topic,
          chainId: chainMetadata.chainId,
          event: SessionEventParams(
            name: 'chainChanged',
            data: int.parse(chainId),
          ),
        );
        debugPrint(
          '[SampleWallet] chainChanged event sent for session ${session.topic}',
        );
      }
      if (!mounted) return;
      setState(() => _selectedChain = chainMetadata);
      await _updateBalance();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  final List<Map<String, dynamic>> _balances = [];
  Future<void> _updateBalance() async {
    if (!mounted) return;
    final chainKeys = _keysService.getKeysForChain('eip155');
    final chainKey = chainKeys[_currentPage];
    final evmService = _walletKitService.getChainService<EVMService>(
      chainId: _selectedChain.chainId,
    );
    evmService.getBalance(address: chainKey.address).then((balances) {
      if (!mounted) return;
      _balances
        ..clear()
        ..addAll(balances);
      setState(() {});
    }).onError((a, b) {
      if (!mounted) return;
      _balances.clear();
      setState(() {});
    });
    setState(() => {});
  }

  Future<void> _onCreateEVMAddress() async {
    await _keysService.createAddressFromSeed();
    await _keysService.loadKeys();
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    setState(() {});
  }

  Future<void> _onEVMAccountChanged(String address) async {
    final sessions = _walletKit.sessions.getAll();
    for (var session in sessions) {
      await _walletKit.emitSessionEvent(
        topic: session.topic,
        chainId: 'eip155:1',
        event: SessionEventParams(name: 'accountsChanged', data: [address]),
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final chainKeys = _keysService.getKeysForChain('eip155');
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s3),
          child: Row(
            children: [
              CachedNetworkImage(
                imageUrl: ChainsDataList.eip155Chains.first.logo,
                width: 20.0,
                height: 20.0,
                errorWidget: (context, url, error) => const SizedBox.shrink(),
              ),
              SizedBox.square(dimension: AppSpacing.s2),
              Expanded(
                child: Text(
                  'EVM Accounts (${_currentPage + 1}/${chainKeys.length})',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: colors.textPrimary,
                  ),
                ),
              ),
              IconButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Create new account'),
                        content: const Text(
                          'This will create a new address out from the seed',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: _onCreateEVMAddress,
                            child: const Text('Proceed'),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(Icons.add_box_rounded, color: colors.textPrimary),
                padding: const EdgeInsets.all(0.0),
                visualDensity: VisualDensity.compact,
              ),
              IconButton(
                onPressed: (_currentPage == 0)
                    ? null
                    : () => _pageController.jumpToPage(_currentPage - 1),
                icon: Icon(Icons.arrow_back, color: colors.textPrimary),
                padding: const EdgeInsets.all(0.0),
                visualDensity: VisualDensity.compact,
              ),
              IconButton(
                onPressed: (_currentPage == chainKeys.length - 1)
                    ? null
                    : () {
                        _pageController.jumpToPage(_currentPage + 1);
                      },
                icon: Icon(Icons.arrow_forward, color: colors.textPrimary),
                padding: const EdgeInsets.all(0.0),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: AppSpacing.s3, right: AppSpacing.s3, bottom: AppSpacing.s2),
          child: Align(
            alignment: AlignmentGeometry.centerRight,
            child: SizedBox(
              width: 200.0,
              child: DropdownButton(
                key: Key('evm_chains'),
                isExpanded: true,
                value: _selectedChain,
                dropdownColor: colors.backgroundSecondary,
                items: ChainsDataList.eip155Chains.map((ChainMetadata chain) {
                  return DropdownMenuItem<ChainMetadata>(
                    value: chain,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: CachedNetworkImage(
                              imageUrl: chain.logo,
                              width: 20.0,
                              height: 20.0,
                              errorWidget: (context, url, error) =>
                                  const SizedBox.shrink(),
                            ),
                          ),
                          TextSpan(
                            text: ' ${chain.name}',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: colors.textPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (ChainMetadata? chain) async {
                  setState(() => _selectedChain = chain!);
                  final sessions = _walletKit.sessions.getAll();
                  final cid = _selectedChain.chainId.split(':').last;
                  for (var session in sessions) {
                    await _walletKit.emitSessionEvent(
                      topic: session.topic,
                      chainId: _selectedChain.chainId,
                      event: SessionEventParams(
                        name: 'chainChanged',
                        data: int.parse(cid),
                      ),
                    );
                  }
                  _updateBalance();
                },
              ),
            ),
          ),
        ),
        SizedBox(
          height: 210.0,
          child: PageView.builder(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (value) async {
              setState(() => _currentPage = value);
              final chainKey = chainKeys[_currentPage];
              _onEVMAccountChanged(chainKey.address);
            },
            itemBuilder: (BuildContext context, int index) {
              final chainKey = chainKeys[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s3),
                child: Column(
                  children: [
                    const SizedBox(height: AppSpacing.s3),
                    DataContainer(
                      title: 'CAIP-10',
                      data: '${_selectedChain.chainId}:${chainKey.address}',
                      height: 84.0,
                    ),
                    const SizedBox(height: AppSpacing.s3),
                    DataContainer(
                      title: 'Private key',
                      data: chainKey.privateKey,
                      blurred: true,
                      height: 84.0,
                    ),
                    const SizedBox(height: AppSpacing.s3),
                  ],
                ),
              );
            },
            itemCount: chainKeys.length,
          ),
        ),
        SizedBox(
          height: 16.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            // ignore: sdk_version_since
            children: chainKeys.indexed
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s05),
                    child: CircleAvatar(
                      radius: e.$1 == _currentPage ? 4.0 : 3.0,
                      backgroundColor: e.$1 == _currentPage
                          ? colors.textSecondary
                          : colors.textSecondary.withValues(alpha: 0.5),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        Builder(
          builder: (BuildContext context) {
            final mnemonic = _keysService.getMnemonic();
            return Visibility(
              visible: mnemonic.isNotEmpty,
              child: Column(
                children: [
                  const SizedBox(height: AppSpacing.s5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s3),
                    child: DataContainer(
                      title: 'Mnemonic phrase',
                      data: mnemonic,
                      blurred: true,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _SolanaAccounts extends StatefulWidget {
  @override
  State<_SolanaAccounts> createState() => _SolanaAccountsState();
}

class _SolanaAccountsState extends State<_SolanaAccounts> {
  final _keysService = GetIt.I<IKeyService>();
  ChainMetadata? _selectedChain;

  @override
  void initState() {
    super.initState();
    try {
      _selectedChain = ChainsDataList.solanaChains.first;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final chainKeys = _keysService.getKeysForChain('solana');
    if (chainKeys.isEmpty) return const SizedBox.shrink();
    final chainData = ChainsDataList.allChains.firstWhere(
      (e) => e.chainId == chainKeys.first.chains.first,
    );
    return Column(
      children: [
        const SizedBox(height: AppSpacing.s5),
        Divider(height: 1.0, color: colors.divider),
        Padding(
          padding: EdgeInsets.only(left: AppSpacing.s3, right: AppSpacing.s3, top: AppSpacing.s3),
          child: Row(
            children: [
              CachedNetworkImage(
                imageUrl: chainData.logo,
                width: 20.0,
                height: 20.0,
                errorWidget: (context, url, error) => const SizedBox.shrink(),
              ),
              SizedBox.square(dimension: AppSpacing.s2),
              Expanded(
                child: Text(
                  'Solana Accounts',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: colors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: AppSpacing.s3,
            right: AppSpacing.s3,
            top: 10.0,
            bottom: AppSpacing.s2,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              SizedBox(
                width: 200.0,
                child: DropdownButton(
                  key: Key('solana_chains'),
                  isExpanded: true,
                  value: _selectedChain,
                  dropdownColor: colors.backgroundSecondary,
                  items: ChainsDataList.solanaChains.map((ChainMetadata chain) {
                    return DropdownMenuItem<ChainMetadata>(
                      value: chain,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: CachedNetworkImage(
                                imageUrl: chain.logo,
                                width: 20.0,
                                height: 20.0,
                                errorWidget: (context, url, error) =>
                                    const SizedBox.shrink(),
                              ),
                            ),
                            TextSpan(
                              text: ' ${chain.name}',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: colors.textPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (ChainMetadata? chain) {
                    setState(() => _selectedChain = chain!);
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox.square(dimension: AppSpacing.s2),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s3),
          child: Column(
            children: [
              DataContainer(
                title: 'CAIP-10',
                data: '${_selectedChain!.chainId}:${chainKeys.first.address}',
              ),
              const SizedBox(height: AppSpacing.s3),
              DataContainer(
                title: 'Secret key',
                data: chainKeys.first.privateKey,
                blurred: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ChainKeyView extends StatefulWidget {
  const _ChainKeyView({required this.chain});
  final String chain;

  @override
  State<_ChainKeyView> createState() => _ChainKeyViewState();
}

class _ChainKeyViewState extends State<_ChainKeyView> {
  final _keysService = GetIt.I<IKeyService>();
  ChainMetadata? _selectedChain;
  double _balance = 0.0;

  @override
  void initState() {
    super.initState();
    if (widget.chain.contains('tron')) {
      try {
        _selectedChain = ChainsDataList.tronChains.first;
        _updateTronBalance();
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  Future<void> _updateTronBalance() async {
    if (!mounted) return;
    if (!widget.chain.contains('tron')) return;
    if (!_selectedChain!.chainId.contains('tron')) return;

    final chainKeys = _keysService.getKeysForChain('tron');
    final tronService = GetIt.I<IWalletKitService>()
        .getChainService<TronService>(chainId: _selectedChain!.chainId);
    final address = chainKeys.first.address;
    tronService.getBalance(address: address).then((value) {
      if (!mounted) return;
      setState(() => _balance = value);
      debugPrint('_updateTronBalance $value');
    }).catchError((error) {
      debugPrint('_updateTronBalance error $error');
    });
    tronService.getTokens(address: address).then((tokens) {
      for (var token in tokens) {
        final balance = tronService.parsedBalance(token.values.first);
        debugPrint('${token.keys.first} $balance');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final chainKeys = _keysService.getKeysForChain(widget.chain);
    if (chainKeys.isEmpty) return const SizedBox.shrink();
    final chainData = ChainsDataList.allChains.firstWhere(
      (e) => e.chainId == chainKeys.first.chains.first,
    );
    return Column(
      children: [
        const SizedBox(height: AppSpacing.s5),
        Divider(height: 1.0, color: colors.divider),
        Padding(
          padding: EdgeInsets.all(AppSpacing.s3),
          child: Row(
            children: [
              CachedNetworkImage(
                imageUrl: chainData.logo,
                width: 20.0,
                height: 20.0,
                errorWidget: (context, url, error) {
                  return CachedNetworkImage(
                    imageUrl:
                        'https://avatars.githubusercontent.com/u/179229932?s=200&v=4',
                  );
                },
              ),
              SizedBox.square(dimension: AppSpacing.s2),
              Expanded(
                child: Text(
                  '${widget.chain} account',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: colors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: chainData.chainId.contains('tron'),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
              right: 12.0,
              top: 10.0,
              bottom: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    '${_balance.toStringAsFixed(4)} ${chainData.currency}',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: colors.textPrimary,
                    ),
                  ),
                ),
                SizedBox(
                  width: 200.0,
                  child: DropdownButton(
                    key: Key('tron_chains'),
                    isExpanded: true,
                    value: _selectedChain,
                    dropdownColor: colors.backgroundSecondary,
                    items: ChainsDataList.tronChains.map((chainData) {
                      return DropdownMenuItem<ChainMetadata>(
                        value: chainData,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: CachedNetworkImage(
                                  imageUrl: chainData.logo,
                                  width: 20.0,
                                  height: 20.0,
                                  errorWidget: (context, url, error) =>
                                      const SizedBox.shrink(),
                                ),
                              ),
                              TextSpan(
                                text: ' ${chainData.name}',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: colors.textPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (ChainMetadata? chain) {
                      setState(() => _selectedChain = chain!);
                      _updateTronBalance();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox.square(dimension: AppSpacing.s2),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s3),
          child: Column(
            children: [
              DataContainer(
                title: 'CAIP-10',
                data: '${chainData.chainId}:${chainKeys.first.address}',
              ),
              const SizedBox(height: AppSpacing.s3),
              DataContainer(
                title: 'Secret key',
                data: chainKeys.first.privateKey,
                blurred: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DataContainer extends StatefulWidget {
  const DataContainer({
    super.key,
    required this.title,
    required this.data,
    this.blurred = false,
    this.height,
  });
  final String title;
  final String data;
  final bool blurred;
  final double? height;

  @override
  State<DataContainer> createState() => _DataContainerState();
}

class _DataContainerState extends State<DataContainer> {
  late bool blurred;

  @override
  void initState() {
    super.initState();
    blurred = widget.blurred;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final blurValue = blurred ? 5.0 : 0.0;
    return GestureDetector(
      onTap: () => Clipboard.setData(ClipboardData(text: widget.data)).then(
        (_) => toastification.show(
          title: Text('${widget.title} copied'),
          context: context,
          autoCloseDuration: Duration(seconds: 2),
          alignment: Alignment.bottomCenter,
        ),
      ),
      onLongPress: () => setState(() {
        blurred = false;
      }),
      onLongPressUp: () => setState(() {
        blurred = widget.blurred;
      }),
      child: Container(
        height: widget.height,
        decoration: BoxDecoration(
          color: colors.neutrals.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        padding: const EdgeInsets.all(AppSpacing.s3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: colors.textPrimary,
                  ),
                ),
                const SizedBox(width: AppSpacing.s2),
                Icon(Icons.copy, size: 14.0, color: colors.textSecondary),
              ],
            ),
            ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: blurValue,
                sigmaY: blurValue,
                tileMode: TileMode.decal,
              ),
              child: Text(
                widget.data,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                  color: colors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
