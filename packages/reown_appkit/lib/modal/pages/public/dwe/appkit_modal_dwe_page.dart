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
        if (networkInfo == null) {
          GetIt.I<IToastService>().show(
            ToastMessage(
              type: ToastType.error,
              text: 'Asset chain not supported',
            ),
          );
          setState(() {});
          return;
        }
        if (appKitModal.session != null) {
          final approvedChains = NamespaceUtils.getChainIdsFromNamespaces(
            namespaces: appKitModal.session!.namespaces!,
          );
          if (!approvedChains.contains(networkInfo.chainId)) {
            GetIt.I<IToastService>().show(
              ToastMessage(type: ToastType.error, text: 'Asset not supported'),
            );
            setState(() {});
            return;
          }
        }
        await appKitModal.selectChain(networkInfo);
        _dweService.depositAsset.value = _dweService.preselectedAsset;
      }

      // IF NO SELECTED CHAIN
      if (appKitModal.selectedChain == null) {
        final selectedAssetChain = _dweService.depositAsset.value?.network;
        if (selectedAssetChain != null) {
          final chainInfo = ReownAppKitModalNetworks.getNetworkInfo(
            selectedAssetChain,
            selectedAssetChain,
          );
          await appKitModal.selectChain(chainInfo);
        } else if (_dweService.supportedAssets.isNotEmpty) {
          final firstAssetChain = _dweService.supportedAssets.first.network;
          final chainInfo = ReownAppKitModalNetworks.getNetworkInfo(
            firstAssetChain,
            firstAssetChain,
          );
          await appKitModal.selectChain(chainInfo);
        } else {
          GetIt.I<IToastService>().show(
            ToastMessage(type: ToastType.error, text: 'No assets supported'),
          );
          setState(() {});
          return;
        }
      }

      final selectedChainId = appKitModal.selectedChain?.chainId;
      final assetChainId = _dweService.depositAsset.value?.network;
      if (assetChainId != selectedChainId) {
        final firstAsset = _dweService.supportedAssets.firstWhere(
          (e) => e.network == selectedChainId,
        );
        _dweService.depositAsset.value = firstAsset;
      }

      // if (_dweService.configuredRecipients.isEmpty) {
      //   Map<String, String> configuredRecipients = {};
      //   final namespaces = appKitModal.session?.namespaces?.keys ?? [];
      //   for (var ns in namespaces) {
      //     final address = appKitModal.session!.getAddress(ns)!;
      //     configuredRecipients[ns] = address;
      //   }
      //   appKitModal.configDeposit(configuredRecipients: configuredRecipients);
      // }

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    // final appKitModal = ModalProvider.of(context).instance;
    // final chainId = appKitModal.selectedChain?.chainId;
    // final availableAssets = _dweService.getAvailableAssets(chainId: chainId);
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
                visible:
                    _dweService.supportedAssets.isNotEmpty &&
                    _dweService.depositAssetButton,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    children: [
                      Text(
                        'Asset to deposit',
                        style: themeData.textStyles.large400.copyWith(
                          color: themeColors.foreground300,
                        ),
                      ),
                      Spacer(),
                      AssetsButton(
                        disabled: _dweService.preselectedAsset != null,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox.square(dimension: kPadding12),
              AmountSelector(),
              const SizedBox.square(dimension: kPadding16),
              Visibility(
                visible: _dweService.supportedAssets.isNotEmpty,
                child: Divider(color: themeColors.grayGlass005, height: 0.0),
              ),
              Visibility(
                visible: _dweService.supportedAssets.isEmpty,
                child: Text(
                  'No assets supported for the selected network',
                  style: themeData.textStyles.paragraph400.copyWith(
                    color: themeColors.foreground100,
                  ),
                ),
              ),
              const SizedBox.square(dimension: kPadding12),
              ExchangesListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
