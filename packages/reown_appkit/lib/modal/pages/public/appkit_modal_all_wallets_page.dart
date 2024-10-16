import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/pages/connect_wallet_page.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/services/explorer_service/i_explorer_service.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/widget_stack_singleton.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/responsive_container.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/modal/widgets/lists/wallets_grid.dart';
import 'package:reown_appkit/modal/widgets/value_listenable_builders/explorer_service_items_listener.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/all_wallets_header.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar.dart';

class ReownAppKitModalAllWalletsPage extends StatefulWidget {
  const ReownAppKitModalAllWalletsPage()
      : super(key: KeyConstants.walletListLongPageKey);

  @override
  State<ReownAppKitModalAllWalletsPage> createState() =>
      _AppKitModalAllWalletsPageState();
}

class _AppKitModalAllWalletsPageState
    extends State<ReownAppKitModalAllWalletsPage> {
  IExplorerService get _explorerService => GetIt.I<IExplorerService>();
  bool _paginating = false;
  final _controller = ScrollController();

  bool _processScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      setState(() => _paginating = false);
    } else {
      if (notification is UserScrollNotification) {
        return true;
      }
      final extent = _controller.position.maxScrollExtent * 0.9;
      final outOfRange = _controller.position.outOfRange;
      if (_controller.offset >= extent && !outOfRange) {
        if (!_paginating) {
          _paginate();
        }
      }
    }
    return true;
  }

  Future<void> _paginate() {
    setState(() => _paginating = _explorerService.canPaginate);
    return _explorerService.paginate();
  }

  @override
  Widget build(BuildContext context) {
    final service = ModalProvider.of(context).instance;
    final totalListings = _explorerService.totalListings.value;
    final rows = (totalListings / 4.0).ceil();
    final isSearchAvailable = totalListings >= kShortWalletListCount;
    final maxHeight = (rows * kGridItemHeight) +
        (kPadding16 * 4.0) +
        (isSearchAvailable ? kSearchFieldHeight : 0.0) +
        ResponsiveData.paddingBottomOf(context);
    return ModalNavbar(
      title: 'All wallets',
      onTapTitle: () => _controller.animateTo(
        0,
        duration: Duration(milliseconds: 200),
        curve: Curves.linear,
      ),
      onBack: () {
        FocusManager.instance.primaryFocus?.unfocus();
        _explorerService.search(query: null);
        widgetStack.instance.pop();
      },
      safeAreaBottom: false,
      safeAreaLeft: true,
      safeAreaRight: true,
      body: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: !isSearchAvailable
              ? maxHeight
              : min(maxHeight, ResponsiveData.maxHeightOf(context)),
        ),
        child: Column(
          children: [
            isSearchAvailable ? const AllWalletsHeader() : SizedBox.shrink(),
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: _processScrollNotification,
                child: ExplorerServiceItemsListener(
                  listen: !_paginating,
                  builder: (context, initialised, items, searching) {
                    if (!initialised || searching) {
                      return WalletsGrid(
                        paddingTop: isSearchAvailable ? 0.0 : kPadding16,
                        showLoading: true,
                        loadingCount:
                            items.isNotEmpty ? min(16, items.length) : 16,
                        scrollController: _controller,
                        itemList: [],
                      );
                    }
                    final isPortrait = ResponsiveData.isPortrait(context);
                    return WalletsGrid(
                      paddingTop: isSearchAvailable ? 0.0 : kPadding16,
                      showLoading: _paginating,
                      loadingCount: isPortrait ? 4 : 8,
                      scrollController: _controller,
                      onTapWallet: (data) async {
                        service.selectWallet(data);
                        widgetStack.instance.push(const ConnectWalletPage());
                      },
                      itemList: items,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
