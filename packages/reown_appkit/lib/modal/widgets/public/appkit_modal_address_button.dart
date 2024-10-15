import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';
import 'package:reown_appkit/modal/utils/render_utils.dart';
import 'package:reown_appkit/modal/widgets/avatars/account_avatar.dart';
import 'package:reown_appkit/modal/widgets/buttons/base_button.dart';
import 'package:reown_appkit/reown_appkit.dart';

class AppKitModalAddressButton extends StatelessWidget {
  const AppKitModalAddressButton({
    super.key,
    required this.appKitModal,
    this.size = BaseButtonSize.regular,
    this.onTap,
  });
  final IReownAppKitModal appKitModal;
  final BaseButtonSize size;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    if (appKitModal.session == null) {
      return SizedBox.shrink();
    }
    final chainId = appKitModal.selectedChain?.chainId ?? '';
    if (chainId.isEmpty) {
      return SizedBox.shrink();
    }
    final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(chainId);
    final address = appKitModal.session!.getAddress(namespace);
    if ((address ?? '').isEmpty) {
      return SizedBox.shrink();
    }
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final textStyle = size == BaseButtonSize.small
        ? themeData.textStyles.small600
        : themeData.textStyles.paragraph600;
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    final innerBorderRadius = radiuses.isSquare() ? 0.0 : size.height / 2;
    return Padding(
      padding: EdgeInsets.only(
        top: size == BaseButtonSize.small ? 4.0 : 0.0,
        bottom: size == BaseButtonSize.small ? 4.0 : 0.0,
      ),
      child: BaseButton(
        size: size,
        onTap: onTap,
        overridePadding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.only(
            left: size == BaseButtonSize.small ? 4.0 : 6.0,
            right: 8.0,
          ),
        ),
        buttonStyle: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return themeColors.grayGlass005;
              }
              return themeColors.grayGlass010;
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return themeColors.grayGlass015;
              }
              return themeColors.foreground175;
            },
          ),
          shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
            (states) {
              return RoundedRectangleBorder(
                side: states.contains(MaterialState.disabled)
                    ? BorderSide(
                        color: themeColors.grayGlass005,
                        width: 1.0,
                      )
                    : BorderSide(
                        color: themeColors.grayGlass010,
                        width: 1.0,
                      ),
                borderRadius: BorderRadius.circular(innerBorderRadius),
              );
            },
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size.iconSize),
                border: Border.all(
                  color: themeColors.grayGlass005,
                  width: 1.0,
                  strokeAlign: BorderSide.strokeAlignInside,
                ),
              ),
              child: AccountAvatar(
                appKit: appKitModal,
                size: size.iconSize * 0.95,
                disabled: false,
              ),
            ),
            const SizedBox.square(dimension: 4.0),
            Text(
              RenderUtils.truncate(
                address!,
                length: size == BaseButtonSize.small ? 2 : 4,
              ),
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
