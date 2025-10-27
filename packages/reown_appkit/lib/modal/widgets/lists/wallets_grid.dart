import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/services/analytics_service/models/analytics_event.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:shimmer/shimmer.dart';

import 'package:reown_appkit/modal/models/grid_item.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/widgets/lists/grid_items/wallet_grid_item.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/responsive_container.dart';

class WalletsGrid extends StatelessWidget {
  const WalletsGrid({
    super.key,
    required this.itemList,
    this.onTapWallet,
    this.showLoading = false,
    this.loadingCount = 8,
    this.scrollController,
    this.paddingTop = 0.0,
  });
  final List<GridItem<ReownAppKitModalWalletInfo>> itemList;
  final Function(ReownAppKitModalWalletInfo walletInfo)? onTapWallet;
  final bool showLoading;
  final int loadingCount;
  final ScrollController? scrollController;
  final double paddingTop;

  @override
  Widget build(BuildContext context) {
    final appKitModal = ModalProvider.of(context).instance;
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final List<Widget> children = itemList
        .map(
          (info) => SizedBox(
            child: WalletGridItem(
              onTap: () => onTapWallet?.call(info.data),
              imageUrl: info.image,
              title: info.title,
              showCheckmark: info.data.installed,
              certified: info.data.listing.badgeType == 'certified',
            ),
          ),
        )
        .toList();

    if (showLoading) {
      final offset = itemList.length % loadingCount;
      final count = offset == 0 ? 0 : loadingCount - offset;
      for (var i = 0; i < (loadingCount + count); i++) {
        children.add(
          SizedBox(
            child: Shimmer.fromColors(
              baseColor: themeColors.grayGlass100,
              highlightColor: themeColors.grayGlass025,
              child: const WalletGridItem(title: ''),
            ),
          ),
        );
      }
    }

    final itemSize = ResponsiveData.gridItemSzieOf(context);
    return GridView.builder(
      controller: scrollController,
      padding: EdgeInsets.only(
        bottom: kPadding12 + ResponsiveData.paddingBottomOf(context),
        left: kPadding6,
        right: kPadding6,
        top: paddingTop,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: ResponsiveData.gridAxisCountOf(context),
        mainAxisSpacing: kPadding12,
        crossAxisSpacing: 0.0,
        mainAxisExtent: itemSize.height,
      ),
      itemBuilder: (_, index) {
        return VisibilityListener(
          onVisible: () {
            try {
              final wallet = itemList[index];
              final event = WalletImpressionEvent(
                name: wallet.data.listing.name,
                explorerId: wallet.data.listing.id,
                view: 'AllWallets',
                walletRank: wallet.data.listing.order,
                certified: wallet.data.listing.badgeType == 'certified',
                installed: wallet.data.installed,
              );
              appKitModal.appKit!.core.events.recordEvent(event);
            } catch (_) {}
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: itemSize.width,
                    height: itemSize.height,
                    child: children[index],
                  ),
                ],
              ),
            ],
          ),
        );
      },
      itemCount: children.length,
    );
  }
}

/// A lightweight visibility listener that triggers [onVisible]
/// once when the widget becomes visible within the viewport.
// TODO move from here if used somewhere else
class VisibilityListener extends StatefulWidget {
  const VisibilityListener({
    super.key,
    required this.child,
    this.onVisible,
    this.fireOnce = true,
  });

  final Widget child;
  final VoidCallback? onVisible;
  final bool fireOnce;

  @override
  State<VisibilityListener> createState() => _VisibilityListenerState();
}

class _VisibilityListenerState extends State<VisibilityListener> {
  bool _fired = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _checkVisibility();
      }
    });
  }

  void _checkVisibility() {
    if (_fired && widget.fireOnce) return;

    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) return;

    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final screen = MediaQuery.of(context).size;

    final fullyVisible =
        offset.dy >= 0 &&
        offset.dy + size.height <= screen.height &&
        offset.dx >= 0 &&
        offset.dx + size.width <= screen.width;

    if (fullyVisible) {
      widget.onVisible?.call();
      if (widget.fireOnce) _fired = true;
    } else {
      // Re-check next frame if not yet visible
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _checkVisibility();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
