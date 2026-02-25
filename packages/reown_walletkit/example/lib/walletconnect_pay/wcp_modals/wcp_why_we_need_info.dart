import 'package:flutter/material.dart';
import 'package:reown_walletkit_wallet/theme/app_colors.dart';
import 'package:reown_walletkit_wallet/theme/app_radius.dart';
import 'package:reown_walletkit_wallet/theme/app_spacing.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_shared_widgets.dart';

class WCPWhyWeNeedInfoModal extends StatelessWidget {
  const WCPWhyWeNeedInfoModal({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const WCPWhyWeNeedInfoModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Material(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(AppRadius.xl),
        topRight: Radius.circular(AppRadius.xl),
      ),
      color: colors.background,
      child: Padding(
        padding: EdgeInsets.only(
          top: AppSpacing.s5,
          left: AppSpacing.s5,
          right: AppSpacing.s5,
          bottom:
              MediaQuery.of(context).viewInsets.bottom + AppSpacing.s5,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _Header(),
            const SizedBox(height: AppSpacing.s7),
            const WCPWhyWeNeedInfoBody(),
            const SizedBox(height: AppSpacing.s7),
            _GotItButton(),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WCPSheetIconButton(
          icon: Icons.arrow_back,
          showBorder: false,
          onPressed: () => Navigator.of(context).pop(),
        ),
        WCPSheetIconButton(
          icon: Icons.close,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

class WCPWhyWeNeedInfoBody extends StatelessWidget {
  const WCPWhyWeNeedInfoBody({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      children: [
        Text(
          'Why we need your information?',
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
            height: 1.0,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.s2),
        Text(
          'For regulatory compliance, we collect basic information on your '
          'first payment: full name, date of birth, and place of birth.',
          style: TextStyle(
            color: colors.textTertiary,
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            height: 1.125,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.s2),
        Text(
          'This information is tied to your wallet address and this specific '
          'network. If you use the same wallet on this network again, you '
          "won't need to provide it again.",
          style: TextStyle(
            color: colors.textTertiary,
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            height: 1.125,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _GotItButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WCPrimaryButton(
      onPressed: () => Navigator.of(context).pop(),
      text: 'Got it!',
    );
  }
}
