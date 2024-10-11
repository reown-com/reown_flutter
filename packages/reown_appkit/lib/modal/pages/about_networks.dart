import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';

import 'package:reown_appkit/modal/constants/string_constants.dart';
import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/widgets/buttons/simple_icon_button.dart';
import 'package:reown_appkit/modal/widgets/help/help_section.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar.dart';

class AboutNetworks extends StatelessWidget {
  const AboutNetworks() : super(key: KeyConstants.helpPageKey);

  @override
  Widget build(BuildContext context) {
    return ModalNavbar(
      title: 'What is a network?',
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Column(
              children: [
                HelpSection(
                  title: 'The system’s nuts and bolts',
                  description:
                      'A network is what brings the blockchain to life, as this technical infrastructure allows apps to access the ledger and smart contract services.',
                  images: [
                    'lib/modal/assets/help/network.svg',
                    'lib/modal/assets/help/layers.svg',
                    'lib/modal/assets/help/system.svg',
                  ],
                ),
                HelpSection(
                  title: 'Designed for different uses',
                  description:
                      'Each network is designed differently, and may therefore suit certain apps and experiences.',
                  images: [
                    'lib/modal/assets/help/noun.svg',
                    'lib/modal/assets/help/defi.svg',
                    'lib/modal/assets/help/dao.svg',
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            SimpleIconButton(
              onTap: () => ReownCoreUtils.openURL(UrlConstants.learnMoreUrl),
              rightIcon: 'lib/modal/assets/icons/arrow_top_right.svg',
              title: 'Learn more',
              size: BaseButtonSize.small,
              iconSize: 12.0,
              fontSize: 14.0,
            ),
            const SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
