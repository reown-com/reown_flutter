import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/theme/app_colors.dart';
import 'package:reown_walletkit_wallet/theme/app_spacing.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_payment_util.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_shared_widgets.dart';

/// Inline gas-fee explainer rendered inside the same bottom sheet as the
/// payment-options/review flow. The header back arrow that returns to the
/// previous view lives in `walletkit_service.dart::_processPayment` (driven by
/// the `showGasFeeNotifier` it owns).
class WCPGasFeeView extends StatelessWidget {
  const WCPGasFeeView({
    super.key,
    required this.option,
    required this.estimate,
    required this.onDismiss,
  });

  final PaymentOption option;
  final WCPFeeEstimate? estimate;
  final VoidCallback onDismiss;

  String get _symbol => option.amount.display.assetSymbol;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final iconUrl = option.amount.display.iconUrl;

    return Semantics(
      container: true,
      identifier: 'pay-gas-fee-explainer',
      label: 'pay-gas-fee-explainer',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: AppSpacing.s5),
          if (iconUrl != null && iconUrl.isNotEmpty)
            CircleAvatar(
              radius: 28.0,
              backgroundImage: NetworkImage(iconUrl),
            )
          else
            CircleAvatar(
              radius: 28.0,
              backgroundColor: colors.foregroundPrimary,
              child: Text(
                _symbol.characters.first,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          const SizedBox(height: AppSpacing.s4),
          Text(
            'Why does $_symbol require a gas fee?',
            style: TextStyle(
              color: colors.textPrimary,
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.s3),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s2),
            child: Text(
              'The gas fee covers a one-time setup that lets your wallet pay '
              'with $_symbol.',
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s2),
            child: Text(
              'You only pay it once. Future $_symbol payments '
              'from this wallet skip this step.',
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: AppSpacing.s4),
          _GasFeeRow(estimate: estimate),
          const SizedBox(height: AppSpacing.s5),
          WCPrimaryButton(
            onPressed: onDismiss,
            text: 'Got it!',
            testId: 'pay-gas-fee-got-it',
          ),
          const SizedBox(height: AppSpacing.s3),
        ],
      ),
    );
  }
}

class _GasFeeRow extends StatelessWidget {
  const _GasFeeRow({required this.estimate});
  final WCPFeeEstimate? estimate;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final fee = estimate;
    final value = fee == null ? '…' : fee.display;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Gas fee: $value',
          style: TextStyle(
            color: colors.textSecondary,
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(width: 4),
        SvgPicture.asset(
          'assets/GasPump.svg',
          width: 16.0,
          height: 16.0,
          colorFilter: ColorFilter.mode(
            colors.textSecondary,
            BlendMode.srcIn,
          ),
        ),
      ],
    );
  }
}
