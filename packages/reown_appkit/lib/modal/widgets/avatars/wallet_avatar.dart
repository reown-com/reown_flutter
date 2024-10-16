import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_theme.dart';
import 'package:reown_appkit/modal/utils/core_utils.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';

class ListAvatar extends StatelessWidget {
  const ListAvatar({
    super.key,
    this.imageUrl,
    this.borderRadius,
    this.isNetwork = false,
    this.color,
    this.disabled = false,
  });
  final String? imageUrl;
  final double? borderRadius;
  final bool isNetwork;
  final Color? color;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final appKitModal = ModalProvider.of(context).instance;
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    final radius = borderRadius ?? radiuses.radiusM;
    final projectId = appKitModal.appKit!.core.projectId;
    final validImage = (imageUrl ?? '').isNotEmpty && !disabled;
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1.0,
          child: Container(
            decoration: isNetwork
                ? ShapeDecoration(
                    shape: StarBorder.polygon(
                      side: BorderSide(
                        color: color ?? themeColors.grayGlass010,
                        width: 1.0,
                        strokeAlign: BorderSide.strokeAlignInside,
                      ),
                      pointRounding: 0.3,
                      sides: 6,
                    ),
                  )
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                    border: Border.all(
                      color: color ?? themeColors.grayGlass010,
                      width: 1.0,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                  ),
          ),
        ),
        AspectRatio(
          aspectRatio: 1.0,
          child: Container(
            decoration: isNetwork
                ? ShapeDecoration(
                    shape: StarBorder.polygon(
                      pointRounding: 0.3,
                      sides: 6,
                    ),
                  )
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                  ),
            clipBehavior: Clip.antiAlias,
            child: validImage
                ? ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      disabled ? Colors.white : Colors.transparent,
                      disabled ? BlendMode.saturation : BlendMode.saturation,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl!,
                      httpHeaders: CoreUtils.getAPIHeaders(projectId),
                      fadeInDuration: const Duration(milliseconds: 500),
                      fadeOutDuration: const Duration(milliseconds: 500),
                      errorWidget: (context, url, error) => ColoredBox(
                        color: themeColors.grayGlass005,
                      ),
                    ),
                  )
                : isNetwork
                    ? Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: SvgPicture.asset(
                          'lib/modal/assets/icons/network.svg',
                          package: 'reown_appkit',
                          colorFilter: ColorFilter.mode(
                            disabled
                                ? Colors.black12
                                : themeColors.grayGlass030,
                            disabled ? BlendMode.srcIn : BlendMode.srcIn,
                          ),
                        ),
                      )
                    : ColoredBox(
                        color: themeColors.grayGlass005,
                      ),
          ),
        ),
      ],
    );
  }
}
