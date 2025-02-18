import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';
import 'package:reown_appkit/modal/utils/render_utils.dart';
import 'package:reown_appkit/reown_appkit.dart';

/// Widget to show the address or identity name
class AddressText extends StatefulWidget {
  const AddressText({
    super.key,
    required this.appKitModal,
    this.style,
  });

  final IReownAppKitModal appKitModal;
  final TextStyle? style;

  @override
  State<AddressText> createState() => _AddressTextState();
}

class _AddressTextState extends State<AddressText> {
  String? _address;

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

  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final identityName =
        (widget.appKitModal.blockchainIdentity?.name ?? '').isNotEmpty
            ? widget.appKitModal.blockchainIdentity!.name!
            : null;
    return Text(
      identityName ?? RenderUtils.truncate(_address ?? ''),
      style: widget.style ??
          themeData.textStyles.paragraph600.copyWith(
            color: themeColors.foreground100,
          ),
    );
  }

  void _modalNotifyListener() {
    setState(() {
      final chainId = widget.appKitModal.selectedChain?.chainId ?? '';
      if (chainId.isNotEmpty) {
        final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(
          chainId,
        );
        _address = widget.appKitModal.session?.getAddress(namespace);
      }
    });
  }
}
