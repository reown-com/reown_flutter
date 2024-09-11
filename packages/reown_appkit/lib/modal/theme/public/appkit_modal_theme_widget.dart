import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_colors.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_radiuses.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_theme_data.dart';

class AppKitModalTheme extends InheritedWidget {
  const AppKitModalTheme({
    super.key,
    required super.child,
    this.themeData,
    this.isDarkMode = false,
  });

  final AppKitModalThemeData? themeData;
  final bool isDarkMode;

  static AppKitModalTheme of(BuildContext context) {
    final AppKitModalTheme? result = maybeOf(context);
    assert(result != null, 'No AppKitModalTheme found in context');
    return result!;
  }

  static bool isCustomTheme(BuildContext context) {
    final AppKitModalTheme? theme = maybeOf(context);
    return theme?.themeData != null;
  }

  static AppKitModalTheme? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppKitModalTheme>();
  }

  static AppKitModalThemeData getDataOf(BuildContext context) {
    final AppKitModalTheme? theme = maybeOf(context);
    return theme?.themeData ?? const AppKitModalThemeData();
  }

  static AppKitModalColors colorsOf(BuildContext context) {
    final AppKitModalTheme? theme = maybeOf(context);
    if (theme?.isDarkMode == true) {
      return theme?.themeData?.darkColors ?? AppKitModalColors.darkMode;
    }
    return theme?.themeData?.lightColors ?? AppKitModalColors.lightMode;
  }

  static AppKitModalRadiuses radiusesOf(BuildContext context) {
    final AppKitModalTheme? theme = maybeOf(context);
    return theme?.themeData?.radiuses ?? const AppKitModalRadiuses();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
