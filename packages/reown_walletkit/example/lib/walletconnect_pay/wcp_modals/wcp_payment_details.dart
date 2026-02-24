import 'dart:convert';

import 'package:flutter/material.dart' hide Action;
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit/reown_walletkit.dart';

import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/evm_service.dart';
import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/theme/app_colors.dart';
import 'package:reown_walletkit_wallet/theme/app_radius.dart';
import 'package:reown_walletkit_wallet/theme/app_spacing.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_modals/wcp_information_capture/wcp_collect_data_browser.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_shared_widgets.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_utils.dart';

class WCPPaymentDetailsWidget extends StatefulWidget {
  const WCPPaymentDetailsWidget({
    super.key,
    required this.paymentOptionsResponse,
    required this.paymentRequest,
  });

  final PaymentOptionsResponse paymentOptionsResponse;
  final ConfirmPaymentRequest paymentRequest;

  @override
  State<WCPPaymentDetailsWidget> createState() =>
      _WCPPaymentDetailsWidgetState();
}

class _WCPPaymentDetailsWidgetState extends State<WCPPaymentDetailsWidget> {
  final _walletKitService = GetIt.I<IWalletKitService>();
  late final PaymentOptionsResponse paymentOptionsResponse;
  late ConfirmPaymentRequest confirmRequest;
  final Set<String> _collectDataCompletedIds = {};
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    paymentOptionsResponse = widget.paymentOptionsResponse;
    confirmRequest = widget.paymentRequest;
  }

  PaymentOption get _selectedOption {
    return paymentOptionsResponse.options.firstWhere(
      (e) => e.id == confirmRequest.optionId,
    );
  }

  bool _needsCollectData(PaymentOption option) {
    final url = option.collectData?.url;
    return url != null &&
        url.isNotEmpty &&
        !_collectDataCompletedIds.contains(option.id);
  }

  String _sign(Action action) {
    final walletKitService = GetIt.I<IWalletKitService>();
    final method = action.walletRpc.method;
    final chainId = action.walletRpc.chainId;
    final params = action.walletRpc.params;
    final service = walletKitService.getChainService<EVMService>(
      chainId: chainId,
    );
    switch (method) {
      case 'eth_signTypedData_v4':
        final decodedParams = jsonDecode(params) as List<dynamic>;
        final typedData = decodedParams.last;
        return service.ethSignTypedDataV4(typedData);
      case 'personal_sign':
        return '';
      default:
        throw UnimplementedError('Unsupported signing method: $method');
    }
  }

  Future<void> _signAndPay() async {
    try {
      final actions = List<Action>.from(_selectedOption.actions);
      if (actions.isEmpty) {
        final requiredActions =
            await _walletKitService.getRequiredPaymentActions(
          _selectedOption.id,
          confirmRequest.paymentId,
        );
        actions.addAll(requiredActions);
      }
      final signatures = actions.map((action) => _sign(action)).toList();
      confirmRequest = confirmRequest.copyWith(signatures: signatures);
      Navigator.of(context).pop(confirmRequest);
    } catch (e) {
      Navigator.of(context).pop(e);
    }
  }

  Future<void> _handleConfirmOrNext() async {
    if (_isProcessing) return;
    if (_needsCollectData(_selectedOption)) {
      setState(() => _isProcessing = true);
      try {
        final result = await WCPCollectDataBrowser.show(
          _selectedOption.collectData!.url!,
        );
        if (result == WCBottomSheetResult.next.name) {
          setState(() {
            _collectDataCompletedIds.add(_selectedOption.id);
          });
        }
      } finally {
        setState(() => _isProcessing = false);
      }
    } else {
      await _signAndPay();
    }
  }

  @override
  Widget build(BuildContext context) {
    final paymentInfo = paymentOptionsResponse.info;
    if (paymentInfo == null) {
      return const SizedBox.shrink();
    }

    final selectedNeedsCollectData = _needsCollectData(_selectedOption);
    final buttonText = selectedNeedsCollectData
        ? 'Next'
        : 'Pay ${formatPayAmount(paymentInfo.amount)}';

    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
      ),
      padding: const EdgeInsets.all(AppSpacing.s2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox.square(dimension: 20.0),
          WCPMerchantHeader(merchant: paymentInfo.merchant),
          const SizedBox(height: AppSpacing.s4),
          WCPPaymentDetails(paymentInfo: paymentInfo),
          const SizedBox(height: AppSpacing.s8),
          WCPPaymentOptionList(
            options: paymentOptionsResponse.options,
            selectedOption: _selectedOption,
            collectDataCompletedIds: _collectDataCompletedIds,
            onOptionSelected: (option) {
              setState(() {
                confirmRequest = confirmRequest.copyWith(optionId: option.id);
              });
            },
          ),
          const SizedBox(height: AppSpacing.s8),
          WCPrimaryButton(
            onPressed: _handleConfirmOrNext,
            enabled: !_isProcessing,
            text: buttonText,
          ),
        ],
      ),
    );
  }
}

class DefaultLogo extends StatelessWidget {
  final String text;
  const DefaultLogo({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: context.colors.onBackgroundInvert,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}


class WCPPaymentOptionList extends StatelessWidget {
  const WCPPaymentOptionList({
    super.key,
    required this.selectedOption,
    required this.options,
    required this.collectDataCompletedIds,
    required this.onOptionSelected,
  });

  final PaymentOption selectedOption;
  final List<PaymentOption> options;
  final Set<String> collectDataCompletedIds;
  final ValueChanged<PaymentOption> onOptionSelected;

  bool _optionNeedsCollectData(PaymentOption option) {
    final url = option.collectData?.url;
    return url != null &&
        url.isNotEmpty &&
        !collectDataCompletedIds.contains(option.id);
  }

  @override
  Widget build(BuildContext context) {
    // After IC is collected, show only the selected option
    final hasCompleted = collectDataCompletedIds.isNotEmpty;
    final visibleOptions =
        hasCompleted ? [selectedOption] : options;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: visibleOptions.map((option) {
        final isSelected = option.id == selectedOption.id;
        final hasCollectData = _optionNeedsCollectData(option);
        return _PaymentOptionItem(
          option: option,
          isSelected: isSelected,
          hasCollectData: hasCollectData,
          onTap: () {
            if (!isSelected) {
              onOptionSelected(option);
            }
          },
        );
      }).toList(),
    );
  }
}

class _PaymentOptionItem extends StatelessWidget {
  const _PaymentOptionItem({
    required this.option,
    required this.isSelected,
    required this.hasCollectData,
    required this.onTap,
  });

  final PaymentOption option;
  final bool isSelected;
  final bool hasCollectData;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final display = option.amount.display;
    final colors = context.colors;
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? colors.accent.withValues(alpha: 0.1)
                  : colors.textSecondary.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.only(
              left: AppSpacing.s3,
              right: AppSpacing.s3,
              bottom: AppSpacing.s2,
            ),
            padding: const EdgeInsets.all(AppSpacing.s4),
            height: 64.0,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 12.0,
                  backgroundImage: NetworkImage(display.iconUrl ?? ''),
                ),
                const SizedBox(width: AppSpacing.s2),
                Text(
                  formatPayAmount(option.amount),
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                if (hasCollectData)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    margin: const EdgeInsets.only(right: AppSpacing.s2),
                    decoration: BoxDecoration(
                      color: colors.accent.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Info required',
                      style: TextStyle(
                        color: colors.accent,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                if (isSelected)
                  Icon(Icons.radio_button_on, color: colors.accent)
                else
                  Icon(
                    Icons.radio_button_off,
                    color: colors.textTertiary,
                  ),
              ],
            ),
          ),
          Positioned(
            bottom: 26,
            left: 38,
            child: Visibility(
              visible: (display.networkIconUrl ?? '').isNotEmpty,
              child: Container(
                padding: const EdgeInsets.all(1.5),
                decoration: BoxDecoration(
                  color: colors.backgroundSecondary,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: CircleAvatar(
                  radius: 6.0,
                  backgroundImage:
                      NetworkImage(display.networkIconUrl ?? ''),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentDetailRow extends StatelessWidget {
  const PaymentDetailRow({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.iconColor,
    this.showChevron = false,
    this.onTap,
  });

  final String label;
  final String value;
  final IconData? icon;
  final Color? iconColor;
  final bool showChevron;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final row = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(color: colors.textSecondary, fontSize: 16.0)),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 6),
            ],
            Text(value,
                style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500)),
            if (showChevron) ...[
              const SizedBox(width: 6),
              Icon(Icons.chevron_right, color: colors.textTertiary, size: 20),
            ],
          ],
        ),
      ],
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: row,
        ),
      );
    }

    return row;
  }
}
