import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';

ButtonStyle buttonStyle(BuildContext context) {
  final themeColors = AppKitModalTheme.colorsOf(context);
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (states) {
        if (states.contains(MaterialState.disabled)) {
          return AppKitModalTheme.colorsOf(context).background225;
        }
        return AppKitModalTheme.colorsOf(context).accent100;
      },
    ),
    shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
      (states) {
        return RoundedRectangleBorder(
          side: states.contains(MaterialState.disabled)
              ? BorderSide(color: themeColors.grayGlass005, width: 1.0)
              : BorderSide(color: themeColors.grayGlass010, width: 1.0),
          borderRadius: borderRadius(context),
        );
      },
    ),
    textStyle: MaterialStateProperty.resolveWith<TextStyle>(
      (states) {
        return AppKitModalTheme.getDataOf(context).textStyles.small600.copyWith(
              color: (states.contains(MaterialState.disabled))
                  ? AppKitModalTheme.colorsOf(context).foreground300
                  : AppKitModalTheme.colorsOf(context).inverse100,
            );
      },
    ),
    foregroundColor: MaterialStateProperty.resolveWith<Color>(
      (states) {
        return (states.contains(MaterialState.disabled))
            ? AppKitModalTheme.colorsOf(context).foreground300
            : AppKitModalTheme.colorsOf(context).inverse100;
      },
    ),
  );
}

BorderRadiusGeometry borderRadius(BuildContext context) {
  final radiuses = AppKitModalTheme.radiusesOf(context);
  return radiuses.isSquare()
      ? const BorderRadius.all(Radius.zero)
      : radiuses.isCircular()
          ? BorderRadius.circular(1000.0)
          : BorderRadius.circular(8.0);
}
