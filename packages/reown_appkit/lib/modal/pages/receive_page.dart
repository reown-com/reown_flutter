import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/pages/receive_compatible_networks.dart';
import 'package:reown_appkit/modal/services/explorer_service/i_explorer_service.dart';
import 'package:reown_appkit/modal/services/toast_service/i_toast_service.dart';
import 'package:reown_appkit/modal/widgets/avatars/wallet_avatar.dart';
import 'package:reown_appkit/modal/widgets/buttons/address_button.dart';
import 'package:reown_appkit/modal/widgets/lists/list_items/account_list_item.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/widget_stack_singleton.dart';
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
    final isDarkMode =
        ReownAppKitModalTheme.maybeOf(context)?.isDarkMode ?? false;
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
              showNetwork: true,
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
            if (isDarkMode) const SizedBox.square(dimension: kPadding12),
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
                  if (isDarkMode) const SizedBox.square(dimension: kPadding16),
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
            Padding(
              padding: const EdgeInsets.only(
                left: kPadding16,
                right: kPadding16,
              ),
              child: SizedBox(
                height: 48.0,
                child: AccountListItem(
                  trailing: Container(
                    width: 110.0,
                    padding: const EdgeInsets.only(right: kPadding6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              ...(_networkIcons(context)
                                  .asMap()
                                  .entries
                                  .map((e) {
                                return Positioned(
                                  right: 15.0 * e.key,
                                  child: e.value,
                                );
                              })),
                            ],
                          ),
                        ),
                        SvgPicture.asset(
                          'lib/modal/assets/icons/chevron_right.svg',
                          package: 'reown_appkit',
                          colorFilter: ColorFilter.mode(
                            themeColors.foreground200,
                            BlendMode.srcIn,
                          ),
                          width: 18.0,
                          height: 18.0,
                        ),
                      ],
                    ),
                  ),
                  title: 'Only receive from networks',
                  titleStyle: themeData.textStyles.small400.copyWith(
                    color: themeColors.foreground200,
                  ),
                  onTap: () {
                    widgetStack.instance.push(ReceiveCompatibleNetworks());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _networkIcons(BuildContext context) {
    final appKitModal = ModalProvider.of(context).instance;
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    //
    List<Widget> buttons = [];

    final chainId = appKitModal.selectedChain!.chainId;
    final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(chainId);
    final available = appKitModal.getAvailableChains()!.where((c) {
      final ns = NamespaceUtils.getNamespaceFromChain(c);
      return namespace == ns;
    }).toList();

    final subList = available.sublist(0, min(5, available.length));
    final chainList = subList.map((c) {
      final ns = c.split(':').first;
      final cid = c.split(':').last;
      return ReownAppKitModalNetworks.getNetworkById(ns, cid);
    }).toList();

    final orderedList = [
      ...(chainList.where((e) => e!.isTestNetwork)),
      ...(chainList.where((e) => !e!.isTestNetwork)),
    ];

    for (var chainInfo in orderedList) {
      final imageId = ReownAppKitModalNetworks.getNetworkIconId(
        chainInfo!.chainId,
      );
      final imageUrl = GetIt.I<IExplorerService>().getAssetImageUrl(imageId);
      buttons.add(
        SizedBox.square(
          dimension: 20.0,
          child: ListAvatar(
            borderRadius: radiuses.radius4XS,
            imageUrl: imageUrl,
            isNetwork: true,
          ),
        ),
      );
    }
    return buttons;
  }
}
