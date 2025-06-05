import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/evm_service.dart';
import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/i_key_service.dart';
import 'package:reown_walletkit_wallet/models/chain_data.dart';
import 'package:reown_walletkit_wallet/models/chain_metadata.dart';
import 'package:reown_walletkit_wallet/widgets/custom_button.dart';

class ChainAbstractionPreparePage extends StatefulWidget {
  const ChainAbstractionPreparePage({super.key});

  @override
  State<ChainAbstractionPreparePage> createState() =>
      _ChainAbstractionPreparePageState();
}

class _ChainAbstractionPreparePageState
    extends State<ChainAbstractionPreparePage> {
  bool _preparing = false;
  String _usdcBalance = '0.0';
  String _usdtBalance = '0.0';
  String _totalBalance = '0.0';
  double _valueToBridge = 0.0;
  Set<String> _selectedToken = <String>{'USDC'};
  final _receiverAddress = TextEditingController();

  late ChainMetadata _selectedChain;
  final _walletKit = GetIt.I<IWalletKitService>().walletKit;
  final _myAddress =
      GetIt.I<IKeyService>().getKeysForChain('eip155').first.address;

  @override
  void initState() {
    super.initState();
    _receiverAddress.text = _myAddress;
    _selectedChain = ChainsDataList.chainAbstraction.first;
    _updateBalance();
  }

  String get _usdcAddress {
    return _ChainAbstractionTokens.getTokenDataAddress(
      'USDC',
      _selectedChain.chainId,
    );
  }

  String get _usdtAddress {
    return _ChainAbstractionTokens.getTokenDataAddress(
      'USDT',
      _selectedChain.chainId,
    );
  }

  Future<void> _updateBalance() async {
    try {
      final balances = await Future.wait([
        _walletKit.erc20TokenBalance(
          chainId: _selectedChain.chainId,
          token: _usdcAddress,
          owner: _myAddress,
        ),
        _walletKit.erc20TokenBalance(
          chainId: _selectedChain.chainId,
          token: _usdtAddress,
          owner: _myAddress,
        ),
      ]);
      _usdcBalance = _formattedBalance(BigInt.parse(balances.first), 6);
      _usdtBalance = _formattedBalance(BigInt.parse(balances.last), 6);
      _totalBalance = _formattedBalance(
        BigInt.parse(balances.first) + BigInt.parse(balances.last),
        6,
      );
    } catch (e) {
      debugPrint(e.toString());
      _usdcBalance = '0.0';
      _usdtBalance = '0.0';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text('Chain Abstraction'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  RichTextWidget(text1: 'NETWORK', text2: ''),
                  SizedBox.square(dimension: 12.0),
                  Expanded(
                    child: DropdownButton(
                      key: Key('ddb_abstraction'),
                      isExpanded: true,
                      value: _selectedChain,
                      items: ChainsDataList.chainAbstraction.map((e) {
                        return DropdownMenuItem<ChainMetadata>(
                          value: e,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: CachedNetworkImage(
                                    width: 20.0,
                                    height: 20.0,
                                    imageUrl: e.logo,
                                    errorWidget: (context, url, error) =>
                                        const SizedBox.shrink(),
                                  ),
                                ),
                                WidgetSpan(
                                  child: RichTextWidget(
                                    text1: ' ${e.name}',
                                    text2: '',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (ChainMetadata? chain) async {
                        if (chain!.chainId == 'eip155:8453') {
                          _selectedToken = {'USDC'};
                        }
                        setState(() => _selectedChain = chain);
                        _updateBalance();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox.square(dimension: 10.0),
              RichTextWidget(text1: 'ADDRESS\n', text2: _myAddress),
              const SizedBox.square(dimension: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichTextWidget(text1: 'BALANCE', text2: '', fontSize: 14),
                  RichTextWidget(text1: '', text2: _totalBalance, fontSize: 14),
                ],
              ),
              const SizedBox.square(dimension: 5.0),
              Divider(height: 1.0, thickness: 0.5, color: Colors.black87),
              const SizedBox.square(dimension: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichTextWidget(text1: 'USDC', text2: '', fontSize: 12),
                  RichTextWidget(text1: '', text2: _usdcBalance, fontSize: 12),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichTextWidget(text1: 'USDT', text2: '', fontSize: 12),
                  RichTextWidget(text1: '', text2: _usdtBalance, fontSize: 12),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichTextWidget(
                    text1: 'USDS',
                    text2: '',
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                  RichTextWidget(
                    text1: '',
                    text2: '[Unavailable]',
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ],
              ),
              const SizedBox.square(dimension: 10.0),
              FutureBuilder(
                future: _walletKit.estimateFees(
                  chainId: _selectedChain.chainId,
                ),
                builder: (_, snapshot) {
                  final mfees = snapshot.data?.maxFeePerGas ?? '0';
                  final mgWeiFees = _formattedStringBalance(mfees, 2);
                  final pfees = snapshot.data?.maxPriorityFeePerGas ?? '0';
                  final pgWeiFees = _formattedStringBalance(pfees, 2);
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichTextWidget(
                            text1: 'MAX FEE ',
                            text2: '',
                            fontSize: 12,
                          ),
                          RichTextWidget(
                            text1: '',
                            text2: '~$mgWeiFees Gwei',
                            fontSize: 12,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichTextWidget(
                            text1: 'MAX PRIORITY FEE ',
                            text2: '',
                            fontSize: 12,
                          ),
                          RichTextWidget(
                            text1: '',
                            text2: '~$pgWeiFees Gwei',
                            fontSize: 12,
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              const SizedBox.square(dimension: 20.0),
              Divider(height: 1.0, thickness: 0.5, color: Colors.black87),
              const SizedBox.square(dimension: 20.0),
              RichTextWidget(text1: 'TRANSACTION ', text2: ''),
              const SizedBox.square(dimension: 5.0),
              RichTextWidget(text1: '', text2: 'COIN'),
              Center(
                child: SegmentedButton<String>(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith<Color>(
                      (states) {
                        if (states.contains(WidgetState.selected)) {
                          return Colors.blue;
                        }
                        return Colors.transparent;
                      },
                    ),
                  ),
                  segments: <ButtonSegment<String>>[
                    ButtonSegment<String>(value: 'USDC', label: Text('USDC')),
                    ButtonSegment<String>(
                      value: 'USDT',
                      label: Text('USDT'),
                      enabled: _selectedChain.chainId != 'eip155:8453',
                    ),
                    ButtonSegment<String>(
                      value: 'USDS',
                      label: Text('USDS'),
                      enabled: false,
                    ),
                  ],
                  selected: _selectedToken,
                  onSelectionChanged: (Set<String> newSelection) {
                    setState(() {
                      _selectedToken = newSelection;
                    });
                  },
                ),
              ),
              SizedBox.square(dimension: 10.0),
              RichTextWidget(text1: '', text2: 'AMOUNT'),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        final value = _valueToBridge - 0.5;
                        setState(() => _valueToBridge = max(value, 0));
                      },
                      icon: CircleAvatar(
                        radius: 15.0,
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.exposure_minus_1),
                      ),
                    ),
                    SizedBox.square(dimension: 10.0),
                    Text(
                      '$_valueToBridge ${_selectedToken.first}',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox.square(dimension: 10.0),
                    IconButton(
                      // iconSize: 20.0,
                      onPressed: () {
                        setState(() => _valueToBridge = _valueToBridge + 0.5);
                      },
                      icon: CircleAvatar(
                        radius: 15.0,
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.plus_one),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox.square(dimension: 10.0),
              RichTextWidget(text1: '', text2: 'RECIPIENT'),
              SizedBox.square(dimension: 4.0),
              CupertinoTextField(
                suffix: IconButton(
                  onPressed: () {
                    try {
                      QrBarCodeScannerDialog().getScannedQrBarCode(
                        context: context,
                        onCode: (value) {
                          if (!mounted) return;
                          setState(() {
                            _receiverAddress.text = value ?? '';
                          });
                        },
                      );
                    } catch (e) {
                      debugPrint(e.toString());
                    }
                  },
                  icon: Icon(Icons.qr_code_2),
                ),
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  fontSize: 13.0,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
                controller: _receiverAddress,
              ),
              Expanded(child: SizedBox()),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _valueToBridge == 0.0
                          ? TextButton(
                              child: const Text(
                                'Prepare',
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                              onPressed: null,
                            )
                          : CustomButton(
                              type: CustomButtonType.normal,
                              onTap: _preparing || _valueToBridge == 0.0
                                  ? null
                                  : _prepareDetailed,
                              child: Center(
                                child: _preparing
                                    ? CircularProgressIndicator.adaptive()
                                    : Text(
                                        'Prepare',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            ),
                    ],
                  ),
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _prepareDetailed() async {
    setState(() => _preparing = true);
    if (_receiverAddress.text.isNotEmpty) {
      final chainId = _selectedChain.chainId;
      final tokenAddress = _ChainAbstractionTokens.getTokenDataAddress(
        _selectedToken.first,
        chainId,
      );
      final rawAmount = _formattedAmount(_valueToBridge.toDouble());
      final input = _constructCallData(_receiverAddress.text, rawAmount);
      final txParams = {'from': _myAddress, 'to': tokenAddress, 'input': input};

      try {
        final evmService = GetIt.I.get<EVMService>(instanceName: chainId);
        // final id = JsonRpcUtils.payloadId();
        final caResponse = await evmService.handleChainAbstractionIfNeeded(
          requestId: 1,
          chainId: chainId,
          txParams: txParams,
          useLifi: true,
        );
        if (caResponse is JsonRpcResponse) {
          if (caResponse.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('❌ ${caResponse.error!.message}'),
              duration: const Duration(seconds: 4),
            ));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('✅ Success'),
              duration: Duration(seconds: 2),
            ));
            _updateBalance();
          }
        } else {
          if (caResponse is PrepareDetailedResponseError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('❌ ${caResponse.error.name}: ${caResponse.reason}'),
              duration: const Duration(seconds: 4),
            ));
          } else {
            // regular flow for eth_sendTransaction
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('⚠️ Chain Abstraction notRequired'),
              duration: const Duration(seconds: 2),
            ));
            await evmService.approveAndSendTransaction(
              1,
              txParams,
              chainId,
              TransportType.relay.name,
              null,
              '',
            );
            _updateBalance();
          }
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('❌ Prepare Error $e'),
          duration: const Duration(seconds: 4),
        ));
      }
    }
    setState(() => _preparing = false);
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

  String _formattedStringBalance(String rawBalance, [int decimals = 6]) {
    return _formattedBalance(BigInt.parse(rawBalance), decimals);
  }

  String _formattedBalance(BigInt rawBalance, [int decimals = 6]) {
    // final d = _usdcTokens[_selected]!['decimals']! as int;
    final balance = rawBalance / BigInt.from(10).pow(6);
    return balance.toStringAsFixed(decimals);
  }
}

class RichTextWidget extends StatelessWidget {
  const RichTextWidget({
    super.key,
    required this.text1,
    required this.text2,
    this.fontSize = 14.0,
    this.color,
  });
  final String text1;
  final String text2;
  final double fontSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text1,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: color ??
                  (Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black),
            ),
          ),
          TextSpan(
            text: text2,
            style: TextStyle(
              fontSize: fontSize,
              color: color ??
                  (Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChainAbstractionTokens {
  static String getTokenDataAddress(String token, String chainId) {
    try {
      return _token[token]![chainId]!['address']!;
    } catch (e) {
      return '';
    }
  }

  static final Map<String, dynamic> _token = {
    'USDC': {
      'eip155:1': {
        'address': '0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48',
        'decimals': 6
      },
      'eip155:42161': {
        'address': '0xaf88d065e77c8cC2239327C5EDb3A432268e5831',
        'decimals': 6
      },
      'eip155:10': {
        'address': '0x0b2C639c533813f4Aa9D7837CAf62653d097Ff85',
        'decimals': 6
      },
      'eip155:8453': {
        'address': '0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913',
        'decimals': 6
      }
    },
    'USDT': {
      'eip155:1': {
        'address': '0xdAC17F958D2ee523a2206206994597C13D831ec7',
        'decimals': 6
      },
      'eip155:42161': {
        'address': '0xFd086bC7CD5C481DCC9C85ebE478A1C0b69FCbb9',
        'decimals': 6
      },
      'eip155:10': {
        'address': '0x94b008aA00579c1307B0EF2c499aD98a8ce58e58',
        'decimals': 6
      },
      'eip155:8453': {
        'address': '0xfde4C96c8593536E31F229EA8f37b2ADa2699bb2',
        'decimals': 6
      }
    }
  };
}
