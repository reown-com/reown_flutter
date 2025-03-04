import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';
import 'package:reown_appkit/modal/utils/render_utils.dart';
import 'package:reown_appkit/modal/widgets/avatars/account_avatar.dart';
import 'package:reown_appkit/modal/widgets/buttons/base_button.dart';
import 'package:reown_appkit/modal/widgets/buttons/network_button.dart';
import 'package:reown_appkit/reown_appkit.dart';

class AddressButton extends StatefulWidget {
  const AddressButton({
    super.key,
    required this.service,
    this.size = BaseButtonSize.regular,
    this.assetPath,
    this.showNetwork = false,
    this.onTap,
    this.child,
  });
  final IReownAppKitModal service;
  final BaseButtonSize size;
  final VoidCallback? onTap;
  final bool showNetwork;
  final String? assetPath;
  final Widget? child;

  @override
  State<AddressButton> createState() => _AddressButtonState();
}

class _AddressButtonState extends State<AddressButton> {
  String? _address;

  @override
  void initState() {
    super.initState();
    _modalNotifyListener();
    widget.service.addListener(_modalNotifyListener);
  }

  @override
  void dispose() {
    widget.service.removeListener(_modalNotifyListener);
    super.dispose();
  }

  void _modalNotifyListener() {
    setState(() {
      try {
        final chainId = widget.service.selectedChain!.chainId;
        final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(
          chainId,
        );
        _address = widget.service.session?.getAddress(namespace);
      } catch (e) {
        widget.service.appKit!.core.logger.e('[$runtimeType] $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final identityName =
        (widget.service.blockchainIdentity?.name ?? '').isNotEmpty
            ? widget.service.blockchainIdentity!.name!
            : null;
    return BaseButton(
      semanticsLabel: 'AddressButton',
      size: widget.size,
      onTap: widget.onTap,
      buttonStyle: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (states) => themeColors.grayGlass002,
        ),
        foregroundColor: WidgetStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(WidgetState.disabled)) {
              return themeColors.grayGlass015;
            }
            return themeColors.foreground100;
          },
        ),
        shape: WidgetStateProperty.resolveWith<RoundedRectangleBorder>(
          (states) {
            return RoundedRectangleBorder(
              side: BorderSide(
                color: themeColors.grayGlass002,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(widget.size.height / 2),
            );
          },
        ),
      ),
      overridePadding: WidgetStateProperty.all<EdgeInsetsGeometry>(
        widget.child != null
            ? const EdgeInsets.all(0.0)
            : EdgeInsets.only(
                left: 6.0,
                right: widget.size == BaseButtonSize.small ? 12.0 : 16.0,
              ),
      ),
      child: widget.child ??
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.showNetwork && widget.service.selectedChain != null
                  ? NetworkButton(
                      chainInfo: widget.service.selectedChain,
                      size: BaseButtonSize.small,
                      iconOnly: true,
                    )
                  : AccountAvatar(
                      appKit: widget.service,
                      size: widget.size.height * 0.6,
                      disabled: widget.onTap == null,
                    ),
              const SizedBox.square(dimension: 4.0),
              Text(identityName ?? RenderUtils.truncate(_address ?? '')),
              const SizedBox.square(dimension: 8.0),
              SvgPicture.asset(
                widget.assetPath ?? 'lib/modal/assets/icons/chevron_down.svg',
                package: 'reown_appkit',
                colorFilter: ColorFilter.mode(
                  themeColors.foreground200,
                  BlendMode.srcIn,
                ),
                width: 14.0,
                height: 14.0,
              ),
            ],
          ),
    );
  }
}
