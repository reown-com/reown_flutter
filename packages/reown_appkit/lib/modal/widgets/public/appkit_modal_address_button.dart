import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';
import 'package:reown_appkit/modal/utils/render_utils.dart';
import 'package:reown_appkit/modal/widgets/avatars/account_avatar.dart';
import 'package:reown_appkit/modal/widgets/buttons/base_button.dart';
import 'package:reown_appkit/modal/widgets/circular_loader.dart';
import 'package:reown_appkit/reown_appkit.dart';

class AppKitModalAddressButton extends StatefulWidget {
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
  State<AppKitModalAddressButton> createState() =>
      _AppKitModalAddressButtonState();
}

class _AppKitModalAddressButtonState extends State<AppKitModalAddressButton> {
  @override
  void initState() {
    super.initState();
    _modalNotifyListener();
    widget.appKitModal.addListener(_modalNotifyListener);
  }

  @override
  void dispose() {
    widget.appKitModal.removeListener(_modalNotifyListener);
    super.dispose();
  }

  void _modalNotifyListener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.appKitModal.session == null) {
      return SizedBox.shrink();
    }
    final chainId = widget.appKitModal.selectedChain?.chainId ?? '';
    if (chainId.isEmpty) {
      return SizedBox.shrink();
    }
    final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(chainId);
    final address = widget.appKitModal.session!.getAddress(namespace);
    if ((address ?? '').isEmpty) {
      return SizedBox.shrink();
    }
    final identityName =
        (widget.appKitModal.blockchainIdentity?.name ?? '').isNotEmpty
            ? widget.appKitModal.blockchainIdentity!.name!
            : null;
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final textStyle = widget.size == BaseButtonSize.small
        ? themeData.textStyles.small600
        : themeData.textStyles.paragraph600;
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    final innerBorderRadius =
        radiuses.isSquare() ? 0.0 : widget.size.height / 2;
    // TODO replace with AddressButton()
    return Padding(
      padding: EdgeInsets.only(
        top: widget.size == BaseButtonSize.small ? 4.0 : 0.0,
        bottom: widget.size == BaseButtonSize.small ? 4.0 : 0.0,
      ),
      child: BaseButton(
        semanticsLabel: 'AppKitModalAddressButton',
        size: widget.size,
        onTap: widget.appKitModal.status.isLoading ? null : widget.onTap,
        overridePadding: WidgetStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.only(
            left: widget.size == BaseButtonSize.small ? 4.0 : 6.0,
            right: 8.0,
          ),
        ),
        buttonStyle: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (states) => themeColors.grayGlass002,
          ),
          foregroundColor: WidgetStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(WidgetState.disabled)) {
                return themeColors.grayGlass015;
              }
              return themeColors.foreground175;
            },
          ),
          shape: WidgetStateProperty.resolveWith<RoundedRectangleBorder>(
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
            widget.appKitModal.status.isLoading
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
                      borderRadius: BorderRadius.circular(widget.size.iconSize),
                      border: Border.all(
                        color: themeColors.grayGlass005,
                        width: 1.0,
                        strokeAlign: BorderSide.strokeAlignInside,
                      ),
                    ),
                    child: AccountAvatar(
                      appKit: widget.appKitModal,
                      size: widget.size.iconSize * 0.95,
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
                      length: widget.size == BaseButtonSize.small ? 2 : 4,
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
