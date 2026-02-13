import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/theme/app_spacing.dart';
import 'package:reown_walletkit_wallet/theme/app_typography.dart';
import 'package:reown_walletkit_wallet/utils/string_constants.dart';
import 'package:reown_walletkit_wallet/widgets/custom_button.dart';
import 'package:reown_walletkit_wallet/widgets/wc_connection_request/wc_connection_request_widget.dart';

class WCRequestWidget extends StatelessWidget {
  const WCRequestWidget({
    super.key,
    required this.child,
    this.verifyContext,
    this.onAccept,
    this.onReject,
  });

  final Widget child;
  final VerifyContext? verifyContext;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        VerifyContextWidget(verifyContext: verifyContext),
        const SizedBox(height: AppSpacing.s2),
        Flexible(child: SingleChildScrollView(child: child)),
        const SizedBox(height: AppSpacing.s4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomButton(
              onTap: onReject ??
                  () {
                    if (Navigator.canPop(context)) {
                      Navigator.of(context).pop(WCBottomSheetResult.reject);
                    }
                  },
              type: CustomButtonType.invalid,
              child: Text(
                StringConstants.reject,
                style: context.textStyles.buttonText,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: AppSpacing.s4),
            CustomButton(
              onTap: onAccept ??
                  () {
                    if (Navigator.canPop(context)) {
                      Navigator.of(context).pop(WCBottomSheetResult.one);
                    }
                  },
              type: CustomButtonType.valid,
              child: Text(
                StringConstants.approve,
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
