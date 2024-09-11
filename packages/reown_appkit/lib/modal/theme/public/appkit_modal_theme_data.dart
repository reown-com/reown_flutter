import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_colors.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_radiuses.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_text_styles.dart';

part 'appkit_modal_theme_data.freezed.dart';

@freezed
class AppKitModalThemeData with _$AppKitModalThemeData {
  const factory AppKitModalThemeData({
    @Default(AppKitModalColors.lightMode) AppKitModalColors lightColors,
    @Default(AppKitModalColors.darkMode) AppKitModalColors darkColors,
    @Default(AppKitModalTextStyles.textStyle) AppKitModalTextStyles textStyles,
    @Default(AppKitModalRadiuses()) AppKitModalRadiuses radiuses,
  }) = _AppKitModalThemeData;
}
