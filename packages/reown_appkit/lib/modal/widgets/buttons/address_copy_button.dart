import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/modal/widgets/text/appkit_address.dart';

import 'package:reown_appkit/modal/services/toast_service/models/toast_message.dart';
import 'package:reown_appkit/modal/services/toast_service/toast_service_singleton.dart';
import 'package:reown_appkit/reown_appkit.dart';

class AddressCopyButton extends StatelessWidget {
  const AddressCopyButton({super.key});

  @override
  Widget build(BuildContext context) {
    final service = ModalProvider.of(context).instance;
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return GestureDetector(
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: service.session!.address!));
        toastService.instance.show(
          ToastMessage(type: ToastType.success, text: 'Address copied'),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Address(
            service: service,
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
            width: 20.0,
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
