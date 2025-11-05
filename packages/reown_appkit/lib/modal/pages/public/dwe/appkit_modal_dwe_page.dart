import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

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
  final String? titleOverride;
  const ReownAppKitModalDepositScreen({this.titleOverride})
    : super(key: KeyConstants.depositPageKey);

  @override
  State<ReownAppKitModalDepositScreen> createState() =>
      _ReownAppKitModalDepositScreenState();
}

class _ReownAppKitModalDepositScreenState
    extends State<ReownAppKitModalDepositScreen> {
  IDWEService get _dweService => GetIt.I<IDWEService>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final appKitModal = ModalProvider.of(context).instance;
      // IF PRESELECTED ASSET
      if (_dweService.preselectedAsset != null) {
        final chainId = _dweService.preselectedAsset!.network;
        final namespace = NamespaceUtils.getNamespaceFromChain(chainId);
        final networkInfo = ReownAppKitModalNetworks.getNetworkInfo(
          namespace,
          chainId,
        );
        await appKitModal.selectChain(networkInfo);
        _dweService.selectedAsset.value = _dweService.preselectedAsset;
        // _dweService.setSupportedAssets([widget.preselectedAsset!]);
      }

      // IF NO SELECTED CHAIN
      if (appKitModal.selectedChain == null) {
        try {
          final assetChain = _dweService.supportedAssets.first.network;
          final namespace = NamespaceUtils.getNamespaceFromChain(assetChain);
          final networks = ReownAppKitModalNetworks.getAllSupportedNetworks(
            namespace: namespace,
          ).where((e) => !e.isTestNetwork);
          await appKitModal.selectChain(networks.first);
        } catch (e) {
          appKitModal.appKit!.core.logger.e('[$runtimeType] init error: $e');
        }
        try {
          final networks = ReownAppKitModalNetworks.getAllSupportedNetworks()
              .where((e) => !e.isTestNetwork);
          await appKitModal.selectChain(networks.first);
        } catch (e) {
          appKitModal.appKit!.core.logger.e('[$runtimeType] init error: $e');
          GetIt.I<IToastService>().show(
            ToastMessage(type: ToastType.error, text: 'So supported networks'),
          );
        }
      }

      final chainId = appKitModal.selectedChain?.chainId;
      debugPrint('[$runtimeType] selected chain id: $chainId');
      final supportedAssets = _dweService.getAvailableAssets(chainId: chainId);
      if (supportedAssets.isEmpty) {
        GetIt.I<IToastService>().show(
          ToastMessage(type: ToastType.error, text: 'No assets supported'),
        );
        setState(() {});
        return;
      }
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
      // _dweService.setSupportedAssets(supportedAssets);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final appKitModal = ModalProvider.of(context).instance;
    final chainId = appKitModal.selectedChain?.chainId;
    final supportedAssets = _dweService.getAvailableAssets(chainId: chainId);
    return ModalNavbar(
      title: widget.titleOverride ?? 'Deposit from Exchange',
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
              Visibility(
                visible: supportedAssets.isNotEmpty,
                child: Padding(
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
                      AssetsButton(
                        disabled:
                            _dweService.preselectedAsset != null &&
                            _dweService.supportedAssets.isEmpty,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox.square(dimension: kPadding12),
              _dweService.isCheckingStatus
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
                            _dweService.stopCheckingStatus();
                            setState(() {});
                          },
                        ),
                      ],
                    )
                  : AmountSelector(),
              const SizedBox.square(dimension: kPadding16),
              Visibility(
                visible: supportedAssets.isNotEmpty,
                child: Divider(color: themeColors.grayGlass005, height: 0.0),
              ),
              Visibility(
                visible: supportedAssets.isEmpty,
                child: Text(
                  'No assets supported for the selected network',
                  style: themeData.textStyles.paragraph400.copyWith(
                    color: themeColors.foreground100,
                  ),
                ),
              ),
              const SizedBox.square(dimension: kPadding12),
              ExchangesListWidget(
                recipient: _dweService.preselectedRecipient,
                onSelect: (Exchange exchange, GetExchangeUrlResult urlResult) {
                  setState(() {});
                  _dweService.loopOnStatusCheck(
                    exchange.id,
                    urlResult.sessionId,
                    (result) {
                      appKitModal.onDepositSuccess.broadcast(
                        DepositSuccessEvent(exchange),
                      );
                      GetIt.I<IToastService>().show(
                        ToastMessage(
                          type: result!.status == 'SUCCESS'
                              ? ToastType.success
                              : ToastType.error,
                          text: result.status,
                        ),
                      );
                      setState(() {});
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
