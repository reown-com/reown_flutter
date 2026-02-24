import 'package:flutter/material.dart';
import 'package:reown_walletkit_wallet/theme/app_colors.dart';
import 'package:reown_walletkit_wallet/theme/app_radius.dart';
import 'package:reown_walletkit_wallet/theme/app_spacing.dart';

enum CustomButtonType { normal, valid, invalid }

enum CustomButtonStyle { filled, outlined }

class CustomButton extends StatelessWidget {
  final Widget child;
  final CustomButtonType? type;
  final CustomButtonStyle style;
  final VoidCallback? onTap;
  final bool expanded;

  const CustomButton({
    super.key,
    required this.child,
    required this.onTap,
    this.type,
    this.style = CustomButtonStyle.filled,
    this.expanded = true,
  });

  Color _getBackgroundColor(BuildContext context) {
    if (style == CustomButtonStyle.outlined) return Colors.transparent;
    final colors = context.colors;
    switch (type) {
      case CustomButtonType.normal:
        return colors.accent;
      case CustomButtonType.valid:
        return colors.success;
      case CustomButtonType.invalid:
        return colors.error;
      default:
        return colors.backgroundTertiary;
    }
  }

  Color _getBorderColor(BuildContext context) {
    if (style != CustomButtonStyle.outlined) return Colors.transparent;
    final colors = context.colors;
    switch (type) {
      case CustomButtonType.normal:
        return colors.accent;
      case CustomButtonType.valid:
        return colors.success;
      case CustomButtonType.invalid:
        return colors.error;
      default:
        return colors.divider;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = onTap == null;
    final opacity = isDisabled ? 0.5 : 1.0;

    final button = Opacity(
      opacity: opacity,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.borderRadiusMd,
        child: Container(
          decoration: BoxDecoration(
            color: _getBackgroundColor(context),
            borderRadius: AppRadius.borderRadiusMd,
            border: style == CustomButtonStyle.outlined
                ? Border.all(color: _getBorderColor(context))
                : null,
          ),
          padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.s2, vertical: AppSpacing.s3),
          child: child,
        ),
      ),
    );

    if (expanded) return Expanded(child: button);
    return button;
  }
}
