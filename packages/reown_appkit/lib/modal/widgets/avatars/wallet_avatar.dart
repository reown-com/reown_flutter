import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_theme.dart';
import 'package:reown_appkit/modal/utils/core_utils.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'dart:math' as math;

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
          child: LayoutBuilder(
            builder: (_, constraints) {
              if (isNetwork) {
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    CustomPaint(
                      painter: HexagonBorderPainter(
                        color: themeColors.grayGlass010,
                        strokeWidth: 1.0,
                      ),
                    ),
                    ClipPath(
                      clipper: HexagonClipper(),
                      clipBehavior: Clip.antiAlias,
                      child: validImage
                          ? CachedNetworkImage(
                              imageUrl: CoreUtils.formatImageUri(
                                imageUrl!,
                                projectId,
                              ),
                              fit: BoxFit.cover,
                              fadeInDuration: const Duration(milliseconds: 500),
                              fadeOutDuration: const Duration(
                                milliseconds: 500,
                              ),
                              errorWidget: (context, url, error) =>
                                  ColoredBox(color: themeColors.grayGlass005),
                            )
                          : Padding(
                              padding: EdgeInsets.all(
                                constraints.maxHeight / 3,
                              ),
                              child: SvgPicture.asset(
                                'lib/modal/assets/icons/network.svg',
                                package: 'reown_appkit',
                                colorFilter: ColorFilter.mode(
                                  themeColors.grayGlass030,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                    ),
                  ],
                );
              }
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                ),
                clipBehavior: Clip.antiAlias,
                child: validImage
                    ? ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          disabled ? Colors.white : Colors.transparent,
                          BlendMode.saturation,
                        ),
                        child: CachedNetworkImage(
                          imageUrl: CoreUtils.formatImageUri(
                            imageUrl!,
                            projectId,
                          ),
                          fadeInDuration: const Duration(milliseconds: 500),
                          fadeOutDuration: const Duration(milliseconds: 500),
                          errorWidget: (context, url, error) =>
                              ColoredBox(color: themeColors.grayGlass005),
                        ),
                      )
                    : ColoredBox(color: themeColors.grayGlass005),
              );
            },
          ),
        ),
      ],
    );
  }
}

class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final width = size.width;
    final height = size.height;
    final centerX = width / 2;
    final centerY = height / 2;
    final radius = width / 2;
    final angle = (2 * math.pi) / 6;
    final rotation = -math.pi / 2; // Rotate so a point is at the top

    path.moveTo(
      centerX + radius * math.cos(rotation),
      centerY + radius * math.sin(rotation),
    );
    for (int i = 1; i <= 6; i++) {
      path.lineTo(
        centerX + radius * math.cos(rotation + i * angle),
        centerY + radius * math.sin(rotation + i * angle),
      );
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class HexagonBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  HexagonBorderPainter({required this.color, this.strokeWidth = 1.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final path = Path();
    final width = size.width;
    final height = size.height;
    final centerX = width / 2;
    final centerY = height / 2;
    final radius = width / 2;
    final angle = (2 * math.pi) / 6;
    final rotation = -math.pi / 2;

    path.moveTo(
      centerX + radius * math.cos(rotation),
      centerY + radius * math.sin(rotation),
    );
    for (int i = 1; i <= 6; i++) {
      path.lineTo(
        centerX + radius * math.cos(rotation + i * angle),
        centerY + radius * math.sin(rotation + i * angle),
      );
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
