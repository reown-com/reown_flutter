import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/theme/app_colors.dart';
import 'package:reown_walletkit_wallet/theme/app_radius.dart';
import 'package:reown_walletkit_wallet/theme/app_spacing.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_shared_widgets.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_utils.dart';
import 'package:reown_walletkit/reown_walletkit.dart';

class WCPPaymentResult extends StatefulWidget {
  const WCPPaymentResult({super.key, required this.status, required this.info});

  // enum PaymentStatus { requires_action, processing, succeeded, failed, expired }
  final PaymentStatus status;
  final PaymentInfo info;

  @override
  State<WCPPaymentResult> createState() => _WCPPaymentResultState();
}

class _WCPPaymentResultState extends State<WCPPaymentResult> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
      ),
      padding: const EdgeInsets.only(
        left: AppSpacing.s2,
        bottom: AppSpacing.s2,
        right: AppSpacing.s2,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.s11),
          Builder(
            builder: (BuildContext context) {
              switch (widget.status) {
                case PaymentStatus.succeeded:
                  return Column(
                    children: [
                      SvgPicture.asset(
                        'lib/walletconnect_pay/assets/pay_success.svg',
                        width: 40.0,
                        height: 40.0,
                      ),
                      const SizedBox(height: AppSpacing.s6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Builder(builder: (context) {
                              final colors = context.colors;
                              return RichText(
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                text: TextSpan(
                                  style: TextStyle(
                                    color: colors.textPrimary,
                                    fontSize: 20.0,
                                    fontFamily: 'KH Teka',
                                    fontWeight: FontWeight.w400,
                                  ),
                                  children: [
                                    const TextSpan(text: 'You\'ve paid '),
                                    TextSpan(
                                      text: formatPayAmount(widget.info.amount),
                                    ),
                                    const TextSpan(text: ' to '),
                                    TextSpan(text: widget.info.merchant.name),
                                    const TextSpan(text: ' '),
                                    WidgetSpan(
                                      child: SvgPicture.asset(
                                        'lib/walletconnect_pay/assets/verified.svg',
                                        width: 20.0,
                                        height: 20.0,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ],
                  );
                case PaymentStatus.failed:
                  return Column(
                    children: [
                      SvgPicture.asset(
                        'lib/walletconnect_pay/assets/pay_failed.svg',
                        width: 40.0,
                        height: 40.0,
                      ),
                      const SizedBox(height: AppSpacing.s6),
                      WCModalTitle(text: 'Payment failed'),
                    ],
                  );
                default:
                  return Column(
                    children: [
                      SvgPicture.asset(
                        'lib/walletconnect_pay/assets/pay_failed.svg',
                        width: 40.0,
                        height: 40.0,
                      ),
                      const SizedBox(height: AppSpacing.s6),
                      WCModalTitle(text: 'Payment ${widget.status.name}'),
                    ],
                  );
              }
            },
          ),
          const SizedBox(height: AppSpacing.s11),
          WCPrimaryButton(
            onPressed: () {
              Navigator.of(context).pop(WCBottomSheetResult.next.name);
            },
            text: 'Got it!',
          ),
        ],
      ),
    );
  }
}
