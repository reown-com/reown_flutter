import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/services/toast_service/i_toast_service.dart';

import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/modal/widgets/text/appkit_address.dart';

import 'package:reown_appkit/modal/services/toast_service/models/toast_message.dart';
import 'package:reown_appkit/reown_appkit.dart';

class AddressCopyButton extends StatelessWidget {
  const AddressCopyButton({super.key});

  @override
  Widget build(BuildContext context) {
    final appKitModal = ModalProvider.of(context).instance;
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return GestureDetector(
      onTap: () async {
        final chainId = appKitModal.selectedChain!.chainId;
        final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(
          chainId,
        );
        final address = appKitModal.session!.getAddress(namespace)!;
        await Clipboard.setData(ClipboardData(text: address));
        GetIt.I<IToastService>().show(ToastMessage(
          type: ToastType.success,
          text: 'Address copied',
        ));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AddressText(
            appKitModal: appKitModal,
            style: themeData.textStyles.title600.copyWith(
              color: themeColors.foreground100,
            ),
          ),
          const SizedBox.square(dimension: 8.0),
          SvgPicture.asset(
            'lib/modal/assets/icons/copy.svg',
            package: 'reown_appkit',
            colorFilter: ColorFilter.mode(
              themeColors.foreground250,
              BlendMode.srcIn,
            ),
            width: 16.0,
            height: 16.0,
          ),
        ],
      ),
    );
  }
}
