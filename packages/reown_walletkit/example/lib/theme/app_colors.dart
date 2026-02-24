import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    // Background
    required this.background,
    required this.backgroundSecondary,
    required this.backgroundTertiary,
    required this.backgroundInvert,
    required this.onBackgroundInvert,
    required this.accent,
    required this.onAccent,
    required this.accentCertified,
    required this.bgSuccess,
    required this.bgError,
    required this.bgWarning,
    // Text
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textInvert,
    required this.textAccentPrimary,
    required this.textAccentSecondary,
    required this.textSuccess,
    required this.textError,
    required this.textWarning,
    // Foreground
    required this.foregroundPrimary,
    required this.foregroundSecondary,
    required this.foregroundTertiary,
    required this.foregroundAccentPrimary010,
    required this.foregroundAccentPrimary040,
    required this.foregroundAccentPrimary060,
    required this.foregroundAccentSecondary010,
    required this.foregroundAccentSecondary040,
    required this.foregroundAccentSecondary060,
    // Icon
    required this.iconDefault,
    required this.iconInvert,
    required this.iconAccentPrimary,
    required this.iconAccentSecondary,
    required this.iconSuccess,
    required this.iconError,
    required this.iconWarning,
    // Legacy / utility
    required this.neutrals,
    required this.success,
    required this.error,
    required this.warning,
    required this.divider,
    required this.overlay,
    required this.inputFill,
    required this.inputBorder,
    required this.inputBorderFocused,
  });

  // Background
  final Color background;
  final Color backgroundSecondary;
  final Color backgroundTertiary;
  final Color backgroundInvert;
  final Color onBackgroundInvert;
  final Color accent;
  final Color onAccent;
  final Color accentCertified;
  final Color bgSuccess;
  final Color bgError;
  final Color bgWarning;

  // Text
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textInvert;
  final Color textAccentPrimary;
  final Color textAccentSecondary;
  final Color textSuccess;
  final Color textError;
  final Color textWarning;

  // Foreground
  final Color foregroundPrimary;
  final Color foregroundSecondary;
  final Color foregroundTertiary;
  final Color foregroundAccentPrimary010;
  final Color foregroundAccentPrimary040;
  final Color foregroundAccentPrimary060;
  final Color foregroundAccentSecondary010;
  final Color foregroundAccentSecondary040;
  final Color foregroundAccentSecondary060;

  // Icon
  final Color iconDefault;
  final Color iconInvert;
  final Color iconAccentPrimary;
  final Color iconAccentSecondary;
  final Color iconSuccess;
  final Color iconError;
  final Color iconWarning;

  // Legacy / utility
  final Color neutrals;
  final Color success;
  final Color error;
  final Color warning;
  final Color divider;
  final Color overlay;
  final Color inputFill;
  final Color inputBorder;
  final Color inputBorderFocused;

  static const light = AppColors(
    // Background
    background: Color(0xFFFFFFFF),
    backgroundSecondary: Color(0xFFF3F3F3),
    backgroundTertiary: Color(0xFFE9E9E9),
    backgroundInvert: Color(0xFF202020),
    onBackgroundInvert: Color(0xFFFFFFFF),
    accent: Color(0xFF0988F0),
    onAccent: Color(0xFFFFFFFF),
    accentCertified: Color(0xFFC7B994),
    bgSuccess: Color(0x3330A46B), // #30A46B at 20%
    bgError: Color(0x33DF4A34), // #DF4A34 at 20%
    bgWarning: Color(0x33F3A13F), // #F3A13F at 20%
    // Text
    textPrimary: Color(0xFF202020),
    textSecondary: Color(0xFF9A9A9A),
    textTertiary: Color(0xFF6C6C6C),
    textInvert: Color(0xFFFFFFFF),
    textAccentPrimary: Color(0xFF0988F0),
    textAccentSecondary: Color(0xFFC7B994),
    textSuccess: Color(0xFF30A46B),
    textError: Color(0xFFDF4A34),
    textWarning: Color(0xFFF3A13F),
    // Foreground
    foregroundPrimary: Color(0xFFF3F3F3),
    foregroundSecondary: Color(0xFFE9E9E9),
    foregroundTertiary: Color(0xFFD0D0D0),
    foregroundAccentPrimary010: Color(0x1A0988F0), // #0988F0 at 10%
    foregroundAccentPrimary040: Color(0x660988F0), // #0988F0 at 40%
    foregroundAccentPrimary060: Color(0x990988F0), // #0988F0 at 60%
    foregroundAccentSecondary010: Color(0x1AC7B994), // #C7B994 at 10%
    foregroundAccentSecondary040: Color(0x66C7B994), // #C7B994 at 40%
    foregroundAccentSecondary060: Color(0x99C7B994), // #C7B994 at 60%
    // Icon
    iconDefault: Color(0xFF9A9A9A),
    iconInvert: Color(0xFF202020),
    iconAccentPrimary: Color(0xFF0988F0),
    iconAccentSecondary: Color(0xFFC7B994),
    iconSuccess: Color(0xFF30A46B),
    iconError: Color(0xFFDF4A34),
    iconWarning: Color(0xFFF3A13F),
    // Legacy / utility
    neutrals: Color(0xFFBBBBBB),
    success: Color(0xFF30A46B),
    error: Color(0xFFDF4A34),
    warning: Color(0xFFF3A13F),
    divider: Color(0x1F000000),
    overlay: Color(0x61000000),
    inputFill: Color(0xFFF0F0F0),
    inputBorder: Color(0xFFD0D0D0),
    inputBorderFocused: Color(0xFF0988F0),
  );

  static const dark = AppColors(
    // Background
    background: Color(0xFF202020),
    backgroundSecondary: Color(0xFF1E1E1E),
    backgroundTertiary: Color(0xFF2A2A2A),
    backgroundInvert: Color(0xFFFFFFFF),
    onBackgroundInvert: Color(0xFF202020),
    accent: Color(0xFF0988F0),
    onAccent: Color(0xFFFFFFFF),
    accentCertified: Color(0xFFC7B994),
    bgSuccess: Color(0x3330A46B), // #30A46B at 20%
    bgError: Color(0x33DF4A34), // #DF4A34 at 20%
    bgWarning: Color(0x33F3A13F), // #F3A13F at 20%
    // Text
    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0xFF9A9A9A),
    textTertiary: Color(0xFFBBBBBB),
    textInvert: Color(0xFF202020),
    textAccentPrimary: Color(0xFF0988F0),
    textAccentSecondary: Color(0xFFC7B994),
    textSuccess: Color(0xFF30A46B),
    textError: Color(0xFFDF4A34),
    textWarning: Color(0xFFF3A13F),
    // Foreground
    foregroundPrimary: Color(0xFF252525),
    foregroundSecondary: Color(0xFF2A2A2A),
    foregroundTertiary: Color(0xFF363636),
    foregroundAccentPrimary010: Color(0x1A0988F0), // #0988F0 at 10%
    foregroundAccentPrimary040: Color(0x660988F0), // #0988F0 at 40%
    foregroundAccentPrimary060: Color(0x990988F0), // #0988F0 at 60%
    foregroundAccentSecondary010: Color(0x1AC7B994), // #C7B994 at 10%
    foregroundAccentSecondary040: Color(0x66C7B994), // #C7B994 at 40%
    foregroundAccentSecondary060: Color(0x99C7B994), // #C7B994 at 60%
    // Icon
    iconDefault: Color(0xFF9A9A9A),
    iconInvert: Color(0xFFFFFFFF),
    iconAccentPrimary: Color(0xFF0988F0),
    iconAccentSecondary: Color(0xFFC7B994),
    iconSuccess: Color(0xFF30A46B),
    iconError: Color(0xFFDF4A34),
    iconWarning: Color(0xFFF3A13F),
    // Legacy / utility
    neutrals: Color(0xFF555555),
    success: Color(0xFF30A46B),
    error: Color(0xFFDF4A34),
    warning: Color(0xFFF3A13F),
    divider: Color(0x1FFFFFFF),
    overlay: Color(0x61000000),
    inputFill: Color(0xFF1E1E1E),
    inputBorder: Color(0xFF3A3A3A),
    inputBorderFocused: Color(0xFF0988F0),
  );

  @override
  AppColors copyWith({
    // Background
    Color? background,
    Color? backgroundSecondary,
    Color? backgroundTertiary,
    Color? backgroundInvert,
    Color? onBackgroundInvert,
    Color? accent,
    Color? onAccent,
    Color? accentCertified,
    Color? bgSuccess,
    Color? bgError,
    Color? bgWarning,
    // Text
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? textInvert,
    Color? textAccentPrimary,
    Color? textAccentSecondary,
    Color? textSuccess,
    Color? textError,
    Color? textWarning,
    // Foreground
    Color? foregroundPrimary,
    Color? foregroundSecondary,
    Color? foregroundTertiary,
    Color? foregroundAccentPrimary010,
    Color? foregroundAccentPrimary040,
    Color? foregroundAccentPrimary060,
    Color? foregroundAccentSecondary010,
    Color? foregroundAccentSecondary040,
    Color? foregroundAccentSecondary060,
    // Icon
    Color? iconDefault,
    Color? iconInvert,
    Color? iconAccentPrimary,
    Color? iconAccentSecondary,
    Color? iconSuccess,
    Color? iconError,
    Color? iconWarning,
    // Legacy / utility
    Color? neutrals,
    Color? success,
    Color? error,
    Color? warning,
    Color? divider,
    Color? overlay,
    Color? inputFill,
    Color? inputBorder,
    Color? inputBorderFocused,
  }) {
    return AppColors(
      background: background ?? this.background,
      backgroundSecondary: backgroundSecondary ?? this.backgroundSecondary,
      backgroundTertiary: backgroundTertiary ?? this.backgroundTertiary,
      backgroundInvert: backgroundInvert ?? this.backgroundInvert,
      onBackgroundInvert: onBackgroundInvert ?? this.onBackgroundInvert,
      accent: accent ?? this.accent,
      onAccent: onAccent ?? this.onAccent,
      accentCertified: accentCertified ?? this.accentCertified,
      bgSuccess: bgSuccess ?? this.bgSuccess,
      bgError: bgError ?? this.bgError,
      bgWarning: bgWarning ?? this.bgWarning,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      textInvert: textInvert ?? this.textInvert,
      textAccentPrimary: textAccentPrimary ?? this.textAccentPrimary,
      textAccentSecondary: textAccentSecondary ?? this.textAccentSecondary,
      textSuccess: textSuccess ?? this.textSuccess,
      textError: textError ?? this.textError,
      textWarning: textWarning ?? this.textWarning,
      foregroundPrimary: foregroundPrimary ?? this.foregroundPrimary,
      foregroundSecondary: foregroundSecondary ?? this.foregroundSecondary,
      foregroundTertiary: foregroundTertiary ?? this.foregroundTertiary,
      foregroundAccentPrimary010:
          foregroundAccentPrimary010 ?? this.foregroundAccentPrimary010,
      foregroundAccentPrimary040:
          foregroundAccentPrimary040 ?? this.foregroundAccentPrimary040,
      foregroundAccentPrimary060:
          foregroundAccentPrimary060 ?? this.foregroundAccentPrimary060,
      foregroundAccentSecondary010:
          foregroundAccentSecondary010 ?? this.foregroundAccentSecondary010,
      foregroundAccentSecondary040:
          foregroundAccentSecondary040 ?? this.foregroundAccentSecondary040,
      foregroundAccentSecondary060:
          foregroundAccentSecondary060 ?? this.foregroundAccentSecondary060,
      iconDefault: iconDefault ?? this.iconDefault,
      iconInvert: iconInvert ?? this.iconInvert,
      iconAccentPrimary: iconAccentPrimary ?? this.iconAccentPrimary,
      iconAccentSecondary: iconAccentSecondary ?? this.iconAccentSecondary,
      iconSuccess: iconSuccess ?? this.iconSuccess,
      iconError: iconError ?? this.iconError,
      iconWarning: iconWarning ?? this.iconWarning,
      neutrals: neutrals ?? this.neutrals,
      success: success ?? this.success,
      error: error ?? this.error,
      warning: warning ?? this.warning,
      divider: divider ?? this.divider,
      overlay: overlay ?? this.overlay,
      inputFill: inputFill ?? this.inputFill,
      inputBorder: inputBorder ?? this.inputBorder,
      inputBorderFocused: inputBorderFocused ?? this.inputBorderFocused,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      background: Color.lerp(background, other.background, t)!,
      backgroundSecondary:
          Color.lerp(backgroundSecondary, other.backgroundSecondary, t)!,
      backgroundTertiary:
          Color.lerp(backgroundTertiary, other.backgroundTertiary, t)!,
      backgroundInvert:
          Color.lerp(backgroundInvert, other.backgroundInvert, t)!,
      onBackgroundInvert:
          Color.lerp(onBackgroundInvert, other.onBackgroundInvert, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      accentCertified: Color.lerp(accentCertified, other.accentCertified, t)!,
      bgSuccess: Color.lerp(bgSuccess, other.bgSuccess, t)!,
      bgError: Color.lerp(bgError, other.bgError, t)!,
      bgWarning: Color.lerp(bgWarning, other.bgWarning, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      textInvert: Color.lerp(textInvert, other.textInvert, t)!,
      textAccentPrimary:
          Color.lerp(textAccentPrimary, other.textAccentPrimary, t)!,
      textAccentSecondary:
          Color.lerp(textAccentSecondary, other.textAccentSecondary, t)!,
      textSuccess: Color.lerp(textSuccess, other.textSuccess, t)!,
      textError: Color.lerp(textError, other.textError, t)!,
      textWarning: Color.lerp(textWarning, other.textWarning, t)!,
      foregroundPrimary:
          Color.lerp(foregroundPrimary, other.foregroundPrimary, t)!,
      foregroundSecondary:
          Color.lerp(foregroundSecondary, other.foregroundSecondary, t)!,
      foregroundTertiary:
          Color.lerp(foregroundTertiary, other.foregroundTertiary, t)!,
      foregroundAccentPrimary010: Color.lerp(
          foregroundAccentPrimary010, other.foregroundAccentPrimary010, t)!,
      foregroundAccentPrimary040: Color.lerp(
          foregroundAccentPrimary040, other.foregroundAccentPrimary040, t)!,
      foregroundAccentPrimary060: Color.lerp(
          foregroundAccentPrimary060, other.foregroundAccentPrimary060, t)!,
      foregroundAccentSecondary010: Color.lerp(
          foregroundAccentSecondary010, other.foregroundAccentSecondary010, t)!,
      foregroundAccentSecondary040: Color.lerp(
          foregroundAccentSecondary040, other.foregroundAccentSecondary040, t)!,
      foregroundAccentSecondary060: Color.lerp(
          foregroundAccentSecondary060, other.foregroundAccentSecondary060, t)!,
      iconDefault: Color.lerp(iconDefault, other.iconDefault, t)!,
      iconInvert: Color.lerp(iconInvert, other.iconInvert, t)!,
      iconAccentPrimary:
          Color.lerp(iconAccentPrimary, other.iconAccentPrimary, t)!,
      iconAccentSecondary:
          Color.lerp(iconAccentSecondary, other.iconAccentSecondary, t)!,
      iconSuccess: Color.lerp(iconSuccess, other.iconSuccess, t)!,
      iconError: Color.lerp(iconError, other.iconError, t)!,
      iconWarning: Color.lerp(iconWarning, other.iconWarning, t)!,
      neutrals: Color.lerp(neutrals, other.neutrals, t)!,
      success: Color.lerp(success, other.success, t)!,
      error: Color.lerp(error, other.error, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      overlay: Color.lerp(overlay, other.overlay, t)!,
      inputFill: Color.lerp(inputFill, other.inputFill, t)!,
      inputBorder: Color.lerp(inputBorder, other.inputBorder, t)!,
      inputBorderFocused:
          Color.lerp(inputBorderFocused, other.inputBorderFocused, t)!,
    );
  }
}

extension AppColorsExtension on BuildContext {
  AppColors get colors =>
      Theme.of(this).extension<AppColors>() ?? AppColors.light;
}
