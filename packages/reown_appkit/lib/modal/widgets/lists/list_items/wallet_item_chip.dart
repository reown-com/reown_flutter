import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_theme.dart';

class WalletItemChip extends StatelessWidget {
  const WalletItemChip({
    super.key,
    required this.value,
    this.color,
    this.textStyle,
  });
  final String value;
  final Color? color;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    return Container(
      decoration: BoxDecoration(
        color: color ?? themeColors.grayGlass010,
        borderRadius: BorderRadius.all(Radius.circular(radiuses.radius4XS)),
      ),
      padding: const EdgeInsets.all(5.0),
      margin: const EdgeInsets.only(right: 8.0),
      child: Text(
        value,
        style: textStyle ??
            themeData.textStyles.micro700.copyWith(
              color: themeColors.foreground150,
            ),
      ),
    );
  }
}
