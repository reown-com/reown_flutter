import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_colors.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_radiuses.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_theme_data.dart';

class ReownAppKitModalTheme extends InheritedWidget {
  const ReownAppKitModalTheme({
    super.key,
    required super.child,
    this.themeData,
    this.isDarkMode = false,
  });

  final ReownAppKitModalThemeData? themeData;
  final bool isDarkMode;

  static ReownAppKitModalTheme of(BuildContext context) {
    final ReownAppKitModalTheme? result = maybeOf(context);
    assert(result != null, 'No ReownAppKitModalTheme found in context');
    return result!;
  }

  static bool isCustomTheme(BuildContext context) {
    final ReownAppKitModalTheme? theme = maybeOf(context);
    return theme?.themeData != null;
  }

  static ReownAppKitModalTheme? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ReownAppKitModalTheme>();
  }

  static ReownAppKitModalThemeData getDataOf(BuildContext context) {
    final ReownAppKitModalTheme? theme = maybeOf(context);
    return theme?.themeData ?? const ReownAppKitModalThemeData();
  }

  static ReownAppKitModalColors colorsOf(BuildContext context) {
    final ReownAppKitModalTheme? theme = maybeOf(context);
    if (theme?.isDarkMode == true) {
      return theme?.themeData?.darkColors ?? ReownAppKitModalColors.darkMode;
    }
    return theme?.themeData?.lightColors ?? ReownAppKitModalColors.lightMode;
  }

  static ReownAppKitModalRadiuses radiusesOf(BuildContext context) {
    final ReownAppKitModalTheme? theme = maybeOf(context);
    return theme?.themeData?.radiuses ?? const ReownAppKitModalRadiuses();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
