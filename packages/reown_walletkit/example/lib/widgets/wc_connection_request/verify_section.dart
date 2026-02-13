import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/theme/app_colors.dart';
import 'package:reown_walletkit_wallet/theme/app_spacing.dart';
import 'package:reown_walletkit_wallet/widgets/shared/expandable_section.dart';

class VerifySection extends StatelessWidget {
  const VerifySection({super.key, required this.verifyContext});

  final VerifyContext? verifyContext;

  static String _cleanUrl(String url) {
    var cleaned = url;
    cleaned = cleaned.replaceFirst(RegExp(r'^https?://'), '');
    cleaned = cleaned.replaceFirst(RegExp(r'^www\.'), '');
    if (cleaned.endsWith('/')) {
      cleaned = cleaned.substring(0, cleaned.length - 1);
    }
    return cleaned;
  }

  @override
  Widget build(BuildContext context) {
    if (verifyContext == null) return const SizedBox.shrink();

    final colors = context.colors;
    final validation = verifyContext!.validation;
    final origin = verifyContext!.origin;

    return ExpandableSection(
      headerLeft: Text(
        _cleanUrl(origin),
        style: TextStyle(
          color: colors.textTertiary,
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      headerRight: VerifyBadge(validation: validation),
      expandedContent: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (validation.scam || validation.invalid) ...[
            _WarningBanner(
              validation: validation,
              colors: colors,
            ),
            const SizedBox(height: AppSpacing.s2),
          ],
          _PermissionRow(
            svgAsset: 'assets/CheckCircle.svg',
            text: 'View your balance & activity',
          ),
          const SizedBox(height: AppSpacing.s1),
          _PermissionRow(
            svgAsset: 'assets/CheckCircle.svg',
            text: 'Request transaction approvals',
          ),
          const SizedBox(height: AppSpacing.s1),
          _PermissionRow(
            svgAsset: 'assets/XCircle.svg',
            text: 'Move funds without permission',
          ),
        ],
      ),
    );
  }
}

class VerifyBadge extends StatelessWidget {
  const VerifyBadge({super.key, required this.validation});

  final Validation validation;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    final (String label, Color color, Color textColor) = switch (validation) {
      _ when validation.valid => ('Verified', colors.success, Colors.white),
      _ when validation.scam => ('Unsafe', colors.error, Colors.white),
      _ when validation.invalid =>
        ('Mismatch', colors.warning, Colors.white),
      _ => ('Unverified', colors.foregroundTertiary, colors.textPrimary),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: AppSpacing.s1),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _WarningBanner extends StatelessWidget {
  const _WarningBanner({
    required this.validation,
    required this.colors,
  });

  final Validation validation;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    final color = colors.error;
    final text = validation.scam
        ? 'This domain is flagged as unsafe by multiple security providers. '
            'Leave immediately to protect your assets.'
        : 'This website has a domain that does not match the sender of this '
            'request. Approving may lead to loss of funds.';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.s2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSpacing.s2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber_rounded, color: color, size: 16.0),
          const SizedBox(width: AppSpacing.s1),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: color,
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PermissionRow extends StatelessWidget {
  const _PermissionRow({
    required this.svgAsset,
    required this.text,
  });

  final String svgAsset;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s05),
      child: Row(
        children: [
          SvgPicture.asset(svgAsset, width: 17.0, height: 17.0),
          const SizedBox(width: AppSpacing.s2),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: context.colors.textPrimary,
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
