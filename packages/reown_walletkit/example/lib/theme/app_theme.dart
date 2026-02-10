import 'package:flutter/material.dart';
import 'package:reown_walletkit_wallet/theme/app_colors.dart';

abstract final class AppTheme {
  static const _fontFamily = 'KH Teka';

  static ThemeData light() {
    const colors = AppColors.light;
    return ThemeData(
      brightness: Brightness.light,
      fontFamily: _fontFamily,
      colorScheme: ColorScheme.light(
        primary: colors.accent,
        surface: colors.background,
        error: colors.error,
      ),
      scaffoldBackgroundColor: colors.background,
      appBarTheme: AppBarTheme(
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        elevation: 0,
      ),
      dividerColor: colors.divider,
      extensions: <ThemeExtension<dynamic>>[colors],
    );
  }

  static ThemeData dark() {
    const colors = AppColors.dark;
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: _fontFamily,
      colorScheme: ColorScheme.dark(
        primary: colors.accent,
        surface: colors.background,
        error: colors.error,
      ),
      scaffoldBackgroundColor: colors.background,
      appBarTheme: AppBarTheme(
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        elevation: 0,
      ),
      dividerColor: colors.divider,
      extensions: <ThemeExtension<dynamic>>[colors],
    );
  }
}
