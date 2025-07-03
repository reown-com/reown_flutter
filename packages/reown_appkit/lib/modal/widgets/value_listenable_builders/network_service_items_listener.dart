import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/models/grid_item.dart';

import 'package:reown_appkit/modal/models/public/appkit_network_info.dart';
import 'package:reown_appkit/modal/services/network_service/i_network_service.dart';
import 'package:reown_appkit/modal/utils/public/appkit_modal_default_networks.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';

class NetworkServiceItemsListener extends StatelessWidget {
  INetworkService get _networkService => GetIt.I<INetworkService>();
  const NetworkServiceItemsListener({
    super.key,
    required this.builder,
  });
  final Function(
    BuildContext context,
    bool initialised,
    List<GridItem<ReownAppKitModalNetworkInfo>> items,
  ) builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _networkService.initialized,
      builder: (context, bool initialised, _) {
        if (!initialised) {
          return builder(context, initialised, []);
        }
        return ValueListenableBuilder(
          valueListenable: _networkService.itemList,
          builder: (context, items, _) {
            final parsedItems = items.parseItems(context);
            return builder(context, initialised, parsedItems);
          },
        );
      },
    );
  }
}

extension on List<GridItem<ReownAppKitModalNetworkInfo>> {
  List<GridItem<ReownAppKitModalNetworkInfo>> parseItems(BuildContext context) {
    final service = ModalProvider.of(context).instance;
    final supportedChains = service.getAvailableChains();
    final allNetworks = ReownAppKitModalNetworks.getAllSupportedNetworks()
        .map((e) => e.chainId)
        .toList();
    if (supportedChains == null) {
      return this
        ..sort((a, b) {
          final disabledA = a.disabled ? 0 : 1;
          final disabledB = b.disabled ? 0 : 1;
          final testNetworkA = a.data.isTestNetwork ? 0 : 1;
          final testNetworkB = b.data.isTestNetwork ? 0 : 1;

          // First sort by disabled status, then by test network status
          if (disabledA != disabledB) {
            return disabledB.compareTo(disabledA);
          }
          if (testNetworkA != testNetworkB) {
            return testNetworkB.compareTo(testNetworkA);
          }

          // Then sort by order in allNetworks
          final indexA = allNetworks.indexOf(a.data.chainId);
          final indexB = allNetworks.indexOf(b.data.chainId);
          return indexA.compareTo(indexB);
        });
    }
    return map((item) {
      return item.copyWith(
        disabled: !supportedChains.contains(
          item.data.chainId,
        ),
      );
    }).toList()
      ..sort((a, b) {
        final disabledA = a.disabled ? 0 : 1;
        final disabledB = b.disabled ? 0 : 1;
        final testNetworkA = a.data.isTestNetwork ? 0 : 1;
        final testNetworkB = b.data.isTestNetwork ? 0 : 1;

        // First sort by disabled status, then by test network status
        if (disabledA != disabledB) {
          return disabledB.compareTo(disabledA);
        }
        if (testNetworkA != testNetworkB) {
          return testNetworkB.compareTo(testNetworkA);
        }

        // Then sort by order in allNetworks
        final indexA = allNetworks.indexOf(a.data.chainId);
        final indexB = allNetworks.indexOf(b.data.chainId);
        return indexA.compareTo(indexB);
      });
  }
}
