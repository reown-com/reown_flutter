import 'dart:io';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/evm_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/solana_service.dart';
import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/chain_key.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/i_key_service.dart';
import 'package:reown_walletkit_wallet/models/chain_data.dart';
import 'package:reown_walletkit_wallet/models/chain_metadata.dart';
import 'package:reown_walletkit_wallet/pages/chain_abstraction_prepare_page.dart';
import 'package:reown_walletkit_wallet/utils/constants.dart';
import 'package:reown_walletkit_wallet/widgets/custom_button.dart';
import 'package:reown_walletkit_wallet/widgets/recover_from_seed.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _keysService = GetIt.I<IKeyService>();

  Future<void> _onDeleteData() async {
    final walletKit = GetIt.I<IWalletKitService>().walletKit;
    await walletKit.core.storage.deleteAll();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Storage cleared'),
      duration: Duration(seconds: 1),
    ));
  }

  Future<void> _onRestoreFromSeed() async {
    final mnemonic = await GetIt.I<IBottomSheetService>().queueBottomSheet(
      widget: RecoverFromSeed(),
    );
    if (mnemonic is String) {
      await _keysService.clearAll();
      await _keysService.restoreWallet(
        mnemonicOrPrivate: mnemonic,
      );
      await _keysService.loadKeys();
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
              content: Text('Wallet restored. App will close.'));
        },
      );
      if (!kDebugMode) {
        exit(0);
      } else {
        setState(() {});
      }
    }
  }

  Future<void> _onRegenerateSeed() async {
    await _keysService.clearAll();
    await _keysService.regenerateStoredWallet();
    await _keysService.loadKeys();
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Text('Wallet restored. App will close.'),
        );
      },
    );
    if (!kDebugMode) {
      exit(0);
    } else {
      setState(() {});
    }
  }

  Future<void> _onCreateNewWallet() async {
    final response = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            'This will delete the current wallet and create a new one',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Proceed'),
            ),
          ],
        );
      },
    );
    if (response == true) {
      await _keysService.clearAll();
      await _keysService.createRandomWallet();
      await _keysService.loadKeys();
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            content: Text('New wallet created. App will close.'),
          );
        },
      );
      if (!kDebugMode) {
        exit(0);
      } else {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<List<ChainKey>>(
                    future: _keysService.loadKeys(),
                    initialData: _keysService.keys,
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
                  _DeviceData(),
                  _Metadata(),
                  _Buttons(
                    onDeleteData: _onDeleteData,
                    onRestoreFromSeed: _onRestoreFromSeed,
                    onRegenerateSeed: _onRegenerateSeed,
                    onCreateNewWallet: _onCreateNewWallet,
                  ),
                  //
                ],
              ),
            ),
          ),
        ],
      ),
      // floatingActionButton: _LinkModeButton(),
    );
  }
}

// ignore: unused_element
class _LinkModeButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          final prefs = snapshot.data!;
          final linkModeEnabled = prefs.getBool('rwkt_sample_linkmode') ?? true;
          return FloatingActionButton.extended(
            backgroundColor: Colors.blue,
            label: Row(
              children: [
                Text('Link Mode: ${linkModeEnabled ? 'True' : 'False'}'),
              ],
            ),
            onPressed: () async {
              final value = !linkModeEnabled;
              await prefs.setBool('rwkt_sample_linkmode', value);
              final result = await showDialog<bool>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text(
                        'To ${value ? 'enable' : 'disable'} Link mode app will be closed'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text('Ok'),
                      ),
                    ],
                  );
                },
              );
              if (result == true) {
                await prefs.setBool('rwkt_sample_linkmode', value);
                if (!kDebugMode) {
                  exit(0);
                }
              }
            },
          );
        }
        return SizedBox.shrink();
      },
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
    return Column(
      children: [
        const SizedBox(height: 20.0),
        const Divider(height: 1.0, color: Colors.grey),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox.square(dimension: 20.0),
              _DataContainer(
                title: 'Redirect',
                data:
                    'Native: $nativeLink\nUniversal: $universalLink\nLink Mode: $linkMode',
              ),
              const SizedBox.square(dimension: 10.0),
              FutureBuilder(
                future: ReownCoreUtils.getPackageName(),
                builder: (_, snapshot) {
                  return Text(snapshot.data ?? '');
                },
              ),
            ],
          ),
        ),
      ],
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
  double _balance = 0.0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _selectedChain = _walletKitService.currentSelectedChain.value!;
    _walletKitService.currentSelectedChain.addListener(_onChainChanged);
    _updateBalance();
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
      setState(() => _selectedChain = chainMetadata);
      await _updateBalance();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _updateBalance() async {
    if (!mounted) return;
    final chainKeys = _keysService.getKeysForChain('eip155');
    final chainKey = chainKeys[_currentPage];
    final evmService = GetIt.I.get<EVMService>(
      instanceName: _selectedChain.chainId,
    );
    evmService.getBalance(address: chainKey.address).then((value) {
      if (!mounted) return;
      setState(() => _balance = value);
    }).onError((a, b) {
      if (!mounted) return;
      setState(() => _balance = 0.0);
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
        event: SessionEventParams(
          name: 'accountsChanged',
          data: [address],
        ),
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final chainKeys = _keysService.getKeysForChain('eip155');
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
                icon: const Icon(Icons.add_box_rounded),
                padding: const EdgeInsets.all(0.0),
                visualDensity: VisualDensity.compact,
              ),
              IconButton(
                onPressed: (_currentPage == 0)
                    ? null
                    : () => _pageController.jumpToPage(_currentPage - 1),
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
                  '${_balance.toStringAsFixed(6)} ETH',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: 200.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    DropdownButton(
                      key: Key('evm_chains'),
                      isExpanded: true,
                      value: _selectedChain,
                      items: ChainsDataList.eip155Chains.map((e) {
                        return DropdownMenuItem<ChainMetadata>(
                          value: e,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: CachedNetworkImage(
                                    imageUrl: e.logo,
                                    width: 20.0,
                                    height: 20.0,
                                    errorWidget: (context, url, error) =>
                                        const SizedBox.shrink(),
                                  ),
                                ),
                                TextSpan(
                                  text: ' ${e.name}',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black,
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
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 12.0,
          ),
          child: Row(
            children: [
              CustomButton(
                type: CustomButtonType.normal,
                onTap: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  enableDrag: false,
                  showDragHandle: false,
                  isDismissible: false,
                  useRootNavigator: true,
                  useSafeArea: true,
                  builder: (context) => ChainAbstractionPreparePage(),
                ),
                child: const Center(
                  child: Text(
                    'Chain Abstraction',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
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
              _onEVMAccountChanged(chainKey.address);
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
                      data: '${_selectedChain.chainId}:${chainKey.address}',
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
                      backgroundColor: e.$1 == _currentPage
                          ? StyleConstants.lightGray
                          : StyleConstants.lightGray.withOpacity(0.5),
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
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: _DataContainer(
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
          .get<SolanaService>(instanceName: _selectedChain!.chainId)
          .getBalance(address: chainKeys.first.address)
          .then((value) {
        if (!mounted) return;
        setState(() => _balance = value);
      }).catchError((error) {
        debugPrint(error);
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
        const SizedBox(height: 20.0),
        const Divider(height: 1.0, color: Colors.grey),
        const Padding(
          padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'solana Accounts',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
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
                  '${_balance.toStringAsFixed(3)} SOL',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: 150.0,
                child: DropdownButton(
                  key: Key('solana_chains'),
                  isExpanded: true,
                  value: _selectedChain,
                  items: ChainsDataList.solanaChains.map((e) {
                    return DropdownMenuItem<ChainMetadata>(
                      value: e,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: CachedNetworkImage(
                                imageUrl: e.logo,
                                width: 20.0,
                                height: 20.0,
                                errorWidget: (context, url, error) =>
                                    const SizedBox.shrink(),
                              ),
                            ),
                            TextSpan(
                              text: ' ${e.name}',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (ChainMetadata? chain) {
                    setState(() => _selectedChain = chain);
                    final chainKey = chainKeys.first;
                    GetIt.I
                        .get<SolanaService>(instanceName: chain?.chainId)
                        .getBalance(address: chainKey.address)
                        .then((value) => setState(() => _balance = value));
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox.square(dimension: 8.0),
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

class _ChainKeyView extends StatelessWidget {
  const _ChainKeyView({required this.chain});
  final String chain;
  @override
  Widget build(BuildContext context) {
    final keysService = GetIt.I<IKeyService>();
    final chainKeys = keysService.getKeysForChain(chain);
    if (chainKeys.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        const SizedBox(height: 20.0),
        const Divider(height: 1.0, color: Colors.grey),
        Padding(
          padding: EdgeInsets.all(12.0),
          child: Row(
            children: [
              SizedBox.square(dimension: 8.0),
              Expanded(
                child: Text(
                  '$chain account',
                  style: TextStyle(
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
    return Column(
      children: [
        const SizedBox(height: 20.0),
        const Divider(height: 1.0, color: Colors.grey),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0, top: 12.0, left: 10.0),
                child: Text(
                  'device info',
                  style: TextStyle(
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
        ),
      ],
    );
  }
}

class _Buttons extends StatelessWidget {
  final VoidCallback onRestoreFromSeed;
  final VoidCallback onRegenerateSeed;
  final VoidCallback onCreateNewWallet;
  final VoidCallback onDeleteData;
  const _Buttons({
    required this.onRestoreFromSeed,
    required this.onRegenerateSeed,
    required this.onCreateNewWallet,
    required this.onDeleteData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20.0),
        const Divider(height: 1.0, color: Colors.grey),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const SizedBox(height: 8.0),
              TextButton(
                onPressed: onDeleteData,
                child: Text(
                  'Clear local storage',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 12.0),
              Row(
                children: [
                  CustomButton(
                    type: CustomButtonType.valid,
                    onTap: onRestoreFromSeed,
                    child: const Center(
                      child: Text(
                        'Restore a wallet',
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
                    type: CustomButtonType.normal,
                    onTap: onRegenerateSeed,
                    child: const Center(
                      child: Text(
                        'Regenerate current wallet',
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
                    onTap: onCreateNewWallet,
                    child: const Center(
                      child: Text(
                        'Create new random wallet',
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
        ),
      ],
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
          color: StyleConstants.lightGray.withOpacity(0.5),
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
