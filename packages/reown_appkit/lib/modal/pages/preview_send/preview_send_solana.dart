import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'dart:ui' as ui;

import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';
import 'package:reown_appkit/modal/models/send_data.dart';
import 'package:reown_appkit/modal/pages/preview_send/utils.dart';
import 'package:reown_appkit/modal/pages/preview_send/widgets.dart';
import 'package:reown_appkit/modal/services/analytics_service/i_analytics_service.dart';
import 'package:reown_appkit/modal/services/analytics_service/models/analytics_event.dart';
import 'package:reown_appkit/modal/services/blockchain_service/models/token_balance.dart';
import 'package:reown_appkit/modal/services/toast_service/i_toast_service.dart';
import 'package:reown_appkit/modal/services/toast_service/models/toast_message.dart';
import 'package:reown_appkit/modal/utils/core_utils.dart';
import 'package:reown_appkit/modal/widgets/icons/rounded_icon.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/widget_stack_singleton.dart';
import 'package:reown_appkit/reown_appkit.dart' hide TransactionExtension;
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar.dart';

import 'package:reown_appkit/solana/solana_web3/solana_web3.dart' as solana;
import 'package:reown_appkit/solana/solana_web3/programs.dart' as programs;

class PreviewSendSolana extends StatefulWidget {
  const PreviewSendSolana({
    required this.sendData,
    required this.sendTokenData,
    required this.networkTokenData,
    required this.originalSendValue,
    required this.isMaxSend,
    required this.isContractCall,
    required this.senderAddress,
    required this.recipientAddress,
  });

  final SendData sendData;
  final TokenBalance sendTokenData;
  final TokenBalance? networkTokenData;
  final String originalSendValue;
  final bool isMaxSend;
  final bool isContractCall;
  final String senderAddress;
  final String recipientAddress;

  @override
  State<PreviewSendSolana> createState() => _PreviewSendSolanaState();
}

class _PreviewSendSolanaState extends State<PreviewSendSolana> {
  // IBlockChainService get _blockchainService => GetIt.I<IBlockChainService>();
  IAnalyticsService get _analyticsService => GetIt.I<IAnalyticsService>();
  IToastService get _toastService => GetIt.I<IToastService>();

  late final IReownAppKitModal _appKitModal;
  late SendData _sendData;
  late final TokenBalance _sendTokenData;
  late final TokenBalance? _networkTokenData;
  late final String _originalSendValue;
  late final bool _isMaxSend;
  late final String _senderAddress;
  late final String _recipientAddress;

  solana.Transaction? _transaction;
  bool _isSendEnabled = false;

  double _gasValue = 0.0;
  Timer? _gasEstimationTimer;

  void _logger(String m) => _appKitModal.appKit!.core.logger.d(m);
  //
  @override
  void initState() {
    super.initState();
    _sendData = widget.sendData;
    _sendTokenData = widget.sendTokenData;
    _networkTokenData = widget.networkTokenData;
    _originalSendValue = widget.originalSendValue;
    _isMaxSend = widget.isMaxSend;
    _senderAddress = widget.senderAddress;
    _recipientAddress = widget.recipientAddress;
    //

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _appKitModal = ModalProvider.of(context).instance;
      await _constructTransaction();
      await _estimateNetworkCost();
    });
  }

  Future<void> _reEstimateGas(_) async {
    await _estimateNetworkCost();
  }

  int _getDecimals({required bool nativeToken}) {
    if (nativeToken) {
      final decimals = _networkTokenData?.quantity?.decimals ?? '18';
      return int.parse(decimals);
    }
    final decimals = _sendTokenData.quantity?.decimals ?? '18';
    return int.parse(decimals);
  }

  BigInt _valueToBigInt(double value) {
    final decimals = _getDecimals(nativeToken: false);
    final factor = BigInt.from(pow(10, decimals));
    return BigInt.from(value * factor.toDouble());
  }

  double _valueToDouble(BigInt value) {
    final decimals = _getDecimals(nativeToken: false);
    final factor = BigInt.from(pow(10, decimals));
    return value / factor;
  }

  Future<solana.Transaction> _contructSolanaTX(double valueToSend) async {
    // Create a connection to the devnet cluster.
    final chainId = _sendTokenData.chainId!.split(':').last;
    final chainData = ReownAppKitModalNetworks.getNetworkById(
      'solana',
      chainId,
    );
    // Create a connection to the devnet cluster.
    final cluster = solana.Cluster.https(
      Uri.parse(chainData!.rpcUrl).authority,
    );
    // final cluster = solana.Cluster.devnet;
    final connection = solana.Connection(cluster);

    // Fetch the latest blockhash.
    final blockhash = await connection.getLatestBlockhash();

    // Define transfer amount in lamports (1 SOL = 1,000,000,000 lamports)
    // Amount to send in lamports (0.001 SOL)
    final lamports = _valueToBigInt(valueToSend);

    // Create the transfer instruction
    final transferInstruction = programs.SystemProgram.transfer(
      fromPubkey: solana.Pubkey.fromBase58(_senderAddress),
      toPubkey: solana.Pubkey.fromBase58(_recipientAddress),
      lamports: lamports,
    );

    final transactionv0 = solana.Transaction.v0(
      payer: solana.Pubkey.fromBase58(_senderAddress),
      recentBlockhash: blockhash.blockhash,
      instructions: [
        transferInstruction,
      ],
    );

    return transactionv0;
  }

  Future<void> _constructTransaction() async {
    final actualValueToSend =
        _originalSendValue.toDouble() - (_isMaxSend ? _gasValue : 0.0);
    _sendData = _sendData.copyWith(
      amount: CoreUtils.formatChainBalance(
        max(0.000000, actualValueToSend),
        precision: _getDecimals(nativeToken: false),
      ),
    );
    _transaction = await _contructSolanaTX(actualValueToSend);
    _logger('[$runtimeType] transaction ${jsonEncode(_transaction?.toJson())}');
    setState(() {});
  }

  double get _baseFee => 0.000005;

  final Map<String, int> _urgency = {
    'low': 10,
    'med': 100,
    'high': 500,
    'vhigh': 1000,
  };

  Future<void> _estimateNetworkCost() async {
    try {
      final chainId = _sendTokenData.chainId!.split(':').last;
      final chainData = ReownAppKitModalNetworks.getNetworkById(
        'solana',
        chainId,
      );

      // Create a connection to the devnet cluster.
      final cluster = solana.Cluster.https(
        Uri.parse(chainData!.rpcUrl).authority,
      );
      // final cluster = solana.Cluster.devnet;
      final connection = solana.Connection(cluster);
      final status = await connection.simulateTransaction(_transaction!);
      final uc = (status.unitsConsumed ?? 1).toInt();
      final priorityFee = BigInt.from(uc * _urgency['med']!);
      final networkCostInLamports = _valueToBigInt(_baseFee) + priorityFee;
      _gasValue = _valueToDouble(networkCostInLamports);

      await _constructTransaction();

      setState(() => _isSendEnabled = _sendData.amount!.toDouble() > 0.0);

      if (_isSendEnabled) {
        _gasEstimationTimer ??= Timer.periodic(
          Duration(seconds: 10),
          _reEstimateGas,
        );
      } else {
        _toastService.show(ToastMessage(
          type: ToastType.error,
          text: 'Insufficient funds',
        ));
      }
    } on ArgumentError catch (e) {
      _toastService.show(ToastMessage(
        type: ToastType.error,
        text: 'Invald ${e.name ?? 'argument'}',
      ));
    } on Exception catch (e) {
      _toastService.show(ToastMessage(
        type: ToastType.error,
        text: e.toString(),
      ));
    }
  }

  String get _encodedTransaction {
    const config = solana.TransactionSerializableConfig(
      verifySignatures: false,
    );
    final bytes = _transaction!.serialize(config).asUint8List();
    return base58.encode(bytes);
  }

  Future<void> _sendTransaction() async {
    final valueToSend = CoreUtils.formatStringBalance(
      _sendData.amount!,
      precision: 3,
    );
    _analyticsService.sendEvent(WalletFeatureSendInitiated(
      network: _sendTokenData.chainId!,
      sendToken: _sendTokenData.symbol!,
      sendAmount: valueToSend,
    ));
    try {
      final appKitModal = ModalProvider.of(context).instance;

      await appKitModal.request(
        topic: appKitModal.session!.topic,
        chainId: _sendTokenData.chainId!,
        request: SessionRequestParams(
          method: 'solana_signAndSendTransaction',
          params: {
            'transaction': _encodedTransaction,
            'pubkey': _senderAddress,
            'feePayer': _senderAddress,
            ..._transaction!.message.toJson(),
          },
        ),
      );
      _analyticsService.sendEvent(WalletFeatureSendSuccess(
        network: _sendTokenData.chainId!,
        sendToken: _sendTokenData.symbol!,
        sendAmount: valueToSend,
      ));
    } on ArgumentError catch (e) {
      _toastService.show(ToastMessage(
        type: ToastType.error,
        text: 'Invald ${e.name ?? 'argument'}',
      ));
      _analyticsService.sendEvent(WalletFeatureSendError(
        network: _sendTokenData.chainId!,
        sendToken: _sendTokenData.symbol!,
        sendAmount: valueToSend,
      ));
    } on Exception catch (e) {
      _toastService.show(ToastMessage(
        type: ToastType.error,
        text: e.toString(),
      ));
      _analyticsService.sendEvent(WalletFeatureSendError(
        network: _sendTokenData.chainId!,
        sendToken: _sendTokenData.symbol!,
        sendAmount: valueToSend,
      ));
    }
  }

  @override
  void dispose() {
    _gasEstimationTimer?.cancel();
    _gasEstimationTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    return ModalNavbar(
      title: 'Review send',
      divider: false,
      body: Container(
        padding: const EdgeInsets.only(
          left: kPadding16,
          right: kPadding16,
          top: kPadding16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SendRow(
              sendTokenData: _sendTokenData,
              sendData: _sendData,
              originalSendValue: _originalSendValue,
            ),
            const SizedBox.square(dimension: kPadding6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPadding8),
              child: SvgPicture.asset(
                colorFilter: ColorFilter.mode(
                  themeColors.foreground200,
                  BlendMode.srcIn,
                ),
                'lib/modal/assets/icons/arrow_down.svg',
                package: 'reown_appkit',
                width: 14.0,
                height: 14.0,
              ),
            ),
            ReceiveRow(
              sendData: _sendData,
            ),
            const SizedBox.square(dimension: kPadding16),
            if (_transaction != null)
              DetailsRow(
                nativeTokenData: _networkTokenData ?? _sendTokenData,
                sendData: _sendData,
                requiredGasInTokens: _gasValue,
              ),
            const SizedBox.square(dimension: kPadding16),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: RoundedIcon(
                        assetPath: 'lib/modal/assets/icons/warning.svg',
                        assetColor: themeColors.foreground250,
                        circleColor: Colors.transparent,
                        borderColor: Colors.transparent,
                        padding: 0.0,
                        size: 14.0,
                      ),
                      alignment: ui.PlaceholderAlignment.middle,
                    ),
                    TextSpan(
                      text: ' Review transaction carefully',
                      style: themeData.textStyles.small400.copyWith(
                        color: themeColors.foreground200,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox.square(dimension: kPadding16),
            SendButtonRow(
              onCancel: () => widgetStack.instance.pop(),
              onSend: _isSendEnabled ? _sendTransaction : null,
            ),
            const SizedBox.square(dimension: kPadding12),
          ],
        ),
      ),
    );
  }
}
