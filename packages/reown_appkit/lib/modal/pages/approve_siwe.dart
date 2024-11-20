import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/services/analytics_service/i_analytics_service.dart';
import 'package:reown_appkit/modal/services/analytics_service/models/analytics_event.dart';
import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/services/siwe_service/i_siwe_service.dart';
import 'package:reown_appkit/modal/services/toast_service/i_toast_service.dart';
import 'package:reown_appkit/modal/services/toast_service/models/toast_message.dart';
import 'package:reown_appkit/modal/widgets/avatars/account_avatar.dart';
import 'package:reown_appkit/modal/widgets/buttons/primary_button.dart';
import 'package:reown_appkit/modal/widgets/buttons/secondary_button.dart';
import 'package:reown_appkit/modal/widgets/icons/rounded_icon.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/content_loading.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/modal/widgets/avatars/wallet_avatar.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar.dart';
import 'package:reown_appkit/reown_appkit.dart';

class ApproveSIWEPage extends StatefulWidget {
  final Function(ReownAppKitModalSession session) onSiweFinish;
  const ApproveSIWEPage({
    required this.onSiweFinish,
  }) : super(key: KeyConstants.approveSiwePageKey);

  @override
  State<ApproveSIWEPage> createState() => _ApproveSIWEPageState();
}

class _ApproveSIWEPageState extends State<ApproveSIWEPage> {
  ISiweService get _siweService => GetIt.I<ISiweService>();
  IAnalyticsService get _analyticsService => GetIt.I<IAnalyticsService>();

  IReownAppKitModal? _appKitModal;
  double _position = 0.0;
  static const _duration = Duration(milliseconds: 1500);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _position = (MediaQuery.of(context).size.width / 2) + 8.0;
        _appKitModal = ModalProvider.of(context).instance;
        Future.delayed(Duration(milliseconds: 200), () {
          _animate();
        });
      });
    });
  }

  void _animate() {
    if (!mounted) return;
    setState(() {
      if (_position == (MediaQuery.of(context).size.width / 2) - 12.0) {
        _position = (MediaQuery.of(context).size.width / 2) + 8.0;
      } else {
        _position = (MediaQuery.of(context).size.width / 2) - 12.0;
      }
    });
    Future.delayed(_duration, _animate);
  }

  bool _waitingSign = false;
  void _signIn() async {
    setState(() => _waitingSign = true);
    try {
      String chainId = _appKitModal!.selectedChain?.chainId ?? '1';
      final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(
        chainId,
      );
      final address = _appKitModal!.session!.getAddress(namespace)!;
      _analyticsService.sendEvent(ClickSignSiweMessage(network: chainId));
      chainId = ReownAppKitModalNetworks.getCaip2Chain(chainId);
      //
      final message = await _siweService.createMessage(
        chainId: chainId,
        address: address,
      );
      //
      _appKitModal!.launchConnectedWallet();
      final signature = await _siweService.signMessageRequest(
        message,
        session: _appKitModal!.session!,
      );
      //
      final clientId = await _appKitModal!.appKit!.core.crypto.getClientId();
      await _siweService.verifyMessage(
        message: message,
        signature: signature,
        clientId: clientId,
      );
      //
      final siweSession = await _siweService.getSession();
      final newSession = _appKitModal!.session!.copyWith(
        siweSession: siweSession,
      );
      //
      widget.onSiweFinish(newSession);
      //
    } on JsonRpcError catch (e) {
      _handleError(e.message);
    } on ReownAppKitModalException catch (e) {
      _handleError(e.message);
    } catch (e) {
      _handleError(e.toString());
    }
  }

  void _handleError(String? error) {
    final chainId = _appKitModal!.selectedChain?.chainId ?? '1';
    _analyticsService.sendEvent(SiweAuthError(network: chainId));
    GetIt.I<IToastService>().show(ToastMessage(
      type: ToastType.error,
      text: error ?? 'Something went wrong.',
    ));
    if (!mounted) return;
    setState(() => _waitingSign = false);
  }

  void _cancelSIWE() async {
    _appKitModal?.closeModal(disconnectSession: true);
  }

  @override
  Widget build(BuildContext context) {
    if (_appKitModal == null) return ContentLoading();

    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    String peerIcon;
    try {
      peerIcon = _appKitModal?.session?.peer?.metadata.icons.first ?? '';
    } catch (e) {
      peerIcon = '';
    }
    String selfIcon;
    try {
      selfIcon = _appKitModal?.session?.self?.metadata.icons.first ?? '';
    } catch (e) {
      selfIcon = '';
    }
    return ModalNavbar(
      title: 'Sign In',
      noClose: true,
      safeAreaLeft: true,
      safeAreaRight: true,
      safeAreaBottom: true,
      onBack: _cancelSIWE,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox.square(dimension: kPadding12),
          const SizedBox.square(dimension: kPadding8),
          SizedBox(
            height: 76.0,
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                AnimatedPositioned(
                  duration: _duration,
                  curve: Curves.easeInOut,
                  top: 0,
                  left: _position,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius:
                          _appKitModal!.session!.sessionService.isMagic ||
                                  peerIcon.isEmpty
                              ? BorderRadius.circular(60.0)
                              : BorderRadius.circular(radiuses.radiusM),
                      color: themeColors.background150,
                    ),
                    child: _appKitModal!.session!.sessionService.isMagic
                        ? AccountAvatar(
                            appKit: _appKitModal!,
                            size: 60.0,
                          )
                        : SizedBox(
                            width: 60.0,
                            height: 60.0,
                            child: peerIcon.isEmpty
                                ? RoundedIcon(
                                    borderRadius:
                                        radiuses.isSquare() ? 0.0 : 60.0,
                                    size: 60.0,
                                    padding: 12.0,
                                    assetPath:
                                        'lib/modal/assets/icons/regular/wallet.svg',
                                    assetColor: themeColors.accent100,
                                    circleColor: themeColors.accenGlass010,
                                    borderColor: themeColors.accenGlass010,
                                  )
                                : ListAvatar(
                                    imageUrl: peerIcon,
                                    borderRadius: radiuses.radiusS,
                                  ),
                          ),
                  ),
                ),
                AnimatedPositioned(
                  duration: _duration,
                  curve: Curves.easeInOut,
                  top: 0,
                  right: _position,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(36.0),
                      color: themeColors.background150,
                    ),
                    child: selfIcon.isEmpty
                        ? AccountAvatar(
                            appKit: _appKitModal!,
                            size: 60.0,
                          )
                        : SizedBox(
                            width: 60.0,
                            height: 60.0,
                            child: ListAvatar(
                              imageUrl: selfIcon,
                              borderRadius: 30.0,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox.square(dimension: kPadding12),
          const SizedBox.square(dimension: kPadding8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60.0),
            child: Text(
              '${_appKitModal!.appKit!.metadata.name} needs to connect to your wallet',
              textAlign: TextAlign.center,
              style: themeData.textStyles.paragraph400.copyWith(
                color: themeColors.foreground100,
              ),
            ),
          ),
          const SizedBox.square(dimension: kPadding12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              'Sign this message to prove you own this wallet and proceed. Canceling will disconnect you.',
              textAlign: TextAlign.center,
              style: themeData.textStyles.small400.copyWith(
                color: themeColors.foreground200,
              ),
            ),
          ),
          const SizedBox.square(dimension: kPadding12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPadding12),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox.square(dimension: 4.0),
                Expanded(
                  child: SecondaryButton(
                    title: 'Cancel',
                    onTap: _cancelSIWE,
                  ),
                ),
                const SizedBox.square(dimension: kPadding8),
                Expanded(
                  child: PrimaryButton(
                    title: 'Sign',
                    onTap: _signIn,
                    loading: _waitingSign,
                  ),
                ),
                const SizedBox.square(dimension: 4.0),
              ],
            ),
          ),
          const SizedBox.square(dimension: kPadding8),
        ],
      ),
    );
  }
}
