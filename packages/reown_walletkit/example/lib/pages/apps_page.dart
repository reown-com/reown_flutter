import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/dependencies/deep_link_handler.dart';
import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/pages/app_detail_page.dart';
import 'package:reown_walletkit_wallet/utils/constants.dart';
import 'package:reown_walletkit_wallet/utils/eth_utils.dart';
import 'package:reown_walletkit_wallet/widgets/pairing_item.dart';
import 'package:reown_walletkit_wallet/widgets/uri_input_popup.dart';
import 'package:toastification/toastification.dart';

class AppsPage extends StatefulWidget {
  AppsPage({super.key});

  @override
  AppsPageState createState() => AppsPageState();
}

class AppsPageState extends State<AppsPage> with WidgetsBindingObserver {
  List<PairingInfo> _pairings = [];
  final _walletKitService = GetIt.I<IWalletKitService>();

  @override
  void initState() {
    super.initState();
    _pairings =
        _walletKitService.pairings!.getAll().where((p) => p.active).toList();
    _registerListeners();
  }

  void _registerListeners() {
    _walletKitService.walletKit.core.relayClient.onRelayClientMessage.subscribe(
      _onRelayClientMessage,
    );
    _walletKitService.pairings!.onSync.subscribe(_refreshState);
    _walletKitService.pairings!.onUpdate.subscribe(_refreshState);
    _walletKitService.walletKit.onSessionConnect.subscribe(_refreshState);
    _walletKitService.walletKit.onSessionDelete.subscribe(_refreshState);
  }

  void _unregisterListeners() {
    _walletKitService.walletKit.core.relayClient.onRelayClientMessage
        .unsubscribe(
      _onRelayClientMessage,
    );
    _walletKitService.walletKit.onSessionDelete.unsubscribe(_refreshState);
    _walletKitService.walletKit.onSessionConnect.unsubscribe(_refreshState);
    _walletKitService.pairings!.onSync.unsubscribe(_refreshState);
    _walletKitService.pairings!.onUpdate.unsubscribe(_refreshState);
  }

  @override
  void dispose() {
    _unregisterListeners();
    WidgetsBinding.instance.removeObserver(this);
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
        toastification.show(
          title: Text(jsonObject.method, maxLines: 1),
          context: context,
          autoCloseDuration: Duration(seconds: 2),
          alignment: Alignment.bottomCenter,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _pairings =
        _walletKitService.pairings!.getAll().where((p) => p.active).toList();
    return Stack(
      children: [
        if (_pairings.isNotEmpty) _buildPairingList(),
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
      ],
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
        color: StyleConstants.accentPrimary,
        borderRadius: BorderRadius.circular(
          StyleConstants.linear48,
        ),
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: StyleConstants.foregroundPrimary,
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

    if (uri != WCBottomSheetResult.reject.name &&
        uri != WCBottomSheetResult.close.name) {
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
      await _walletKitService.pair(uri!);
      DeepLinkHandler.waiting.value = false;
    } on TimeoutException catch (_) {
      _showErrorDialog('Time out error. Check your connection.');
    } on ReownSignError catch (e) {
      _showErrorDialog('${e.code}:\n${e.message}');
    } on PayInitializeError catch (e) {
      _showErrorDialog('${e.code}:\n${e.message}');
    } on GetPaymentOptionsError catch (e) {
      _showErrorDialog('${e.code}:\n${e.message}');
    } on GetRequiredActionsError catch (e) {
      _showErrorDialog('${e.code}:\n${e.message}');
    } on ConfirmPaymentError catch (e) {
      _showErrorDialog('${e.code}:\n${e.message}');
    } on PayError catch (e) {
      _showErrorDialog('${e.code}\n${e.message}');
    } catch (e) {
      _showErrorDialog('$e');
    }
  }

  void _showErrorDialog(String message) async {
    DeepLinkHandler.waiting.value = false;
    await showDialog(
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
