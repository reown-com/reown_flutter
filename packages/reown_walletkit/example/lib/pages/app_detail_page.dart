import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/utils/constants.dart';
import 'package:reown_walletkit_wallet/utils/methods_utils.dart';
import 'package:reown_walletkit_wallet/utils/namespace_model_builder.dart';
import 'package:reown_walletkit_wallet/widgets/custom_button.dart';

class AppDetailPage extends StatefulWidget {
  final PairingInfo pairing;

  const AppDetailPage({
    super.key,
    required this.pairing,
  });

  @override
  AppDetailPageState createState() => AppDetailPageState();
}

class AppDetailPageState extends State<AppDetailPage> {
  late ReownWalletKit _walletKit;

  @override
  void initState() {
    super.initState();
    _walletKit = GetIt.I<IWalletKitService>().walletKit;
    _walletKit.onSessionDelete.subscribe(_onSessionDelete);
    _walletKit.onSessionExpire.subscribe(_onSessionDelete);
  }

  @override
  void dispose() {
    _walletKit.onSessionDelete.unsubscribe(_onSessionDelete);
    _walletKit.onSessionExpire.unsubscribe(_onSessionDelete);
    super.dispose();
  }

  void _onSessionDelete(dynamic args) {
    setState(() {
      _walletKit = GetIt.I<IWalletKitService>().walletKit;
    });
  }

  @override
  Widget build(BuildContext context) {
    final metadata = widget.pairing.peerMetadata;
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(widget.pairing.expiry * 1000);
    int year = dateTime.year;
    int month = dateTime.month;
    int day = dateTime.day;

    String expiryDate =
        '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

    final sessions = _walletKit.sessions
        .getAll()
        .where((element) => element.pairingTopic == widget.pairing.topic)
        .toList();

    List<Widget> sessionWidgets = [];
    for (final SessionData session in sessions) {
      final namespaceWidget = ConnectionWidgetBuilder.buildFromNamespaces(
        session.topic,
        session.namespaces,
        context,
      );
      // Loop through and add the namespace widgets, but put 20 pixels between each one
      for (int i = 0; i < namespaceWidget.length; i++) {
        sessionWidgets.add(namespaceWidget[i]);
        if (i != namespaceWidget.length - 1) {
          sessionWidgets.add(const SizedBox(height: 20.0));
        }
      }
      sessionWidgets.add(const SizedBox.square(dimension: 10.0));
      sessionWidgets.add(
        Row(
          children: [
            CustomButton(
              type: CustomButtonType.normal,
              onTap: () async {
                try {
                  await _walletKit.disconnectSession(
                    topic: session.topic,
                    reason: Errors.getSdkError(Errors.USER_DISCONNECTED)
                        .toSignError(),
                  );
                  setState(() {});
                } catch (e) {
                  debugPrint('[SampleWallet] ${e.toString()}');
                }
              },
              child: const Center(
                child: Text(
                  'Disconnect Session',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(metadata?.name ?? 'Unknown'),
        actions: [
          Visibility(
            visible: metadata?.redirect?.native != null,
            child: IconButton(
              icon: const Icon(
                Icons.open_in_new_rounded,
              ),
              onPressed: () {
                MethodsUtils.openApp(
                  sessions.first.topic,
                  sessions.first.peer.metadata.redirect,
                );
              },
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: StyleConstants.linear8,
          top: StyleConstants.linear8,
          right: StyleConstants.linear8,
          bottom: StyleConstants.linear32,
        ),
        child: Column(
          children: [
            Visibility(
              visible: metadata != null,
              child: Row(
                children: [
                  Builder(
                    builder: (BuildContext context) {
                      if (metadata!.icons.isNotEmpty) {
                        final imageUrl = metadata.icons.first;
                        if (imageUrl.split('.').last == 'svg') {
                          return Container(
                            width: 80.0,
                            height: 80.0,
                            padding: const EdgeInsets.all(1.0),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1.0, color: Colors.black38),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0)),
                            ),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0)),
                              child: SvgPicture.network(imageUrl),
                            ),
                          );
                        }
                        return CircleAvatar(
                          backgroundImage: NetworkImage(imageUrl),
                          radius: 40.0,
                        );
                      }
                      return CircleAvatar(
                        backgroundImage:
                            const AssetImage('assets/images/default_icon.png'),
                        radius: 40.0,
                      );
                    },
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(metadata?.url ?? ''),
                        Text('Expires on: $expiryDate'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Visibility(
              visible: metadata != null,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: sessionWidgets,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                CustomButton(
                  type: CustomButtonType.invalid,
                  onTap: () async {
                    try {
                      await _walletKit.core.pairing.disconnect(
                        topic: widget.pairing.topic,
                      );
                      final topicSession = sessions.where(
                        (s) => s.pairingTopic == widget.pairing.topic,
                      );
                      for (var session in topicSession) {
                        await _walletKit.disconnectSession(
                          topic: session.topic,
                          reason: Errors.getSdkError(Errors.USER_DISCONNECTED)
                              .toSignError(),
                        );
                      }
                      _back();
                    } catch (e) {
                      debugPrint('[SampleWallet] ${e.toString()}');
                    }
                  },
                  child: const Center(
                    child: Text(
                      'Delete Pairing',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _back() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }
}
