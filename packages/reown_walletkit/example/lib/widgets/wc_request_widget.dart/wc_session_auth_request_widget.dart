import 'package:flutter/material.dart';
import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/utils/constants.dart';
import 'package:reown_walletkit_wallet/widgets/custom_button.dart';

class WCSessionAuthRequestWidget extends StatelessWidget {
  const WCSessionAuthRequestWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: child,
          ),
        ),
        const SizedBox(height: StyleConstants.linear16),
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
              child: const Text(
                'Cancel',
                style: StyleConstants.buttonText,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: StyleConstants.linear8),
            CustomButton(
              onTap: () {
                if (Navigator.canPop(context)) {
                  Navigator.of(context).pop(WCBottomSheetResult.one);
                }
              },
              type: CustomButtonType.normal,
              child: const Text(
                'Sign One',
                style: StyleConstants.buttonText,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: StyleConstants.linear8),
            CustomButton(
              onTap: () {
                if (Navigator.canPop(context)) {
                  Navigator.of(context).pop(WCBottomSheetResult.all);
                }
              },
              type: CustomButtonType.valid,
              child: const Text(
                'Sign All',
                style: StyleConstants.buttonText,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
