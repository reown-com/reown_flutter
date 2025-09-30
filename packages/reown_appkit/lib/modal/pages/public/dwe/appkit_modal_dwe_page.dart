import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_appkit/base/services/models/query_models.dart';

import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/pages/public/dwe/widgets/amount_selector.dart';
import 'package:reown_appkit/modal/pages/public/dwe/widgets/asset_button.dart';
import 'package:reown_appkit/modal/pages/public/dwe/widgets/exchanges_list.dart';
import 'package:reown_appkit/modal/services/dwe_service/i_dwe_service.dart';
import 'package:reown_appkit/modal/services/toast_service/i_toast_service.dart';
import 'package:reown_appkit/modal/services/toast_service/models/toast_message.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar.dart';

class ReownAppKitModalDepositScreen extends StatefulWidget {
  final String? recipient;
  const ReownAppKitModalDepositScreen({this.recipient})
    : super(key: KeyConstants.depositPageKey);

  @override
  State<ReownAppKitModalDepositScreen> createState() =>
      _ReownAppKitModalDepositScreenState();
}

class _ReownAppKitModalDepositScreenState
    extends State<ReownAppKitModalDepositScreen> {
  IDWEService get _dweService => GetIt.I<IDWEService>();
  bool _isLooping = false;
  bool _shouldStopLooping = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final appKitModal = ModalProvider.of(context).instance;
      if (appKitModal.selectedChain == null) {
        final netforInfo = ReownAppKitModalNetworks.getNetworkInfo(
          'eip155',
          '1',
        );
        await appKitModal.selectChain(netforInfo);
      }
      final chainId = appKitModal.selectedChain?.chainId;
      final supportedAssets = appKitModal.appKit!.getPaymentAssetsForNetwork(
        chainId: chainId,
      );
      // _dweService.supportedAssets.value = supportedAssets;
      if (_dweService.selectedAsset.value?.network != chainId) {
        _dweService.selectedAsset.value =
            supportedAssets.firstWhereOrNull(
              (asset) => asset.address != 'native',
            ) ??
            supportedAssets.first;
      } else {
        _dweService.selectedAsset.value =
            _dweService.selectedAsset.value ??
            supportedAssets.firstWhereOrNull(
              (asset) => asset.address != 'native',
            ) ??
            supportedAssets.first;
      }
      _dweService.setSupportedAssets(supportedAssets);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return ModalNavbar(
      title: 'Deposit from Exchange',
      divider: false,
      body: Container(
        padding: const EdgeInsets.only(
          left: kPadding12,
          right: kPadding12,
          bottom: kPadding12,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Row(
                  children: [
                    Text(
                      'Asset',
                      style: themeData.textStyles.large400.copyWith(
                        color: themeColors.foreground300,
                      ),
                    ),
                    Spacer(),
                    AssetsButton(),
                  ],
                ),
              ),
              const SizedBox.square(dimension: kPadding12),
              _isLooping
                  ? Column(
                      children: [
                        CircularProgressIndicator(
                          color: themeColors.foreground200,
                        ),
                        const SizedBox.square(dimension: kPadding16),
                        Text(
                          'Waiting confirmation..',
                          style: themeData.textStyles.small400.copyWith(
                            color: themeColors.foreground300,
                          ),
                        ),
                        const SizedBox.square(dimension: kPadding16),
                        SecondaryButton(
                          title: 'Stop checking',
                          onTap: () {
                            setState(() {
                              _isLooping = false;
                              _shouldStopLooping = true;
                            });
                          },
                        ),
                      ],
                    )
                  : AmountSelector(),
              const SizedBox.square(dimension: kPadding16),
              Divider(color: themeColors.grayGlass005, height: 0.0),
              const SizedBox.square(dimension: kPadding12),
              ExchangesListWidget(
                recipient: widget.recipient,
                onSelect: (exchange, urlResult) {
                  _loopOnStatusCheck(exchange.id, urlResult.sessionId, (
                    result,
                  ) {
                    GetIt.I<IToastService>().show(
                      ToastMessage(
                        type: result!.status == 'SUCCESS'
                            ? ToastType.success
                            : ToastType.error,
                        text: result.status,
                      ),
                    );
                    setState(() {});
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _loopOnStatusCheck(
    String exchangeId,
    String sessionId,
    Function(GetExchangeDepositStatusResult?) completer,
  ) async {
    if (_isLooping) return;
    _isLooping = true;
    _shouldStopLooping = false;
    int maxAttempts = 30;
    int currentAttempt = 0;

    final appKit = ModalProvider.of(context).instance.appKit!;
    while (currentAttempt < maxAttempts && !_shouldStopLooping) {
      try {
        // 4. TODO [DWE Check the status of the deposit/transaction Better to call this in a loop]
        final params = GetExchangeDepositStatusParams(
          exchangeId: exchangeId,
          sessionId: sessionId,
        );
        final response = await appKit.getExchangeDepositStatus(params: params);
        //
        if (response.status == 'UNKNOWN' || response.status == 'IN_PROGRESS') {
          currentAttempt++;
          if (currentAttempt < maxAttempts && !_shouldStopLooping) {
            // Keep trying
            await Future.delayed(Duration(seconds: 5));
          } else {
            // Max attempts reached or stopped by user, complete with appropriate status
            _isLooping = false;
            completer.call(
              _shouldStopLooping
                  ? GetExchangeDepositStatusResult(status: 'CANCELLED')
                  : GetExchangeDepositStatusResult(status: 'TIMEOUT'),
            );
            break;
          }
        } else {
          // Either SUCCESS or FAILED received
          _isLooping = false;
          completer.call(response);
          break;
        }
      } catch (e) {
        debugPrint(e.toString());
        _isLooping = false;
        completer.call(null);
        break;
      }
    }
  }
}
