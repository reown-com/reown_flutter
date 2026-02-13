import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/theme/app_radius.dart';
import 'package:reown_walletkit_wallet/theme/app_spacing.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_shared_widgets.dart';

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
  final _walletKitService = GetIt.I<IWalletKitService>();

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
        final response = await _walletKitService.getPaymentOptions(request);
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
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
      ),
      padding: const EdgeInsets.only(
        left: AppSpacing.s2,
        bottom: AppSpacing.s2,
        right: AppSpacing.s2,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.s11),
          const Center(child: WalletConnectLoading(size: 120.0)),
          const SizedBox(height: AppSpacing.s6),
        ],
      ),
    );
  }
}
