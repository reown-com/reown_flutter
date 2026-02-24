import 'package:flutter/material.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/models/chain_metadata.dart';
import 'package:reown_walletkit_wallet/theme/app_colors.dart';
import 'package:reown_walletkit_wallet/theme/app_typography.dart';
import 'package:reown_walletkit_wallet/theme/app_radius.dart';
import 'package:reown_walletkit_wallet/theme/app_spacing.dart';
import 'package:reown_walletkit_wallet/widgets/custom_button.dart';
import 'package:reown_walletkit_wallet/widgets/shared/app_icon_widget.dart';
import 'package:reown_walletkit_wallet/widgets/shared/chain_icon_widget.dart';
import 'package:reown_walletkit_wallet/widgets/shared/request_info_row.dart';
import 'package:reown_walletkit_wallet/widgets/wc_connection_request/verify_section.dart';

/// A single labeled content row shown inside [WCRequestModal].
class WCRequestItem {
  const WCRequestItem({required this.label, required this.value});

  final String label;
  final String value;
}

/// Compact key/value row rendered in the summary area.
class WCRequestSummaryRow {
  const WCRequestSummaryRow({required this.label, required this.value});

  final String label;
  final String value;
}

/// Redesigned request modal for sign/send/approve wallet requests.
///
/// Follows the same design language as [WCConnectModal]:
///   - App icon + title
///   - Expandable domain (verify) row
///   - Read-only network row (when chain is provided)
///   - Labeled content rows
///   - Cancel + action buttons
class WCRequestModal extends StatelessWidget {
  const WCRequestModal({
    super.key,
    this.requester,
    this.verifyContext,
    this.chain,
    required this.title,
    required this.items,
    this.summaryRows = const [],
    this.approveLabel = 'Sign',
    this.rejectLabel = 'Cancel',
  });

  final ConnectionMetadata? requester;
  final VerifyContext? verifyContext;
  final ChainMetadata? chain;
  final String title;
  final List<WCRequestItem> items;
  final List<WCRequestSummaryRow> summaryRows;
  final String approveLabel;
  final String rejectLabel;

  void _onReject(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop(WCBottomSheetResult.reject);
    }
  }

  void _onApprove(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop(WCBottomSheetResult.one);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final metadata = requester?.metadata;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: AppSpacing.s2),
        // App icon
        if (metadata != null)
          Center(child: AppIcon(metadata: metadata, size: 64.0)),
        const SizedBox(height: AppSpacing.s3),
        // Title
        Text(
          title,
          style: context.textStyles.heading6,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.s5),
        // Scrollable content area
        Flexible(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                VerifySection(verifyContext: verifyContext),
                if (verifyContext != null)
                  const SizedBox(height: AppSpacing.s2),
                if (chain != null) ...[
                  _NetworkRow(chain: chain!),
                  const SizedBox(height: AppSpacing.s2),
                ],
                ...summaryRows.map(
                  (row) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.s2),
                    child: _SummaryRow(row: row),
                  ),
                ),
                ...items.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.s2),
                    child: RequestInfoRow(
                      label: item.label,
                      value: item.value,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.s5),
        // Action buttons
        Row(
          children: [
            CustomButton(
              onTap: () => _onReject(context),
              style: CustomButtonStyle.outlined,
              child: Text(
                rejectLabel,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: AppSpacing.s3),
            CustomButton(
              onTap: () => _onApprove(context),
              type: CustomButtonType.normal,
              child: Text(
                approveLabel,
                style: TextStyle(
                  color: colors.onAccent,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.row});

  final WCRequestSummaryRow row;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.foregroundPrimary,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s5,
        vertical: AppSpacing.s5,
      ),
      child: Row(
        children: [
          Text(
            row.label,
            style: TextStyle(
              color: colors.textTertiary,
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              letterSpacing: -0.16,
              height: 18.0 / 16.0,
            ),
          ),
          const SizedBox(width: AppSpacing.s2),
          Expanded(
            child: Text(
              row.value,
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                letterSpacing: -0.16,
                height: 18.0 / 16.0,
              ),
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _NetworkRow extends StatelessWidget {
  const _NetworkRow({required this.chain});

  final ChainMetadata chain;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.foregroundPrimary,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.s5,
        vertical: AppSpacing.s5,
      ),
      child: Row(
        children: [
          Text(
            'Network',
            style: TextStyle(
              color: colors.textTertiary,
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              letterSpacing: -0.16,
              height: 18.0 / 16.0,
            ),
          ),
          const Spacer(),
          if (chain.logo.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.s2),
              child: ChainIcon(
                logoUrl: chain.logo,
                size: 24.0,
                showBorder: false,
              ),
            ),
          Text(
            chain.name,
            style: TextStyle(
              color: colors.textPrimary,
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              letterSpacing: -0.16,
              height: 18.0 / 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
