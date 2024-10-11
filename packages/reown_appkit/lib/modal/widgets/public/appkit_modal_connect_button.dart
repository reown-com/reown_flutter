import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/services/magic_service/i_magic_service.dart';
import 'package:reown_appkit/modal/services/magic_service/models/magic_events.dart';
import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';
import 'package:reown_appkit/modal/widgets/buttons/base_button.dart';
import 'package:reown_appkit/modal/widgets/buttons/connect_button.dart';

class AppKitModalConnectButton extends StatefulWidget {
  const AppKitModalConnectButton({
    super.key,
    required this.appKit,
    this.size = BaseButtonSize.regular,
    this.state,
    this.context,
    this.custom,
  });

  final IReownAppKitModal appKit;
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
    widget.appKit.addListener(_updateState);
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
    widget.appKit.removeListener(_updateState);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        _WebViewWidget(),
        widget.custom ??
            ConnectButton(
              serviceStatus: widget.appKit.status,
              state: _state,
              size: widget.size,
              onTap: _onTap,
            ),
      ],
    );
  }

  void _onTap() {
    if (widget.appKit.isConnected) {
      widget.appKit.disconnect();
    } else {
      widget.appKit.openModalView();
      _updateState();
    }
  }

  void _updateState() {
    final isConnected = widget.appKit.isConnected;
    if (_state == ConnectButtonState.none && !isConnected) {
      return;
    }
    // Case 0: init error
    if (widget.appKit.status == ReownAppKitModalStatus.error) {
      return setState(() => _state = ConnectButtonState.error);
    }
    // Case 1: Is connected
    else if (widget.appKit.isConnected) {
      return setState(() => _state = ConnectButtonState.connected);
    }
    // Case 1.5: No required namespaces
    else if (!widget.appKit.hasNamespaces) {
      return setState(() => _state = ConnectButtonState.disabled);
    }
    // Case 2: Is not open and is not connected
    else if (!widget.appKit.isOpen && !widget.appKit.isConnected) {
      return setState(() => _state = ConnectButtonState.idle);
    }
    // Case 3: Is open and is not connected
    else if (widget.appKit.isOpen && !widget.appKit.isConnected) {
      return setState(() => _state = ConnectButtonState.connecting);
    }
  }
}

class _WebViewWidget extends StatefulWidget {
  @override
  State<_WebViewWidget> createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<_WebViewWidget> {
  IMagicService get _magicService => GetIt.I<IMagicService>();
  bool _show = true;
  //
  @override
  void initState() {
    super.initState();
    _magicService.onMagicRpcRequest.subscribe(_onRequest);
  }

  @override
  void dispose() {
    _magicService.onMagicRpcRequest.unsubscribe(_onRequest);
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
    final emailEnabled = _magicService.isEmailEnabled.value;
    final socialEnabled = _magicService.isSocialEnabled.value;
    if ((emailEnabled || socialEnabled) && _show) {
      return SizedBox(
        width: 0.5,
        height: 0.5,
        child: _magicService.webview,
      );
    }
    return const SizedBox.shrink();
  }
}
