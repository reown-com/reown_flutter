import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:reown_appkit/modal/models/grid_item.dart';
import 'package:reown_appkit/modal/services/explorer_service/i_explorer_service.dart';
import 'package:reown_appkit/modal/services/network_service/i_network_service.dart';
import 'package:reown_appkit/modal/utils/render_utils.dart';
import 'package:reown_appkit/reown_appkit.dart';

class NetworkService implements INetworkService {
  IExplorerService get _explorerService => GetIt.I<IExplorerService>();

  @override
  ValueNotifier<bool> initialized = ValueNotifier<bool>(false);

  List<GridItem<ReownAppKitModalNetworkInfo>> itemListComplete = [];

  @override
  ValueNotifier<List<GridItem<ReownAppKitModalNetworkInfo>>> itemList =
      ValueNotifier<List<GridItem<ReownAppKitModalNetworkInfo>>>([]);

  String _getImageUrl(ReownAppKitModalNetworkInfo chainInfo) {
    if (chainInfo.isTestNetwork) {
      return '';
    }
    if (chainInfo.chainIcon != null && chainInfo.chainIcon!.contains('http')) {
      return chainInfo.chainIcon!;
    }
    final imageId = ReownAppKitModalNetworks.getNetworkIconId(
      chainInfo.chainId,
    );
    return _explorerService.getAssetImageUrl(imageId);
  }

  @override
  Future<void> init() async {
    if (initialized.value) {
      return;
    }

    final networks = ReownAppKitModalNetworks.getAllSupportedNetworks();
    for (var network in networks) {
      final imageUrl = _getImageUrl(network);
      itemListComplete.add(
        GridItem<ReownAppKitModalNetworkInfo>(
          image: imageUrl,
          id: network.chainId,
          title: RenderUtils.shorten(network.name),
          data: network,
        ),
      );
    }

    itemList.value = itemListComplete;

    initialized.value = true;
  }

  @override
  void filterList({String? query}) {
    if (query == null || query.isEmpty) {
      itemList.value = itemListComplete;
      return;
    }

    itemList.value = itemListComplete
        .where(
          (element) => element.title.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();
  }
}
