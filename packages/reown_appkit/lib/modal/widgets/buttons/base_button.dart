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
    required this.semanticsLabel,
    this.onTap,
    this.buttonStyle,
    this.overridePadding,
  });
  final Widget child;
  final VoidCallback? onTap;
  final BaseButtonSize size;
  final String semanticsLabel;
  final ButtonStyle? buttonStyle;
  final WidgetStateProperty<EdgeInsetsGeometry?>? overridePadding;

  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final textStyle = size == BaseButtonSize.small
        ? themeData.textStyles.small500
        : themeData.textStyles.paragraph500;
    return Semantics(
      // Semantic label for Maestro
      label: onTap != null
          ? '$semanticsLabel enabled'
          : '$semanticsLabel disabled',
      // Marks it as a button for accessibility
      button: true,
      // Reflects if the button is tappable
      enabled: onTap != null,
      child: FilledButton(
        onPressed: onTap,
        child: child,
        style: ButtonStyle(
          textStyle: WidgetStateProperty.all<TextStyle>(textStyle),
          minimumSize: WidgetStateProperty.all<Size>(Size(
            size.height,
            size.height,
          )),
          maximumSize: WidgetStateProperty.all<Size>(Size(
            1000.0,
            size.height,
          )),
          padding: overridePadding ??
              WidgetStateProperty.all<EdgeInsetsGeometry>(
                const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                ),
              ),
        ).merge(buttonStyle),
      ),
    );
  }
}
