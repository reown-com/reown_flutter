import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';
import 'package:reown_appkit/modal/utils/render_utils.dart';
import 'package:reown_appkit/modal/widgets/avatars/account_avatar.dart';
import 'package:reown_appkit/modal/widgets/buttons/base_button.dart';
import 'package:reown_appkit/reown_appkit.dart';

class AddressButton extends StatefulWidget {
  const AddressButton({
    super.key,
    required this.service,
    this.size = BaseButtonSize.regular,
    this.onTap,
  });
  final IReownAppKitModal service;
  final BaseButtonSize size;
  final VoidCallback? onTap;

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
    return BaseButton(
      size: widget.size,
      onTap: widget.onTap,
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
            return themeColors.foreground100;
          },
        ),
        shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
          (states) {
            return RoundedRectangleBorder(
              side: states.contains(MaterialState.disabled)
                  ? BorderSide(color: themeColors.grayGlass005, width: 1.0)
                  : BorderSide(color: themeColors.grayGlass010, width: 1.0),
              borderRadius: BorderRadius.circular(widget.size.height / 2),
            );
          },
        ),
      ),
      overridePadding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        EdgeInsets.only(
          left: 6.0,
          right: widget.size == BaseButtonSize.small ? 12.0 : 16.0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AccountAvatar(
            appKit: widget.service,
            size: widget.size.height * 0.7,
            disabled: widget.onTap == null,
          ),
          const SizedBox.square(dimension: 4.0),
          Text(RenderUtils.truncate(_address ?? '')),
        ],
      ),
    );
  }
}
