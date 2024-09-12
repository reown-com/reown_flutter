import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'appkit_modal_colors.freezed.dart';

@freezed
class ReownAppKitModalColors with _$ReownAppKitModalColors {
  const factory ReownAppKitModalColors({
    required Color accent100,
    required Color accent090,
    required Color accent080,
    //
    required Color grayGlass100,
    //
    required Color foreground100,
    required Color foreground125,
    required Color foreground150,
    required Color foreground175,
    required Color foreground200,
    required Color foreground225,
    required Color foreground250,
    required Color foreground275,
    required Color foreground300,
    //
    required Color background100,
    required Color background125,
    required Color background150,
    required Color background175,
    required Color background200,
    required Color background225,
    required Color background250,
    required Color background275,
    required Color background300,
    //
    required Color inverse100,
    required Color inverse000,
    required Color success100,
    required Color error100,
    required Color teal100,
    required Color magenta100,
    required Color indigo100,
    required Color orange100,
    required Color purple100,
    required Color yellow100,
  }) = _AppKitModalColors;

  static const darkMode = ReownAppKitModalColors(
    accent100: Color(0xFF667DFF),
    accent090: Color(0xFF7388FD),
    accent080: Color(0xFF7F92FA),
    //
    grayGlass100: Color(0xFFFFFFFF),
    //
    foreground100: Color(0xFFE4E7E7),
    foreground125: Color(0xFFD0D5D5),
    foreground150: Color(0xFFA8B1B1),
    foreground175: Color(0xFFA8B0B0),
    foreground200: Color(0xFF949E9E),
    foreground225: Color(0xFF868F8F),
    foreground250: Color(0xFF788080),
    foreground275: Color(0xFF788181),
    foreground300: Color(0xFF6E7777),
    //
    background100: Color(0xFF121313),
    background125: Color(0xFF191A1A),
    background150: Color(0xFF1E1F1F),
    background175: Color(0xFF222525),
    background200: Color(0xFF272A2A),
    background225: Color(0xFF2C3030),
    background250: Color(0xFF313535),
    background275: Color(0xFF363B3B),
    background300: Color(0xFF3B4040),
    //
    inverse100: Color(0xFFFFFFFF),
    inverse000: Color(0xFF000000),
    success100: Color(0xFF26D962),
    error100: Color(0xFFF25A67),
    teal100: Color(0xFF36E2E2),
    magenta100: Color(0xFFCB4D8C),
    indigo100: Color(0xFF516DFB),
    orange100: Color(0xFFFFA64C),
    purple100: Color(0xFF906EF7),
    yellow100: Color(0xFFFAFF00),
  );

  static const lightMode = ReownAppKitModalColors(
    accent100: Color(0xFF5570FF),
    accent090: Color(0xFF4F67E7),
    accent080: Color(0xFF485ED0),
    //
    grayGlass100: Color(0xFF000000),
    //
    foreground100: Color(0xFF141414),
    foreground125: Color(0xFF2D3131),
    foreground150: Color(0xFF474D4D),
    foreground175: Color(0xFF636D6D),
    foreground200: Color(0xFF798686),
    foreground225: Color(0xFF828F8F),
    foreground250: Color(0xFF8B9797),
    foreground275: Color(0xFF95A0A0),
    foreground300: Color(0xFF9EA9A9),
    //
    background100: Color(0xFFFFFFFF),
    background125: Color(0xFFFFFFFF),
    background150: Color(0xFFF5FAFA),
    background175: Color(0xFFF3F8F8),
    background200: Color(0xFFEAF1F1),
    background225: Color(0xFFE5EDED),
    background250: Color(0xFFE1E9E9),
    background275: Color(0xFFDCE7E7),
    background300: Color(0xFFD8E3E3),
    //
    inverse100: Color(0xFFFFFFFF),
    inverse000: Color(0xFF000000),
    success100: Color(0xFF26B562),
    error100: Color(0xFFF05142),
    teal100: Color(0xFF2BB6B6),
    magenta100: Color(0xFFC65380),
    indigo100: Color(0xFF3D5CF5),
    orange100: Color(0xFFEA8C2E),
    purple100: Color(0xFF794CFF),
    yellow100: Color(0xFFEECC1C),
  );
}

extension AppKitColorsExtension on ReownAppKitModalColors {
  Color get accenGlass090 => accent100.withOpacity(0.9);
  Color get accenGlass080 => accent100.withOpacity(0.8);
  Color get accenGlass020 => accent100.withOpacity(0.2);
  Color get accenGlass015 => accent100.withOpacity(0.15);
  Color get accenGlass010 => accent100.withOpacity(0.1);
  Color get accenGlass005 => accent100.withOpacity(0.05);
  Color get accenGlass002 => accent100.withOpacity(0.02);
  //
  Color get grayGlass001 => grayGlass100.withOpacity(0.01);
  Color get grayGlass002 => grayGlass100.withOpacity(0.02);
  Color get grayGlass005 => grayGlass100.withOpacity(0.05);
  Color get grayGlass010 => grayGlass100.withOpacity(0.1);
  Color get grayGlass015 => grayGlass100.withOpacity(0.15);
  Color get grayGlass020 => grayGlass100.withOpacity(0.2);
  Color get grayGlass025 => grayGlass100.withOpacity(0.25);
  Color get grayGlass030 => grayGlass100.withOpacity(0.3);
  Color get grayGlass060 => grayGlass100.withOpacity(0.6);
  Color get grayGlass080 => grayGlass100.withOpacity(0.8);
  Color get grayGlass090 => grayGlass100.withOpacity(0.9);
}
