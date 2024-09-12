import 'package:flutter/material.dart';

import 'package:reown_appkit/modal/theme/public/appkit_modal_theme.dart';

class AssetUtils {
  static String getThemedAsset(BuildContext context, String assetName) {
    if (ReownAppKitModalTheme.maybeOf(context)?.isDarkMode == true) {
      return 'lib/modal/assets/dark/$assetName';
    }
    return 'lib/modal/assets/light/$assetName';
  }
}
