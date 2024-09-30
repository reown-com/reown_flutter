import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/widgets/buttons/base_button.dart';
import 'package:reown_appkit/reown_appkit.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool loading;
  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  const PrimaryButton({
    super.key,
    required this.title,
    this.onTap,
    this.loading = false,
    this.color,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    return BaseButton(
      size: BaseButtonSize.big,
      child: loading
          ? SizedBox(
              height: BaseButtonSize.big.height * 0.4,
              width: BaseButtonSize.big.height * 0.4,
              child: CircularProgressIndicator(
                color: themeColors.accent100,
                strokeWidth: 2.0,
              ),
            )
          : Text(title),
      onTap: loading ? null : onTap,
      buttonStyle: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              return themeColors.grayGlass010;
            }
            return color ?? themeColors.accent100;
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              return themeColors.foreground200;
            }
            return themeColors.inverse100;
          },
        ),
        shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
          (states) {
            return RoundedRectangleBorder(
              side: BorderSide(
                color: themeColors.grayGlass010,
                width: 1.0,
              ),
              borderRadius: borderRadius ??
                  (radiuses.isSquare()
                      ? BorderRadius.all(Radius.zero)
                      : BorderRadius.circular(16.0)),
            );
          },
        ),
      ),
    );
  }
}
