import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/constants/string_constants.dart';
import 'package:reown_appkit/modal/models/grid_item.dart';

import 'package:reown_appkit/modal/models/public/appkit_network_info.dart';
import 'package:reown_appkit/modal/services/network_service/network_service_singleton.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';

class NetworkServiceItemsListener extends StatelessWidget {
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
      valueListenable: networkService.instance.initialized,
      builder: (context, bool initialised, _) {
        if (!initialised) {
          return builder(context, initialised, []);
        }
        return ValueListenableBuilder(
          valueListenable: networkService.instance.itemList,
          builder: (context, items, _) {
            final service = ModalProvider.of(context).instance;
            final supportedChains = service.getAvailableChains();
            final parsedItems = supportedChains == null
                ? items
                : items.map((e) {
                    final caip2Chain =
                        '${CoreConstants.namespace}:${e.data.chainId}';
                    return e.copyWith(
                      disabled: !supportedChains.contains(caip2Chain),
                    );
                  }).toList()
              ..sort((a, b) {
                final disabledA = a.disabled ? 0 : 1;
                final disabledB = b.disabled ? 0 : 1;
                return disabledB.compareTo(disabledA);
              });
            return builder(context, initialised, parsedItems);
          },
        );
      },
    );
  }
}
