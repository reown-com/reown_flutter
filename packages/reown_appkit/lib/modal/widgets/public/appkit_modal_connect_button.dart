import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/services/magic_service/magic_service_singleton.dart';
import 'package:reown_appkit/modal/services/magic_service/models/magic_events.dart';
import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';
import 'package:reown_appkit/modal/widgets/buttons/base_button.dart';
import 'package:reown_appkit/modal/widgets/buttons/connect_button.dart';

class AppKitModalConnectButton extends StatefulWidget {
  const AppKitModalConnectButton({
    super.key,
    required this.service,
    this.size = BaseButtonSize.regular,
    this.state,
    this.context,
    this.custom,
  });

  final IReownAppKitModal service;
  final BaseButtonSize size;
  final ConnectButtonState? state;
  final BuildContext? context;
  final Widget? custom;

  @override
  State<AppKitModalConnectButton> createState() =>
      _AppKitModalConnectButtonState();
}

class _AppKitModalConnectButtonState extends State<AppKitModalConnectButton> {
  late ConnectButtonState _state;

  @override
  void initState() {
    super.initState();
    _state = widget.state ?? ConnectButtonState.idle;
    _updateState();
    widget.service.addListener(_updateState);
  }

  @override
  void didUpdateWidget(covariant AppKitModalConnectButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _state = widget.state ?? ConnectButtonState.idle;
    _updateState();
  }

  @override
  void dispose() {
    super.dispose();
    widget.service.removeListener(_updateState);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        _WebViewWidget(),
        widget.custom ??
            ConnectButton(
              serviceStatus: widget.service.status,
              state: _state,
              size: widget.size,
              onTap: _onTap,
            ),
      ],
    );
  }

  void _onTap() {
    if (widget.service.isConnected) {
      widget.service.disconnect();
    } else {
      widget.service.openModalView();
      _updateState();
    }
  }

  void _updateState() {
    final isConnected = widget.service.isConnected;
    if (_state == ConnectButtonState.none && !isConnected) {
      return;
    }
    // Case 0: init error
    if (widget.service.status == ReownAppKitModalStatus.error) {
      return setState(() => _state = ConnectButtonState.error);
    }
    // Case 1: Is connected
    else if (widget.service.isConnected) {
      return setState(() => _state = ConnectButtonState.connected);
    }
    // Case 1.5: No required namespaces
    else if (!widget.service.hasNamespaces) {
      return setState(() => _state = ConnectButtonState.disabled);
    }
    // Case 2: Is not open and is not connected
    else if (!widget.service.isOpen && !widget.service.isConnected) {
      return setState(() => _state = ConnectButtonState.idle);
    }
    // Case 3: Is open and is not connected
    else if (widget.service.isOpen && !widget.service.isConnected) {
      return setState(() => _state = ConnectButtonState.connecting);
    }
  }
}

class _WebViewWidget extends StatefulWidget {
  @override
  State<_WebViewWidget> createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<_WebViewWidget> {
  bool _show = true;
  //
  @override
  void initState() {
    super.initState();
    magicService.instance.onMagicRpcRequest.subscribe(_onRequest);
  }

  @override
  void dispose() {
    magicService.instance.onMagicRpcRequest.unsubscribe(_onRequest);
    super.dispose();
  }

  void _onRequest(MagicRequestEvent? args) async {
    if (args != null) {
      final show = args.request == null;
      await Future.delayed(Duration(milliseconds: show ? 500 : 0));
      setState(() => _show = args.request == null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final emailEnabled = magicService.instance.isEnabled.value;
    if (emailEnabled && _show) {
      return SizedBox(
        width: 0.5,
        height: 0.5,
        child: magicService.instance.webview,
      );
    }
    return const SizedBox.shrink();
  }
}
