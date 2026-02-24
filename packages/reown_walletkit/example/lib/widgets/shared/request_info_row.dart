import 'package:flutter/material.dart';
import 'package:reown_walletkit_wallet/theme/app_colors.dart';
import 'package:reown_walletkit_wallet/theme/app_radius.dart';
import 'package:reown_walletkit_wallet/theme/app_spacing.dart';

class RequestInfoRow extends StatelessWidget {
  const RequestInfoRow({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.foregroundPrimary,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      padding: const EdgeInsets.all(AppSpacing.s5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: colors.textTertiary,
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              letterSpacing: -0.16,
              height: 18.0 / 16.0,
            ),
          ),
          const SizedBox(height: AppSpacing.s2),
          Text(
            value,
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
