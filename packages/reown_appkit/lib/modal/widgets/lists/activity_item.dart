import 'dart:ui' as ui;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/services/blockchain_service/models/wallet_activity.dart';
import 'package:reown_appkit/modal/services/explorer_service/i_explorer_service.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_theme.dart';
import 'package:reown_appkit/modal/utils/core_utils.dart';
import 'package:reown_appkit/modal/utils/public/appkit_modal_default_networks.dart';
import 'package:reown_appkit/modal/utils/render_utils.dart';
import 'package:reown_appkit/modal/widgets/icons/rounded_icon.dart';
import 'package:reown_appkit/modal/widgets/lists/list_items/base_list_item.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';

class ActivityListItem extends StatelessWidget {
  const ActivityListItem({
    super.key,
    required this.activity,
    this.onTap,
  });

  final Activity activity;
  final VoidCallback? onTap;

  Transfer? get _nft {
    final transfers = activity.transfers ?? <Transfer>[];
    return transfers.firstWhereOrNull((e) => e.nftInfo != null);
  }

  bool get _isNFT => _nft != null;

  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final appKitModal = ModalProvider.of(context).instance;
    final imageId = ReownAppKitModalNetworks.getNetworkIconId(
      appKitModal.selectedChain!.chainId,
    );
    final tokenImage = GetIt.I<IExplorerService>().getAssetImageUrl(
      imageId,
    );
    //
    final operationType = OperationType.values.firstWhere(
      (e) =>
          e.toString() == 'OperationType.${activity.metadata!.operationType}',
    );
    //
    final dateFormatter = DateFormat('d MMM');
    final minedAt = dateFormatter.format(activity.metadata!.minedAt!);
    final confirmed = activity.metadata?.status == 'confirmed';
    //
    final transfers = activity.transfers ?? <Transfer>[];
    final leftIcon = _leftIconImage(transfers);
    final rightIcon = _rightIconImage(transfers);
    final stops = _iconsStops(leftIcon, rightIcon);
    final semantics = 'ActivityListItem ${activity.id}';
    print('[$runtimeType] semanticsLabel: $semantics');
    //
    return BaseListItem(
      semanticsLabel: semantics,
      onTap: onTap,
      backgroundColor: WidgetStateProperty.all<Color>(
        themeColors.background125,
      ),
      padding: const EdgeInsets.all(0.0),
      child: Row(
        children: [
          const SizedBox.square(dimension: kPadding6),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  right: 8.0,
                  bottom: 8.0,
                ),
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Stack(
                    children: [
                      // left-side icon
                      Positioned(
                        top: 0,
                        left: 0,
                        bottom: 0,
                        right: 0,
                        child: _HalfIconImage(
                          imageUrl: leftIcon,
                          isLeft: true,
                          isNFT: _isNFT,
                          stops: stops,
                          // placeHolder:
                          //     transfers.first.fungibleInfo?.symbol ?? '',
                        ),
                      ),
                      // right-side icon
                      Positioned(
                        top: 0,
                        right: 0,
                        bottom: 0,
                        left: 0,
                        child: _HalfIconImage(
                          imageUrl: rightIcon,
                          isLeft: false,
                          isNFT: _isNFT,
                          stops: stops,
                          // placeHolder:
                          //     transfers.first.fungibleInfo?.symbol ?? '',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 6,
                right: 6,
                child: Container(
                  decoration: BoxDecoration(
                    color: themeColors.background150,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  padding: const EdgeInsets.all(1.0),
                  clipBehavior: Clip.antiAlias,
                  child: RoundedIcon(
                    imageUrl: tokenImage,
                    padding: 2.0,
                    size: 15.0,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: RoundedIcon(
                            assetPath: operationType.icon,
                            assetColor: confirmed
                                ? themeColors.success100
                                : themeColors.foreground200,
                            circleColor: confirmed
                                ? themeColors.success100.withOpacity(0.1)
                                : themeColors.grayGlass010,
                            borderColor: confirmed
                                ? themeColors.success100.withOpacity(0.15)
                                : themeColors.background150,
                            padding: 4.0,
                            size: 20.0,
                          ),
                          alignment: ui.PlaceholderAlignment.middle,
                        ),
                        TextSpan(
                          text: ' ${operationType.name}',
                          style: themeData.textStyles.paragraph500.copyWith(
                            height: 1.3,
                            color: themeColors.foreground100,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox.square(dimension: 2.0),
                  Text(
                    _subtitle(operationType),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: themeData.textStyles.small400.copyWith(
                      height: 1.3,
                      color: themeColors.foreground200,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            minedAt.toUpperCase(),
            style: themeData.textStyles.micro700.copyWith(
              color: themeColors.foreground300,
            ),
          ),
          const SizedBox.square(dimension: 8.0),
        ],
      ),
    );
  }

  String _subtitle(OperationType operationType) {
    // execute, send, trade, receive, mint
    if (_isNFT) {
      return '${_nft!.nftInfo?.name ?? ''} → '
          '${RenderUtils.truncate(activity.metadata?.sentTo ?? '')}';
    }
    //
    final transfers = activity.transfers ?? <Transfer>[];
    final transferValue1 = transfers.isNotEmpty
        ? CoreUtils.formatStringBalance(transfers.first.quantity?.numeric ?? '')
        : null;
    final transferSymbol1 =
        transfers.isNotEmpty ? transfers.first.fungibleInfo?.symbol : null;
    //
    final transferValue2 = transfers.isNotEmpty
        ? CoreUtils.formatStringBalance(transfers.last.quantity?.numeric ?? '')
        : null;
    final transferSymbol2 =
        transfers.isNotEmpty ? transfers.last.fungibleInfo?.symbol : null;
    //
    switch (operationType) {
      case OperationType.execute:
        return '$transferValue1 $transferSymbol1';
      case OperationType.trade:
        return '$transferValue1 $transferSymbol1 → '
            '$transferValue2 $transferSymbol2';
      case OperationType.send:
        return '$transferValue1 $transferSymbol1 → '
            '${RenderUtils.truncate(activity.metadata?.sentTo ?? '')}';
      case OperationType.receive:
        return '$transferValue1 $transferSymbol1 ← '
            '${RenderUtils.truncate(activity.metadata?.sentFrom ?? '')}';
      case OperationType.mint:
        return '$transferValue1 $transferSymbol1';
    }
  }

  String? _leftIconImage(List<Transfer> transfers) {
    if (_isNFT) {
      return _nft!.nftInfo?.content?.preview?.url;
    }
    if (transfers.isNotEmpty) {
      return transfers.first.fungibleInfo?.icon?.url;
    }
    return null;
  }

  String? _rightIconImage(List<Transfer> transfers) {
    if (_isNFT) {
      return _nft!.nftInfo?.content?.preview?.url;
    }
    if (transfers.isNotEmpty) {
      return transfers.last.fungibleInfo?.icon?.url;
    }
    return null;
  }

  List<double> _iconsStops(String? leftIcon, String? rightIcon) {
    return leftIcon == null
        ? [1.0, 1.0]
        : (rightIcon == null || leftIcon == rightIcon)
            ? [0.5, 0.5]
            : [0.47, 0.47];
  }
}

class ActivityListItemLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    //
    return BaseListItem(
      semanticsLabel: 'ActivityListItemLoader',
      backgroundColor: WidgetStateProperty.all<Color>(
        Colors.transparent,
      ),
      padding: const EdgeInsets.all(0.0),
      child: Row(
        children: [
          const SizedBox.square(dimension: 8.0),
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              right: 8.0,
              bottom: 8.0,
            ),
            child: AspectRatio(
              aspectRatio: 1.0,
              child: CircleAvatar(
                backgroundColor: themeColors.grayGlass010,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 12.0,
                        backgroundColor: themeColors.grayGlass010,
                      ),
                      Expanded(
                        child: Container(
                          height: 16.0,
                          margin: const EdgeInsets.only(left: 4.0),
                          decoration: BoxDecoration(
                            color: themeColors.grayGlass010,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                          ),
                          child: SizedBox(),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 16.0,
                    margin: const EdgeInsets.only(top: 4.0),
                    decoration: BoxDecoration(
                      color: themeColors.grayGlass010,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 36.0,
            height: 14.0,
            margin: const EdgeInsets.only(left: 4.0),
            decoration: BoxDecoration(
              color: themeColors.grayGlass010,
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
            ),
            child: SizedBox(),
          ),
          const SizedBox.square(dimension: 8.0),
        ],
      ),
    );
  }
}

class _HalfIconImage extends StatelessWidget {
  const _HalfIconImage({
    required this.imageUrl,
    required this.isNFT,
    required this.stops,
    required this.isLeft,
    // required this.placeHolder,
  });
  final String? imageUrl;
  final bool isNFT, isLeft;
  final List<double> stops;
  // final String placeHolder;

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          begin: isLeft ? Alignment.centerLeft : Alignment.centerRight,
          end: isLeft ? Alignment.centerRight : Alignment.centerLeft,
          colors: [Colors.white, Colors.transparent],
          stops: stops,
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstIn,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: isLeft
              ? (isNFT ? Radius.circular(8.0) : Radius.circular(100.0))
              : Radius.zero,
          bottomLeft: isLeft
              ? (isNFT ? Radius.circular(8.0) : Radius.circular(100.0))
              : Radius.zero,
          topRight: !isLeft
              ? (isNFT ? Radius.circular(8.0) : Radius.circular(100.0))
              : Radius.zero,
          bottomRight: !isLeft
              ? (isNFT ? Radius.circular(8.0) : Radius.circular(100.0))
              : Radius.zero,
        ),
        child: CachedNetworkImage(
          imageUrl: imageUrl ?? '',
          fit: BoxFit.cover,
          fadeInDuration: const Duration(milliseconds: 500),
          fadeOutDuration: const Duration(milliseconds: 500),
          errorWidget: (context, url, error) => Padding(
            padding: const EdgeInsets.all(2.0),
            child: RoundedIcon(
              size: 20.0,
              circleColor: themeColors.background275,
              borderColor: themeColors.background275,
              assetColor: themeColors.foreground200,
              padding: 10.0,
            ),
          ),
        ),
      ),
    );
  }
}

enum OperationType {
  execute,
  send,
  trade,
  receive,
  mint;

  String get name {
    switch (this) {
      case execute:
        return 'Executed';
      case send:
        return 'Sent';
      case trade:
        return 'Swapped';
      case receive:
        return 'Received';
      case mint:
        return 'Minted';
    }
  }

  String get icon {
    switch (this) {
      case execute:
        return 'lib/modal/assets/icons/checkmark.svg';
      case send:
        return 'lib/modal/assets/icons/send.svg';
      case trade:
        return 'lib/modal/assets/icons/swap_horizontal.svg';
      case receive:
        return 'lib/modal/assets/icons/receive.svg';
      case mint:
        return 'lib/modal/assets/icons/swap_vertical.svg';
    }
  }
}
