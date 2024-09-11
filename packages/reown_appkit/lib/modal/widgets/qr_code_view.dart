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
    final radiuses = AppKitModalTheme.radiusesOf(context);
    final responsiveData = ResponsiveData.of(context);
    final isPortrait = ResponsiveData.isPortrait(context);
    final isDarkMode = AppKitModalTheme.maybeOf(context)?.isDarkMode ?? false;
    final imageSize = isPortrait ? 80.0 : 60.0;
    final maxRadius = min(radiuses.radiusL, 36.0);
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
      padding: const EdgeInsets.all(20.0),
      child: AspectRatio(
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
    );
  }
}
