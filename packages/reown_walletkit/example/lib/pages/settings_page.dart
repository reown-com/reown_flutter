import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/evm_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/solana_service_2.dart';
import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/i_key_service.dart';
import 'package:reown_walletkit_wallet/models/chain_data.dart';
import 'package:reown_walletkit_wallet/models/chain_metadata.dart';
import 'package:reown_walletkit_wallet/utils/constants.dart';
import 'package:reown_walletkit_wallet/widgets/custom_button.dart';
import 'package:reown_walletkit_wallet/widgets/recover_from_seed.dart';
import 'package:toastification/toastification.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final keysService = GetIt.I<IKeyService>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _EVMAccounts(
                  onCreateAddress: () async {
                    await keysService.createAddressFromSeed();
                    await keysService.loadKeys();
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                    setState(() {});
                  },
                  onAccountChanged: (address) async {
                    final walletKit = GetIt.I<IWalletKitService>().walletKit;
                    final sessions = walletKit.sessions.getAll();
                    for (var session in sessions) {
                      await walletKit.emitSessionEvent(
                        topic: session.topic,
                        chainId: 'eip155:1',
                        event: SessionEventParams(
                          name: 'accountsChanged',
                          data: [address],
                        ),
                      );
                    }
                    setState(() {});
                  },
                ),
                //
                const SizedBox(height: 20.0),
                const Divider(height: 1.0),
                _SolanaAccounts(),
                const SizedBox(height: 20.0),
                const Divider(height: 1.0),
                _PolkadotAccounts(),
                const SizedBox(height: 20.0),
                const Divider(height: 1.0),
                _KadenaAccounts(),
                const SizedBox(height: 20.0),
                const Divider(height: 1.0),
                _DeviceData(),
                const SizedBox(height: 20.0),
                const Divider(height: 1.0),
                _Metadata(),
                const SizedBox(height: 20.0),
                const Divider(height: 1.0),
                _Buttons(
                  onDeleteData: () async {
                    final walletKit = GetIt.I<IWalletKitService>().walletKit;
                    await walletKit.core.storage.deleteAll();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Storage cleared'),
                      duration: Duration(seconds: 1),
                    ));
                  },
                  onRestoreFromSeed: () async {
                    final mnemonic =
                        await GetIt.I<IBottomSheetService>().queueBottomSheet(
                      widget: RecoverFromSeed(),
                    );
                    if (mnemonic is String) {
                      await keysService.restoreWalletFromSeed(
                        mnemonic: mnemonic,
                      );
                      await keysService.loadKeys();
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            content: Text('Wallet from seed restored'),
                          );
                        },
                      );
                      setState(() {});
                    }
                  },
                  onRestoreDefault: () async {
                    await keysService.clearAll();
                    await keysService.loadDefaultWallet();
                    await keysService.loadKeys();
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          content: Text('Default wallet restored'),
                        );
                      },
                    );
                    setState(() {});
                  },
                ),
                //
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Metadata extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final walletKit = GetIt.I<IWalletKitService>().walletKit;
    final nativeLink = walletKit.metadata.redirect?.native;
    final universalLink = walletKit.metadata.redirect?.universal;
    final linkMode = walletKit.metadata.redirect?.linkMode;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox.square(dimension: 20.0),
          _DataContainer(
            title: 'Redirect',
            data:
                'Native: $nativeLink\nUniversal: $universalLink\nLink Mode: $linkMode',
          ),
        ],
      ),
    );
  }
}

class _EVMAccounts extends StatefulWidget {
  final VoidCallback onCreateAddress;
  final Function(String) onAccountChanged;
  const _EVMAccounts({
    required this.onCreateAddress,
    required this.onAccountChanged,
  });

  @override
  State<_EVMAccounts> createState() => _EVMAccountsState();
}

class _EVMAccountsState extends State<_EVMAccounts> {
  int _currentPage = 0;
  late final PageController _pageController;
  ChainMetadata? _selectedChain;
  double _balance = 0.0;

  @override
  void initState() {
    super.initState();
    _selectedChain = ChainsDataList.eip155Chains.first;
    _pageController = PageController();
    final keysService = GetIt.I<IKeyService>();
    final chainKeys = keysService.getKeysForChain('eip155');
    GetIt.I
        .get<EVMService>(instanceName: _selectedChain!.chainId)
        .getBalance(address: chainKeys[_currentPage].address)
        .then((value) {
      if (!mounted) return;
      setState(() => _balance = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final keysService = GetIt.I<IKeyService>();
    final chainKeys = keysService.getKeysForChain('eip155');
    debugPrint('[$runtimeType] chainKeys ${chainKeys.length}');
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'EVM Accounts (${_currentPage + 1}/${chainKeys.length})',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
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
                          'This will create a new address out from the same seed phrase',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: widget.onCreateAddress,
                            child: const Text('Proceed'),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.add_box_rounded),
                padding: const EdgeInsets.all(0.0),
                visualDensity: VisualDensity.compact,
              ),
              IconButton(
                onPressed: (_currentPage == 0)
                    ? null
                    : () {
                        _pageController.jumpToPage(_currentPage - 1);
                      },
                icon: const Icon(Icons.arrow_back),
                padding: const EdgeInsets.all(0.0),
                visualDensity: VisualDensity.compact,
              ),
              IconButton(
                onPressed: (_currentPage == chainKeys.length - 1)
                    ? null
                    : () {
                        _pageController.jumpToPage(_currentPage + 1);
                      },
                icon: const Icon(Icons.arrow_forward),
                padding: const EdgeInsets.all(0.0),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  '${_balance.toStringAsFixed(4)} ETH',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              DropdownButton(
                value: _selectedChain,
                items: ChainsDataList.eip155Chains.map((e) {
                  return DropdownMenuItem<ChainMetadata>(
                    value: e,
                    child: Text(e.name),
                  );
                }).toList(),
                onChanged: (ChainMetadata? chain) {
                  setState(() => _selectedChain = chain);
                  final chainKey = chainKeys[_currentPage];
                  GetIt.I
                      .get<EVMService>(instanceName: chain?.chainId)
                      .getBalance(address: chainKey.address)
                      .then((value) => setState(() => _balance = value));
                },
              ),
            ],
          ),
        ),
        SizedBox(
          height: 300.0,
          child: PageView.builder(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (value) async {
              setState(() => _currentPage = value);
              final chainKey = chainKeys[_currentPage];
              widget.onAccountChanged(chainKey.address);
            },
            itemBuilder: (BuildContext context, int index) {
              final chainKey = chainKeys[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    const SizedBox(height: 12.0),
                    _DataContainer(
                      title: 'CAIP-10',
                      data: '${_selectedChain?.chainId}:${chainKey.address}',
                      height: 84.0,
                    ),
                    const SizedBox(height: 12.0),
                    _DataContainer(
                      title: 'Public key',
                      data: chainKey.publicKey,
                      height: 84.0,
                    ),
                    const SizedBox(height: 12.0),
                    _DataContainer(
                      title: 'Private key',
                      data: chainKey.privateKey,
                      blurred: true,
                      height: 84.0,
                    ),
                    const SizedBox(height: 12.0),
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
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: CircleAvatar(
                      radius: e.$1 == _currentPage ? 4.0 : 3.0,
                      backgroundColor:
                          e.$1 == _currentPage ? Colors.black : Colors.black38,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        const SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: FutureBuilder<String>(
            future: keysService.getMnemonic(),
            builder: (context, snapshot) {
              return _DataContainer(
                title: 'Seed phrase',
                data: snapshot.data ?? '',
                blurred: true,
              );
            },
          ),
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
  ChainMetadata? _selectedChain;
  double _balance = 0.0;

  @override
  void initState() {
    super.initState();
    try {
      _selectedChain = ChainsDataList.solanaChains.first;
      final keysService = GetIt.I<IKeyService>();
      final chainKeys = keysService.getKeysForChain('solana');
      GetIt.I
          .get<SolanaService2>(instanceName: _selectedChain!.chainId)
          .getBalance(address: chainKeys.first.address)
          .then((value) {
        if (!mounted) return;
        setState(() => _balance = value);
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final keysService = GetIt.I<IKeyService>();
    final chainKeys = keysService.getKeysForChain('solana');
    if (chainKeys.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(12.0),
          child: Row(
            children: [
              SizedBox.square(dimension: 8.0),
              Expanded(
                child: Text(
                  'Solana Account',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  '${_balance.toStringAsFixed(3)} SOL',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              DropdownButton(
                value: _selectedChain,
                items: ChainsDataList.solanaChains.map((e) {
                  return DropdownMenuItem<ChainMetadata>(
                    value: e,
                    child: Text(e.name),
                  );
                }).toList(),
                onChanged: (ChainMetadata? chain) {
                  setState(() => _selectedChain = chain);
                  final chainKey = chainKeys.first;
                  GetIt.I
                      .get<SolanaService2>(instanceName: chain?.chainId)
                      .getBalance(address: chainKey.address)
                      .then((value) => setState(() => _balance = value));
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              _DataContainer(
                title: 'Address',
                data: chainKeys.first.address,
              ),
              const SizedBox(height: 12.0),
              _DataContainer(
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

class _PolkadotAccounts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final keysService = GetIt.I<IKeyService>();
    final chainKeys = keysService.getKeysForChain('polkadot');
    if (chainKeys.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(12.0),
          child: Row(
            children: [
              SizedBox.square(dimension: 8.0),
              Expanded(
                child: Text(
                  'Polkadot Account',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              _DataContainer(
                title: 'Address',
                data: chainKeys.first.address,
              ),
              const SizedBox(height: 12.0),
              _DataContainer(
                title: 'Mnemonic',
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

class _KadenaAccounts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final keysService = GetIt.I<IKeyService>();
    final chainKeys = keysService.getKeysForChain('kadena');
    if (chainKeys.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(12.0),
          child: Row(
            children: [
              SizedBox.square(dimension: 8.0),
              Expanded(
                child: Text(
                  'Kadena Account',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              _DataContainer(
                title: 'Address',
                data: chainKeys.first.address,
              ),
              const SizedBox(height: 12.0),
              _DataContainer(
                title: 'Secret key',
                data: chainKeys.first.privateKey,
                blurred: true,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _DeviceData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final walletKit = GetIt.I<IWalletKitService>().walletKit;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8.0, bottom: 8.0, top: 12.0),
            child: Text(
              'Device',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          FutureBuilder<String>(
            future: walletKit.core.crypto.getClientId(),
            builder: (context, snapshot) {
              return _DataContainer(
                title: 'Client ID',
                data: snapshot.data ?? '',
              );
            },
          ),
          const SizedBox(height: 12.0),
          FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const SizedBox.shrink();
              }
              final v = snapshot.data!.version;
              final b = snapshot.data!.buildNumber;
              const f = String.fromEnvironment('FLUTTER_APP_FLAVOR');
              return _DataContainer(
                title: 'App version',
                data: '$v-$f ($b) - SDK v$packageVersion',
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  final VoidCallback onRestoreFromSeed;
  final VoidCallback onRestoreDefault;
  final VoidCallback onDeleteData;
  const _Buttons({
    required this.onRestoreFromSeed,
    required this.onRestoreDefault,
    required this.onDeleteData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          const SizedBox(height: 8.0),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onDeleteData,
              child: Text(
                'Clear local storage',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          Row(
            children: [
              CustomButton(
                type: CustomButtonType.normal,
                onTap: onRestoreFromSeed,
                child: const Center(
                  child: Text(
                    'Restore wallet from seed',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Row(
            children: [
              CustomButton(
                type: CustomButtonType.invalid,
                onTap: onRestoreDefault,
                child: const Center(
                  child: Text(
                    'Restore default wallet',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DataContainer extends StatefulWidget {
  const _DataContainer({
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
  State<_DataContainer> createState() => __DataContainerState();
}

class __DataContainerState extends State<_DataContainer> {
  late bool blurred;

  @override
  void initState() {
    super.initState();
    blurred = widget.blurred;
  }

  @override
  Widget build(BuildContext context) {
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
          color: StyleConstants.lightGray,
          borderRadius: BorderRadius.circular(
            StyleConstants.linear16,
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8.0),
                const Icon(Icons.copy, size: 14.0),
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
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SizeReportingWidget extends StatefulWidget {
  final Widget child;
  final ValueChanged<Size> onSizeChange;

  const SizeReportingWidget({
    super.key,
    required this.child,
    required this.onSizeChange,
  });

  @override
  State<SizeReportingWidget> createState() => _SizeReportingWidgetState();
}

class _SizeReportingWidgetState extends State<SizeReportingWidget> {
  Size? _oldSize;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _notifySize());
    return widget.child;
  }

  void _notifySize() {
    if (!mounted) {
      return;
    }
    final size = context.size;
    if (_oldSize != size && size != null) {
      _oldSize = size;
      widget.onSizeChange(size);
    }
  }
}

class ExpandablePageView extends StatefulWidget {
  final List<Widget> children;
  final PageController? controller;
  final Function(int)? onPageChanged;

  const ExpandablePageView({
    super.key,
    required this.children,
    this.controller,
    this.onPageChanged,
  });

  @override
  State<ExpandablePageView> createState() => _ExpandablePageViewState();
}

class _ExpandablePageViewState extends State<ExpandablePageView>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late List<double> _heights;
  int _currentPage = 0;

  double get _currentHeight => _heights[_currentPage];

  @override
  void initState() {
    super.initState();
    _heights = widget.children.map((e) => 0.0).toList();
    _pageController = widget.controller ?? PageController()
      ..addListener(() {
        final newPage = _pageController.page?.round() ?? 0;
        if (_currentPage != newPage) {
          setState(() => _currentPage = newPage);
        }
      });
  }

  @override
  void didUpdateWidget(covariant ExpandablePageView oldWidget) {
    super.didUpdateWidget(oldWidget);
    final diff = widget.children.length - oldWidget.children.length;
    if (diff > 0) {
      for (var i = 0; i < diff; i++) {
        final lastHeight = _heights.last;
        _heights.add(lastHeight);
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('${_heights[0]} $_currentHeight');
    return TweenAnimationBuilder<double>(
      curve: Curves.easeInOutCubic,
      duration: const Duration(milliseconds: 50),
      tween: Tween<double>(
        begin: max(_heights[0], 200.0),
        end: max(_currentHeight, 200.0),
      ),
      builder: (context, value, child) => SizedBox(
        height: value,
        child: child,
      ),
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: widget.onPageChanged,
        children: _sizeReportingChildren
            .asMap() //
            .map((index, child) => MapEntry(index, child))
            .values
            .toList(),
      ),
    );
  }

  List<Widget> get _sizeReportingChildren => widget.children
      .asMap() //
      .map(
        (index, child) => MapEntry(
          index,
          OverflowBox(
            //needed, so that parent won't impose its constraints on the children, thus skewing the measurement results.
            minHeight: 0,
            maxHeight: double.infinity,
            alignment: Alignment.topCenter,
            child: SizeReportingWidget(
              onSizeChange: (size) =>
                  setState(() => _heights[index] = size.height),
              child: Align(child: child),
            ),
          ),
        ),
      )
      .values
      .toList();
}
