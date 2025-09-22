import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_appkit/base/services/models/query_models.dart';

import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/models/send_data.dart';
import 'package:reown_appkit/modal/pages/select_token_page.dart';
import 'package:reown_appkit/modal/services/analytics_service/i_analytics_service.dart';
import 'package:reown_appkit/modal/services/blockchain_service/i_blockchain_service.dart';
import 'package:reown_appkit/modal/services/blockchain_service/models/token_balance.dart';
import 'package:reown_appkit/modal/services/explorer_service/i_explorer_service.dart';
import 'package:reown_appkit/modal/utils/core_utils.dart';
import 'package:reown_appkit/modal/widgets/buttons/base_button.dart';
import 'package:reown_appkit/modal/widgets/icons/rounded_icon.dart';
import 'package:reown_appkit/modal/widgets/lists/list_items/account_list_item.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/i_widget_stack.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar.dart';

final assetSelectedController = StreamController<ExchangeAsset>.broadcast();
Stream<ExchangeAsset> get assetSelected => assetSelectedController.stream;

class ReownAppKitModalDepositScreen extends StatefulWidget {
  const ReownAppKitModalDepositScreen()
    : super(key: KeyConstants.depositPageKey);

  @override
  State<ReownAppKitModalDepositScreen> createState() =>
      _ReownAppKitModalDepositScreenState();
}

class _ReownAppKitModalDepositScreenState
    extends State<ReownAppKitModalDepositScreen>
    with WidgetsBindingObserver {
  IBlockChainService get _blockchainService => GetIt.I<IBlockChainService>();
  IAnalyticsService get _analyticsService => GetIt.I<IAnalyticsService>();
  IWidgetStack get _widgetStack => GetIt.I<IWidgetStack>();

  // final _amountController = TextEditingController();
  // final _addressController = TextEditingController();
  // var _sendData = SendData();
  ExchangeAsset? _selectedAsset;
  // late final TokenBalance? _networkToken;

  int _selectedAmount = 10;

  @override
  void initState() {
    super.initState();
    assetSelected.last.then((value) {
      print(value);
    });
    assetSelected.listen((value) {
      setState(() {
        _selectedAsset = value;
      });
    });
    // final cachedTokens = _blockchainService.tokensList ?? <TokenBalance>[];
    // _selectedAsset = _blockchainService.selectedSendToken ?? cachedTokens.last;
    // final namespace = NamespaceUtils.getNamespaceFromChain(
    //   _selectedAsset.chainId!,
    // );

    // // TODO check this
    // if (namespace == 'eip155') {
    //   _networkToken = cachedTokens.firstWhereOrNull(
    //     (element) =>
    //         element.address == null &&
    //         element.chainId == _selectedAsset.chainId,
    //   );
    // } else {
    //   _networkToken = TokenBalance.fromJson(_selectedAsset.toJson());
    // }

    // _amountController.addListener(() {
    //   _sendData = _sendData.copyWith(amount: _amountController.text);
    //   setState(() {});
    // });
    // _addressController.addListener(() {
    //   _sendData = _sendData.copyWith(address: _addressController.text);
    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    // final appKitModal = ModalProvider.of(context).instance;
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    // final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    // final tokenPrice = (_selectedAsset.price ?? 0.0);
    // final tokenAmount = tokenPrice * _selectedAmount.toDouble();
    // 1. [DWE Get supported assets on the given chainId (CAIP-2) Null value will return all supported assets in all networks]
    // final supportedAssets = appKitModal.appKit!.getPaymentAssetsForNetwork(
    //   chainId: appKitModal.selectedChain!.chainId,
    // );
    // _selectedAsset = supportedAssets.first;
    // print(supportedAssets);
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
                  AssetsButton(
                    onAssetSelect: (asset) async {
                      // try {
                      //   final tokenPrice = await _blockchainService
                      //       .getFungiblePrice(addresses: [asset.toCaip19()]);
                      //   print(tokenPrice);
                      // } catch (e) {}
                      // setState(() {
                      //   _selectedAsset = asset;
                      // });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox.square(dimension: kPadding12),
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
              '${123.0.toStringAsFixed(4)} ${_selectedAsset?.metadata.symbol}',
              style: themeData.textStyles.paragraph500.copyWith(
                color: themeColors.foreground275,
              ),
            ),
            const SizedBox.square(dimension: kPadding16),
            Row(
              children: [
                Expanded(
                  child: AmountSelectorChip(
                    value: 10,
                    selected: _selectedAmount == 10,
                    callback: () {
                      setState(() {
                        _selectedAmount = 10;
                      });
                    },
                  ),
                ),
                const SizedBox.square(dimension: kPadding8),
                Expanded(
                  child: AmountSelectorChip(
                    value: 50,
                    selected: _selectedAmount == 50,
                    callback: () {
                      setState(() {
                        _selectedAmount = 50;
                      });
                    },
                  ),
                ),
                const SizedBox.square(dimension: kPadding8),
                Expanded(
                  child: AmountSelectorChip(
                    value: 100,
                    selected: _selectedAmount == 100,
                    callback: () {
                      setState(() {
                        _selectedAmount = 100;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox.square(dimension: kPadding16),
            Divider(color: themeColors.grayGlass005, height: 0.0),
            const SizedBox.square(dimension: kPadding12),
            ExchangesListWidget(
              selectedAsset: _selectedAsset,
              onTapExchange: (Exchange exchange) async {
                // 2 GET PAYMENT URL
                final appKitModal = ModalProvider.of(context).instance;
                final chainId = _selectedAsset!.network;
                final namespace = NamespaceUtils.getNamespaceFromChain(chainId);
                final address = appKitModal.session!.getAddress(namespace);
                final getExchangeUrlParams = GetExchangeUrlParams(
                  exchangeId: exchange.id,
                  asset: _selectedAsset!,
                  amount: '1.0',
                  recipient: '${_selectedAsset!.network}:$address',
                );
                final urlResult = await appKitModal.appKit!.getExchangeUrl(
                  params: getExchangeUrlParams,
                );
                await ReownCoreUtils.openURL(urlResult.url);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AmountSelectorChip extends StatelessWidget {
  const AmountSelectorChip({
    super.key,
    required this.value,
    required this.selected,
    required this.callback,
  });
  final int value;
  final bool selected;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return AmountButton(title: '\$$value', onTap: selected ? null : callback);
  }
}

class AmountButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool loading;
  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final BaseButtonSize buttonSize;
  const AmountButton({
    super.key,
    required this.title,
    this.onTap,
    this.loading = false,
    this.color,
    this.borderRadius,
    this.buttonSize = BaseButtonSize.regular,
  });

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    return BaseButton(
      semanticsLabel: 'AmountButton',
      size: buttonSize,
      child: loading
          ? SizedBox(
              height: BaseButtonSize.big.height * 0.4,
              width: BaseButtonSize.big.height * 0.4,
              child: CircularProgressIndicator(
                color: themeColors.accent100,
                strokeWidth: 2.0,
              ),
            )
          : Text(title),
      onTap: loading ? null : onTap,
      buttonStyle: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) {
            return themeColors.foreground100;
          }
          return color ?? themeColors.grayGlass002;
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
            borderRadius:
                borderRadius ??
                (radiuses.isSquare()
                    ? BorderRadius.all(Radius.zero)
                    : BorderRadius.circular(16.0)),
          );
        }),
      ),
    );
  }
}

class AssetsButton extends StatefulWidget {
  const AssetsButton({
    super.key,
    required this.onAssetSelect,
    this.size = BaseButtonSize.regular,
    this.iconOnly = false,
    this.iconOnRight = false,
  });
  final BaseButtonSize size;
  final bool iconOnly;
  final bool iconOnRight;
  final Function(ExchangeAsset) onAssetSelect;

  @override
  State<AssetsButton> createState() => _AssetsButtonState();
}

class _AssetsButtonState extends State<AssetsButton> {
  IWidgetStack get _widgetStack => GetIt.I<IWidgetStack>();
  final List<ExchangeAsset> _supportedAssets = [];
  ExchangeAsset? _selectedAsset;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final appKitModal = ModalProvider.of(context).instance;
      _supportedAssets
        ..clear()
        ..addAll(
          appKitModal.appKit!.getPaymentAssetsForNetwork(
            chainId: appKitModal.selectedChain!.chainId,
          ),
        );
      _selectedAsset =
          _supportedAssets.firstWhereOrNull(
            (asset) => asset.address != 'native',
          ) ??
          _supportedAssets.first;
      // widget.onAssetSelect.call(_selectedAsset!);
      assetSelectedController.sink.add(_selectedAsset!);
    });
  }

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
    if (_selectedAsset == null) {
      return const SizedBox.shrink();
    }
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final chainInfo = ModalProvider.of(context).instance.selectedChain;
    final networkIconUrl = _getNetworkIconImage(chainInfo);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    final borderRadius = radiuses.isSquare() ? 0.0 : widget.size.height / 2;
    return widget.iconOnly
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RoundedIcon(
                assetPath: 'lib/modal/assets/icons/coin.svg',
                // imageUrl: _selectedAsset?.iconUrl ?? imageUrl,
                imageUrl: networkIconUrl,
                size: widget.size.height * 0.7,
                assetColor: themeColors.inverse100,
                padding: widget.size == BaseButtonSize.small ? 5.0 : 6.0,
              ),
            ],
          )
        : BaseButton(
            semanticsLabel: 'AppKitModalAssetButton',
            size: widget.size,
            onTap: () async {
              final response = await _widgetStack.push(SelectAssetPage());
              await Future.delayed(Duration(milliseconds: 1000));
              // setState(() {
              //   _selectedAsset = response as ExchangeAsset;
              // });
              // widget.onAssetSelect.call(response);
              assetSelectedController.sink.add(response);
            },
            buttonStyle: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color>(
                (states) => themeColors.grayGlass002,
              ),
              foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                if (states.contains(WidgetState.disabled)) {
                  return themeColors.grayGlass015;
                }
                return themeColors.foreground100;
              }),
              shape: WidgetStateProperty.resolveWith<RoundedRectangleBorder>((
                states,
              ) {
                return RoundedRectangleBorder(
                  side: BorderSide(color: themeColors.grayGlass002, width: 1.0),
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
                        // imageUrl: _selectedAsset?.iconUrl ?? imageUrl,
                        imageUrl: networkIconUrl,
                        size: widget.size.height * 0.6,
                        assetColor: themeColors.inverse100,
                        padding: widget.size == BaseButtonSize.small
                            ? 5.0
                            : 6.0,
                      ),
                      const SizedBox.square(dimension: 4.0),
                    ],
                  ),
                Text(' ${_selectedAsset!.metadata.symbol}'),
                if (widget.iconOnRight)
                  Row(
                    children: [
                      const SizedBox.square(dimension: 4.0),
                      RoundedIcon(
                        assetPath: 'lib/modal/assets/icons/network.svg',
                        // imageUrl: _selectedAsset?.iconUrl ?? imageUrl,
                        imageUrl: networkIconUrl,
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
            overridePadding: WidgetStateProperty.all<EdgeInsetsGeometry>(
              !widget.iconOnRight
                  ? const EdgeInsets.only(left: 6.0, right: 16.0)
                  : const EdgeInsets.only(left: 16.0, right: 6.0),
            ),
          );
  }
}

class ExchangesListWidget extends StatefulWidget {
  const ExchangesListWidget({
    super.key,
    required this.onTapExchange,
    required this.selectedAsset,
  });
  final Function(Exchange) onTapExchange;
  final ExchangeAsset? selectedAsset; // CAIP-19 token address

  @override
  State<ExchangesListWidget> createState() => _ExchangesListWidgetState();
}

class _ExchangesListWidgetState extends State<ExchangesListWidget> {
  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    final appKitModal = ModalProvider.of(context).instance;
    return FutureBuilder(
      future: appKitModal.appKit!.getExchanges(
        params: GetExchangesParams(page: 1, asset: widget.selectedAsset),
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
                    onTap: () => widget.onTapExchange.call(exchange),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

// ********************

class SelectAssetPage extends StatefulWidget {
  const SelectAssetPage() : super(key: KeyConstants.selectTokenPage);

  @override
  State<SelectAssetPage> createState() => _SelectAssetPageState();
}

class _SelectAssetPageState extends State<SelectAssetPage> {
  IBlockChainService get _blockchainService => GetIt.I<IBlockChainService>();
  IWidgetStack get _widgetStack => GetIt.I<IWidgetStack>();

  final List<ExchangeAsset> _supportedAssets = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final appKitModal = ModalProvider.of(context).instance;
      _supportedAssets
        ..clear()
        ..addAll(
          appKitModal.appKit!.getPaymentAssetsForNetwork(
            chainId: appKitModal.selectedChain!.chainId,
          ),
        );
      setState(() {});
    });
  }

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
            ..._supportedAssets.mapIndexed((index, token) {
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
                title: _supportedAssets[index].metadata.name,
                titleStyle: themeData.textStyles.paragraph500.copyWith(
                  color: themeColors.foreground100,
                ),
                subtitle: '0.0 ${_supportedAssets[index].metadata.symbol}',
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
                  // _blockchainService.selectSendToken(token);
                  // widget.onSelect.call();
                  _widgetStack.pop(_supportedAssets[index]);
                },
              );
            }),
            SizedBox.square(
              dimension: MediaQuery.of(context).padding.bottom + kPadding6,
            ),
          ],
        ),
      ),
    );
  }
}
