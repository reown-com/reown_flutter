import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/services/explorer_service/i_explorer_service.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_theme.dart';
import 'package:reown_appkit/modal/utils/core_utils.dart';

class RoundedIcon extends StatelessWidget {
  const RoundedIcon({
    super.key,
    this.assetPath,
    this.imageUrl,
    this.assetColor,
    this.circleColor,
    this.borderColor,
    this.size = 34.0,
    this.padding = 8.0,
    this.borderRadius,
  });
  final String? assetPath, imageUrl;
  final Color? assetColor, circleColor, borderColor;
  final double size, padding;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final projectId = GetIt.I<IExplorerService>().projectId;
    final radius = borderRadius ?? size;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        border: Border.fromBorderSide(
          BorderSide(
            color: borderColor ?? themeColors.grayGlass005,
            width: 2,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
        color: circleColor ?? themeColors.grayGlass010,
      ),
      clipBehavior: Clip.antiAlias,
      child: (imageUrl ?? '').isNotEmpty
          ? ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(radius)),
              child: CachedNetworkImage(
                imageUrl: imageUrl!,
                width: size,
                height: size,
                fit: BoxFit.fill,
                fadeInDuration: const Duration(milliseconds: 500),
                fadeOutDuration: const Duration(milliseconds: 500),
                httpHeaders: CoreUtils.getAPIHeaders(projectId),
                errorWidget: (context, url, error) => ColoredBox(
                  color: themeColors.grayGlass005,
                ),
              ),
            )
          : Padding(
              padding: EdgeInsets.all(padding),
              child: SvgPicture.asset(
                colorFilter: ColorFilter.mode(
                  assetColor ?? themeColors.foreground200,
                  BlendMode.srcIn,
                ),
                assetPath ?? 'lib/modal/assets/icons/coin.svg',
                package: 'reown_appkit',
                width: size,
                height: size,
              ),
            ),
    );
  }
}
