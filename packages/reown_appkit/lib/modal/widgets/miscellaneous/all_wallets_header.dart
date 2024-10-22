import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/pages/public/appkit_modal_qrcode_page.dart';
import 'package:reown_appkit/modal/services/analytics_service/models/analytics_event.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/services/explorer_service/i_explorer_service.dart';
import 'package:reown_appkit/modal/widgets/icons/themed_icon.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/searchbar.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/widget_stack_singleton.dart';

class AllWalletsHeader extends StatelessWidget {
  const AllWalletsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.all(kPadding8),
      child: Row(
        children: [
          Expanded(
            child: ModalSearchBar(
              hint: 'Search wallet',
              onTextChanged: (value) {
                GetIt.I<IExplorerService>().search(query: value);
              },
              onDismissKeyboard: (clear) {
                FocusManager.instance.primaryFocus?.unfocus();
                if (clear) {
                  GetIt.I<IExplorerService>().search(query: null);
                }
              },
            ),
          ),
          const SizedBox.square(dimension: kPadding8),
          ThemedButton(
            size: kSearchFieldHeight,
            iconPath: 'lib/modal/assets/icons/code.svg',
            onPressed: () {
              widgetStack.instance.push(
                const ReownAppKitModalQRCodePage(),
                event: SelectWalletEvent(
                  name: 'WalletConnect',
                  platform: AnalyticsPlatform.qrcode,
                ),
              );
            },
          ),
          const SizedBox.square(dimension: 4.0),
        ],
      ),
    );
  }
}
