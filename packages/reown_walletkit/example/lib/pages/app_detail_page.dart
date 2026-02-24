import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/models/chain_data.dart';
import 'package:reown_walletkit_wallet/models/chain_metadata.dart';
import 'package:reown_walletkit_wallet/theme/app_colors.dart';
import 'package:reown_walletkit_wallet/theme/app_spacing.dart';
import 'package:reown_walletkit_wallet/widgets/shared/app_icon_widget.dart';
import 'package:reown_walletkit_wallet/widgets/shared/chain_icon_widget.dart';

class AppDetailPage extends StatelessWidget {
  final SessionData session;

  const AppDetailPage({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final metadata = session.peer.metadata;

    final allMethods = <String>[];
    final allEvents = <String>[];
    final chainIds = <String>{};

    for (final ns in session.namespaces.values) {
      allMethods.addAll(ns.methods);
      allEvents.addAll(ns.events);
      for (final account in ns.accounts) {
        final parts = account.split(':');
        if (parts.length >= 2) {
          chainIds.add('${parts[0]}:${parts[1]}');
        }
      }
    }

    final chains = chainIds
        .map((id) {
          try {
            return ChainsDataList.allChains.firstWhere(
              (c) => c.chainId == id,
            );
          } catch (_) {
            return null;
          }
        })
        .whereType<ChainMetadata>()
        .toList();

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.s5),
          // App info card
          _AppInfoCard(
            metadata: metadata,
            chains: chains,
            colors: colors,
          ),
          const SizedBox(height: AppSpacing.s2),
          // Methods card
          if (allMethods.isNotEmpty)
            _DetailCard(
              title: 'Methods',
              content: allMethods.join(', '),
              colors: colors,
            ),
          if (allMethods.isNotEmpty) const SizedBox(height: AppSpacing.s2),
          // Events card
          if (allEvents.isNotEmpty)
            _DetailCard(
              title: 'Events',
              content: allEvents.join(', '),
              colors: colors,
            ),
        ],
      ),
    );
  }
}

/// Disconnect button shown in the bottom sheet header.
/// Filled dark background with white text/icon, 12px border-radius.
class DisconnectButton extends StatelessWidget {
  final String sessionTopic;

  const DisconnectButton({super.key, required this.sessionTopic});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return GestureDetector(
      onTap: () => _disconnect(context),
      child: Container(
        height: 38.0,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s4,
        ),
        decoration: BoxDecoration(
          color: colors.backgroundInvert,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/LinkBreak.svg',
              width: 14.0,
              height: 14.0,
              colorFilter: ColorFilter.mode(
                colors.onBackgroundInvert,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 6.0),
            Text(
              'Disconnect',
              style: TextStyle(
                color: colors.onBackgroundInvert,
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                fontFamily: 'KH Teka',
                letterSpacing: -0.14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _disconnect(BuildContext context) async {
    final walletKit = GetIt.I<IWalletKitService>().walletKit;
    try {
      await walletKit.disconnectSession(
        topic: sessionTopic,
        reason: Errors.getSdkError(
          Errors.USER_DISCONNECTED,
        ).toSignError(),
      );
    } catch (e) {
      debugPrint('[SampleWallet] ${e.toString()}');
    }
    if (context.mounted && Navigator.canPop(context)) {
      Navigator.of(context).pop(WCBottomSheetResult.close);
    }
  }
}

/// Horizontal app info card: icon | name+url | chain icons
class _AppInfoCard extends StatelessWidget {
  const _AppInfoCard({
    required this.metadata,
    required this.chains,
    required this.colors,
  });

  final PairingMetadata metadata;
  final List<ChainMetadata> chains;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.s5),
      decoration: BoxDecoration(
        color: colors.foregroundPrimary,
        borderRadius: BorderRadius.circular(AppSpacing.s5),
      ),
      child: Row(
        children: [
          AppIcon(metadata: metadata, size: 42.0, borderRadius: 12.0),
          const SizedBox(width: AppSpacing.s4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  metadata.name,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'KH Teka',
                    letterSpacing: -0.16,
                    height: 18.0 / 16.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: AppSpacing.s05),
                Text(
                  metadata.url,
                  style: TextStyle(
                    color: colors.textSecondary,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'KH Teka',
                    letterSpacing: -0.16,
                    height: 18.0 / 16.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          if (chains.isNotEmpty) ...[
            const SizedBox(width: AppSpacing.s2),
            ChainIcons(logoUrls: chains.map((c) => c.logo).toList()),
          ],
        ],
      ),
    );
  }
}

/// Card for Methods/Events sections with gray background.
class _DetailCard extends StatelessWidget {
  const _DetailCard({
    required this.title,
    required this.content,
    required this.colors,
  });

  final String title;
  final String content;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.s5),
      decoration: BoxDecoration(
        color: colors.foregroundPrimary,
        borderRadius: BorderRadius.circular(AppSpacing.s5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: colors.textPrimary,
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              fontFamily: 'KH Teka',
              letterSpacing: -0.16,
              height: 18.0 / 16.0,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          const SizedBox(height: AppSpacing.s1),
          Text(
            content,
            style: TextStyle(
              color: colors.textSecondary,
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
              fontFamily: 'KH Teka',
              letterSpacing: -0.14,
              height: 16.0 / 14.0,
            ),
          ),
        ],
      ),
    );
  }
}
