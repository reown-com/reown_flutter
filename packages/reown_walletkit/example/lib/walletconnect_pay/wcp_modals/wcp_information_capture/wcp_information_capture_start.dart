import 'package:flutter/material.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/utils/constants.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_shared_widgets.dart';

class WCPInformationCaptureStartWidget extends StatelessWidget {
  const WCPInformationCaptureStartWidget({
    super.key,
    required this.paymentInfo,
    this.onStart,
  });

  final PaymentInfo paymentInfo;
  final VoidCallback? onStart;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: StyleConstants.bgPrimary,
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
          const PaymentSteps(),
          const SizedBox(height: StyleConstants.linear32),
          WCPrimaryButton(
            onPressed: onStart ??
                () {
                  if (Navigator.canPop(context)) {
                    Navigator.of(context).pop(WCBottomSheetResult.next.name);
                  }
                },
            text: "Let's start",
          ),
        ],
      ),
    );
  }
}

class PaymentSteps extends StatelessWidget {
  const PaymentSteps({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PaymentStep(
          title: 'Provide information',
          description:
              'A quick one-time check required for regulated payments.',
          timeEstimate: '≈2min',
          isLast: false,
        ),
        PaymentStep(
          title: 'Confirm payment',
          description: 'Review the details and approve the payment.',
          isLast: true,
        ),
      ],
    );
  }
}

class PaymentStep extends StatelessWidget {
  const PaymentStep({
    super.key,
    required this.title,
    required this.description,
    this.timeEstimate,
    required this.isLast,
  });

  final String title;
  final String description;
  final String? timeEstimate;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StepIndicator(isLast: isLast),
          const SizedBox(width: StyleConstants.linear16),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: StyleConstants.wcpTextPrimaryStyle),
                      const SizedBox.square(dimension: 6.0),
                      Text(
                        description,
                        style: StyleConstants.wcpTextSecondaryStyle,
                      ),
                      if (!isLast) const SizedBox.square(dimension: 30.0),
                    ],
                  ),
                ),
                if (timeEstimate != null)
                  TimeEstimateBadge(timeEstimate: timeEstimate!),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StepIndicator extends StatelessWidget {
  const StepIndicator({super.key, required this.isLast});

  final bool isLast;

  static const double _circleSize = 14.0;
  static const double _lineWidth = 2.0;
  static const double _topLineHeight = 16.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isLast) StepLine(height: _topLineHeight),
        Container(
          margin: !isLast ? const EdgeInsets.only(top: 24.0) : null,
          width: _circleSize,
          height: _circleSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey[300]!, width: _lineWidth),
          ),
        ),
        if (!isLast) const Expanded(child: StepLine.expandable()),
      ],
    );
  }
}

class StepLine extends StatelessWidget {
  const StepLine({super.key, required this.height});

  const StepLine.expandable({super.key}) : height = null;

  final double? height;

  static const double _width = 2.0;

  @override
  Widget build(BuildContext context) {
    if (height != null) {
      return Container(width: _width, height: height, color: Colors.grey[300]);
    } else {
      return Container(width: _width, color: Colors.grey[300]);
    }
  }
}

class TimeEstimateBadge extends StatelessWidget {
  const TimeEstimateBadge({super.key, required this.timeEstimate});

  final String timeEstimate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12.0),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        timeEstimate,
        style: StyleConstants.wcpTextPrimaryStyle.copyWith(fontSize: 14.0),
      ),
    );
  }
}
