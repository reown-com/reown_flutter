import 'package:flutter/material.dart';

import 'package:reown_appkit/modal/models/grid_item.dart';
import 'package:reown_appkit/modal/services/explorer_service/explorer_service_singleton.dart';
import 'package:reown_appkit/reown_appkit.dart';

class ExplorerServiceItemsListener extends StatefulWidget {
  const ExplorerServiceItemsListener({
    super.key,
    required this.builder,
    this.listen = true,
  });
  final Function(
    BuildContext context,
    bool initialised,
    List<GridItem<ReownAppKitModalWalletInfo>> items,
    bool searching,
  ) builder;
  final bool listen;

  @override
  State<ExplorerServiceItemsListener> createState() =>
      _ExplorerServiceItemsListenerState();
}

class _ExplorerServiceItemsListenerState
    extends State<ExplorerServiceItemsListener> {
  List<GridItem<ReownAppKitModalWalletInfo>> _items = [];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: explorerService.instance.initialized,
      builder: (context, initialised, _) {
        if (!initialised) {
          return widget.builder(context, initialised, [], false);
        }
        return ValueListenableBuilder<bool>(
          valueListenable: explorerService.instance.isSearching,
          builder: (context, searching, _) {
            if (searching) {
              return widget.builder(context, initialised, _items, searching);
            }
            return ValueListenableBuilder<List<ReownAppKitModalWalletInfo>>(
              valueListenable: explorerService.instance.listings,
              builder: (context, items, _) {
                if (widget.listen) {
                  _items = items.toGridItems();
                }
                return widget.builder(context, initialised, _items, false);
              },
            );
          },
        );
      },
    );
  }
}

extension on List<ReownAppKitModalWalletInfo> {
  List<GridItem<ReownAppKitModalWalletInfo>> toGridItems() {
    List<GridItem<ReownAppKitModalWalletInfo>> gridItems = [];
    for (ReownAppKitModalWalletInfo item in this) {
      gridItems.add(
        GridItem<ReownAppKitModalWalletInfo>(
          title: item.listing.name,
          id: item.listing.id,
          image: explorerService.instance.getWalletImageUrl(
            item.listing.imageId,
          ),
          data: item,
        ),
      );
    }
    return gridItems;
  }
}
