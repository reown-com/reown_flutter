import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/services/explorer_service/i_explorer_service.dart';
import 'package:reown_appkit/modal/services/magic_service/i_magic_service.dart';
import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/services/siwe_service/i_siwe_service.dart';
import 'package:reown_appkit/modal/widgets/icons/rounded_icon.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/content_loading.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/widget_stack_singleton.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/responsive_container.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/modal/widgets/avatars/wallet_avatar.dart';
import 'package:reown_appkit/modal/widgets/avatars/loading_border.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar.dart';
import 'package:reown_appkit/reown_appkit.dart';

class ConnectNetworkPage extends StatefulWidget {
  const ConnectNetworkPage({
    required this.chainInfo,
    this.isMagic = false,
  }) : super(key: KeyConstants.connecNetworkPageKey);

  final ReownAppKitModalNetworkInfo chainInfo;
  final bool isMagic;

  @override
  State<ConnectNetworkPage> createState() => _ConnectNetworkPageState();
}

class _ConnectNetworkPageState extends State<ConnectNetworkPage>
    with WidgetsBindingObserver {
  IReownAppKitModal? _appKitModal;
  ModalError? errorEvent;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _appKitModal = ModalProvider.of(context).instance;
      _appKitModal?.onModalError.subscribe(_errorListener);
      setState(() {});
      Future.delayed(const Duration(milliseconds: 300), () => _connect());
    });
  }

  IMagicService get _magicService => GetIt.I<IMagicService>();
  IExplorerService get _explorerService => GetIt.I<IExplorerService>();
  ISiweService get _siweService => GetIt.I<ISiweService>();

  void _connect() async {
    errorEvent = null;
    if (widget.isMagic) {
      final newCaip2Chain = ReownAppKitModalNetworks.getCaip2Chain(
        widget.chainInfo.chainId,
      );
      final success = await _magicService.switchNetwork(chainId: newCaip2Chain);
      if (success) {
        final siweEnabled = _siweService.config?.enabled != true;
        final signOutOnNetworkChange = _siweService.signOutOnNetworkChange;
        if (!siweEnabled || !signOutOnNetworkChange) {
          final newCaip2Chain = ReownAppKitModalNetworks.getCaip2Chain(
            widget.chainInfo.chainId,
          );
          await _magicService.getUser(
            chainId: newCaip2Chain,
            isUpdate: true,
          );
          widgetStack.instance.pop();
        }
      }
    } else {
      try {
        _appKitModal!.launchConnectedWallet();
        await _appKitModal!.requestSwitchToChain(widget.chainInfo);
        final chainId = widget.chainInfo.chainId;
        final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(
          chainId,
        );
        final chainInfo = ReownAppKitModalNetworks.getNetworkById(
          namespace,
          chainId,
        );
        if (chainInfo != null) {
          Future.delayed(const Duration(milliseconds: 300), () {
            if (!_siweService.enabled) {
              widgetStack.instance.pop();
            }
          });
        }
      } on JsonRpcError catch (e) {
        setState(
          () => errorEvent = ModalError(e.message ?? 'An error occurred'),
        );
      } on ReownAppKitModalException catch (e) {
        setState(() => errorEvent = ModalError(e.message));
      } catch (e) {
        setState(() => errorEvent = ModalError('An error occurred'));
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (_appKitModal?.session?.sessionService.isCoinbase == true) {
        if (_appKitModal?.selectedChain?.chainId == widget.chainInfo.chainId) {
          if (!_siweService.enabled) {
            widgetStack.instance.pop();
          }
        }
      }
    }
  }

  void _errorListener(ModalError? event) => setState(() => errorEvent = event);

  @override
  void dispose() {
    _appKitModal?.onModalError.unsubscribe(_errorListener);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_appKitModal == null) {
      return ContentLoading();
    }
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final isPortrait = ResponsiveData.isPortrait(context);
    final maxWidth = isPortrait
        ? ResponsiveData.maxWidthOf(context)
        : ResponsiveData.maxHeightOf(context) -
            kNavbarHeight -
            (kPadding16 * 2);
    //
    final chainId = widget.chainInfo.chainId;
    final imageId = ReownAppKitModalNetworks.getNetworkIconId(chainId);
    final imageUrl = _explorerService.getAssetImageUrl(imageId);
    //
    return ModalNavbar(
      title: widget.chainInfo.name,
      noClose: true,
      body: SingleChildScrollView(
        scrollDirection: isPortrait ? Axis.vertical : Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: kPadding16),
        child: Flex(
          direction: isPortrait ? Axis.vertical : Axis.horizontal,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox.square(dimension: 20.0),
                  LoadingBorder(
                    animate: errorEvent == null,
                    isNetwork: true,
                    borderRadius: themeData.radiuses.isSquare()
                        ? 0
                        : themeData.radiuses.radiusM + 4.0,
                    // themeData.radiuses.radiusM + 4.0
                    child: _WalletAvatar(
                      imageUrl: imageUrl,
                      errorConnection: errorEvent is UserRejectedConnection,
                      themeColors: themeColors,
                    ),
                  ),
                  const SizedBox.square(dimension: 20.0),
                  errorEvent != null
                      ? Text(
                          errorEvent?.message ?? 'Switch declined',
                          textAlign: TextAlign.center,
                          style: themeData.textStyles.paragraph500.copyWith(
                            color: themeColors.error100,
                          ),
                        )
                      : Text(
                          widget.isMagic
                              ? 'Switching to ${widget.chainInfo.name}'
                              : 'Continue in ${_appKitModal?.session?.peer?.metadata.name ?? 'wallet'}',
                          textAlign: TextAlign.center,
                          style: themeData.textStyles.paragraph500.copyWith(
                            color: themeColors.foreground100,
                          ),
                        ),
                  const SizedBox.square(dimension: 8.0),
                  errorEvent != null
                      ? Text(
                          'Switch can be declined by the user or if the wallet doesn\'t support the selected chain.',
                          textAlign: TextAlign.center,
                          style: themeData.textStyles.small500.copyWith(
                            color: themeColors.foreground200,
                          ),
                        )
                      : Text(
                          widget.isMagic
                              ? 'Wait until it\'s completed'
                              : 'Accept switch request in your wallet',
                          textAlign: TextAlign.center,
                          style: themeData.textStyles.small500.copyWith(
                            color: themeColors.foreground200,
                          ),
                        ),
                  const SizedBox.square(dimension: kPadding16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WalletAvatar extends StatelessWidget {
  const _WalletAvatar({
    required this.imageUrl,
    required this.errorConnection,
    required this.themeColors,
  });

  final String imageUrl;
  final bool errorConnection;
  final ReownAppKitModalColors themeColors;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListAvatar(
          imageUrl: imageUrl,
          isNetwork: true,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Visibility(
            visible: errorConnection,
            child: Container(
              decoration: BoxDecoration(
                color: themeColors.background125,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
              padding: const EdgeInsets.all(1.0),
              clipBehavior: Clip.antiAlias,
              child: RoundedIcon(
                assetPath: 'lib/modal/assets/icons/close.svg',
                assetColor: themeColors.error100,
                circleColor: themeColors.error100.withOpacity(0.2),
                borderColor: themeColors.background125,
                padding: 4.0,
                size: 24.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
