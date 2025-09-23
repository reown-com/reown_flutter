import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/services/blockchain_service/i_blockchain_service.dart';
import 'package:reown_appkit/modal/services/dwe_service/dwe_service.dart';
import 'package:reown_appkit/modal/services/explorer_service/i_explorer_service.dart';
import 'package:reown_appkit/modal/widgets/buttons/base_button.dart';
import 'package:reown_appkit/modal/widgets/icons/rounded_icon.dart';
import 'package:reown_appkit/modal/widgets/lists/list_items/account_list_item.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/i_widget_stack.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar.dart';

class ReownAppKitModalDepositScreen extends StatefulWidget {
  const ReownAppKitModalDepositScreen()
    : super(key: KeyConstants.depositPageKey);

  @override
  State<ReownAppKitModalDepositScreen> createState() =>
      _ReownAppKitModalDepositScreenState();
}

class _ReownAppKitModalDepositScreenState
    extends State<ReownAppKitModalDepositScreen> {
  DWEService get _dweService => GetIt.I<DWEService>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final appKitModal = ModalProvider.of(context).instance;
      _dweService.supportedAssets.value
        ..clear()
        ..addAll(
          appKitModal.appKit!.getPaymentAssetsForNetwork(
            // chainId: appKitModal.selectedChain!.chainId, // TODO
          ),
        );
      _dweService.selectedAsset.value =
          _dweService.selectedAsset.value ??
          _dweService.supportedAssets.value.firstWhereOrNull(
            (asset) => asset.address != 'native',
          ) ??
          _dweService.supportedAssets.value.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return ModalNavbar(
      title: 'Deposit from Exchange',
      divider: false,
      body: Container(
        padding: const EdgeInsets.all(kPadding12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
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
                  AssetsButton(),
                ],
              ),
            ),
            const SizedBox.square(dimension: kPadding12),
            _AmountSelector(),
            const SizedBox.square(dimension: kPadding16),
            Divider(color: themeColors.grayGlass005, height: 0.0),
            const SizedBox.square(dimension: kPadding12),
            ExchangesListWidget(),
          ],
        ),
      ),
    );
  }
}

// ********************

class AssetsButton extends StatefulWidget {
  const AssetsButton({
    super.key,
    this.size = BaseButtonSize.regular,
    this.iconOnly = false,
    this.iconOnRight = false,
  });
  final BaseButtonSize size;
  final bool iconOnly;
  final bool iconOnRight;

  @override
  State<AssetsButton> createState() => _AssetsButtonState();
}

class _AssetsButtonState extends State<AssetsButton> {
  IWidgetStack get _widgetStack => GetIt.I<IWidgetStack>();
  DWEService get _dweService => GetIt.I<DWEService>();
  IBlockChainService get _blockchainService => GetIt.I<IBlockChainService>();

  String _getNetworkIconImage(ReownAppKitModalNetworkInfo? chainInfo) {
    if (chainInfo == null || chainInfo.isTestNetwork) return '';

    if (chainInfo.chainIcon != null && chainInfo.chainIcon!.contains('http')) {
      return chainInfo.chainIcon!;
    }
    final imageId = ReownAppKitModalNetworks.getNetworkIconId(
      chainInfo.chainId,
    );
    return GetIt.I<IExplorerService>().getAssetImageUrl(imageId);
  }

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final chainInfo = ModalProvider.of(context).instance.selectedChain;
    final networkIconUrl = _getNetworkIconImage(chainInfo);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    final borderRadius = radiuses.isSquare() ? 0.0 : widget.size.height / 2;
    return ValueListenableBuilder(
      valueListenable: _dweService.selectedAsset,
      builder: (context, selectedAsset, _) {
        if (selectedAsset == null) {
          return const SizedBox.shrink();
        }
        return FutureBuilder(
          future: _blockchainService.getFungiblePrice(
            address: selectedAsset.toCaip10(),
          ),
          builder: (context, snapshot) {
            final token = snapshot.data;
            return widget.iconOnly
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RoundedIcon(
                        assetPath: 'lib/modal/assets/icons/coin.svg',
                        imageUrl: token?.iconUrl ?? networkIconUrl,
                        size: widget.size.height * 0.7,
                        assetColor: themeColors.inverse100,
                        padding: widget.size == BaseButtonSize.small
                            ? 5.0
                            : 6.0,
                      ),
                    ],
                  )
                : BaseButton(
                    semanticsLabel: 'AppKitModalAssetButton',
                    size: widget.size,
                    onTap: () => _widgetStack.push(_SelectAssetPage()),
                    buttonStyle: ButtonStyle(
                      backgroundColor: WidgetStateProperty.resolveWith<Color>(
                        (states) => themeColors.grayGlass002,
                      ),
                      foregroundColor: WidgetStateProperty.resolveWith<Color>((
                        states,
                      ) {
                        if (states.contains(WidgetState.disabled)) {
                          return themeColors.grayGlass015;
                        }
                        return themeColors.foreground100;
                      }),
                      shape:
                          WidgetStateProperty.resolveWith<
                            RoundedRectangleBorder
                          >((states) {
                            return RoundedRectangleBorder(
                              side: BorderSide(
                                color: themeColors.grayGlass002,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(borderRadius),
                            );
                          }),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!widget.iconOnRight)
                          Row(
                            children: [
                              RoundedIcon(
                                assetPath: 'lib/modal/assets/icons/coin.svg',
                                imageUrl: token?.iconUrl ?? networkIconUrl,
                                size: widget.size.height * 0.6,
                                assetColor: themeColors.inverse100,
                                padding: widget.size == BaseButtonSize.small
                                    ? 5.0
                                    : 6.0,
                              ),
                              const SizedBox.square(dimension: 4.0),
                            ],
                          ),
                        Text(' ${selectedAsset.metadata.symbol}'),
                        if (widget.iconOnRight)
                          Row(
                            children: [
                              const SizedBox.square(dimension: 4.0),
                              RoundedIcon(
                                assetPath: 'lib/modal/assets/icons/network.svg',
                                imageUrl: token?.iconUrl ?? networkIconUrl,
                                size: widget.size.height * 0.55,
                                assetColor: themeColors.inverse100,
                                padding: widget.size == BaseButtonSize.small
                                    ? 5.0
                                    : 6.0,
                              ),
                            ],
                          ),
                      ],
                    ),
                    overridePadding:
                        WidgetStateProperty.all<EdgeInsetsGeometry>(
                          !widget.iconOnRight
                              ? const EdgeInsets.only(left: 6.0, right: 16.0)
                              : const EdgeInsets.only(left: 16.0, right: 6.0),
                        ),
                  );
          },
        );
      },
    );
  }
}

class ExchangesListWidget extends StatefulWidget {
  @override
  State<ExchangesListWidget> createState() => _ExchangesListWidgetState();
}

class _ExchangesListWidgetState extends State<ExchangesListWidget> {
  DWEService get _dweService => GetIt.I<DWEService>();

  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    final appKitModal = ModalProvider.of(context).instance;
    return ValueListenableBuilder(
      valueListenable: _dweService.selectedAsset,
      builder: (context, selectedAsset, _) {
        if (selectedAsset == null) {
          return const SizedBox.shrink();
        }
        return FutureBuilder(
          future: appKitModal.appKit!.getExchanges(
            params: GetExchangesParams(
              page: 1,
              // asset: selectedAsset, // TODO
            ),
          ),
          builder: (context, snapshot) {
            return Column(
              children: (snapshot.data?.exchanges ?? [])
                  .map(
                    (exchange) => Padding(
                      padding: const EdgeInsets.only(top: kPadding8),
                      child: AccountListItem(
                        iconWidget: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: RoundedIcon(
                            borderRadius: radiuses.isSquare() ? 0.0 : null,
                            imageUrl: exchange.imageUrl,
                            assetColor: themeColors.background100,
                          ),
                        ),
                        title: exchange.name,
                        titleStyle: themeData.textStyles.paragraph500.copyWith(
                          color: themeColors.foreground100,
                        ),
                        onTap: () async {
                          // 2 GET PAYMENT URL
                          final chainId = selectedAsset.network;
                          final namespace =
                              NamespaceUtils.getNamespaceFromChain(chainId);
                          final address = appKitModal.session!.getAddress(
                            namespace,
                          );
                          final getExchangeUrlParams = GetExchangeUrlParams(
                            exchangeId: exchange.id,
                            asset: selectedAsset,
                            amount: '1.0',
                            recipient: '${selectedAsset.network}:$address',
                          );
                          final urlResult = await appKitModal.appKit!
                              .getExchangeUrl(params: getExchangeUrlParams);
                          await ReownCoreUtils.openURL(urlResult.url);
                        },
                      ),
                    ),
                  )
                  .toList(),
            );
          },
        );
      },
    );
  }
}

class _AmountSelector extends StatefulWidget {
  @override
  State<_AmountSelector> createState() => __AmountSelectorState();
}

class __AmountSelectorState extends State<_AmountSelector> {
  DWEService get _dweService => GetIt.I<DWEService>();
  IBlockChainService get _blockchainService => GetIt.I<IBlockChainService>();
  int _selectedAmount = 10;

  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return ValueListenableBuilder(
      valueListenable: _dweService.selectedAsset,
      builder: (context, selectedAsset, _) {
        if (selectedAsset == null) {
          return const SizedBox.shrink();
        }
        return FutureBuilder(
          future: _blockchainService.getFungiblePrice(
            address: selectedAsset.toCaip10(),
          ),
          builder: (context, snapshot) {
            final token = snapshot.data;
            final amountToReceive =
                ((token?.price ?? 0.0) * _selectedAmount.toDouble());
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedAmount.toString(),
                      style: themeData.textStyles.title400.copyWith(
                        color: themeColors.foreground275,
                        fontSize: 40.0,
                      ),
                    ),
                    Text(
                      'USD',
                      style: themeData.textStyles.paragraph500.copyWith(
                        color: themeColors.foreground275,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${amountToReceive.toStringAsFixed(4)} ${selectedAsset.metadata.symbol}',
                  style: themeData.textStyles.paragraph500.copyWith(
                    color: themeColors.foreground275,
                  ),
                ),
                const SizedBox.square(dimension: kPadding16),
                Row(
                  children: [10, 50, 100].map((e) {
                    return Expanded(
                      child: _AmountButton(
                        value: e,
                        selected: _selectedAmount == e,
                        onTap: () {
                          setState(() => _selectedAmount = e);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _AmountButton extends StatelessWidget {
  final VoidCallback? onTap;
  final int value;
  final bool selected;
  const _AmountButton({
    required this.value,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: BaseButton(
        semanticsLabel: '_AmountButton',
        size: BaseButtonSize.regular,
        child: Text('\$$value'),
        onTap: selected ? null : onTap,
        buttonStyle: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.disabled)) {
              return themeColors.foreground100;
            }
            return themeColors.grayGlass002;
          }),
          foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.disabled)) {
              return themeColors.background100;
            }
            return themeColors.foreground200;
          }),
          overlayColor: WidgetStateProperty.resolveWith((states) {
            return states.contains(WidgetState.pressed)
                ? themeColors.foreground100
                : null;
          }),
          shape: WidgetStateProperty.resolveWith<RoundedRectangleBorder>((
            states,
          ) {
            return RoundedRectangleBorder(
              side: BorderSide(color: themeColors.grayGlass005, width: 1.0),
              borderRadius: radiuses.isSquare()
                  ? BorderRadius.all(Radius.zero)
                  : BorderRadius.circular(16.0),
            );
          }),
        ),
      ),
    );
  }
}

// ***************

class _SelectAssetPage extends StatefulWidget {
  const _SelectAssetPage() : super(key: KeyConstants.selectTokenPage);

  @override
  State<_SelectAssetPage> createState() => __SelectAssetPageState();
}

class __SelectAssetPageState extends State<_SelectAssetPage> {
  IWidgetStack get _widgetStack => GetIt.I<IWidgetStack>();
  DWEService get _dweService => GetIt.I<DWEService>();

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    final appKitModal = ModalProvider.of(context).instance;
    final chainId = appKitModal.selectedChain!.chainId;
    final imageId = ReownAppKitModalNetworks.getNetworkIconId(chainId);
    final chainIcon = GetIt.I<IExplorerService>().getAssetImageUrl(imageId);
    return ModalNavbar(
      title: 'Select asset',
      safeAreaLeft: true,
      safeAreaRight: true,
      safeAreaBottom: false,
      divider: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPadding12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Your tokens',
                  style: themeData.textStyles.paragraph400.copyWith(
                    color: themeColors.foreground200,
                  ),
                ),
              ),
              ..._dweService.supportedAssets.value.mapIndexed((_, asset) {
                final ns = NamespaceUtils.getNamespaceFromChain(asset.network);
                final networkInfo = ReownAppKitModalNetworks.getNetworkInfo(
                  ns,
                  asset.network,
                );
                return AccountListItem(
                  padding: const EdgeInsets.all(0.0),
                  backgroundColor: WidgetStatePropertyAll(Colors.transparent),
                  iconWidget: Padding(
                    padding: const EdgeInsets.only(left: kPadding6),
                    child: Stack(
                      children: [
                        // (_supportedAssets[index].iconUrl ?? '').isEmpty
                        //     ?
                        RoundedIcon(
                          assetPath: 'lib/modal/assets/icons/coin.svg',
                          assetColor: themeColors.inverse100,
                          borderRadius: radiuses.isSquare() ? 0.0 : null,
                        ),
                        // : ClipRRect(
                        //     borderRadius: radiuses.isSquare()
                        //         ? BorderRadius.zero
                        //         : BorderRadius.circular(34),
                        //     child: CachedNetworkImage(
                        //       imageUrl: _supportedAssets[index].iconUrl!,
                        //       height: 38,
                        //       width: 38,
                        //       errorWidget: (context, url, error) {
                        //         return RoundedIcon(
                        //           assetPath:
                        //               'lib/modal/assets/icons/coin.svg',
                        //           assetColor: themeColors.inverse100,
                        //           borderRadius: radiuses.isSquare()
                        //               ? 0.0
                        //               : null,
                        //         );
                        //       },
                        //     ),
                        //   ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: themeColors.background150,
                              borderRadius: BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                            ),
                            padding: const EdgeInsets.all(1.0),
                            clipBehavior: Clip.antiAlias,
                            child: RoundedIcon(
                              imageUrl: chainIcon,
                              padding: 2.0,
                              size: 15.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  title: asset.metadata.symbol,
                  titleStyle: themeData.textStyles.paragraph500.copyWith(
                    color: themeColors.foreground100,
                  ),
                  subtitle: '${networkInfo?.name ?? ''} (${asset.network})',
                  subtitleStyle: themeData.textStyles.small400.copyWith(
                    color: themeColors.foreground200,
                  ),
                  trailing: Row(
                    children: [
                      Text(
                        '\$1.0',
                        style: themeData.textStyles.paragraph500.copyWith(
                          color: themeColors.foreground100,
                        ),
                      ),
                      SizedBox.square(dimension: kPadding6),
                    ],
                  ),
                  onTap: () {
                    _dweService.selectAsset(asset);
                    _widgetStack.pop();
                  },
                );
              }),
              SizedBox.square(
                dimension: MediaQuery.of(context).padding.bottom + kPadding6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
