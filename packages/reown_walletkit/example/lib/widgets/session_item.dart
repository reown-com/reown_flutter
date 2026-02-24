import 'package:flutter/material.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/models/chain_data.dart';
import 'package:reown_walletkit_wallet/models/chain_metadata.dart';
import 'package:reown_walletkit_wallet/theme/app_colors.dart';
import 'package:reown_walletkit_wallet/theme/app_radius.dart';
import 'package:reown_walletkit_wallet/theme/app_spacing.dart';
import 'package:reown_walletkit_wallet/theme/app_typography.dart';
import 'package:reown_walletkit_wallet/widgets/shared/app_icon_widget.dart';
import 'package:reown_walletkit_wallet/widgets/shared/chain_icon_widget.dart';

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
        margin: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s4, vertical: AppSpacing.s1),
        padding: const EdgeInsets.all(AppSpacing.s5),
        decoration: BoxDecoration(
          color: colors.foregroundPrimary,
          borderRadius: AppRadius.borderRadiusMd,
        ),
        child: Row(
          children: [
            AppIcon(metadata: metadata, size: 42.0),
            const SizedBox(width: AppSpacing.s4),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    metadata.name,
                    style: context.textStyles.wcpTextPrimary,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.s05),
                  Text(
                    _cleanUrl(metadata.url),
                    style: context.textStyles.wcpTextSecondary,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            if (chains.isNotEmpty) ...[
              const SizedBox(width: AppSpacing.s4),
              ChainIcons(logoUrls: chains.map((c) => c.logo).toList()),
            ],
          ],
        ),
      ),
    );
  }
}
