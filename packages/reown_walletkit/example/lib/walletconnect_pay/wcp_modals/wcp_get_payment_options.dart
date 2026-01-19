import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/utils/constants.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/i_walletconnect_pay_service.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_shared_widgets.dart';
import 'package:walletconnect_pay/walletconnect_pay.dart';

class WCPGetPaymentOptions extends StatefulWidget {
  const WCPGetPaymentOptions({
    super.key,
    required this.paymentLink,
    required this.accounts,
  });

  final String paymentLink;
  final List<String> accounts;

  @override
  State<WCPGetPaymentOptions> createState() => _WCPGetPaymentOptionsState();
}

class _WCPGetPaymentOptionsState extends State<WCPGetPaymentOptions> {
  final _wcPayService = GetIt.I<IWalletConnectPayService>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        final request = GetPaymentOptionsRequest(
          paymentLink: widget.paymentLink,
          accounts: widget.accounts,
          includePaymentInfo: true,
        );
        final response = await _wcPayService.getPaymentOptions(request);
        Navigator.of(context).pop(response);
      } on GetPaymentOptionsError catch (e) {
        Navigator.of(context).pop(e);
      } catch (e) {
        Navigator.of(context).pop(WCBottomSheetResult.reject.name);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(StyleConstants.linear48),
      ),
      padding: const EdgeInsets.only(
        left: StyleConstants.linear8,
        bottom: StyleConstants.linear8,
        right: StyleConstants.linear8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: StyleConstants.linear48),
          const Center(
            child: WalletConnectLoading(size: 120.0),
          ),
          // const SizedBox(height: 24.0),
          // WCModalTitle(text: 'Confirming your payment...'),
          const SizedBox(height: StyleConstants.linear24),
        ],
      ),
    );
  }
}
