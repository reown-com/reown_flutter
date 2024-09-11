import 'package:flutter/material.dart';

import 'package:reown_appkit/modal/pages/get_wallet_page.dart';
import 'package:reown_appkit/modal/services/analytics_service/models/analytics_event.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/widget_stack_singleton.dart';
import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/widgets/buttons/simple_icon_button.dart';
import 'package:reown_appkit/modal/widgets/help/help_section.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar.dart';

class AboutWallets extends StatelessWidget {
  const AboutWallets() : super(key: KeyConstants.helpPageKey);

  @override
  Widget build(BuildContext context) {
    return ModalNavbar(
      title: 'What is a wallet?',
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Column(
              children: [
                HelpSection(
                  title: 'One login for all of web3',
                  description:
                      'Log in to any app by connecting your wallet. Say goodbye to countless passwords!',
                  images: [
                    'lib/modal/assets/help/key.svg',
                    'lib/modal/assets/help/user.svg',
                    'lib/modal/assets/help/lock.svg',
                  ],
                ),
                HelpSection(
                  title: 'A home for your digital assets',
                  description:
                      'A wallet lets you store, send, and receive digital assets like cryptocurrencies and NFTs.',
                  images: [
                    'lib/modal/assets/help/chart.svg',
                    'lib/modal/assets/help/painting.svg',
                    'lib/modal/assets/help/eth.svg',
                  ],
                ),
                HelpSection(
                  title: 'Your gateway to a new web',
                  description:
                      'With your wallet, you can explore and interact with DeFi, NFTs, DAOS, and much more.',
                  images: [
                    'lib/modal/assets/help/compass.svg',
                    'lib/modal/assets/help/noun.svg',
                    'lib/modal/assets/help/dao.svg',
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            SimpleIconButton(
              onTap: () {
                widgetStack.instance.push(
                  const GetWalletPage(),
                  event: ClickGetWalletEvent(),
                );
              },
              leftIcon: 'lib/modal/assets/icons/wallet.svg',
              title: 'Get a wallet',
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
