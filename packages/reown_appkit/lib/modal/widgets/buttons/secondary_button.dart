import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/widgets/buttons/base_button.dart';
import 'package:reown_appkit/reown_appkit.dart';

class SecondaryButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final BaseButtonSize? size;
  const SecondaryButton({
    super.key,
    required this.title,
    this.onTap,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    final buttonSize = size ?? BaseButtonSize.big;
    return BaseButton(
      semanticsLabel: 'SecondaryButton',
      size: buttonSize,
      child: Text(title),
      onTap: onTap,
      buttonStyle: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (states) => themeColors.grayGlass002,
        ),
        foregroundColor: WidgetStateProperty.resolveWith<Color>(
          (states) => themeColors.foreground200,
        ),
        shape: WidgetStateProperty.resolveWith<RoundedRectangleBorder>((
          states,
        ) {
          return RoundedRectangleBorder(
            side: BorderSide(color: themeColors.grayGlass002, width: 1.0),
            borderRadius: radiuses.isSquare()
                ? BorderRadius.zero
                : BorderRadius.circular(buttonSize.height),
          );
        }),
      ),
    );
  }
}
