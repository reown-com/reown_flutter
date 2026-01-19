import 'package:flutter/material.dart';

class Constants {
  static const smallScreen = 640;

  static const String domain = 'walletconnect.com';
  static const String aud = 'https://$domain/login';
}

class StyleConstants {
  static TextStyle get wcpTextPrimaryStyle => TextStyle(
        color: textPrimary,
        fontSize: 16,
        fontFamily: 'KH Teka',
        fontWeight: FontWeight.w400,
        // height: 1.0, // 20px line height / 20px font size = 1.0
        // letterSpacing: -0.6, // -3% of 20px = -0.6
      );

  static TextStyle get wcpTextSecondaryStyle => TextStyle(
        color: textSecondary,
        fontSize: 16,
        fontFamily: 'KH Teka',
        fontWeight: FontWeight.w400,
        // height: 1.0, // 20px line height / 20px font size = 1.0
        // letterSpacing: -0.6, // -3% of 20px = -0.6
      );

  static Color get bgPrimary => Color(0xFFFFFFFF);
  static Color get accentPrimary => Color(0xFF0988F0);
  static Color get foregroundPrimary => Color(0xFFF3F3F3);
  static Color get foregroundSecondary => Color(0xFFE9E9E9);
  static Color get neutrals => Color(0xFFBBBBBB);
  static Color get textPrimary => Color(0xFF202020);
  static Color get textSecondary => Color(0xFF9A9A9A);
  static Color get textTertiary => Color(0xFF6C6C6C);
  static Color get textSuccess => Color(0xFF30A46B);
  static Color get textError => Color(0xFFDF4A34);

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

  // Text styles
  static const TextStyle titleText = TextStyle(
    color: Colors.grey,
    fontSize: magic40,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle subtitleText = TextStyle(
    color: Colors.white,
    fontSize: linear24,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle buttonText = TextStyle(
    color: Colors.white,
    fontSize: linear16,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle bodyTextBold = TextStyle(
    color: Colors.grey,
    fontSize: magic14,
    fontWeight: FontWeight.w900,
  );
  static const TextStyle bodyText = TextStyle(
    color: Colors.grey,
    fontSize: magic14,
    fontWeight: FontWeight.w400,
  );
  static TextStyle bodyLightGray = TextStyle(
    color: textSecondary,
    fontSize: magic14,
  );
  static TextStyle layerTextStyle2 = TextStyle(
    color: textPrimary,
    fontSize: magic14,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle layerTextStyle3 = TextStyle(
    color: Colors.black,
    fontSize: magic14,
    fontWeight: FontWeight.w600,
  );
  static TextStyle layerTextStyle4 = TextStyle(
    color: accentPrimary,
    fontSize: magic14,
    fontWeight: FontWeight.w600,
  );

  // Bubbles
  static const EdgeInsets bubblePadding = EdgeInsets.symmetric(
    vertical: linear8,
    horizontal: linear8,
  );
}
