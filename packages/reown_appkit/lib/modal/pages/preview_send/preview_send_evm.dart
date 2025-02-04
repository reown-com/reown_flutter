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
import 'package:reown_appkit/modal/services/blockchain_service/i_blockchain_service.dart';
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

class PreviewSendEvm extends StatefulWidget {
  const PreviewSendEvm({
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
  State<PreviewSendEvm> createState() => _PreviewSendEvmState();
}

class _PreviewSendEvmState extends State<PreviewSendEvm> {
  IBlockChainService get _blockchainService => GetIt.I<IBlockChainService>();
  IAnalyticsService get _analyticsService => GetIt.I<IAnalyticsService>();
  IToastService get _toastService => GetIt.I<IToastService>();

  late final IReownAppKitModal _appKitModal;
  late SendData _sendData;
  late final TokenBalance _sendTokenData;
  late final TokenBalance? _networkTokenData;
  late final String _originalSendValue;
  late final bool _isMaxSend;
  late final bool _isContractCall;
  late final String _senderAddress;
  late final String _recipientAddress;

  Transaction? _transaction;
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
    _isContractCall = widget.isContractCall;
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

  Future<void> _constructTransaction() async {
    final actualValueToSend =
        _originalSendValue.toDouble() - (_isMaxSend ? _gasValue : 0.0);
    if (_isContractCall) {
      final contractAddress = NamespaceUtils.getAccount(
        _sendTokenData.address!,
      );
      _sendData = _sendData.copyWith(
        amount: CoreUtils.formatChainBalance(
          max(0.000000, actualValueToSend),
          precision: _getDecimals(nativeToken: false),
        ),
      );
      _transaction = Transaction(
        from: EthereumAddress.fromHex(_senderAddress),
        to: EthereumAddress.fromHex(contractAddress),
        data: utf8.encode(
          constructCallData(
            _recipientAddress,
            _valueToBigInt(
              actualValueToSend,
            ),
          ),
        ),
      );
    } else {
      //
      _sendData = _sendData.copyWith(
        amount: max(0.000000, actualValueToSend).toString(),
      );
      _transaction = Transaction(
        to: EthereumAddress.fromHex(_recipientAddress),
        value: EtherAmount.fromBigInt(
          EtherUnit.wei,
          _valueToBigInt(
            actualValueToSend,
          ),
        ),
        data: utf8.encode('0x'),
      );
    }
    _logger('[$runtimeType] transaction ${jsonEncode(_transaction?.toJson())}');
  }

  Future<void> _estimateNetworkCost() async {
    try {
      final chainId = _sendTokenData.chainId!;
      final gasPrices = await _blockchainService.gasPrice(
        caip2Chain: chainId,
      );
      final standardGasPrice = gasPrices.standard ?? BigInt.zero;
      //
      final estimatedGas = await _blockchainService.estimateGas(
        transaction: _isContractCall
            ? _transaction!
                .copyWith(
                  data: utf8.encode(
                    constructCallData(
                      _recipientAddress,
                      _valueToBigInt(_originalSendValue.toDouble()),
                    ),
                  ),
                )
                .toJson()
            : _transaction!
                .copyWith(
                  from: EthereumAddress.fromHex(_senderAddress),
                  value: EtherAmount.fromBigInt(
                    EtherUnit.wei,
                    _valueToBigInt(_originalSendValue.toDouble()),
                  ),
                )
                .toJson(),
        caip2Chain: chainId,
      );
      //
      final decimals = BigInt.from(10).pow(_getDecimals(nativeToken: true));
      _gasValue = (standardGasPrice * estimatedGas) / decimals;
      // Add a little buffer of 5% more since this is just an estimation
      _gasValue = CoreUtils.formatChainBalance(
        _gasValue * 1.1,
        precision: _getDecimals(nativeToken: true),
      ).toDouble();

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
          method: MethodsConstants.ethSendTransaction,
          params: [
            _transaction!.toJson(),
          ],
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
