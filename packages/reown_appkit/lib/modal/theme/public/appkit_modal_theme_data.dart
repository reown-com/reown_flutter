import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_colors.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_radiuses.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_text_styles.dart';

part 'appkit_modal_theme_data.freezed.dart';

@freezed
class ReownAppKitModalThemeData with _$ReownAppKitModalThemeData {
  const factory ReownAppKitModalThemeData({
    @Default(ReownAppKitModalColors.lightMode)
    ReownAppKitModalColors lightColors,
    @Default(ReownAppKitModalColors.darkMode) ReownAppKitModalColors darkColors,
    @Default(ReownAppKitModalTextStyles.textStyle)
    ReownAppKitModalTextStyles textStyles,
    @Default(ReownAppKitModalRadiuses()) ReownAppKitModalRadiuses radiuses,
  }) = _ReownAppKitModalThemeData;
}
