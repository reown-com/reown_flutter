import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/theme/app_colors.dart';
import 'package:reown_walletkit_wallet/theme/app_spacing.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/widgets/wcp_shimmer.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_payment_util.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_utils.dart';

/// Action button rendered on the right side of [WCPOptionRow].
enum WCPOptionRowAction { none, info, edit, infoRequired }

/// Shared row used by the select-token list and by the post-select review
/// screen. The right-hand side is a small icon button — `info` on select,
/// `edit` (pencil) on review — or an `Info required` badge when the option
/// still needs data collection.
class WCPOptionRow extends StatelessWidget {
  const WCPOptionRow({
    super.key,
    required this.option,
    required this.isSelected,
    required this.testId,
    this.action = WCPOptionRowAction.none,
    this.onTap,
    this.onActionTap,
    this.feeEstimate,
    this.isFeeLoading = false,
    this.showSelectedTint = true,
  });

  final PaymentOption option;
  final bool isSelected;
  final String testId;
  final WCPOptionRowAction action;
  final VoidCallback? onTap;
  final VoidCallback? onActionTap;
  final WCPFeeEstimate? feeEstimate;
  final bool isFeeLoading;

  /// In select mode rows show an accent tint when selected. In review mode the
  /// row stands alone so a tint would be visual noise.
  final bool showSelectedTint;

  static const _selectionDuration = Duration(milliseconds: 220);
  static const _selectionCurve = Curves.easeOutCubic;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final display = option.amount.display;
    final networkName = display.networkName?.toLowerCase() ?? 'unknown';

    return Semantics(
      key: ValueKey(testId),
      container: true,
      identifier: testId,
      label: networkName,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: _selectionDuration,
          curve: _selectionCurve,
          decoration: BoxDecoration(
            color: colors.foregroundPrimary,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected && showSelectedTint
                  ? colors.accent
                  : Colors.transparent,
              width: 1,
            ),
          ),
          margin: const EdgeInsets.only(bottom: AppSpacing.s2),
          height: 72.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (showSelectedTint)
                  Positioned.fill(
                    child: IgnorePointer(
                      child: AnimatedOpacity(
                        duration: _selectionDuration,
                        curve: _selectionCurve,
                        opacity: isSelected ? 1.0 : 0.0,
                        child: Container(
                          color: colors.foregroundAccentPrimary010,
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.s5,
                  ),
                  child: Row(
                    children: [
                      _OptionIcon(display: display),
                      const SizedBox(width: AppSpacing.s2),
                      ExcludeSemantics(
                        child: Text(
                          formatPayAmount(option.amount),
                          style: TextStyle(
                            color: colors.textPrimary,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.s2),
                      Expanded(
                        child: _FeeSlot(
                          estimate: feeEstimate,
                          isLoading: isFeeLoading,
                        ),
                      ),
                      _ActionSlot(
                        action: action,
                        isSelected: isSelected,
                        onTap: onActionTap,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OptionIcon extends StatelessWidget {
  const _OptionIcon({required this.display});
  final AmountDisplay display;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final iconUrl = display.iconUrl;
    final networkIconUrl = display.networkIconUrl;
    final hasIcon = iconUrl != null && iconUrl.isNotEmpty;
    final hasNetworkIcon = networkIconUrl != null && networkIconUrl.isNotEmpty;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: 16.0,
          backgroundColor: colors.foregroundPrimary,
          backgroundImage: hasIcon ? NetworkImage(iconUrl) : null,
          child: hasIcon
              ? null
              : Text(
                  display.assetSymbol.characters.first,
                  style: TextStyle(
                    color: colors.textPrimary,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ),
        if (hasNetworkIcon)
          Positioned(
            bottom: -2,
            right: -2,
            child: Container(
              padding: const EdgeInsets.all(1.5),
              decoration: BoxDecoration(
                color: colors.backgroundSecondary,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: CircleAvatar(
                radius: 8.0,
                backgroundImage: NetworkImage(networkIconUrl),
              ),
            ),
          ),
      ],
    );
  }
}

class _FeeSlot extends StatelessWidget {
  const _FeeSlot({required this.estimate, required this.isLoading});

  final WCPFeeEstimate? estimate;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    if (isLoading) {
      return Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(right: AppSpacing.s2),
          child: WCPShimmer(width: 56.0, height: 14.0, borderRadius: 6.0),
        ),
      );
    }
    final fee = estimate;
    if (fee == null) return const SizedBox.shrink();
    final inline = formatInlineApprovalFee(fee);
    if (inline == null) return const SizedBox.shrink();
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: AppSpacing.s2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              inline,
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                letterSpacing: -0.16,
              ),
            ),
            const SizedBox(width: 4),
            SvgPicture.asset(
              'assets/GasPump.svg',
              width: 18.0,
              height: 18.0,
              colorFilter: ColorFilter.mode(
                colors.textSecondary,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionSlot extends StatelessWidget {
  const _ActionSlot({
    required this.action,
    required this.isSelected,
    required this.onTap,
  });

  final WCPOptionRowAction action;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    switch (action) {
      case WCPOptionRowAction.none:
        return const SizedBox.shrink();
      case WCPOptionRowAction.info:
        return _IconButton(
          assetPath: 'assets/Info.svg',
          testId: 'pay-option-info-button',
          onTap: onTap,
        );
      case WCPOptionRowAction.edit:
        return _IconButton(
          assetPath: 'assets/Pencil.svg',
          testId: 'pay-button-edit-option',
          onTap: onTap,
        );
      case WCPOptionRowAction.infoRequired:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _InfoRequiredBadge(isSelected: isSelected),
            const SizedBox(width: AppSpacing.s2),
            _IconButton(
              assetPath: 'assets/Info.svg',
              testId: 'pay-option-info-button',
              onTap: onTap,
            ),
          ],
        );
    }
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({
    required this.assetPath,
    required this.testId,
    required this.onTap,
  });

  final String assetPath;
  final String testId;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Semantics(
      container: true,
      identifier: testId,
      label: testId,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: 38.0,
          height: 38.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: colors.foregroundTertiary, width: 1),
            borderRadius: BorderRadius.circular(AppSpacing.s3),
          ),
          child: SvgPicture.asset(
            assetPath,
            width: 18.0,
            height: 18.0,
            colorFilter: ColorFilter.mode(
              colors.textPrimary,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoRequiredBadge extends StatelessWidget {
  const _InfoRequiredBadge({required this.isSelected});
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Semantics(
      container: true,
      identifier: 'pay-info-required-badge',
      label: 'pay-info-required-badge',
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        height: 28.0,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s2),
        decoration: BoxDecoration(
          color: isSelected
              ? colors.accent.withValues(alpha: 0.9)
              : colors.foregroundTertiary,
          borderRadius: BorderRadius.circular(AppSpacing.s2),
        ),
        alignment: Alignment.center,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          style: TextStyle(
            color: isSelected ? Colors.white : colors.textPrimary,
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
          ),
          child: const Text('Info required'),
        ),
      ),
    );
  }
}
