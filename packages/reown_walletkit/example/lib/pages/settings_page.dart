import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'dart:developer' as dev;

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
import 'package:reown_walletkit_wallet/dependencies/key_service/i_key_service.dart';
import 'package:reown_walletkit_wallet/models/chain_data.dart';
import 'package:reown_walletkit_wallet/models/chain_metadata.dart';
import 'package:reown_walletkit_wallet/pages/chain_abstraction_page.dart';
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
  final _walletKit = GetIt.I<IWalletKitService>().walletKit;

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
                  },
                ),
                //
                const SizedBox(height: 20.0),
                const Divider(height: 1.0, color: Colors.grey),
                _SolanaAccounts(),
                const SizedBox(height: 20.0),
                const Divider(height: 1.0, color: Colors.grey),
                _PolkadotAccounts(),
                const SizedBox(height: 20.0),
                const Divider(height: 1.0, color: Colors.grey),
                _KadenaAccounts(),
                const SizedBox(height: 20.0),
                const Divider(height: 1.0, color: Colors.grey),
                _DeviceData(),
                const SizedBox(height: 20.0),
                const Divider(height: 1.0, color: Colors.grey),
                _Metadata(),
                const SizedBox(height: 20.0),
                const Divider(height: 1.0, color: Colors.grey),
                _Buttons(
                  onDeleteData: () async {
                    await _walletKit.core.storage.deleteAll();
                    await keysService.clearAll();
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
                      await keysService.restoreWallet(
                        mnemonicOrPrivate: mnemonic,
                      );
                      await keysService.loadKeys();
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            content: Text(
                              'Wallet restored. Restart app',
                            ),
                          );
                        },
                      );
                      if (!kDebugMode) {
                        exit(0);
                      } else {
                        setState(() {});
                      }
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
  late ChainMetadata _selectedChain;
  double _balance = 0.0;
  String _usdcBalance = '0.0';
  int _valueToBridge = 0;

  final _walletKit = GetIt.I<IWalletKitService>().walletKit;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _selectedChain = GetIt.I<IWalletKitService>().currentSelectedChain.value!;
    GetIt.I<IWalletKitService>().currentSelectedChain.addListener(
          _onChainChanged,
        );
    _updateBalance();
  }

  Future<void> _onChainChanged() async {
    final chain = GetIt.I<IWalletKitService>().currentSelectedChain.value;
    await _switchToChain(chain);
  }

  Future<void> _switchToChain(ChainMetadata? chainMetadata) async {
    try {
      final sessions = _walletKit.sessions.getAll();
      final chainId = chainMetadata!.chainId.split(':').last;
      for (var session in sessions) {
        _walletKit.emitSessionEvent(
          topic: session.topic,
          chainId: chainMetadata.chainId,
          event: SessionEventParams(
            name: 'chainChanged',
            data: int.parse(chainId),
          ),
        );
      }
      setState(() => _selectedChain = chainMetadata);
      await _updateBalance();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _updateBalance() async {
    final keysService = GetIt.I<IKeyService>();
    final chainKeys = keysService.getKeysForChain('eip155');
    final chainKey = chainKeys[_currentPage];
    final evmService = GetIt.I.get<EVMService>(
      instanceName: _selectedChain.chainId,
    );
    setState(() => {});
    evmService
        .getBalance(address: chainKey.address)
        .then((value) => setState(() => _balance = value))
        .onError((a, b) => setState(() => _balance = 0.0));

    //
    final tokenAddress = _usdcTokens[_selectedChain.chainId]?['address'] ?? '';
    try {
      final value = await _walletKit.erc20TokenBalance(
        chainId: _selectedChain.chainId,
        token: tokenAddress,
        owner: chainKeys[_currentPage].address,
      );
      final rawBalance = BigInt.parse(value);
      _usdcBalance = _formattedBalance(rawBalance, 3);
    } catch (e) {
      debugPrint(e.toString());
      _usdcBalance = '0.0';
    }
  }

  final Map<String, Map<String, dynamic>> _usdcTokens = {
    'eip155:1': {
      'address': '0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48',
      'decimals': 6,
    },
    'eip155:42161': {
      'address': '0xaf88d065e77c8cC2239327C5EDb3A432268e5831',
      'decimals': 6,
    },
    'eip155:10': {
      'address': '0x0b2C639c533813f4Aa9D7837CAf62653d097Ff85',
      'decimals': 6,
    },
    'eip155:8453': {
      'address': '0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913',
      'decimals': 6,
    },
  };

  // final Map<String, Map<String, dynamic>> _usdtTokens = {
  //   'eip155:1': {
  //     'address': '0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48',
  //     'decimals': 6,
  //   },
  //   'eip155:42161': {
  //     'address': '0xaf88d065e77c8cC2239327C5EDb3A432268e5831',
  //     'decimals': 6,
  //   },
  //   'eip155:10': {
  //     'address': '0x0b2C639c533813f4Aa9D7837CAf62653d097Ff85',
  //     'decimals': 6,
  //   },
  //   'eip155:8453': {
  //     'address': '0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913',
  //     'decimals': 6,
  //   },
  // };

  @override
  Widget build(BuildContext context) {
    final keysService = GetIt.I<IKeyService>();
    final chainKeys = keysService.getKeysForChain('eip155');
    // final tokenAddress = _usdcTokens[_selectedChain.chainId]?['address'] ?? '';
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
                          'This will create a new address out from the same private key',
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_balance.toStringAsFixed(3)} ETH',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '$_usdcBalance USDC',
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    FutureBuilder(
                      future: _walletKit.estimateFees(
                        chainId: _selectedChain.chainId,
                      ),
                      builder: (_, snapshot) {
                        final mfees = snapshot.data?.maxFeePerGas ?? '0';
                        final mgWeiFees = _formattedStringBalance(mfees, 2);
                        final pfees =
                            snapshot.data?.maxPriorityFeePerGas ?? '0';
                        final pgWeiFees = _formattedStringBalance(pfees, 2);
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '~$mgWeiFees Gwei',
                              style: TextStyle(fontSize: 13.0),
                              maxLines: 1,
                            ),
                            Text(
                              '~$pgWeiFees Gwei',
                              maxLines: 1,
                              style: TextStyle(fontSize: 13.0),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
              Container(
                // color: Colors.red,
                width: 220.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    DropdownButton(
                      isExpanded: true,
                      value: _selectedChain,
                      items: ChainsDataList.eip155Chains.map((e) {
                        return DropdownMenuItem<ChainMetadata>(
                          value: e,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Image.network(
                                    width: 20.0,
                                    height: 20.0,
                                    e.logo,
                                  ),
                                ),
                                TextSpan(
                                  text: ' ${e.name}',
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          padding: const EdgeInsets.all(0.0),
                          visualDensity: VisualDensity.compact,
                          iconSize: 20.0,
                          onPressed: () {
                            var value = _valueToBridge;
                            value--;
                            setState(() {
                              _valueToBridge = max(value, 0);
                            });
                          },
                          icon: Icon(Icons.exposure_minus_1),
                        ),
                        Expanded(
                          child: Text(
                            '$_valueToBridge USDC',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        IconButton(
                          padding: const EdgeInsets.all(0.0),
                          visualDensity: VisualDensity.compact,
                          iconSize: 20.0,
                          onPressed: () {
                            setState(() {
                              _valueToBridge++;
                            });
                          },
                          icon: Icon(Icons.plus_one),
                        ),
                        IconButton(
                          icon: CircleAvatar(
                            radius: 20.0,
                            backgroundColor:
                                _valueToBridge == 0 ? Colors.grey : null,
                            child: _preparing
                                ? CircularProgressIndicator.adaptive(
                                    backgroundColor: Colors.white,
                                  )
                                : Icon(Icons.move_up_outlined),
                          ),
                          onPressed: _preparing || _valueToBridge == 0
                              ? null
                              : () => _prepareDetailed(),
                        ),
                      ],
                    )
                  ],
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

  String _formattedStringBalance(String rawBalance, [int decimals = 6]) {
    return _formattedBalance(BigInt.parse(rawBalance), decimals);
  }

  String _formattedBalance(BigInt rawBalance, [int decimals = 6]) {
    // final d = _usdcTokens[_selected]!['decimals']! as int;
    final balance = rawBalance / BigInt.from(10).pow(6);
    return balance.toStringAsFixed(decimals);
  }

  BigInt _formattedAmount(double value, [int decimals = 6]) {
    // final decimals = _usdcTokens[_selected]!['decimals']! as int;
    return BigInt.from(value * BigInt.from(10).pow(decimals).toDouble());
  }

  String _constructCallData(String recipient, BigInt sendValue) {
    // Keccak256 hash of `transfer(address,uint256)`'s signature
    const transferMethodId = 'a9059cbb';
    // Remove '0x' and pad
    final paddedReceiver = recipient.replaceFirst('0x', '').padLeft(64, '0');
    // Amount in hex, padded
    final paddedAmount = sendValue.toRadixString(16).padLeft(64, '0');
    //
    return '0x$transferMethodId$paddedReceiver$paddedAmount';
  }

  bool _preparing = false;

  Future<void> _prepareDetailed() async {
    setState(() => _preparing = true);
    final keysService = GetIt.I<IKeyService>();
    final chainKeys = keysService.getKeysForChain('eip155');
    final senderAddress = chainKeys[_currentPage].address; // my address
    final receiverAddress = await _setReceiverAddress();
    if (receiverAddress.isNotEmpty) {
      final chainId = _selectedChain.chainId;
      final tokenAddress = _usdcTokens[_selectedChain.chainId]!['address']!;
      final amount = _valueToBridge.toDouble();
      final rawAmount = _formattedAmount(amount);
      final hexData = _constructCallData(receiverAddress, rawAmount);

      try {
        final response = await _walletKit.prepare(
          chainId: chainId,
          from: senderAddress,
          localCurrency: Currency.usd,
          call: CallCompat(
            to: tokenAddress,
            value: BigInt.zero,
            input: hexData,
          ),
        );
        response.when(
          success: (PrepareDetailedResponseSuccessCompat deatailResponse) {
            deatailResponse.when(
              available: (uiFieldsCompat) async {
                dev.log(jsonEncode(uiFieldsCompat.toJson()));
                final response = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DetailsAndExecute(
                      uiFieldsCompat: uiFieldsCompat,
                    ),
                    fullscreenDialog: true,
                  ),
                );
                if (response is ErrorCompat) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('❌ ${response.message}'),
                    duration: const Duration(seconds: 4),
                  ));
                } else if (response is Exception) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('❌ Response error: $response'),
                    duration: const Duration(seconds: 4),
                  ));
                } else if (response != null) {
                  debugPrint(jsonEncode(response.toJson()));
                  // it means that no bridging is required
                  // proceeds as normal transaction with initial transaction
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('✅ Success'),
                    duration: Duration(seconds: 2),
                  ));
                }
                _updateBalance();
              },
              notRequired: (notRequired) {
                // it means that no bridging is required
                // proceeds as normal transaction with initial transaction
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('✅ Routing not required'),
                  duration: Duration(seconds: 2),
                ));
              },
            );
          },
          error: (PrepareResponseError error) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('❌ Prepare Error ${error.error.name}'),
              duration: const Duration(seconds: 4),
            ));
          },
        );
      } catch (e) {
        debugPrint(e.toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('❌ Prepare Error $e'),
          duration: const Duration(seconds: 4),
        ));
      }
    }
    setState(() => _preparing = false);
  }

  Future<String> _setReceiverAddress() async {
    final address = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        final keysService = GetIt.I<IKeyService>();
        final chainKeys = keysService.getKeysForChain('eip155');
        final myAddress = chainKeys[_currentPage].address;
        final controller = TextEditingController();
        return AlertDialog(
          title: Text('Receiver address'),
          insetPadding: EdgeInsets.symmetric(horizontal: 12.0),
          content: Material(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Receiver address',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Colors.black45,
                    ),
                  ),
                  controller: controller,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    onPressed: () => setState(
                      () => controller.text = myAddress,
                    ),
                    child: Text('Set my address'),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(''),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(controller.text),
              child: Text(
                'Continue',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
    return address;
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
          padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Solana Accounts',
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
                  isExpanded: true,
                  value: _selectedChain,
                  items: ChainsDataList.solanaChains.map((e) {
                    return DropdownMenuItem<ChainMetadata>(
                      value: e,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Image.network(
                                width: 20.0,
                                height: 20.0,
                                e.logo,
                              ),
                            ),
                            TextSpan(
                              text: ' ${e.name}',
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
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
            padding: EdgeInsets.only(bottom: 8.0, top: 12.0),
            child: Text(
              'Device info',
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
          FutureBuilder(
            future: SharedPreferences.getInstance(),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                final prefs = snapshot.data!;
                final linkModeEnabled =
                    prefs.getBool('appkit_sample_linkmode') ?? false;
                return Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Link Mode',
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Switch(
                      value: linkModeEnabled,
                      onChanged: (value) async {
                        await prefs.setBool('appkit_sample_linkmode', value);
                        final result = await showDialog<bool>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content:
                                  Text('App will be closed to apply changes'),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: Text('Ok'),
                                ),
                              ],
                            );
                          },
                        );
                        if (result == true) {
                          await prefs.setBool('appkit_sample_linkmode', value);
                          if (!kDebugMode) {
                            exit(0);
                          }
                        }
                      },
                    ),
                    Expanded(child: SizedBox.shrink()),
                  ],
                );
              }
              return SizedBox.shrink();
            },
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              CustomButton(
                type: CustomButtonType.normal,
                onTap: onDeleteData,
                child: const Center(
                  child: Text(
                    'Clear local storage',
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
                type: CustomButtonType.valid,
                onTap: onRestoreFromSeed,
                child: const Center(
                  child: Text(
                    'Restore wallet',
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
