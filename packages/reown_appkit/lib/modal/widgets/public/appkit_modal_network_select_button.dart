import 'package:flutter/material.dart';

import 'package:reown_appkit/modal/models/public/appkit_network_info.dart';
import 'package:reown_appkit/modal/pages/public/appkit_modal_select_network_page.dart';
import 'package:reown_appkit/modal/services/analytics_service/analytics_service_singleton.dart';
import 'package:reown_appkit/modal/services/analytics_service/models/analytics_event.dart';
import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/widget_stack_singleton.dart';
import 'package:reown_appkit/modal/widgets/buttons/base_button.dart';
import 'package:reown_appkit/modal/widgets/buttons/network_button.dart';

class AppKitModalNetworkSelectButton extends StatefulWidget {
  const AppKitModalNetworkSelectButton({
    super.key,
    required this.service,
    this.size = BaseButtonSize.regular,
    this.context,
    this.custom,
  });

  final IAppKitModal service;
  final BaseButtonSize size;
  final BuildContext? context;
  final Widget? custom;

  @override
  State<AppKitModalNetworkSelectButton> createState() =>
      _AppKitModalNetworkSelectButtonState();
}

class _AppKitModalNetworkSelectButtonState
    extends State<AppKitModalNetworkSelectButton> {
  AppKitModalNetworkInfo? _selectedChain;

  @override
  void initState() {
    super.initState();
    _onServiceUpdate();
    widget.service.addListener(_onServiceUpdate);
  }

  @override
  void dispose() {
    widget.service.removeListener(_onServiceUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.custom ??
        NetworkButton(
          serviceStatus: widget.service.status,
          chainInfo: _selectedChain,
          size: widget.size,
          onTap: () => _onConnectPressed(),
        );
  }

  void _onConnectPressed() {
    analyticsService.instance.sendEvent(ClickNetworksEvent());
    widget.service.openModalView(
      AppKitModalSelectNetworkPage(
        onTapNetwork: (info) {
          widget.service.selectChain(info);
          widgetStack.instance.addDefault();
        },
      ),
    );
  }

  void _onServiceUpdate() {
    setState(() {
      _selectedChain = widget.service.selectedChain;
    });
  }
}
