import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_appkit_dapp/utils/constants.dart';
import 'package:reown_appkit_dapp/utils/crypto/helpers.dart';
import 'package:reown_appkit_dapp/utils/string_constants.dart';
import 'package:reown_appkit_dapp/widgets/method_dialog.dart';
import 'package:toastification/toastification.dart';

class ConnectPage extends StatefulWidget {
  const ConnectPage({
    super.key,
    required this.appKitModal,
    required this.reinitialize,
    this.linkMode = false,
  });

  final ReownAppKitModal appKitModal;
  final Function(bool linkMode) reinitialize;
  final bool linkMode;

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
    await widget.appKitModal.reconnectRelay();
    await widget.appKitModal.loadAccountData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Build the list of chain buttons, clear if the textnet changed
    return RefreshIndicator(
      onRefresh: () => _refreshData(),
      child: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: StyleConstants.linear16,
        ),
        children: <Widget>[
          const SizedBox(height: StyleConstants.linear16),
          Text(
            widget.appKitModal.appKit!.metadata.name,
            style: StyleConstants.subtitleText.copyWith(
              color: ReownAppKitModalTheme.colorsOf(context).foreground100,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: StyleConstants.linear24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppKitModalNetworkSelectButton(
                appKit: widget.appKitModal,
              ),
              const SizedBox.square(dimension: 8.0),
              AppKitModalConnectButton(
                appKit: widget.appKitModal,
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
                _RequestButtons(
                  appKitModal: widget.appKitModal,
                ),
              ],
            ),
          ),
          const SizedBox(height: StyleConstants.linear8),
          Visibility(
            visible: !widget.appKitModal.isConnected,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        'non-EVM\nSession Proposal',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: ReownAppKitModalTheme.colorsOf(context)
                              .foreground100,
                          fontWeight: !widget.linkMode
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                    Switch(
                      value: widget.linkMode,
                      onChanged: (value) {
                        widget.reinitialize(value);
                      },
                    ),
                    Expanded(
                      child: Text(
                        'only EVM\nLink Mode',
                        style: TextStyle(
                          color: ReownAppKitModalTheme.colorsOf(context)
                              .foreground100,
                          fontWeight: widget.linkMode
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: StyleConstants.linear16),
          const Divider(height: 1.0),
          const SizedBox(height: StyleConstants.linear8),
          _FooterWidget(appKitModal: widget.appKitModal),
          const SizedBox(height: StyleConstants.linear8),
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
    final chainId = widget.appKitModal.selectedChain!.chainId;
    final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(chainId);
    final methods = widget.appKitModal.getApprovedMethods(namespace: namespace);
    final address = widget.appKitModal.session!.getAddress(namespace)!;
    final chainInfo = ReownAppKitModalNetworks.getNetworkById(
      namespace,
      chainId,
    );
    return Column(
      children: (methods ?? []).map((method) {
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
                  ReownAppKitModalTheme.colorsOf(context).accent080),
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

class _FooterWidget extends StatefulWidget {
  const _FooterWidget({required this.appKitModal});
  final ReownAppKitModal appKitModal;

  @override
  State<_FooterWidget> createState() => __FooterWidgetState();
}

class __FooterWidgetState extends State<_FooterWidget> {
  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 12.0,
      color: ReownAppKitModalTheme.colorsOf(context).foreground100,
    );
    final textStyleBold = textStyle.copyWith(
      fontWeight: FontWeight.bold,
    );
    final redirect = widget.appKitModal.appKit!.metadata.redirect;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: StyleConstants.linear8),
        Text('Redirect:', style: textStyleBold),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Native: ', style: textStyle),
            Expanded(
              child: Text('${redirect?.native}', style: textStyleBold),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Universal: ', style: textStyle),
            Expanded(
              child: Text('${redirect?.universal}', style: textStyleBold),
            ),
          ],
        ),
        Row(
          children: [
            Text('Link Mode: ', style: textStyle),
            Text('${redirect?.linkMode}', style: textStyleBold),
          ],
        ),
        FutureBuilder<PackageInfo>(
          future: PackageInfo.fromPlatform(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox.shrink();
            }
            final v = snapshot.data!.version;
            final b = snapshot.data!.buildNumber;
            const f = String.fromEnvironment('FLUTTER_APP_FLAVOR');
            // return Text('App Version: $v-$f ($b) - SDK v$packageVersion');
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('App Version: ', style: textStyle),
                Expanded(
                  child: Text(
                    '$v-$f ($b) - SDK v$packageVersion',
                    style: textStyleBold,
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: StyleConstants.linear8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: !widget.appKitModal.isConnected,
              child: SizedBox(
                height: 30.0,
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: WidgetStateProperty.all(0.0),
                    backgroundColor: WidgetStateProperty.all<Color>(
                      ReownAppKitModalTheme.colorsOf(context).accenGlass010,
                    ),
                    foregroundColor: WidgetStateProperty.all<Color>(
                      ReownAppKitModalTheme.colorsOf(context).foreground100,
                    ),
                  ),
                  onPressed: () async {
                    await widget.appKitModal.appKit!.core.storage.deleteAll();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Storage cleared'),
                      duration: Duration(seconds: 1),
                    ));
                  },
                  child: Text(
                    'CLEAR STORAGE',
                    style: TextStyle(fontSize: 10.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({
    super.key,
    required this.uri,
    this.walletScheme = '',
  });
  final String uri;
  final String walletScheme;

  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(title: const Text(StringConstants.scanQrCode)),
        body: _QRCodeView(
          uri: widget.uri,
          walletScheme: widget.walletScheme,
        ),
      ),
    );
  }
}

class _QRCodeView extends StatelessWidget {
  const _QRCodeView({
    required this.uri,
    this.walletScheme = '',
  });
  final String uri;
  final String walletScheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        QrImageView(data: uri),
        const SizedBox(
          height: StyleConstants.linear16,
        ),
        ElevatedButton(
          onPressed: () {
            Clipboard.setData(
              ClipboardData(text: uri.toString()),
            ).then(
              (_) => toastification.show(
                title: const Text(StringConstants.copiedToClipboard),
                context: context,
                autoCloseDuration: Duration(seconds: 2),
                alignment: Alignment.bottomCenter,
              ),
            );
          },
          child: const Text('Copy URL to Clipboard'),
        ),
        Visibility(
          visible: walletScheme.isNotEmpty,
          child: ElevatedButton(
            onPressed: () async {
              final encodedUri = Uri.encodeComponent(uri);
              await ReownCoreUtils.openURL('$walletScheme?uri=$encodedUri');
            },
            child: const Text('Open Test Wallet'),
          ),
        ),
      ],
    );
  }
}
