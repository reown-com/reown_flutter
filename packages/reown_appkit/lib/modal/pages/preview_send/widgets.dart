import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/models/send_data.dart';
import 'package:reown_appkit/modal/pages/preview_send/utils.dart';
import 'package:reown_appkit/modal/services/blockchain_service/models/token_balance.dart';
import 'package:reown_appkit/modal/utils/core_utils.dart';
import 'package:reown_appkit/modal/utils/render_utils.dart';
import 'package:reown_appkit/modal/widgets/avatars/account_avatar.dart';
import 'package:reown_appkit/modal/widgets/buttons/address_button.dart';
import 'package:reown_appkit/modal/widgets/buttons/network_button.dart';
import 'package:reown_appkit/modal/widgets/buttons/primary_button.dart';
import 'package:reown_appkit/modal/widgets/buttons/secondary_button.dart';
import 'package:reown_appkit/modal/widgets/lists/list_items/account_list_item.dart';
import 'package:reown_appkit/reown_appkit.dart' hide TransactionExtension;
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';

class SendRow extends StatelessWidget {
  const SendRow({
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
    final balanceSend = sendData.amount!.toDouble() * tokenPrice;
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

class ReceiveRow extends StatelessWidget {
  const ReceiveRow({required this.sendData});
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

class SendButtonRow extends StatelessWidget {
  const SendButtonRow({
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

class DetailsRow extends StatefulWidget {
  const DetailsRow({
    required this.nativeTokenData,
    required this.sendData,
    required this.requiredGasInTokens,
  });
  final TokenBalance nativeTokenData;
  final SendData sendData;
  final double requiredGasInTokens;

  @override
  State<DetailsRow> createState() => _DetailsRowState();
}

class _DetailsRowState extends State<DetailsRow> {
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
            titleStyle: themeData.textStyles.small400.copyWith(
              color: themeColors.foreground150,
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(right: 4.0),
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
