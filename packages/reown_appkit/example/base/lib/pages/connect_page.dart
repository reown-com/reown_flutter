import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_appkit_dapp/utils/constants.dart';
import 'package:reown_appkit_dapp/utils/crypto/helpers.dart';
import 'package:reown_appkit_dapp/widgets/method_dialog.dart';
import 'package:toastification/toastification.dart';

class ConnectPage extends StatefulWidget {
  const ConnectPage({
    super.key,
    required this.appKitModal,
  });

  final ReownAppKitModal appKitModal;

  @override
  ConnectPageState createState() => ConnectPageState();
}

class ConnectPageState extends State<ConnectPage> {
  final List<ReownAppKitModalNetworkInfo> _selectedChains = [];
  bool _shouldDismissQrCode = true;

  @override
  void initState() {
    super.initState();
    widget.appKitModal.onModalConnect.subscribe(_onModalConnect);
    widget.appKitModal.onModalUpdate.subscribe(_onModalUpdate);
    widget.appKitModal.onModalNetworkChange.subscribe(_onModalNetworkChange);
    widget.appKitModal.onModalDisconnect.subscribe(_onModalDisconnect);
    widget.appKitModal.onModalError.subscribe(_onModalError);
    //
    widget.appKitModal.appKit!.onSessionConnect.subscribe(
      _onSessionConnect,
    );
    widget.appKitModal.appKit!.onSessionAuthResponse.subscribe(
      _onSessionAuthResponse,
    );
    widget.appKitModal.onModalDisconnect.subscribe(
      _onModalDisconnect,
    );
  }

  @override
  void dispose() {
    widget.appKitModal.onModalConnect.unsubscribe(_onModalConnect);
    widget.appKitModal.onModalUpdate.unsubscribe(_onModalUpdate);
    widget.appKitModal.onModalNetworkChange.unsubscribe(_onModalNetworkChange);
    widget.appKitModal.onModalDisconnect.unsubscribe(_onModalDisconnect);
    widget.appKitModal.onModalError.unsubscribe(_onModalError);
    widget.appKitModal.onModalDisconnect.unsubscribe(
      _onModalDisconnect,
    );
    widget.appKitModal.appKit!.onSessionAuthResponse.unsubscribe(
      _onSessionAuthResponse,
    );
    widget.appKitModal.appKit!.onSessionConnect.unsubscribe(
      _onSessionConnect,
    );
    super.dispose();
  }

  Future<void> _refreshData() async {
    try {
      await widget.appKitModal.reconnectRelay();
      await widget.appKitModal.loadAccountData();
      final topic = widget.appKitModal.session!.topic ?? '';
      if (topic.isNotEmpty) {
        await widget.appKitModal.appKit!.ping(topic: topic);
      }
      setState(() {});
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build the list of chain buttons, clear if the textnet changed
    final isDarkMode =
        ReownAppKitModalTheme.maybeOf(context)?.isDarkMode ?? false;
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: Stack(
        children: [
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Center(
                  child: Image.asset('assets/appkit-logo.png', width: 200.0),
                ),
                Container(
                  color: isDarkMode
                      ? Colors.black.withOpacity(0.8)
                      : Colors.white.withOpacity(0.8),
                )
              ],
            ),
          ),
          ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: StyleConstants.linear16,
            ),
            children: <Widget>[
              const SizedBox(height: StyleConstants.linear16),
              _TitleSection(
                appKitModal: widget.appKitModal,
              ),
              const SizedBox(height: StyleConstants.linear8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppKitModalNetworkSelectButton(
                    appKit: widget.appKitModal,
                    size: BaseButtonSize.small,
                  ),
                  const SizedBox.square(dimension: 8.0),
                  AppKitModalConnectButton(
                    appKit: widget.appKitModal,
                    size: BaseButtonSize.small,
                  ),
                ],
              ),
              const SizedBox(height: StyleConstants.linear8),
              Visibility(
                visible: widget.appKitModal.isConnected,
                child: Column(
                  children: [
                    AppKitModalAccountButton(
                      appKitModal: widget.appKitModal,
                    ),
                    const SizedBox.square(dimension: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppKitModalBalanceButton(
                          appKitModal: widget.appKitModal,
                          onTap: widget.appKitModal.openNetworksView,
                        ),
                        const SizedBox.square(dimension: 8.0),
                        AppKitModalAddressButton(
                          appKitModal: widget.appKitModal,
                          onTap: widget.appKitModal.openModalView,
                        ),
                      ],
                    ),
                    const SizedBox.square(dimension: 8.0),
                    Text(
                      'Connected with ${widget.appKitModal.session?.connectedWalletName ?? 'Unknown wallet'}',
                    ),
                    const SizedBox.square(dimension: 8.0),
                    _RequestButtons(
                      appKitModal: widget.appKitModal,
                    ),
                    Text(
                      const JsonEncoder.withIndent('    ').convert(
                        widget.appKitModal.session?.toJson(),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: StyleConstants.linear8),
            ],
          ),
        ],
      ),
    );
  }

  void _onSessionConnect(SessionConnect? event) async {
    if (event == null) return;

    setState(() => _selectedChains.clear());

    if (_shouldDismissQrCode && Navigator.canPop(context)) {
      _shouldDismissQrCode = false;
      Navigator.pop(context);
    }
  }

  void _onSessionAuthResponse(SessionAuthResponse? response) {
    if (response?.session != null) {
      setState(() => _selectedChains.clear());
    }
  }

  void _onModalConnect(ModalConnect? event) async {
    setState(() {});
  }

  void _onModalUpdate(ModalConnect? event) {
    setState(() {});
  }

  void _onModalNetworkChange(ModalNetworkChange? event) {
    setState(() {});
  }

  void _onModalDisconnect(ModalDisconnect? event) {
    setState(() {});
  }

  void _onModalError(ModalError? event) {
    setState(() {});
  }
}

class _RequestButtons extends StatefulWidget {
  final ReownAppKitModal appKitModal;
  const _RequestButtons({required this.appKitModal});

  @override
  State<_RequestButtons> createState() => __RequestButtonsState();
}

class __RequestButtonsState extends State<_RequestButtons> {
  @override
  Widget build(BuildContext context) {
    final topic = widget.appKitModal.session!.topic ?? '';
    final chainId = widget.appKitModal.selectedChain?.chainId ?? '';
    if (chainId.isEmpty) {
      return SizedBox.shrink();
    }
    final namespace = NamespaceUtils.getNamespaceFromChain(chainId);
    final approvedMethods = widget.appKitModal.getApprovedMethods(
      namespace: namespace,
    );
    final address = widget.appKitModal.session!.getAddress(namespace)!;
    final chainInfo = ReownAppKitModalNetworks.getNetworkInfo(
      namespace,
      chainId,
    );
    final implemented = getChainMethods(namespace);
    return Column(
      children: (approvedMethods ?? []).map((method) {
        final enabled = implemented.contains(method);
        if (!enabled) {
          return SizedBox.shrink();
        }
        return Container(
          height: 40.0,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(
            vertical: StyleConstants.linear8,
          ),
          child: ElevatedButton(
            style: ButtonStyle(
              elevation: WidgetStateProperty.all(0.0),
              backgroundColor: WidgetStateProperty.all<Color>(
                ReownAppKitModalTheme.colorsOf(context).accent080,
              ),
              foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
            ),
            onPressed: () async {
              final params = await getParams(method, address, chainInfo!);
              if (params?.params != null) {
                widget.appKitModal.launchConnectedWallet();
                final future = widget.appKitModal.request(
                  topic: topic,
                  chainId: chainId,
                  request: params!,
                );
                MethodDialog.show(context, method, future);
              } else {
                toastification.show(
                  type: ToastificationType.error,
                  title: const Text('Method not implemented'),
                  context: context,
                  autoCloseDuration: Duration(seconds: 2),
                  alignment: Alignment.bottomCenter,
                );
              }
            },
            child: Text(method),
          ),
        );
      }).toList(),
    );
  }
}

class _TitleSection extends StatelessWidget {
  final ReownAppKitModal appKitModal;
  const _TitleSection({required this.appKitModal});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          appKitModal.appKit!.metadata.name,
          style: StyleConstants.subtitleText.copyWith(
            color: ReownAppKitModalTheme.colorsOf(context).foreground100,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          appKitModal.appKit!.metadata.description,
          style: StyleConstants.paragraph.copyWith(
            color: ReownAppKitModalTheme.colorsOf(context).foreground100,
            fontWeight: FontWeight.normal,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
