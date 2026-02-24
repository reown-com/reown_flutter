import 'package:flutter/material.dart';
import 'package:reown_walletkit_wallet/theme/app_colors.dart';
import 'package:reown_walletkit_wallet/theme/app_radius.dart';
import 'package:reown_walletkit_wallet/theme/app_spacing.dart';
import 'package:reown_walletkit_wallet/theme/app_typography.dart';
import 'package:reown_walletkit_wallet/widgets/wc_connection_widget/wc_connection_model.dart';

class WCConnectionWidgetInfo extends StatelessWidget {
  const WCConnectionWidgetInfo({super.key, required this.model});

  final WCConnectionModel model;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.neutrals.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      padding: const EdgeInsets.all(AppSpacing.s2),
      margin: const EdgeInsetsDirectional.only(top: AppSpacing.s2),
      child: model.elements != null ? _buildList(context) : _buildText(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (model.title != null)
          Text(model.title!, style: context.textStyles.layerTextStyle3),
        if (model.title != null) const SizedBox(height: AppSpacing.s2),
        Wrap(
          spacing: 4,
          runSpacing: 4,
          direction: Axis.horizontal,
          children:
              model.elements!.map((e) => _buildElement(context, e)).toList(),
        ),
      ],
    );
  }

  Widget _buildElement(BuildContext context, String text) {
    final colors = context.colors;
    if (text.isEmpty) {
      return SizedBox.shrink();
    }
    return ElevatedButton(
      onPressed:
          model.elementActions != null ? model.elementActions![text] : null,
      style: ButtonStyle(
        elevation: model.elementActions != null
            ? WidgetStateProperty.all(4.0)
            : WidgetStateProperty.all(0.0),
        padding: WidgetStateProperty.all(const EdgeInsets.all(0.0)),
        visualDensity: VisualDensity.compact,
        backgroundColor: WidgetStateProperty.all(
          colors.neutrals.withValues(alpha: 0.8),
        ),
        overlayColor: WidgetStateProperty.all(colors.background),
        shape: WidgetStateProperty.resolveWith<RoundedRectangleBorder>((
          states,
        ) {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          );
        }),
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.s2),
        child: Text(
          text,
          style: context.textStyles.bodyText.copyWith(
            color: colors.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    return Text(model.text!, style: context.textStyles.layerTextStyle3);
  }
}
