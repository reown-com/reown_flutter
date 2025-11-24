import 'package:flutter/material.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/utils/constants.dart';
import 'package:reown_walletkit_wallet/utils/string_constants.dart';
import 'package:reown_walletkit_wallet/widgets/custom_button.dart';
import 'package:reown_walletkit_wallet/widgets/wc_connection_request/wc_connection_request_widget.dart';

class WalletPayRequestWidget extends StatelessWidget {
  const WalletPayRequestWidget({
    super.key,
    required this.walletPayRequest,
    required this.requester,
    this.verifyContext,
    this.onAccept,
    this.onReject,
  });

  final WalletPayRequest walletPayRequest;
  final ConnectionMetadata requester;
  final VerifyContext? verifyContext;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        VerifyContextWidget(
          verifyContext: verifyContext,
        ),
        const SizedBox(height: StyleConstants.linear8),
        Flexible(
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  StyleConstants.linear8,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: StyleConstants.linear8),
                  Image.network(
                    requester.metadata.icons.first,
                    width: 80.0,
                  ),
                  const SizedBox(height: StyleConstants.linear8),
                  Text(
                    'Pay ${requester.metadata.name}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: StyleConstants.linear8),
                  WalletPayRequestDisplayData(
                    walletPayRequest: walletPayRequest,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: StyleConstants.linear16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomButton(
              onTap: onReject ??
                  () {
                    if (Navigator.canPop(context)) {
                      Navigator.of(context).pop(WCBottomSheetResult.reject);
                    }
                  },
              type: CustomButtonType.invalid,
              child: const Text(
                StringConstants.reject,
                style: StyleConstants.buttonText,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              width: StyleConstants.linear16,
            ),
            CustomButton(
              onTap: onAccept ??
                  () {
                    if (Navigator.canPop(context)) {
                      Navigator.of(context).pop(WCBottomSheetResult.one);
                    }
                  },
              type: CustomButtonType.valid,
              child: const Text(
                StringConstants.approve,
                style: StyleConstants.buttonText,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class WalletPayRequestDisplayData extends StatelessWidget {
  const WalletPayRequestDisplayData({
    super.key,
    required this.walletPayRequest,
  });
  final WalletPayRequest walletPayRequest;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DisplayData>(
      future: walletPayRequest.getDisplayData(),
      builder: (context, snapshot) {
        return Column(
          children: [
            ...?snapshot.data?.paymentOptions.asMap().entries.map((entry) {
              final index = entry.key;
              final PaymentItem item = entry.value;
              return ListTile(
                title: Text(
                    '${item.parsedData?.amount} ${item.parsedData!.assetName}'),
                subtitle: Text(item.asset),
                trailing: Icon(Icons.chevron_right_outlined),
                onTap: () async {
                  final payAction = await walletPayRequest.getPaymentAction(
                    optionIndex: index,
                  );
                  print(payAction.toJson().toString());
                },
              );
            }),
          ],
        );
      },
    );
  }
}
