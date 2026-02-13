import 'package:flutter/material.dart';
import 'package:reown_walletkit_wallet/theme/app_colors.dart';

class AppTypography {
  final BuildContext _context;
  AppTypography._(this._context);

  AppColors get _c => _context.colors;

  TextStyle get titleText => TextStyle(
        color: _c.textSecondary,
        fontSize: 40.0,
        fontWeight: FontWeight.w500,
      );

  TextStyle get subtitleText => TextStyle(
        color: _c.textPrimary,
        fontSize: 24.0,
        fontWeight: FontWeight.w500,
      );

  TextStyle get buttonText => TextStyle(
        color: _c.onAccent,
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
      );

  TextStyle get bodyTextBold => TextStyle(
        color: _c.textSecondary,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      );

  TextStyle get bodyText => TextStyle(
        color: _c.textSecondary,
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
      );

  TextStyle get bodyLightGray => TextStyle(
        color: _c.textSecondary,
        fontSize: 14.0,
      );

  /// Used for general primary-colored labels (e.g. session item names).
  TextStyle get layerTextStyle2 => TextStyle(
        color: _c.textPrimary,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      );

  /// Used for connection widget info titles. Currently identical to
  /// layerTextStyle2 but kept separate for semantic distinction.
  TextStyle get layerTextStyle3 => TextStyle(
        color: _c.textPrimary,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      );

  TextStyle get layerTextStyle4 => TextStyle(
        color: _c.accent,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      );

  TextStyle get wcpTextPrimary => TextStyle(
        color: _c.textPrimary,
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
      );

  TextStyle get wcpTextSecondary => TextStyle(
        color: _c.textSecondary,
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
      );
}

extension AppTypographyExtension on BuildContext {
  AppTypography get textStyles => AppTypography._(this);
}
