import 'package:flutter/material.dart';
import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/theme/app_spacing.dart';
import 'package:reown_walletkit_wallet/theme/app_typography.dart';
import 'package:reown_walletkit_wallet/widgets/custom_button.dart';

class WCSessionAuthRequestWidget extends StatelessWidget {
  const WCSessionAuthRequestWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(child: SingleChildScrollView(child: child)),
        const SizedBox(height: AppSpacing.s4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomButton(
              onTap: () {
                if (Navigator.canPop(context)) {
                  Navigator.of(context).pop(WCBottomSheetResult.reject);
                }
              },
              type: CustomButtonType.invalid,
              child: Text(
                'Cancel',
                style: context.textStyles.buttonText,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: AppSpacing.s2),
            CustomButton(
              onTap: () {
                if (Navigator.canPop(context)) {
                  Navigator.of(context).pop(WCBottomSheetResult.one);
                }
              },
              type: CustomButtonType.normal,
              child: Text(
                'Sign One',
                style: context.textStyles.buttonText,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: AppSpacing.s2),
            CustomButton(
              onTap: () {
                if (Navigator.canPop(context)) {
                  Navigator.of(context).pop(WCBottomSheetResult.all);
                }
              },
              type: CustomButtonType.valid,
              child: Text(
                'Sign All',
                style: context.textStyles.buttonText,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
