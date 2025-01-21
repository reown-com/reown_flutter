import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'dart:ui' as ui;

import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';
import 'package:reown_appkit/modal/models/send_data.dart';
import 'package:reown_appkit/modal/services/blockchain_service/i_blockchain_service.dart';
import 'package:reown_appkit/modal/services/blockchain_service/models/token_balance.dart';
import 'package:reown_appkit/modal/services/toast_service/i_toast_service.dart';
import 'package:reown_appkit/modal/services/toast_service/models/toast_message.dart';
import 'package:reown_appkit/modal/utils/core_utils.dart';
import 'package:reown_appkit/modal/utils/render_utils.dart';
import 'package:reown_appkit/modal/widgets/avatars/account_avatar.dart';
import 'package:reown_appkit/modal/widgets/buttons/address_button.dart';
import 'package:reown_appkit/modal/widgets/buttons/network_button.dart';
import 'package:reown_appkit/modal/widgets/buttons/primary_button.dart';
import 'package:reown_appkit/modal/widgets/buttons/secondary_button.dart';
import 'package:reown_appkit/modal/widgets/icons/rounded_icon.dart';
import 'package:reown_appkit/modal/widgets/lists/list_items/account_list_item.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/widget_stack_singleton.dart';
import 'package:reown_appkit/reown_appkit.dart' hide TransactionExtension;
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar.dart';

class PreviewSendPage extends StatefulWidget {
  const PreviewSendPage({
    required this.sendData,
    required this.sendTokenData,
    required this.networkTokenData,
  }) : super(key: KeyConstants.previewSendPageKey);

  final SendData sendData;
  final TokenBalance sendTokenData;
  final TokenBalance? networkTokenData;

  @override
  State<PreviewSendPage> createState() => _PreviewSendPageState();
}

class _PreviewSendPageState extends State<PreviewSendPage> {
  IBlockChainService get _blockchainService => GetIt.I<IBlockChainService>();
  IToastService get _toastService => GetIt.I<IToastService>();
  late final IReownAppKitModal _appKitModal;
  //
  late SendData _sendData;
  late final String _originalSendValue;
  late final TokenBalance _sendTokenData;
  late final TokenBalance? _networkTokenData;

  Transaction? _transaction;
  double _requiredGasInNativeToken = 0.0;
  bool _isSendEnabled = false;
  Timer? _gasEstimationTimer;
  //
  @override
  void initState() {
    super.initState();
    _sendData = widget.sendData;
    _originalSendValue = _sendData.amount!;
    _sendTokenData = widget.sendTokenData;
    _networkTokenData = widget.networkTokenData;
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

  void _log(String m) => _appKitModal.appKit!.core.logger.d(m);

  bool get _isMaxSend {
    final valueToSend = CoreUtils.formatStringBalance(
      _originalSendValue,
      precision: _getDecimals(nativeToken: false),
    );
    final maxAllowance = CoreUtils.formatStringBalance(
      _sendTokenData.quantity!.numeric!,
      precision: _getDecimals(nativeToken: false),
    );

    return valueToSend == maxAllowance;
  }

  // if sendTokenData.address is not null it means a contract should be called
  bool get _shouldCallContract => _sendTokenData.address != null;

  String get _senderAddress {
    final appKitModal = ModalProvider.of(context).instance;
    final chainId = _sendTokenData.chainId!;
    final namespace = NamespaceUtils.getNamespaceFromChain(chainId);
    return appKitModal.session!.getAddress(namespace)!;
  }

  String get _recipientAddress => _sendData.address!;

  String _constructCallData(BigInt sendValue) {
    // Keccak256 hash of `transfer(address,uint256)`'s signature
    final transferMethodId = 'a9059cbb';
    // Remove '0x' and pad
    final paddedReceiver =
        _recipientAddress.replaceFirst('0x', '').padLeft(64, '0');
    // Amount in hex, padded
    final paddedAmount = sendValue.toRadixString(16).padLeft(64, '0');
    //
    return '0x$transferMethodId$paddedReceiver$paddedAmount';
  }

  Future<void> _constructTransaction() async {
    final valueToSend = CoreUtils.formatStringBalance(
      _originalSendValue,
      precision: _getDecimals(nativeToken: false),
    );
    if (_shouldCallContract) {
      final contractAddress = NamespaceUtils.getAccount(
        _sendTokenData.address!,
      );
      final tokenPrice = _networkTokenData!.price!;
      final cost = (_requiredGasInNativeToken * tokenPrice);
      final networkCost = CoreUtils.formatChainBalance(
        cost,
        precision: _getDecimals(nativeToken: false),
      );
      final actualValueToSend = double.parse(valueToSend) -
          (_isMaxSend ? double.parse(networkCost) : 0.0);
      //
      _sendData = _sendData.copyWith(
        amount: max(0.000000, actualValueToSend).toString(),
      );
      _transaction = Transaction(
        from: EthereumAddress.fromHex(_senderAddress),
        to: EthereumAddress.fromHex(contractAddress),
        data: utf8.encode(
          _constructCallData(
            _valueToBigInt(
              actualValueToSend,
            ),
          ),
        ),
      );
    } else {
      final actualValueToSend = double.parse(valueToSend) -
          (_isMaxSend ? _requiredGasInNativeToken : 0.0);
      _log('[$runtimeType] actualValueToSend $actualValueToSend');
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
    _log('[$runtimeType] transaction ${jsonEncode(_transaction?.toJson())}');
  }

  Future<void> _estimateNetworkCost() async {
    try {
      final chainId = _sendTokenData.chainId!;
      final gasPrices = await _blockchainService.gasPrice(
        caip2chain: chainId,
      );
      final standardGasPrice = gasPrices.standard ?? BigInt.zero;
      //
      final estimatedGas = await _blockchainService.estimateGas(
        transaction: _transaction!.toJson(),
        caip2Chain: chainId,
      );
      //
      final decimals = BigInt.from(10).pow(_getDecimals(nativeToken: true));
      _requiredGasInNativeToken = (standardGasPrice * estimatedGas) / decimals;
      // Add a little buffer of 10% more since this is just an estimation
      _requiredGasInNativeToken = double.parse(CoreUtils.formatChainBalance(
        _requiredGasInNativeToken * 1.1,
        precision: _getDecimals(nativeToken: true),
      ));

      await _constructTransaction();

      setState(() => _isSendEnabled = double.parse(_sendData.amount!) > 0.0);

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

  Future<void> _sendTransaction() async {
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
            _SendRow(
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
            _ReceiveRow(
              sendData: _sendData,
            ),
            const SizedBox.square(dimension: kPadding16),
            if (_transaction != null)
              _DetailsRow(
                transaction: _transaction!,
                nativeTokenData: _networkTokenData ?? _sendTokenData,
                sendData: _sendData,
                requiredGasInTokens: _requiredGasInNativeToken,
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
            _SendButtonRow(
              onCancel: () => widgetStack.instance.pop(),
              onSend: _isSendEnabled ? _sendTransaction : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _SendRow extends StatelessWidget {
  const _SendRow({
    required this.sendTokenData,
    required this.sendData,
    required this.originalSendValue,
  });
  final TokenBalance sendTokenData;
  final SendData sendData;
  final String originalSendValue;

  @override
  Widget build(BuildContext context) {
    final appKitModal = ModalProvider.of(context).instance;
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final tokenPrice = sendTokenData.price ?? 0.0;
    final balanceSend = double.parse(sendData.amount!) * tokenPrice;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPadding8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Send',
                style: themeData.textStyles.small400.copyWith(
                  color: themeColors.foreground150,
                  height: 1.2,
                ),
              ),
              Text(
                '\$${CoreUtils.formatChainBalance(balanceSend)}',
                style: themeData.textStyles.paragraph400.copyWith(
                  color: themeColors.foreground100,
                  height: 1.2,
                ),
              ),
            ],
          ),
          Expanded(child: SizedBox()),
          NetworkButton(
            serviceStatus: appKitModal.status,
            chainInfo: appKitModal.selectedChain,
            iconUrl: sendTokenData.iconUrl,
            title: '${CoreUtils.formatStringBalance(
              originalSendValue,
              precision: 8,
            )} ${sendTokenData.symbol} ',
            iconOnRight: true,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _ReceiveRow extends StatelessWidget {
  const _ReceiveRow({required this.sendData});
  final SendData sendData;

  String get _recipientAddress => sendData.address!;

  @override
  Widget build(BuildContext context) {
    final appKitModal = ModalProvider.of(context).instance;
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPadding8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'To',
            style: themeData.textStyles.small400.copyWith(
              color: themeColors.foreground150,
              height: 1.2,
            ),
          ),
          Expanded(child: SizedBox()),
          AddressButton(
            service: appKitModal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox.square(dimension: kPadding12),
                Text(RenderUtils.truncate(_recipientAddress)),
                const SizedBox.square(dimension: 6.0),
                SizedBox.square(
                  dimension: BaseButtonSize.regular.height * 0.55,
                  child: GradientOrb(
                    address: _recipientAddress,
                    size: BaseButtonSize.regular.height * 0.55,
                  ),
                ),
                const SizedBox.square(dimension: 6.0),
              ],
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _SendButtonRow extends StatelessWidget {
  const _SendButtonRow({
    required this.onCancel,
    required this.onSend,
  });
  final VoidCallback onCancel;
  final VoidCallback? onSend;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: kListItemHeight,
          child: SecondaryButton(
            title: ' Cancel ',
            onTap: onCancel,
          ),
        ),
        const SizedBox.square(dimension: kPadding8),
        Expanded(
          child: SizedBox(
            height: kListItemHeight,
            child: PrimaryButton(
              title: 'Send',
              onTap: onSend,
            ),
          ),
        ),
      ],
    );
  }
}

class _DetailsRow extends StatefulWidget {
  const _DetailsRow({
    required this.transaction,
    required this.nativeTokenData,
    required this.sendData,
    required this.requiredGasInTokens,
  });
  final Transaction transaction;
  final TokenBalance nativeTokenData;
  final SendData sendData;
  final double requiredGasInTokens;

  @override
  State<_DetailsRow> createState() => _DetailsRowState();
}

class _DetailsRowState extends State<_DetailsRow> {
  bool _feesInTokens = false;

  String _formattedFee(double unformatted) {
    if (_feesInTokens) {
      return '${CoreUtils.formatChainBalance(
        widget.requiredGasInTokens,
        precision: 8,
      )} ${widget.nativeTokenData.symbol}';
    }
    final formatted = unformatted.toStringAsFixed(2);
    if (double.parse(formatted) < 0.01) {
      return '< \$0.01';
    }
    return '\$$formatted';
  }

  @override
  Widget build(BuildContext context) {
    final appKitModal = ModalProvider.of(context).instance;
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    final chainId = appKitModal.selectedChain!.chainId;
    final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(
      chainId,
    );
    final address = appKitModal.session!.getAddress(namespace);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(kPadding8),
      decoration: BoxDecoration(
        color: themeColors.grayGlass002,
        borderRadius: BorderRadius.all(Radius.circular(
          radiuses.radius2XS,
        )),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(kPadding8),
            child: Text(
              'Details',
              style: themeData.textStyles.small400.copyWith(
                color: themeColors.foreground100,
              ),
            ),
          ),
          const SizedBox.square(dimension: kPadding8),
          AccountListItem(
            title: 'Network cost',
            titleStyle: themeData.textStyles.small400.copyWith(
              color: themeColors.foreground150,
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                _formattedFee(
                  (widget.requiredGasInTokens * widget.nativeTokenData.price!),
                ),
                style: themeData.textStyles.small400.copyWith(
                  color: themeColors.foreground100,
                ),
              ),
            ),
            onTap: () {
              setState(() {
                _feesInTokens = !_feesInTokens;
              });
            },
          ),
          const SizedBox.square(dimension: kPadding8),
          AccountListItem(
            title: 'Address',
            titleStyle: themeData.textStyles.small400.copyWith(
              color: themeColors.foreground150,
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                RenderUtils.truncate(address!),
                style: themeData.textStyles.small400.copyWith(
                  color: themeColors.foreground100,
                ),
              ),
            ),
          ),
          const SizedBox.square(dimension: kPadding8),
          AccountListItem(
            title: 'Network',
            titleStyle: themeData.textStyles.small500.copyWith(
              color: themeColors.foreground100,
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: NetworkButton(
                serviceStatus: appKitModal.status,
                chainInfo: appKitModal.selectedChain,
                iconOnRight: true,
                size: BaseButtonSize.small,
                onTap: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension on Transaction {
  Map<String, dynamic> toJson() {
    return {
      if (from != null) 'from': from!.hexEip55,
      if (to != null) 'to': to!.hexEip55,
      if (maxGas != null) 'gas': '0x${maxGas!.toRadixString(16)}',
      if (gasPrice != null)
        'gasPrice': '0x${gasPrice!.getInWei.toRadixString(16)}',
      if (value != null) 'value': '0x${value!.getInWei.toRadixString(16)}',
      if (data != null) 'data': utf8.decode(data!),
      if (nonce != null) 'nonce': nonce,
      if (maxFeePerGas != null)
        'maxFeePerGas': '0x${maxFeePerGas!.getInWei.toRadixString(16)}',
      if (maxPriorityFeePerGas != null)
        'maxPriorityFeePerGas':
            '0x${maxPriorityFeePerGas!.getInWei.toRadixString(16)}',
    };
  }
}
