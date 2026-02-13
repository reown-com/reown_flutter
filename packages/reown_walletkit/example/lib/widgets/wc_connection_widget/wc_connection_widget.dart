import 'package:flutter/material.dart';
import 'package:reown_walletkit_wallet/theme/app_colors.dart';
import 'package:reown_walletkit_wallet/theme/app_radius.dart';
import 'package:reown_walletkit_wallet/theme/app_spacing.dart';
import 'package:reown_walletkit_wallet/theme/app_typography.dart';
import 'package:reown_walletkit_wallet/widgets/wc_connection_widget/wc_connection_widget_info.dart';
import 'package:reown_walletkit_wallet/widgets/wc_connection_widget/wc_connection_model.dart';

class WCConnectionWidget extends StatelessWidget {
  const WCConnectionWidget({
    super.key,
    required this.title,
    required this.info,
  });

  final String title;
  final List<WCConnectionModel> info;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      decoration: BoxDecoration(
        color: colors.neutrals.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      padding: const EdgeInsets.all(AppSpacing.s2),
      margin: const EdgeInsets.only(bottom: AppSpacing.s3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(context, title),
          ...info.map((e) => WCConnectionWidgetInfo(model: e)),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context, String text) {
    final colors = context.colors;
    return Container(
      decoration: BoxDecoration(
        color: colors.neutrals.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      padding: const EdgeInsets.all(AppSpacing.s2),
      child: Text(text, style: context.textStyles.layerTextStyle2),
    );
  }
}
