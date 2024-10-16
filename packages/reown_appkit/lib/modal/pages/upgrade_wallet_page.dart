import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/services/analytics_service/i_analytics_service.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/services/analytics_service/models/analytics_event.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/constants/string_constants.dart';
import 'package:reown_appkit/modal/widgets/buttons/simple_icon_button.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar.dart';

class UpgradeWalletPage extends StatelessWidget {
  const UpgradeWalletPage() : super(key: KeyConstants.upgradeWalletPage);

  @override
  Widget build(BuildContext context) {
    final textStyles = ReownAppKitModalTheme.getDataOf(context).textStyles;
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return ModalNavbar(
      title: 'Upgrade your Wallet',
      safeAreaBottom: true,
      safeAreaLeft: true,
      safeAreaRight: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox.square(dimension: kPadding8),
          const SizedBox.square(dimension: kPadding8),
          Text(
            'Follow the instructions on',
            style: textStyles.paragraph500.copyWith(
              color: themeColors.foreground100,
            ),
          ),
          const SizedBox.square(dimension: kPadding8),
          SimpleIconButton(
            leftIcon: 'lib/modal/assets/icons/wc.svg',
            onTap: () {
              GetIt.I<IAnalyticsService>().sendEvent(EmailUpgradeFromModal());
              ReownCoreUtils.openURL(UrlConstants.secureDashboard);
            },
            rightIcon: 'lib/modal/assets/icons/arrow_top_right.svg',
            title: Uri.parse(UrlConstants.secureDashboard).authority,
            size: BaseButtonSize.small,
            iconSize: 12.0,
            fontSize: 14.0,
          ),
          const SizedBox.square(dimension: kPadding8),
          Text(
            'You will have to reconnect for security reasons',
            style: textStyles.small400.copyWith(
              color: themeColors.foreground200,
            ),
          ),
          const SizedBox.square(dimension: kPadding8),
        ],
      ),
    );
  }
}
