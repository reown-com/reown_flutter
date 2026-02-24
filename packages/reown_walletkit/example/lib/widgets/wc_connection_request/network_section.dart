import 'package:flutter/material.dart';
import 'package:reown_walletkit_wallet/models/chain_metadata.dart';
import 'package:reown_walletkit_wallet/theme/app_colors.dart';
import 'package:reown_walletkit_wallet/theme/app_radius.dart';
import 'package:reown_walletkit_wallet/theme/app_spacing.dart';
import 'package:reown_walletkit_wallet/widgets/shared/chain_icon_widget.dart';
import 'package:reown_walletkit_wallet/widgets/shared/expandable_section.dart';

class NetworkSection extends StatelessWidget {
  const NetworkSection({
    super.key,
    required this.chains,
    required this.selectedChainIds,
    required this.onToggleChain,
  });

  final List<ChainMetadata> chains;
  final Set<String> selectedChainIds;
  final ValueChanged<String> onToggleChain;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isSingleChain = chains.length == 1;

    final headerLabelStyle = TextStyle(
      color: colors.textTertiary,
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.16,
      height: 18.0 / 16.0,
    );

    if (isSingleChain) {
      return Container(
        decoration: BoxDecoration(
          color: colors.foregroundPrimary,
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s4,
          vertical: 14.0,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text('Network', style: headerLabelStyle),
            ),
            ChainIcon(
              logoUrl: chains.first.logo,
              size: 24.0,
              showBorder: false,
            ),
          ],
        ),
      );
    }

    return ExpandableSection(
      headerLeft: Text('Network', style: headerLabelStyle),
      headerRight: ChainIcons(
        logoUrls: chains
            .where((c) => selectedChainIds.contains(c.chainId))
            .map((c) => c.logo)
            .toList(),
      ),
      expandedContent: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 280.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final chain in chains)
                _ChainRow(
                  chain: chain,
                  isSelected: selectedChainIds.contains(chain.chainId),
                  onToggle: () => onToggleChain(chain.chainId),
                  colors: colors,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChainRow extends StatelessWidget {
  const _ChainRow({
    required this.chain,
    required this.isSelected,
    required this.onToggle,
    required this.colors,
  });

  final ChainMetadata chain;
  final bool isSelected;
  final VoidCallback onToggle;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.s5),
        margin: const EdgeInsets.only(bottom: 6.0),
        decoration: BoxDecoration(
          color: isSelected
              ? colors.accent.withValues(alpha: 0.1)
              : colors.backgroundTertiary.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: isSelected ? colors.accent : Colors.transparent,
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            ChainIcon(
              logoUrl: chain.logo,
              size: 32.0,
              showBorder: false,
            ),
            const SizedBox(width: AppSpacing.s3),
            Expanded(
              child: Text(
                chain.name,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            _Checkbox(isSelected: isSelected, colors: colors),
          ],
        ),
      ),
    );
  }
}

class _Checkbox extends StatelessWidget {
  const _Checkbox({
    required this.isSelected,
    required this.colors,
  });

  final bool isSelected;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    if (isSelected) {
      return Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          color: colors.accent,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: const Icon(Icons.check, color: Colors.white, size: 16.0),
      );
    }
    return Container(
      width: 24.0,
      height: 24.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: colors.neutrals, width: 2.0),
      ),
    );
  }
}
