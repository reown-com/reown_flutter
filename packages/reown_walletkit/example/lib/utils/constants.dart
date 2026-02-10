import 'package:flutter/material.dart';
import 'package:reown_walletkit_wallet/theme/app_colors.dart';

class Constants {
  static const smallScreen = 640;

  static const String domain = 'walletconnect.com';
  static const String aud = 'https://$domain/login';
}

class StyleConstants {
  // Linear
  static const double linear8 = 8;
  static const double linear16 = 16;
  static const double linear24 = 24;
  static const double linear32 = 32;
  static const double linear48 = 48;
  static const double linear56 = 56;
  static const double linear72 = 72;
  static const double linear80 = 80;

  // Magic Number
  static const double magic10 = 10;
  static const double magic14 = 14;
  static const double magic20 = 20;
  static const double magic40 = 40;
  static const double magic64 = 64;

  // Width
  static const double maxWidth = 400;

  // Bubbles
  static const EdgeInsets bubblePadding = EdgeInsets.symmetric(
    vertical: linear8,
    horizontal: linear8,
  );

  // ----------------------------------------------------------
  // Deprecated color bridges — use context.colors.* instead.
  // These delegate to AppColors.light for backward compatibility.
  // Consumer files will NOT respond to dark mode until migrated.
  // ----------------------------------------------------------

  @Deprecated('Use context.colors.background')
  static Color get bgPrimary => AppColors.light.background;

  @Deprecated('Use context.colors.accent')
  static Color get accentPrimary => AppColors.light.accent;

  @Deprecated('Use context.colors.backgroundSecondary')
  static Color get foregroundPrimary => AppColors.light.backgroundSecondary;

  @Deprecated('Use context.colors.backgroundTertiary')
  static Color get foregroundSecondary => AppColors.light.backgroundTertiary;

  @Deprecated('Use context.colors.neutrals')
  static Color get neutrals => AppColors.light.neutrals;

  @Deprecated('Use context.colors.textPrimary')
  static Color get textPrimary => AppColors.light.textPrimary;

  @Deprecated('Use context.colors.textSecondary')
  static Color get textSecondary => AppColors.light.textSecondary;

  @Deprecated('Use context.colors.textTertiary')
  static Color get textTertiary => AppColors.light.textTertiary;

  @Deprecated('Use context.colors.success')
  static Color get textSuccess => AppColors.light.success;

  @Deprecated('Use context.colors.error')
  static Color get textError => AppColors.light.error;

  // ----------------------------------------------------------
  // Deprecated text style bridges — use context.textStyles.* instead.
  // ----------------------------------------------------------

  @Deprecated('Use context.textStyles.wcpTextPrimary')
  static TextStyle get wcpTextPrimaryStyle => TextStyle(
        color: AppColors.light.textPrimary,
        fontSize: 16,
        fontFamily: 'KH Teka',
        fontWeight: FontWeight.w400,
      );

  @Deprecated('Use context.textStyles.wcpTextSecondary')
  static TextStyle get wcpTextSecondaryStyle => TextStyle(
        color: AppColors.light.textSecondary,
        fontSize: 16,
        fontFamily: 'KH Teka',
        fontWeight: FontWeight.w400,
      );

  @Deprecated('Use context.textStyles.titleText')
  static TextStyle get titleText => TextStyle(
        color: AppColors.light.textSecondary,
        fontSize: magic40,
        fontWeight: FontWeight.w500,
      );

  @Deprecated('Use context.textStyles.subtitleText')
  static TextStyle get subtitleText => TextStyle(
        color: AppColors.light.textPrimary,
        fontSize: linear24,
        fontWeight: FontWeight.w500,
      );

  @Deprecated('Use context.textStyles.buttonText')
  static TextStyle get buttonText => TextStyle(
        color: AppColors.light.onAccent,
        fontSize: linear16,
        fontWeight: FontWeight.w500,
      );

  @Deprecated('Use context.textStyles.bodyTextBold')
  static TextStyle get bodyTextBold => TextStyle(
        color: AppColors.light.textSecondary,
        fontSize: magic14,
        fontWeight: FontWeight.w500,
      );

  @Deprecated('Use context.textStyles.bodyText')
  static TextStyle get bodyText => TextStyle(
        color: AppColors.light.textSecondary,
        fontSize: magic14,
        fontWeight: FontWeight.w400,
      );

  @Deprecated('Use context.textStyles.bodyLightGray')
  static TextStyle get bodyLightGray => TextStyle(
        color: AppColors.light.textSecondary,
        fontSize: magic14,
      );

  @Deprecated('Use context.textStyles.layerTextStyle2')
  static TextStyle get layerTextStyle2 => TextStyle(
        color: AppColors.light.textPrimary,
        fontSize: magic14,
        fontWeight: FontWeight.w500,
      );

  @Deprecated('Use context.textStyles.layerTextStyle3')
  static TextStyle get layerTextStyle3 => TextStyle(
        color: AppColors.light.textPrimary,
        fontSize: magic14,
        fontWeight: FontWeight.w500,
      );

  @Deprecated('Use context.textStyles.layerTextStyle4')
  static TextStyle get layerTextStyle4 => TextStyle(
        color: AppColors.light.accent,
        fontSize: magic14,
        fontWeight: FontWeight.w500,
      );
}
