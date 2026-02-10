import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/models/chain_data.dart';
import 'package:reown_walletkit_wallet/models/chain_metadata.dart';
import 'package:reown_walletkit_wallet/theme/app_colors.dart';
import 'package:reown_walletkit_wallet/theme/app_radius.dart';
import 'package:reown_walletkit_wallet/theme/app_typography.dart';

class SessionItem extends StatelessWidget {
  const SessionItem({
    super.key,
    required this.session,
    required this.onTap,
  });

  final SessionData session;
  final VoidCallback onTap;

  static String _cleanUrl(String url) {
    var cleaned = url;
    cleaned = cleaned.replaceFirst(RegExp(r'^https?://'), '');
    cleaned = cleaned.replaceFirst(RegExp(r'^www\.'), '');
    if (cleaned.endsWith('/')) {
      cleaned = cleaned.substring(0, cleaned.length - 1);
    }
    return cleaned;
  }

  List<ChainMetadata> _getSessionChains() {
    final chainIds = <String>{};
    for (final namespace in session.namespaces.entries) {
      for (final account in namespace.value.accounts) {
        // account format: "namespace:chainId:address"
        final parts = account.split(':');
        if (parts.length >= 2) {
          chainIds.add('${parts[0]}:${parts[1]}');
        }
      }
    }
    return chainIds
        .map((id) =>
            ChainsDataList.allChains.where((c) => c.chainId == id).firstOrNull)
        .whereType<ChainMetadata>()
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final metadata = session.peer.metadata;
    final chains = _getSessionChains();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: colors.backgroundSecondary,
          borderRadius: AppRadius.borderRadiusMd,
        ),
        child: Row(
          children: [
            _AppIcon(metadata: metadata),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    metadata.name,
                    style: context.textStyles.layerTextStyle2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    _cleanUrl(metadata.url),
                    style: context.textStyles.bodyText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (chains.isNotEmpty) ...[
              const SizedBox(width: 16.0),
              _ChainIcons(chains: chains, colors: colors),
            ],
          ],
        ),
      ),
    );
  }
}

class _ChainIcons extends StatelessWidget {
  const _ChainIcons({
    required this.chains,
    required this.colors,
  });

  final List<ChainMetadata> chains;
  final AppColors colors;

  static const double _iconSize = 24.0;
  static const double _overlap = 6.0;
  static const int _maxVisible = 4;

  @override
  Widget build(BuildContext context) {
    final visibleCount =
        chains.length > _maxVisible ? _maxVisible : chains.length;
    final overflow = chains.length - _maxVisible;
    final step = _iconSize - _overlap;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: _iconSize + (visibleCount - 1) * step,
          height: _iconSize,
          child: Stack(
            children: [
              for (int i = 0; i < visibleCount; i++)
                Positioned(
                  left: i * step,
                  child: _ChainIcon(
                    logoUrl: chains[i].logo,
                    colors: colors,
                  ),
                ),
            ],
          ),
        ),
        if (overflow > 0)
          Transform.translate(
            offset: const Offset(-_overlap, 0),
            child: Container(
              height: _iconSize,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color: colors.backgroundTertiary,
                borderRadius: BorderRadius.circular(AppRadius.full),
                border: Border.all(
                  color: colors.backgroundSecondary,
                  width: 2.0,
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

class _ChainIcon extends StatelessWidget {
  const _ChainIcon({
    required this.logoUrl,
    required this.colors,
  });

  final String logoUrl;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _ChainIcons._iconSize,
      height: _ChainIcons._iconSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.backgroundTertiary,
        border: Border.all(
          color: colors.backgroundSecondary,
          width: 2.0,
        ),
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: logoUrl,
          width: _ChainIcons._iconSize,
          height: _ChainIcons._iconSize,
          fit: BoxFit.cover,
          errorWidget: (_, __, ___) => Icon(
            Icons.link,
            color: colors.textSecondary,
            size: 12.0,
          ),
        ),
      ),
    );
  }
}

class _AppIcon extends StatelessWidget {
  const _AppIcon({required this.metadata});

  final PairingMetadata metadata;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final borderRadius = BorderRadius.circular(AppRadius.r3);

    if (metadata.icons.isNotEmpty) {
      final imageUrl = metadata.icons.first;
      if (imageUrl.endsWith('.svg')) {
        return Container(
          width: 42.0,
          height: 42.0,
          decoration: BoxDecoration(
            color: colors.backgroundTertiary,
            borderRadius: borderRadius,
          ),
          clipBehavior: Clip.antiAlias,
          child: SvgPicture.network(imageUrl),
        );
      }
      return ClipRRect(
        borderRadius: borderRadius,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: 42.0,
          height: 42.0,
          errorWidget: (_, __, ___) => _FallbackIcon(colors: colors),
        ),
      );
    }
    return _FallbackIcon(colors: colors);
  }
}

class _FallbackIcon extends StatelessWidget {
  const _FallbackIcon({required this.colors});

  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42.0,
      height: 42.0,
      decoration: BoxDecoration(
        color: colors.backgroundTertiary,
        borderRadius: BorderRadius.circular(AppRadius.r3),
      ),
      child: Icon(Icons.apps, color: colors.textSecondary, size: 20.0),
    );
  }
}
