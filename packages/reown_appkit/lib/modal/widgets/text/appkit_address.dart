import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';
import 'package:reown_appkit/modal/utils/render_utils.dart';
import 'package:reown_appkit/reown_appkit.dart';

class Address extends StatefulWidget {
  const Address({
    super.key,
    required this.service,
    this.style,
  });

  final IReownAppKitModal service;
  final TextStyle? style;

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
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

  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return Text(
      RenderUtils.truncate(_address ?? ''),
      style: widget.style ??
          themeData.textStyles.paragraph600.copyWith(
            color: themeColors.foreground100,
          ),
    );
  }

  void _modalNotifyListener() {
    setState(() {
      final chainId = widget.service.selectedChain?.chainId ?? '';
      final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(
        chainId,
      );
      _address = widget.service.session?.getAddress(namespace);
    });
  }
}
