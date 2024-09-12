import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_theme.dart';

enum BaseButtonSize {
  small,
  regular,
  big;

  double get height {
    switch (this) {
      case small:
        return 32.0;
      case regular:
        return 40.0;
      default:
        return 48.0;
    }
  }

  double get iconSize {
    switch (this) {
      case small:
        return 16.0;
      case regular:
        return 20.0;
      default:
        return 24.0;
    }
  }
}

class BaseButton extends StatelessWidget {
  const BaseButton({
    super.key,
    required this.child,
    required this.size,
    this.onTap,
    this.buttonStyle,
    this.overridePadding,
  });
  final Widget child;
  final VoidCallback? onTap;
  final BaseButtonSize size;
  final ButtonStyle? buttonStyle;
  final MaterialStateProperty<EdgeInsetsGeometry?>? overridePadding;

  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final textStyle = size == BaseButtonSize.small
        ? themeData.textStyles.small600
        : themeData.textStyles.paragraph600;
    return FilledButton(
      onPressed: onTap,
      child: child,
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all<TextStyle>(textStyle),
        minimumSize: MaterialStateProperty.all<Size>(Size(
          size.height,
          size.height,
        )),
        maximumSize: MaterialStateProperty.all<Size>(Size(
          1000.0,
          size.height,
        )),
        padding: overridePadding ??
            MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
              ),
            ),
      ).merge(buttonStyle),
    );
  }
}
