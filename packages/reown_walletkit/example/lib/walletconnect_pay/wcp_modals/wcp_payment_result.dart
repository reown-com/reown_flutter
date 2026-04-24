import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/theme/app_colors.dart';
import 'package:reown_walletkit_wallet/theme/app_radius.dart';
import 'package:reown_walletkit_wallet/theme/app_spacing.dart';
import 'package:reown_walletkit_wallet/theme/app_typography.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_shared_widgets.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_utils.dart';
import 'package:reown_walletkit/reown_walletkit.dart';

class WCPPaymentResult extends StatefulWidget {
  const WCPPaymentResult({
    super.key,
    required this.status,
    this.info,
    this.errorType,
    this.errorMessage,
  }) : assert(status != PaymentStatus.succeeded || info != null);

  // enum PaymentStatus { requires_action, processing, succeeded, failed, expired }
  final PaymentStatus status;
  final PaymentInfo? info;
  // Values: 'insufficient_funds', 'expired', 'cancelled', 'not_found', 'generic'
  final String? errorType;
  // Original error message for generic errors
  final String? errorMessage;

  @override
  State<WCPPaymentResult> createState() => _WCPPaymentResultState();
}

class _WCPPaymentResultState extends State<WCPPaymentResult> {
  String get _errorIconId {
    switch (widget.errorType) {
      case 'insufficient_funds':
        return 'pay-result-insufficient-funds-icon';
      case 'expired':
        return 'pay-result-expired-icon';
      case 'cancelled':
        return 'pay-result-cancelled-icon';
      default:
        return 'pay-result-error-icon';
    }
  }

  String get _errorIconAsset {
    switch (widget.errorType) {
      case 'insufficient_funds':
        return 'lib/walletconnect_pay/assets/coin_stack.svg';
      default:
        return 'lib/walletconnect_pay/assets/warning_circle_blue.svg';
    }
  }

  String get _errorTitle {
    switch (widget.errorType) {
      case 'insufficient_funds':
        return 'Not enough funds';
      case 'expired':
        return 'Your payment has expired';
      case 'cancelled':
        return 'This payment was cancelled';
      case 'not_found':
        return 'Payment not found';
      default:
        return 'Transaction failed';
    }
  }

  String get _errorSubtitle {
    switch (widget.errorType) {
      case 'insufficient_funds':
        return "This wallet doesn't have enough funds on the supported "
            'networks to complete the payment.';
      case 'expired':
        return 'Please ask the merchant to generate a new payment '
            'and try again.';
      case 'cancelled':
        return 'Please ask the merchant to generate a new payment '
            'and try again.';
      case 'not_found':
        return 'This payment link is not valid or has already been completed.';
      default:
        return widget.errorMessage ??
            "The network couldn't complete this transaction.";
    }
  }

  String get _buttonText {
    if (widget.status == PaymentStatus.succeeded) return 'Got it!';
    switch (widget.errorType) {
      case 'insufficient_funds':
        return 'Got it!';
      case 'expired':
      case 'cancelled':
        return 'Scan new QR code';
      default:
        return 'Close';
    }
  }

  String get _popValue {
    if (widget.status == PaymentStatus.succeeded) {
      return WCBottomSheetResult.next.name;
    }
    switch (widget.errorType) {
      case 'expired':
      case 'cancelled':
        return 'scan_qr';
      default:
        return WCBottomSheetResult.close.name;
    }
  }

  bool get _isSuccess => widget.status == PaymentStatus.succeeded;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
      ),
      padding: EdgeInsets.zero,
      child: Semantics(
        container: true,
        identifier: 'pay-result-container',
        label: 'pay-result-container',
        child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.s7),
          if (_isSuccess) _buildSuccessContent() else _buildErrorContent(),
          const SizedBox(height: AppSpacing.s7),
          WCPrimaryButton(
            onPressed: () {
              Navigator.of(context).pop(_popValue);
            },
            text: _buttonText,
            testId: _isSuccess
                ? 'pay-button-result-action-success'
                : 'pay-button-result-action-${widget.errorType ?? 'generic'}',
          ),
        ],
      ),
      ),
    );
  }

  Widget _buildSuccessContent() {
    return Column(
      children: [
        Semantics(
          container: true,
          identifier: 'pay-result-success-icon',
          label: 'pay-result-success-icon',
          child: SvgPicture.asset(
            'lib/walletconnect_pay/assets/pay_success.svg',
            width: 40.0,
            height: 40.0,
          ),
        ),
        const SizedBox(height: AppSpacing.s4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Builder(builder: (context) {
                final colors = context.colors;
                return Semantics(
                  container: true,
                  identifier: 'pay-result-title',
                  label: 'pay-result-title',
                  child: RichText(
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
                        text: formatPayAmount(widget.info!.amount),
                      ),
                      const TextSpan(text: ' to '),
                      TextSpan(text: widget.info!.merchant.name),
                    ],
                  ),
                ),
                );
              }),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildErrorContent() {
    return Column(
      children: [
        Semantics(
          container: true,
          identifier: _errorIconId,
          label: _errorIconId,
          child: SvgPicture.asset(
            _errorIconAsset,
            width: 40.0,
            height: 40.0,
          ),
        ),
        const SizedBox(height: AppSpacing.s4),
        Semantics(
          container: true,
          identifier: 'pay-result-title',
          label: 'pay-result-title',
          child: WCModalTitle(text: _errorTitle),
        ),
        const SizedBox(height: AppSpacing.s1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s4),
          child: Builder(builder: (context) {
            final colors = context.colors;
            return Text(
              _errorSubtitle,
              style: context.textStyles.wcpTextPrimary.copyWith(
                color: colors.textTertiary,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            );
          }),
        ),
      ],
    );
  }
}
