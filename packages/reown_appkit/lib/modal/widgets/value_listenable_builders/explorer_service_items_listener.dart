import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:reown_appkit/modal/models/grid_item.dart';
import 'package:reown_appkit/modal/services/explorer_service/i_explorer_service.dart';
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
  IExplorerService get _explorerService => GetIt.I<IExplorerService>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _explorerService.initialized,
      builder: (context, initialised, _) {
        if (!initialised) {
          return widget.builder(context, initialised, [], false);
        }
        return ValueListenableBuilder<bool>(
          valueListenable: _explorerService.isSearching,
          builder: (context, searching, _) {
            if (searching) {
              return widget.builder(context, initialised, _items, searching);
            }
            return ValueListenableBuilder<List<ReownAppKitModalWalletInfo>>(
              valueListenable: _explorerService.listings,
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
          image: GetIt.I<IExplorerService>().getWalletImageUrl(
            item.listing.imageId,
          ),
          data: item,
        ),
      );
    }
    return gridItems;
  }
}
