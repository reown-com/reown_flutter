import 'dart:io';

import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';

import 'package:reown_appkit/modal/widgets/buttons/simple_icon_button.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/modal/widgets/lists/list_items/wallet_list_item.dart';

class DownloadWalletItem extends StatelessWidget {
  const DownloadWalletItem({
    super.key,
    required this.walletInfo,
    this.webOnly = false,
  });
  final ReownAppKitModalWalletInfo walletInfo;
  final bool webOnly;

  String get _storeUrl {
    if (webOnly) {
      return walletInfo.listing.homepage;
    }
    if (Platform.isIOS) {
      return walletInfo.listing.appStore ?? '';
    }
    if (Platform.isAndroid) {
      return walletInfo.listing.playStore ?? '';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    if (_storeUrl.isEmpty) {
      return SizedBox.shrink();
    }
    return WalletListItem(
      hideAvatar: true,
      title: 'Don\'t have ${walletInfo.listing.name}?',
      trailing: SimpleIconButton(
        onTap: () => _downloadApp(context),
        title: 'Get',
        rightIcon: 'lib/modal/assets/icons/chevron_right.svg',
        backgroundColor: Colors.transparent,
        foregroundColor: themeColors.accent100,
        size: BaseButtonSize.small,
        fontSize: 14.0,
        iconSize: 12.0,
      ),
    );
  }

  void _downloadApp(BuildContext context) {
    try {
      ReownCoreUtils.openURL(_storeUrl);
    } catch (e) {
      ModalProvider.of(context).instance.connectSelectedWallet();
    }
  }
}
