import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.background,
    required this.backgroundSecondary,
    required this.backgroundTertiary,
    required this.accent,
    required this.onAccent,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.neutrals,
    required this.success,
    required this.error,
    required this.warning,
    required this.divider,
    required this.overlay,
    required this.inputFill,
    required this.inputBorder,
    required this.inputBorderFocused,
    required this.backgroundInvert,
    required this.onBackgroundInvert,
  });

  final Color background;
  final Color backgroundSecondary;
  final Color backgroundTertiary;
  final Color accent;
  final Color onAccent;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color neutrals;
  final Color success;
  final Color error;
  final Color warning;
  final Color divider;
  final Color overlay;
  final Color inputFill;
  final Color inputBorder;
  final Color inputBorderFocused;
  final Color backgroundInvert;
  final Color onBackgroundInvert;

  static const light = AppColors(
    background: Color(0xFFFFFFFF),
    backgroundSecondary: Color(0xFFF3F3F3),
    backgroundTertiary: Color(0xFFE9E9E9),
    accent: Color(0xFF0988F0),
    onAccent: Color(0xFFFFFFFF),
    textPrimary: Color(0xFF202020),
    textSecondary: Color(0xFF9A9A9A),
    textTertiary: Color(0xFF6C6C6C),
    neutrals: Color(0xFFBBBBBB),
    success: Color(0xFF30A46B),
    error: Color(0xFFDF4A34),
    warning: Color(0xFFFF9500),
    divider: Color(0x1F000000),
    overlay: Color(0x61000000),
    inputFill: Color(0xFFF0F0F0),
    inputBorder: Color(0xFFD0D0D0),
    inputBorderFocused: Color(0xFF0988F0),
    backgroundInvert: Color(0xFF202020),
    onBackgroundInvert: Color(0xFFFFFFFF),
  );

  static const dark = AppColors(
    background: Color(0xFF131313),
    backgroundSecondary: Color(0xFF1E1E1E),
    backgroundTertiary: Color(0xFF2A2A2A),
    accent: Color(0xFF0988F0),
    onAccent: Color(0xFFFFFFFF),
    textPrimary: Color(0xFFEAEAEA),
    textSecondary: Color(0xFF8A8A8A),
    textTertiary: Color(0xFF6C6C6C),
    neutrals: Color(0xFF555555),
    success: Color(0xFF30A46B),
    error: Color(0xFFDF4A34),
    warning: Color(0xFFFF9500),
    divider: Color(0x1FFFFFFF),
    overlay: Color(0x61000000),
    inputFill: Color(0xFF1E1E1E),
    inputBorder: Color(0xFF3A3A3A),
    inputBorderFocused: Color(0xFF0988F0),
    backgroundInvert: Color(0xFFEAEAEA),
    onBackgroundInvert: Color(0xFF202020),
  );

  @override
  AppColors copyWith({
    Color? background,
    Color? backgroundSecondary,
    Color? backgroundTertiary,
    Color? accent,
    Color? onAccent,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? neutrals,
    Color? success,
    Color? error,
    Color? warning,
    Color? divider,
    Color? overlay,
    Color? inputFill,
    Color? inputBorder,
    Color? inputBorderFocused,
    Color? backgroundInvert,
    Color? onBackgroundInvert,
  }) {
    return AppColors(
      background: background ?? this.background,
      backgroundSecondary: backgroundSecondary ?? this.backgroundSecondary,
      backgroundTertiary: backgroundTertiary ?? this.backgroundTertiary,
      accent: accent ?? this.accent,
      onAccent: onAccent ?? this.onAccent,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      neutrals: neutrals ?? this.neutrals,
      success: success ?? this.success,
      error: error ?? this.error,
      warning: warning ?? this.warning,
      divider: divider ?? this.divider,
      overlay: overlay ?? this.overlay,
      inputFill: inputFill ?? this.inputFill,
      inputBorder: inputBorder ?? this.inputBorder,
      inputBorderFocused: inputBorderFocused ?? this.inputBorderFocused,
      backgroundInvert: backgroundInvert ?? this.backgroundInvert,
      onBackgroundInvert: onBackgroundInvert ?? this.onBackgroundInvert,
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
      accent: Color.lerp(accent, other.accent, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
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
      backgroundInvert:
          Color.lerp(backgroundInvert, other.backgroundInvert, t)!,
      onBackgroundInvert:
          Color.lerp(onBackgroundInvert, other.onBackgroundInvert, t)!,
    );
  }
}

extension AppColorsExtension on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>() ?? AppColors.light;
}
