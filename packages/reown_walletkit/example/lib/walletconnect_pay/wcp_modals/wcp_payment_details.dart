import 'dart:convert';

import 'package:flutter/material.dart' hide Action;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/evm_service.dart';
import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/utils/constants.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/i_walletconnect_pay_service.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_shared_widgets.dart';
import 'package:walletconnect_pay/walletconnect_pay.dart';

class WCPPaymentDetailsWidget extends StatefulWidget {
  const WCPPaymentDetailsWidget({
    super.key,
    required this.paymentOptionsResponse,
    required this.paymentRequest,
  });

  final PaymentOptionsResponse paymentOptionsResponse;
  final ConfirmPaymentJsonRequest paymentRequest;

  @override
  State<WCPPaymentDetailsWidget> createState() =>
      _WCPPaymentDetailsWidgetState();
}

class _WCPPaymentDetailsWidgetState extends State<WCPPaymentDetailsWidget> {
  final _wcPayService = GetIt.I<IWalletConnectPayService>();
  late final PaymentOptionsResponse paymentOptionsResponse;
  late ConfirmPaymentJsonRequest confirmRequest;

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
        // final normalizedData = _normalizeHexValues(typedData);
        final signature = service.ethSignTypedDataV4(typedData);
        return signature;
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
        final requiredActions = await _wcPayService.getPaymentActions(
          _selectedOption.id,
          confirmRequest.paymentId,
        );
        actions.addAll(requiredActions);
      }
      final signatures = actions.map((action) => _sign(action)).toList();
      confirmRequest = confirmRequest.copyWith(signatures: signatures);
      // print(jsonEncode(confirmRequest.toJson()));
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop(confirmRequest);
      }
    } catch (e, s) {
      print('sign and pay error: $e, $s');
    }
  }

  @override
  Widget build(BuildContext context) {
    final paymentInfo = paymentOptionsResponse.info;
    if (paymentInfo == null) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(StyleConstants.linear48),
      ),
      padding: const EdgeInsets.all(StyleConstants.linear8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox.square(dimension: 20.0),
          WCPMerchantHeader(merchant: paymentInfo.merchant),
          const SizedBox(height: StyleConstants.linear16),
          WCPPaymentDetails(paymentInfo: paymentInfo),
          const SizedBox(height: StyleConstants.linear32),
          PaymentDetailsSection(
            paymentInfo: paymentInfo,
            options: paymentOptionsResponse.options,
            selectedOption: _selectedOption,
            onOptionSelected: (option) {
              print(option.actions);
              setState(() {
                confirmRequest = confirmRequest.copyWith(optionId: option.id);
              });
            },
          ),
          const SizedBox(height: StyleConstants.linear32),
          WCPrimaryButton(
            onPressed: _signAndPay,
            text: 'Pay ${paymentInfo.amount.formattedAmount}',
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
        color: Colors.white,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class PaymentDetailsSection extends StatelessWidget {
  const PaymentDetailsSection({
    super.key,
    required this.paymentInfo,
    required this.options,
    required this.selectedOption,
    this.onOptionSelected,
  });

  final PaymentInfo paymentInfo;
  final List<PaymentOption> options;
  final PaymentOption selectedOption;
  final ValueChanged<PaymentOption>? onOptionSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WCPTextField(
          controller: TextEditingController(),
          focusNode: FocusNode(),
          label: 'Amount',
          suffix: Text(
            paymentInfo.amount.formattedAmount,
            style: StyleConstants.wcpTextPrimaryStyle,
          ),
          enabled: false,
          onSubmitted: (_) {
            //
          },
        ),
        const SizedBox(height: 12.0),
        WCPPaymentOptionDropdown(
          label: 'Pay with',
          selectedOption: selectedOption,
          options: options,
          onOptionSelected: (option) {
            // setState(() => _selectedOption = option);
            onOptionSelected?.call(option);
          },
        ),
      ],
    );
  }
}

class WCPPaymentOptionDropdown extends StatefulWidget {
  const WCPPaymentOptionDropdown({
    super.key,
    required this.label,
    required this.selectedOption,
    required this.options,
    required this.onOptionSelected,
  });

  final String label;
  final PaymentOption selectedOption;
  final List<PaymentOption> options;
  final ValueChanged<PaymentOption> onOptionSelected;

  @override
  State<WCPPaymentOptionDropdown> createState() =>
      _WCPPaymentOptionDropdownState();
}

class _WCPPaymentOptionDropdownState extends State<WCPPaymentOptionDropdown> {
  bool _isExpanded = false;

  Widget _buildOptionRow(PaymentOption option, bool isSelected) {
    final display = option.amount.display;
    return InkWell(
      onTap: () {
        if (!isSelected) {
          widget.onOptionSelected(option);
        }
        setState(() => _isExpanded = false);
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? StyleConstants.accentPrimary.withValues(alpha: 0.1)
              : null,
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 8.0),
        padding: const EdgeInsets.all(16.0),
        height: 64.0,
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 12.0,
                  backgroundImage: NetworkImage(display.iconUrl ?? ''),
                ),
                Positioned(
                  bottom: -2,
                  right: 0,
                  child: Visibility(
                    visible: (display.networkIconUrl ?? '').isNotEmpty,
                    child: CircleAvatar(
                      radius: 9.0,
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Image.network(display.networkIconUrl ?? ''),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8.0),
            Text(
              option.amount.formattedAmount,
              style: StyleConstants.wcpTextPrimaryStyle,
            ),
            const SizedBox(width: 4.0),
            Text(
              option.amount.display.networkName ?? 'Unknown',
              style: StyleConstants.wcpTextPrimaryStyle.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 14.0,
              ),
            ),
            Spacer(),
            (widget.selectedOption.id == option.id)
                ? Icon(
                    Icons.radio_button_on,
                    color: StyleConstants.accentPrimary,
                  )
                : Icon(
                    Icons.radio_button_off,
                    color: StyleConstants.neutrals,
                  ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final display = widget.selectedOption.amount.display;
    final hasMultipleOptions = widget.options.length > 1;

    return Container(
      decoration: BoxDecoration(
        color: StyleConstants.foregroundPrimary,
        borderRadius: BorderRadius.circular(20),
      ),
      constraints: BoxConstraints(
        minHeight: 64.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_isExpanded) SizedBox.square(dimension: 6),
          // Selected option header (always visible, highlighted)
          InkWell(
            onTap: hasMultipleOptions
                ? () => setState(() => _isExpanded = !_isExpanded)
                : null,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.label,
                    style: StyleConstants.wcpTextSecondaryStyle.copyWith(
                      color: StyleConstants.textTertiary,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.selectedOption.amount.formattedAmount,
                        style: StyleConstants.wcpTextPrimaryStyle,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        '(${widget.selectedOption.amount.display.networkName ?? 'Unknown'})',
                        style: StyleConstants.wcpTextSecondaryStyle
                            .copyWith(fontSize: 14.0),
                      ),
                      const SizedBox(width: 4.0),
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 12.0,
                            backgroundImage:
                                NetworkImage(display.iconUrl ?? ''),
                          ),
                          Positioned(
                            bottom: -2,
                            right: 0,
                            child: Visibility(
                              visible:
                                  (display.networkIconUrl ?? '').isNotEmpty,
                              child: CircleAvatar(
                                radius: 9.0,
                                backgroundColor: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Image.network(
                                      display.networkIconUrl ?? ''),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (hasMultipleOptions)
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: AnimatedRotation(
                            turns: _isExpanded ? 0.5 : 0.0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            child: SvgPicture.asset(
                              'lib/walletconnect_pay/assets/caret_up_down.svg',
                              width: 20.0,
                              height: 20.0,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Expanded options list with animation
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: _isExpanded && hasMultipleOptions
                ? Column(
                    children: [
                      ...widget.options.map((option) {
                        return _buildOptionRow(
                          option,
                          option.id == widget.selectedOption.id,
                        );
                      }),
                      const SizedBox.square(dimension: 4),
                    ],
                  )
                : const SizedBox.shrink(),
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
    final row = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: StyleConstants.wcpTextSecondaryStyle,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 6),
            ],
            Text(
              value,
              style: StyleConstants.wcpTextPrimaryStyle,
            ),
            if (showChevron) ...[
              const SizedBox(width: 6),
              Icon(Icons.chevron_right, color: Colors.grey[600], size: 20),
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
