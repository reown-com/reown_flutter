import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/theme/app_colors.dart';
import 'package:reown_walletkit_wallet/theme/app_radius.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({
    super.key,
    required this.metadata,
    this.size = 64.0,
    this.borderRadius,
  });

  final PairingMetadata metadata;
  final double size;
  final double? borderRadius;

  double get _borderRadius => borderRadius ?? (size > 50 ? 16.0 : AppRadius.r3);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final radius = BorderRadius.circular(_borderRadius);

    if (metadata.icons.isNotEmpty) {
      final imageUrl = metadata.icons.first;
      if (imageUrl.endsWith('.svg')) {
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: colors.backgroundTertiary,
            borderRadius: radius,
          ),
          clipBehavior: Clip.antiAlias,
          child: SvgPicture.network(imageUrl, fit: BoxFit.cover),
        );
      }
      return ClipRRect(
        borderRadius: radius,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorWidget: (_, __, ___) => _FallbackIcon(
            size: size,
            borderRadius: _borderRadius,
            colors: colors,
          ),
        ),
      );
    }
    return _FallbackIcon(
      size: size,
      borderRadius: _borderRadius,
      colors: colors,
    );
  }
}

class _FallbackIcon extends StatelessWidget {
  const _FallbackIcon({
    required this.size,
    required this.borderRadius,
    required this.colors,
  });

  final double size;
  final double borderRadius;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: colors.backgroundTertiary,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Icon(Icons.apps, color: colors.textSecondary, size: size * 0.48),
    );
  }
}
