import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qr_flutter_wc/qr_flutter_wc.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_theme.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/content_loading.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/responsive_container.dart';

class QRCodeView extends StatelessWidget {
  const QRCodeView({
    super.key,
    required this.uri,
    this.logoPath = '',
  });

  final String logoPath, uri;

  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    final responsiveData = ResponsiveData.of(context);
    final isPortrait = ResponsiveData.isPortrait(context);
    final isDarkMode =
        ReownAppKitModalTheme.maybeOf(context)?.isDarkMode ?? false;
    final imageSize = isPortrait ? 80.0 : 60.0;
    final maxRadius = min(radiuses.radiusS, 36.0);
    return Container(
      constraints: BoxConstraints(
        maxWidth: isPortrait
            ? responsiveData.maxWidth
            : (responsiveData.maxHeight - kNavbarHeight - (kPadding16 * 2)),
      ),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(maxRadius),
      ),
      padding: const EdgeInsets.only(
        left: 20.0,
        top: 20.0,
        right: 20.0,
        bottom: 14.0,
      ),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.0,
            child: uri.isEmpty
                ? const ContentLoading()
                : QrImageView(
                    data: uri,
                    version: QrVersions.auto,
                    errorCorrectionLevel: QrErrorCorrectLevel.Q,
                    eyeStyle: const QrEyeStyle(
                      eyeShape: QrEyeShape.circle,
                      color: Colors.black,
                    ),
                    dataModuleStyle: const QrDataModuleStyle(
                      dataModuleShape: QrDataModuleShape.circle,
                      color: Colors.black,
                    ),
                    embeddedImage: logoPath.isNotEmpty
                        ? AssetImage(
                            logoPath,
                            package: 'reown_appkit',
                          )
                        : null,
                    embeddedImageStyle: QrEmbeddedImageStyle(
                      size: Size(imageSize, imageSize),
                    ),
                    embeddedImageEmitsError: true,
                  ),
          ),
          const SizedBox.square(dimension: 10.0),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'UX by ',
                  style: themeData.textStyles.tiny600.copyWith(
                    color: themeColors.inverse000.withOpacity(0.3),
                  ),
                ),
                TextSpan(
                  text: 'Reown',
                  style: themeData.textStyles.small600.copyWith(
                    color: themeColors.inverse000,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
