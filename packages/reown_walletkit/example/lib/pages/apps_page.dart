import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/pages/app_detail_page.dart';
import 'package:reown_walletkit_wallet/theme/app_colors.dart';
import 'package:reown_walletkit_wallet/theme/app_spacing.dart';
import 'package:reown_walletkit_wallet/utils/eth_utils.dart';
import 'package:reown_walletkit_wallet/widgets/session_item.dart';
import 'package:toastification/toastification.dart';

class AppsPage extends StatefulWidget {
  AppsPage({super.key});

  @override
  AppsPageState createState() => AppsPageState();
}

class AppsPageState extends State<AppsPage> {
  final _walletKitService = GetIt.I<IWalletKitService>();

  List<SessionData> get _sessions =>
      _walletKitService.walletKit.sessions.getAll();

  @override
  void initState() {
    super.initState();
    _registerListeners();
  }

  void _registerListeners() {
    _walletKitService.walletKit.core.relayClient.onRelayClientMessage
        .subscribe(_onRelayClientMessage);
    _walletKitService.pairings!.onSync.subscribe(_refreshState);
    _walletKitService.pairings!.onUpdate.subscribe(_refreshState);
    _walletKitService.walletKit.onSessionConnect.subscribe(_refreshState);
    _walletKitService.walletKit.onSessionDelete.subscribe(_refreshState);
  }

  void _unregisterListeners() {
    _walletKitService.walletKit.core.relayClient.onRelayClientMessage
        .unsubscribe(_onRelayClientMessage);
    _walletKitService.walletKit.onSessionDelete.unsubscribe(_refreshState);
    _walletKitService.walletKit.onSessionConnect.unsubscribe(_refreshState);
    _walletKitService.pairings!.onSync.unsubscribe(_refreshState);
    _walletKitService.pairings!.onUpdate.unsubscribe(_refreshState);
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
    final sessions = _sessions;
    final colors = context.colors;

    if (sessions.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'No connected apps yet',
              style: TextStyle(
                color: colors.textPrimary,
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: AppSpacing.s2),
            Text(
              'Scan a WalletConnect QR code to get started.',
              style: TextStyle(
                color: colors.textSecondary,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s2),
      itemCount: sessions.length,
      itemBuilder: (BuildContext context, int index) {
        final session = sessions[index];
        return SessionItem(
          key: ValueKey(session.topic),
          session: session,
          onTap: () => _onSessionTap(session),
        );
      },
    );
  }

  void _onSessionTap(SessionData session) {
    GetIt.I<IBottomSheetService>().queueBottomSheet(
      widget: AppDetailPage(session: session),
      leadingWidget: DisconnectButton(sessionTopic: session.topic),
    );
  }
}
