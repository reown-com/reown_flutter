import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'dart:ui' as ui;

import 'package:reown_appkit/modal/constants/key_constants.dart';
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
  Transaction? _transaction;
  double _requiredGasInTokens = 0.0;
  bool _isSendEnabled = false;
  Timer? _gasEstimationTimer;

  bool get _isContractCall => widget.sendTokenData.address != null;

  String get _ownAddress {
    final appKitModal = ModalProvider.of(context).instance;
    final chainId = widget.sendTokenData.chainId!;
    final namespace = NamespaceUtils.getNamespaceFromChain(chainId);
    return appKitModal.session!.getAddress(namespace)!;
  }

  String _contractData(BigInt sendValue) {
    // Keccak256 hash of `transfer(address,uint256)`'s signature
    final transferMethodId = 'a9059cbb';
    // Remove '0x' and pad
    final paddedReceiver =
        widget.sendData.address!.replaceFirst('0x', '').padLeft(64, '0');
    // Amount in hex, padded
    final paddedAmount = sendValue.toRadixString(16).padLeft(64, '0');
    //
    return '0x$transferMethodId$paddedReceiver$paddedAmount';
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _constructTransaction();
      await _estimateNetworkCost();
    });
  }

  Future<void> _constructTransaction() async {
    final sendValue = CoreUtils.formatStringBalance(
      widget.sendData.amount!,
      precision: 4,
    );
    final bigIntValue = _valueToBigInt(double.parse(sendValue));
    if (_isContractCall) {
      final contractAddress = NamespaceUtils.getAccount(
        widget.sendTokenData.address!,
      );
      // final chainId = widget.sendTokenData.chainId!;
      // final allowance = await _blockchainService.checkAllowance(
      //   senderAddress: _ownAddress,
      //   receiverAddress: widget.sendData.address!,
      //   contractAddress: contractAddress,
      //   caip2Chain: chainId,
      // );
      // print('allowance $allowance');
      final data = _contractData(bigIntValue);
      _transaction = Transaction(
        from: EthereumAddress.fromHex(_ownAddress),
        to: EthereumAddress.fromHex(contractAddress),
        data: utf8.encode(data),
      );
    } else {
      _transaction = Transaction(
        // from: EthereumAddress.fromHex(address!),
        to: EthereumAddress.fromHex(widget.sendData.address!),
        value: EtherAmount.fromBigInt(EtherUnit.wei, bigIntValue),
        data: utf8.encode('0x'),
      );
    }
    debugPrint('transaction first: ${jsonEncode(_transaction!.toJson())}');
    setState(() {});
  }

  Future<void> _estimateNetworkCost() async {
    try {
      final chainId = widget.sendTokenData.chainId!;
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
      final decimals = BigInt.from(10).pow(_getDecimals(true));
      _requiredGasInTokens = (standardGasPrice * estimatedGas) / decimals;
      // Add a little buffer of 10% more since this is just an estimation
      _requiredGasInTokens = _requiredGasInTokens * 1.1;
      //
      final sendValue = double.parse(widget.sendData.amount!);
      // TODO do this only if sending max
      final actualValue = sendValue - _requiredGasInTokens;
      final finalValue = _valueToBigInt(actualValue);

      if (_isContractCall) {
        final data = _contractData(finalValue);
        _transaction = _transaction!.copyWith(
          data: utf8.encode(data),
        );
      } else {
        _transaction = _transaction!.copyWith(
          value: EtherAmount.fromBigInt(EtherUnit.wei, finalValue),
        );
      }
      debugPrint('transaction then: ${jsonEncode(_transaction!.toJson())}');
      setState(() => _isSendEnabled = true);

      _gasEstimationTimer ??= Timer.periodic(
        Duration(seconds: 10),
        _reEstimateGas,
      );
    } on ArgumentError catch (e) {
      _toastService.show(ToastMessage(
        type: ToastType.error,
        text: 'Invald ${e.name ?? 'argument'}',
      ));
    } catch (e) {
      _toastService.show(ToastMessage(
        type: ToastType.error,
        text: e.toString(),
      ));
    }
  }

  void _reEstimateGas(_) => _estimateNetworkCost();

  @override
  void dispose() {
    _gasEstimationTimer?.cancel();
    _gasEstimationTimer = null;
    super.dispose();
  }

  int _getDecimals(bool isNetworkToken) {
    if (isNetworkToken) {
      final decimals = widget.networkTokenData?.quantity?.decimals ?? '18';
      return int.parse(decimals);
    }
    final decimals = widget.sendTokenData.quantity?.decimals ?? '18';
    return int.parse(decimals);
  }

  BigInt _valueToBigInt(double value) {
    final amountStr = value.toStringAsFixed(_getDecimals(false));
    // Remove the decimal point and parse as an integer
    final normalizedAmountStr = amountStr.replaceAll('.', '');
    return BigInt.parse(normalizedAmountStr);
  }

  Future<void> _sendTransaction() async {
    try {
      final appKitModal = ModalProvider.of(context).instance;
      await appKitModal.request(
        topic: appKitModal.session!.topic,
        chainId: widget.sendTokenData.chainId!,
        request: SessionRequestParams(
          method: 'eth_sendTransaction',
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
              sendTokenData: widget.sendTokenData,
              sendData: widget.sendData,
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
              sendData: widget.sendData,
            ),
            const SizedBox.square(dimension: kPadding16),
            if (_transaction != null)
              _DetailsRow(
                transaction: _transaction!,
                nativeTokenData:
                    widget.networkTokenData ?? widget.sendTokenData,
                sendData: widget.sendData,
                requiredGasInTokens: _requiredGasInTokens,
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
  });
  final TokenBalance sendTokenData;
  final SendData sendData;

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
              sendData.amount!,
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
                Text(RenderUtils.truncate(sendData.address!)),
                const SizedBox.square(dimension: 6.0),
                SizedBox.square(
                  dimension: BaseButtonSize.regular.height * 0.55,
                  child: GradientOrb(
                    address: sendData.address!,
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
