import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/services/toast_service/i_toast_service.dart';
import 'package:reown_appkit/modal/widgets/buttons/address_button.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/widgets/qr_code_view.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/responsive_container.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar.dart';
import 'package:reown_appkit/modal/services/toast_service/models/toast_message.dart';

class ReceivePage extends StatelessWidget {
  const ReceivePage() : super(key: KeyConstants.receivePageKey);

  @override
  Widget build(BuildContext context) {
    final appKitModal = ModalProvider.of(context).instance;
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final isPortrait = ResponsiveData.isPortrait(context);
    final chainId = appKitModal.selectedChain!.chainId;
    final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(
      chainId,
    );
    return ModalNavbar(
      title: 'Receive',
      divider: false,
      body: SingleChildScrollView(
        scrollDirection: isPortrait ? Axis.vertical : Axis.horizontal,
        child: Flex(
          direction: isPortrait ? Axis.vertical : Axis.horizontal,
          children: [
            AddressButton(
              service: appKitModal,
              assetPath: 'lib/modal/assets/icons/copy.svg',
              onTap: () async {
                final address = appKitModal.session!.getAddress(
                  namespace,
                )!;
                final identityName =
                    (appKitModal.blockchainIdentity?.name ?? '').isNotEmpty
                        ? appKitModal.blockchainIdentity!.name!
                        : null;

                await Clipboard.setData(ClipboardData(
                  text: identityName ?? address,
                ));
                GetIt.I<IToastService>().show(ToastMessage(
                  type: ToastType.success,
                  text: identityName != null ? 'Name copied' : 'Address copied',
                ));
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: QRCodeView(
                    uri: appKitModal.session!.getAddress(namespace)!,
                  ),
                ),
              ],
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: isPortrait
                    ? ResponsiveData.maxWidthOf(context)
                    : (ResponsiveData.maxHeightOf(context) -
                        kNavbarHeight -
                        32.0),
              ),
              padding: const EdgeInsets.only(
                left: kPadding16,
                right: kPadding16,
                bottom: kPadding16,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Copy your address or scan this QR code',
                    textAlign: TextAlign.center,
                    style: themeData.textStyles.paragraph500.copyWith(
                      color: themeColors.foreground100,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
