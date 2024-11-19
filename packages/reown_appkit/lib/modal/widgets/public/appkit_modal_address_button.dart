import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';
import 'package:reown_appkit/modal/utils/render_utils.dart';
import 'package:reown_appkit/modal/widgets/avatars/account_avatar.dart';
import 'package:reown_appkit/modal/widgets/buttons/base_button.dart';
import 'package:reown_appkit/modal/widgets/circular_loader.dart';
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
    final identityName = (appKitModal.blockchainIdentity?.name ?? '').isNotEmpty
        ? appKitModal.blockchainIdentity!.name!
        : null;
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final textStyle = size == BaseButtonSize.small
        ? themeData.textStyles.small600
        : themeData.textStyles.paragraph600;
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    final innerBorderRadius = radiuses.isSquare() ? 0.0 : size.height / 2;
    // TODO replace with AddressButton()
    return Padding(
      padding: EdgeInsets.only(
        top: size == BaseButtonSize.small ? 4.0 : 0.0,
        bottom: size == BaseButtonSize.small ? 4.0 : 0.0,
      ),
      child: BaseButton(
        size: size,
        onTap: appKitModal.status.isLoading ? null : onTap,
        overridePadding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.only(
            left: size == BaseButtonSize.small ? 4.0 : 6.0,
            right: 8.0,
          ),
        ),
        buttonStyle: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) => themeColors.grayGlass002,
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
                side: BorderSide(
                  color: themeColors.grayGlass002,
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
            appKitModal.status.isLoading
                ? Row(
                    children: [
                      const SizedBox.square(dimension: 4.0),
                      CircularLoader(
                        size: 16.0,
                        strokeWidth: 1.5,
                      ),
                    ],
                  )
                : Container(
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
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 140.0),
              child: Text(
                identityName ??
                    RenderUtils.truncate(
                      address!,
                      length: size == BaseButtonSize.small ? 2 : 4,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
