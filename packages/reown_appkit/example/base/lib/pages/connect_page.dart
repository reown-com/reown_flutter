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

  @override
  Widget build(BuildContext context) {
    // Build the list of chain buttons, clear if the textnet changed
    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: StyleConstants.linear8,
      ),
      children: <Widget>[
        Text(
          widget.appKitModal.appKit!.metadata.name,
          style: StyleConstants.subtitleText,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: StyleConstants.linear16),
        const Divider(height: 1.0),
        const SizedBox(height: StyleConstants.linear16),
        const Text(
          'Connect With AppKit Modal',
          style: StyleConstants.buttonText,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: StyleConstants.linear8),
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
              ...(_buildRequestButtons()),
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
    );
  }

  List<Widget> _buildRequestButtons() {
    final chainId = widget.appKitModal.selectedChain?.chainId ?? '1';
    final ns = ReownAppKitModalNetworks.getNamespaceForChainId(chainId);
    return widget.appKitModal.getApprovedMethods(namespace: ns)?.map((method) {
          final topic = widget.appKitModal.session!.topic ?? '';
          final chainId = widget.appKitModal.selectedChain!.chainId;
          final address = widget.appKitModal.session!.getAddress(ns)!;
          final chainInfo = ReownAppKitModalNetworks.getNetworkById(
            ns,
            chainId,
          );
          // final requestParams = await getParams(method, address);
          // final enabled = requestParams != null;
          return Container(
            height: 40.0,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(
              vertical: StyleConstants.linear8,
            ),
            child: FutureBuilder<SessionRequestParams?>(
                future: getParams(
                  method,
                  address,
                  chainInfo!,
                ),
                builder: (_, snapshot) {
                  final enabled = snapshot.data != null;
                  return ElevatedButton(
                    onPressed: enabled
                        ? () {
                            widget.appKitModal.launchConnectedWallet();
                            final future = widget.appKitModal.request(
                              topic: topic,
                              chainId: chainId,
                              request: snapshot.data!,
                            );
                            MethodDialog.show(context, method, future);
                          }
                        : null,
                    child: Text(method),
                  );
                }),
          );
        }).toList() ??
        [];
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

class _FooterWidget extends StatefulWidget {
  const _FooterWidget({required this.appKitModal});
  final ReownAppKitModal appKitModal;

  @override
  State<_FooterWidget> createState() => __FooterWidgetState();
}

class __FooterWidgetState extends State<_FooterWidget> {
  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(fontSize: 12.0);
    final textStyleBold = textStyle.copyWith(fontWeight: FontWeight.bold);
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
