import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:reown_appkit/modal/theme/public/appkit_modal_theme.dart';
import 'package:reown_appkit/modal/utils/asset_util.dart';
import 'package:reown_appkit/modal/widgets/lists/list_items/base_list_item.dart';
import 'package:reown_appkit/modal/widgets/lists/list_items/wallet_item_chip.dart';

class WalletConnectItem extends StatelessWidget {
  const WalletConnectItem({
    super.key,
    this.onTap,
  });
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return BaseListItem(
      onTap: onTap,
      child: Row(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return SvgPicture.asset(
                AssetUtils.getThemedAsset(context, 'logo_walletconnect.svg'),
                package: 'reown_appkit',
                height: constraints.maxHeight,
                width: constraints.maxHeight,
              );
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                'WalletConnect',
                style: themeData.textStyles.paragraph500.copyWith(
                  color: themeColors.foreground100,
                ),
              ),
            ),
          ),
          WalletItemChip(
            value: ' QR CODE ',
            color: themeColors.accenGlass015,
            textStyle: themeData.textStyles.micro700.copyWith(
              color: themeColors.accent100,
            ),
          ),
        ],
      ),
    );
  }
}
