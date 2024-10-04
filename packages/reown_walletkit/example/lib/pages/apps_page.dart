import 'dart:async';

import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/dependencies/deep_link_handler.dart';
import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/pages/app_detail_page.dart';
import 'package:reown_walletkit_wallet/utils/constants.dart';
import 'package:reown_walletkit_wallet/utils/eth_utils.dart';
import 'package:reown_walletkit_wallet/utils/string_constants.dart';
import 'package:reown_walletkit_wallet/widgets/pairing_item.dart';
import 'package:reown_walletkit_wallet/widgets/uri_input_popup.dart';

class AppsPage extends StatefulWidget with GetItStatefulWidgetMixin {
  AppsPage({Key? key}) : super(key: key);

  @override
  AppsPageState createState() => AppsPageState();
}

class AppsPageState extends State<AppsPage> with GetItStateMixin {
  List<PairingInfo> _pairings = [];
  late IWalletKitService _walletKitService;
  late IReownWalletKit _walletKit;

  @override
  void initState() {
    super.initState();
    _walletKitService = GetIt.I<IWalletKitService>();
    _walletKit = _walletKitService.walletKit;
    _pairings = _walletKit.pairings.getAll();
    _pairings = _pairings.where((p) => p.active).toList();
    //
    _registerListeners();
    // TODO _walletKit.core.echo.register(firebaseAccessToken);
    DeepLinkHandler.checkInitialLink();
  }

  void _registerListeners() {
    _walletKit.core.relayClient.onRelayClientMessage.subscribe(
      _onRelayClientMessage,
    );
    _walletKit.pairings.onSync.subscribe(_refreshState);
    _walletKit.pairings.onUpdate.subscribe(_refreshState);
    _walletKit.onSessionConnect.subscribe(_refreshState);
    _walletKit.onSessionDelete.subscribe(_refreshState);
  }

  void _unregisterListeners() {
    _walletKit.onSessionDelete.unsubscribe(_refreshState);
    _walletKit.onSessionConnect.unsubscribe(_refreshState);
    _walletKit.pairings.onSync.unsubscribe(_refreshState);
    _walletKit.pairings.onUpdate.unsubscribe(_refreshState);
    _walletKit.core.relayClient.onRelayClientMessage.unsubscribe(
      _onRelayClientMessage,
    );
  }

  @override
  void dispose() {
    _unregisterListeners();
    super.dispose();
  }

  void _refreshState(dynamic event) async {
    setState(() {});
  }

  void _onRelayClientMessage(MessageEvent? event) async {
    _refreshState(event);
    if (event != null) {
      final jsonObject = await EthUtils.decodeMessageEvent(event);
      if (!mounted) return;
      if (jsonObject is JsonRpcRequest &&
          jsonObject.method == MethodConstants.WC_SESSION_PING) {
        showPlatformToast(
          duration: const Duration(seconds: 1),
          child: Container(
            padding: const EdgeInsets.all(StyleConstants.linear8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                StyleConstants.linear16,
              ),
            ),
            child: Text(jsonObject.method, maxLines: 1),
          ),
          context: context,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _pairings = _walletKit.pairings.getAll();
    _pairings = _pairings.where((p) => p.active).toList();
    return Stack(
      children: [
        _pairings.isEmpty ? _buildNoPairingMessage() : _buildPairingList(),
        Positioned(
          bottom: StyleConstants.magic20,
          right: StyleConstants.magic20,
          left: StyleConstants.magic20,
          child: Row(
            children: [
              const SizedBox(width: StyleConstants.magic20),
              _buildIconButton(Icons.copy, _onCopyQrCode),
              const SizedBox(width: StyleConstants.magic20),
              _buildIconButton(Icons.qr_code_rounded, _onScanQrCode),
            ],
          ),
        ),
        ValueListenableBuilder(
          valueListenable: DeepLinkHandler.waiting,
          builder: (context, value, _) {
            return Visibility(
              visible: value,
              child: Center(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  ),
                  padding: const EdgeInsets.all(12.0),
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildNoPairingMessage() {
    return const Center(
      child: Text(
        StringConstants.noApps,
        textAlign: TextAlign.center,
        style: StyleConstants.bodyText,
      ),
    );
  }

  Widget _buildPairingList() {
    final pairingItems = _pairings
        .map(
          (PairingInfo pairing) => PairingItem(
            key: ValueKey(pairing.topic),
            pairing: pairing,
            onTap: () => _onListItemTap(pairing),
          ),
        )
        .toList();

    return ListView.builder(
      itemCount: pairingItems.length,
      itemBuilder: (BuildContext context, int index) {
        return pairingItems[index];
      },
    );
  }

  Widget _buildIconButton(IconData icon, void Function()? onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: StyleConstants.primaryColor,
        borderRadius: BorderRadius.circular(
          StyleConstants.linear48,
        ),
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: StyleConstants.titleTextColor,
        ),
        iconSize: StyleConstants.linear24,
        onPressed: onPressed,
      ),
    );
  }

  Future<dynamic> _onCopyQrCode() async {
    final uri = await GetIt.I<IBottomSheetService>().queueBottomSheet(
      widget: UriInputPopup(),
    );
    if (uri is String) {
      _onFoundUri(uri);
    }
  }

  Future _onScanQrCode() async {
    try {
      QrBarCodeScannerDialog().getScannedQrBarCode(
        context: context,
        onCode: (value) {
          if (!mounted) return;
          _onFoundUri(value);
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _onFoundUri(String? uri) async {
    if ((uri ?? '').isEmpty) return;
    try {
      DeepLinkHandler.waiting.value = true;
      await _walletKit.pair(uri: Uri.parse(uri!));
    } on ReownSignError catch (e) {
      _showErrorDialog('${e.code}: ${e.message}\n$uri');
    } on TimeoutException catch (_) {
      _showErrorDialog('Time out error. Check your connection.');
    }
  }

  void _showErrorDialog(String message) {
    DeepLinkHandler.waiting.value = false;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Error',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              message,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'Close',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          );
        });
  }

  void _onListItemTap(PairingInfo pairing) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AppDetailPage(
          pairing: pairing,
        ),
      ),
    );
  }
}
