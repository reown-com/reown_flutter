import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reown_walletkit_wallet/theme/app_colors.dart';
import 'package:reown_walletkit_wallet/theme/app_radius.dart';
import 'package:reown_walletkit_wallet/theme/app_spacing.dart';

class ChainIcon extends StatelessWidget {
  const ChainIcon({
    super.key,
    required this.logoUrl,
    this.size = 24.0,
    this.borderWidth = 2.0,
    this.showBorder = true,
  });

  final String logoUrl;
  final double size;
  final double borderWidth;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.backgroundTertiary,
        border: showBorder
            ? Border.all(color: colors.backgroundSecondary, width: borderWidth)
            : null,
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: logoUrl,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorWidget: (_, __, ___) => Icon(
            Icons.link,
            color: colors.textSecondary,
            size: size * 0.5,
          ),
        ),
      ),
    );
  }
}

class ChainIcons extends StatelessWidget {
  const ChainIcons({
    super.key,
    required this.logoUrls,
    this.iconSize = 24.0,
    this.overlap = 6.0,
    this.maxVisible = 4,
    this.borderWidth = 2.0,
  });

  final List<String> logoUrls;
  final double iconSize;
  final double overlap;
  final int maxVisible;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final visibleCount =
        logoUrls.length > maxVisible ? maxVisible : logoUrls.length;
    final overflow = logoUrls.length - maxVisible;
    final step = iconSize - overlap;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: iconSize + (visibleCount - 1) * step,
          height: iconSize,
          child: Stack(
            children: [
              for (int i = 0; i < visibleCount; i++)
                Positioned(
                  left: i * step,
                  child: ChainIcon(
                    logoUrl: logoUrls[i],
                    size: iconSize,
                    borderWidth: borderWidth,
                  ),
                ),
            ],
          ),
        ),
        if (overflow > 0)
          Transform.translate(
            offset: Offset(-overlap, 0),
            child: Container(
              height: iconSize,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s2),
              decoration: BoxDecoration(
                color: colors.backgroundTertiary,
                borderRadius: BorderRadius.circular(AppRadius.full),
                border: Border.all(
                  color: colors.backgroundSecondary,
                  width: borderWidth,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                '+$overflow',
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
