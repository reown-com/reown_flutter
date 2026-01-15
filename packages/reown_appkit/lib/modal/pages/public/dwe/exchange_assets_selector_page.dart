import 'dart:async' show Timer;

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/pages/public/dwe/payment_process_page.dart';
import 'package:reown_appkit/modal/services/blockchain_service/models/token_balance.dart';
import 'package:reown_appkit/modal/services/dwe_service/i_dwe_service.dart';
import 'package:reown_appkit/modal/services/explorer_service/i_explorer_service.dart';
import 'package:reown_appkit/modal/services/transfers/i_transfers_service.dart';
import 'package:reown_appkit/modal/services/transfers/models/quote_models.dart';
import 'package:reown_appkit/modal/services/transfers/models/quote_params.dart';
import 'package:reown_appkit/modal/utils/core_utils.dart';
import 'package:reown_appkit/modal/widgets/buttons/base_button.dart';
import 'package:reown_appkit/modal/widgets/icons/rounded_icon.dart';
import 'package:reown_appkit/modal/widgets/lists/list_items/account_list_item.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/responsive_container.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/i_widget_stack.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:shimmer/shimmer.dart';

class ExchangeAssetsSelectorPage extends StatefulWidget {
  final Exchange exchange;
  const ExchangeAssetsSelectorPage({required this.exchange})
    : super(key: KeyConstants.exchangeAssetsSelectorPage);

  @override
  State<ExchangeAssetsSelectorPage> createState() =>
      _ExchangeAssetsSelectorPageState();
}

class _ExchangeAssetsSelectorPageState
    extends State<ExchangeAssetsSelectorPage> {
  IDWEService get _dweService => GetIt.I<IDWEService>();
  ITransfersService get _transferService => GetIt.I<ITransfersService>();

  final List<ExchangeAsset> exchangeAssets = [];
  final _selectedExchangeAsset = ValueNotifier<ExchangeAsset?>(null);
  bool _loadingQuote = false;
  Quote? _quoteResult;

  @override
  void initState() {
    super.initState();
    _selectedExchangeAsset.addListener(_onAssetChange);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final result = await _transferService.getExchangeAssets(
        exchange: widget.exchange.id,
      );
      final allAssets = result.assets.values.expand((e) => e).toList();
      final selectedAsset = _dweService.depositAsset.value!;

      // WE DON'T CURRENTLY SUPPORT SAME-CHAIN SWAPS
      // SO WE REMOVE THE TOKENS THAT WOULD TRIGGER IT
      allAssets.removeWhere((asset) {
        return asset.network == selectedAsset.network &&
            asset.address != selectedAsset.address;
      });

      exchangeAssets
        ..clear()
        ..addAll(allAssets);

      _selectedExchangeAsset.value = exchangeAssets.first;
    });
  }

  Future<void> _onAssetChange() async {
    if (_selectedExchangeAsset.value == null) {
      return;
    }

    setState(() => _loadingQuote = true);
    final appKitModal = ModalProvider.of(context).instance;
    try {
      final sourceAsset = _selectedExchangeAsset.value!;
      final toAsset = _dweService.depositAsset.value!;
      final toNS = NamespaceUtils.getNamespaceFromChain(toAsset.network);
      final configuredRecipient = _dweService.configuredRecipients[toNS];
      final connectedAddress = appKitModal.session?.getAddress(toNS);
      final finalRecipient = configuredRecipient ?? connectedAddress;
      if (finalRecipient == null) {
        appKitModal.onModalError.broadcast(ModalError('No recipient found'));
        _selectedExchangeAsset.value = null;
        setState(() => _loadingQuote = false);
        return;
      }
      final depositAmountInAsset = '${_dweService.depositAmountInAsset.value}';
      final params = GetQuoteParams(
        sourceToken: sourceAsset,
        toToken: toAsset,
        recipient: finalRecipient,
        amount: depositAmountInAsset,
        // Only when a wallet is connected and top up from wallet is happening, which is not implemented
        // address: connectedAddress,
      );
      _quoteResult = await _transferService.getQuote(params: params);
      setState(() {});
    } on StateError catch (e) {
      appKitModal.onModalError.broadcast(ModalError(e.message));
      _quoteResult = null;
      _selectedExchangeAsset.value = null;
    } on ArgumentError catch (e) {
      appKitModal.onModalError.broadcast(ModalError(e.message));
      _quoteResult = null;
      _selectedExchangeAsset.value = null;
    }
    setState(() => _loadingQuote = false);
  }

  @override
  void dispose() {
    _selectedExchangeAsset.removeListener(_onAssetChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    return ModalNavbar(
      title: '',
      titleOverride: Center(child: _TitleButton()),
      safeAreaLeft: true,
      safeAreaRight: true,
      safeAreaBottom: false,
      divider: false,
      body: Container(
        constraints: BoxConstraints(
          maxHeight: ResponsiveData.maxHeightOf(context),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPadding12),
              child: Row(
                children: [
                  Text(
                    'Paying with',
                    style: themeData.textStyles.paragraph400.copyWith(
                      color: themeColors.foreground200,
                    ),
                  ),
                  Spacer(),
                  _ShimmerWidget(
                    enabled: _loadingQuote,
                    child: Text(
                      _quoteResult.formattedAmount(),
                      style: themeData.textStyles.paragraph400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox.square(dimension: kPadding12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(kPadding12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(radiuses.radiusS),
                  ),
                  border: Border.fromBorderSide(
                    BorderSide(
                      color: themeColors.grayGlass002,
                      width: 2.0,
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                  ),
                  color: themeColors.grayGlass005,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CHOOSE PAYMENT OPTION',
                      style: themeData.textStyles.tiny400.copyWith(
                        color: themeColors.foreground200,
                      ),
                    ),
                    SizedBox.square(dimension: kPadding12),
                    Expanded(
                      child: _AssetOptionsList(
                        exchangeAssets: exchangeAssets,
                        selectedExchangeAsset: _selectedExchangeAsset.value,
                        onSelectAsset: (ExchangeAsset a) {
                          _selectedExchangeAsset.value = a;
                        },
                      ),
                    ),
                    //
                    SizedBox.square(dimension: kPadding12),
                    _PaymentDetails(
                      quoteResult: _quoteResult,
                      loadingQuote: _loadingQuote,
                    ),
                    SizedBox.square(dimension: kPadding12),
                    Divider(color: themeColors.grayGlass005, height: 0.0),
                    SizedBox.square(dimension: kPadding12),
                    Row(
                      children: [
                        Expanded(
                          child: PrimaryButton(
                            title: 'Continue in ${widget.exchange.name}',
                            loading: _loadingQuote,
                            onTap: _selectedExchangeAsset.value != null
                                ? () {
                                    GetIt.I<IWidgetStack>().push(
                                      PaymentProcessPage(
                                        quoteResult: _quoteResult!,
                                        exchange: widget.exchange,
                                      ),
                                    );
                                  }
                                : null,
                          ),
                        ),
                      ],
                    ),
                    SizedBox.square(
                      dimension:
                          MediaQuery.of(context).padding.bottom + kPadding6,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AssetOptionsList extends StatefulWidget {
  const _AssetOptionsList({
    required this.exchangeAssets,
    required this.selectedExchangeAsset,
    required this.onSelectAsset,
  });
  final List<ExchangeAsset> exchangeAssets;
  final ExchangeAsset? selectedExchangeAsset;
  final Function(ExchangeAsset) onSelectAsset;

  @override
  State<_AssetOptionsList> createState() => _AssetOptionsListState();
}

class _AssetOptionsListState extends State<_AssetOptionsList> {
  IDWEService get _dweService => GetIt.I<IDWEService>();
  Timer? _fetchPriceTimer;

  @override
  void initState() {
    super.initState();
    _fetchPriceTimer ??= Timer.periodic(
      Duration(seconds: 10),
      _fetchTokenPrice,
    );
  }

  void _fetchTokenPrice(_) => setState(() {});

  @override
  void deactivate() {
    _fetchPriceTimer?.cancel();
    _fetchPriceTimer = null;
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radiuses.radiusS)),
        border: Border.fromBorderSide(
          BorderSide(
            color: themeColors.grayGlass002,
            width: 2.0,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
        color: themeColors.grayGlass005,
      ),
      padding: const EdgeInsets.all(kPadding6),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: widget.exchangeAssets.isEmpty,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Center(
                  child: Text('No assets supported for this network'),
                ),
              ),
            ),
            ...widget.exchangeAssets.mapIndexed((_, asset) {
              final networkInfo = ReownAppKitModalNetworks.getNetworkInfo(
                asset.network,
                asset.network,
              );
              final chainIcon = GetIt.I<IExplorerService>().getChainIcon(
                networkInfo,
              );
              return FutureBuilder(
                future: _dweService.getFungiblePrice(
                  asset: asset,
                  forceFetch: asset.isNative(),
                ),
                builder: (context, snapshot) {
                  return AccountListItem(
                    padding: const EdgeInsets.all(0.0),
                    backgroundColor: WidgetStatePropertyAll(Colors.transparent),
                    iconWidget: Padding(
                      padding: const EdgeInsets.only(left: kPadding6),
                      child: Stack(
                        children: [
                          RoundedIcon(
                            assetPath: 'lib/modal/assets/icons/coin.svg',
                            imageUrl: snapshot.data?.iconUrl,
                            assetColor: themeColors.inverse100,
                            borderRadius: radiuses.isSquare() ? 0.0 : null,
                          ),
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
                                size: 16.0,
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
                    onTap: () => widget.onSelectAsset.call(asset),
                    trailing: Visibility(
                      visible:
                          widget.selectedExchangeAsset?.address ==
                          asset.address,
                      child: Padding(
                        padding: const EdgeInsets.only(right: kPadding6),
                        child: Icon(Icons.check, color: Colors.green),
                      ),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _PaymentDetails extends StatelessWidget {
  const _PaymentDetails({
    required this.quoteResult,
    required this.loadingQuote,
  });
  final bool loadingQuote;
  final Quote? quoteResult;

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kPadding12,
            vertical: kPadding6,
          ),
          child: Row(
            children: [
              Text(
                'Pay',
                style: themeData.textStyles.small400.copyWith(
                  color: themeColors.foreground200,
                ),
              ),
              Spacer(),
              _ShimmerWidget(
                enabled: loadingQuote,
                child: Text(
                  quoteResult.formattedAmount(),
                  style: themeData.textStyles.small400,
                ),
              ),
            ],
          ),
        ),
        ...(quoteResult?.fees ?? []).map((fee) {
          final networkInfo = ReownAppKitModalNetworks.getNetworkInfo(
            fee.currency.network,
            fee.currency.network,
          );
          final chainIcon = GetIt.I<IExplorerService>().getChainIcon(
            networkInfo,
          );
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kPadding12,
              vertical: kPadding6,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Text(
                      fee.label,
                      style: themeData.textStyles.small400.copyWith(
                        color: themeColors.foreground200,
                      ),
                    ),
                    Spacer(),
                    _ShimmerWidget(
                      enabled: loadingQuote,
                      child: Text(
                        fee.formattedFee,
                        style: themeData.textStyles.small400,
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: fee.label.toLowerCase() == 'network fee',
                  child: _ShimmerWidget(
                    enabled: loadingQuote,
                    height: 16.0,
                    width: 60.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        RoundedIcon(
                          imageUrl: chainIcon,
                          padding: 0.0,
                          size: 13.0,
                        ),
                        Text(
                          ' ${networkInfo?.name ?? 'Unknown'}',
                          style: themeData.textStyles.micro600.copyWith(
                            fontWeight: FontWeight.w400,
                            color: themeColors.foreground200,
                            fontSize: 11.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

class _ShimmerWidget extends StatelessWidget {
  final Widget child;
  final bool enabled;
  final double width, height;
  const _ShimmerWidget({
    required this.child,
    required this.enabled,
    this.width = 100.0,
    this.height = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return child;
    }
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    return Shimmer.fromColors(
      baseColor: themeColors.foreground100,
      highlightColor: themeColors.background300,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radiuses.radiusS)),
          border: Border.fromBorderSide(
            BorderSide(
              color: themeColors.grayGlass002,
              width: 2.0,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
          color: themeColors.grayGlass005,
        ),
      ),
    );
  }
}

class _TitleButton extends StatefulWidget {
  @override
  State<_TitleButton> createState() => __TitleButtonState();
}

class __TitleButtonState extends State<_TitleButton> {
  IDWEService get _dweService => GetIt.I<IDWEService>();
  Timer? _fetchPriceTimer;

  @override
  void initState() {
    super.initState();
    _fetchPriceTimer ??= Timer.periodic(
      Duration(seconds: 10),
      _fetchTokenPrice,
    );
    _fetchTokenPrice(_fetchPriceTimer);
  }

  TokenBalance? _fungible;
  Future<void> _fetchTokenPrice(_) async {
    final selectedAsset = _dweService.depositAsset.value!;
    _fungible = await _dweService.getFungiblePrice(
      asset: selectedAsset,
      forceFetch: selectedAsset.isNative(),
    );
    setState(() {});
  }

  @override
  void deactivate() {
    _fetchPriceTimer?.cancel();
    _fetchPriceTimer = null;
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    if (_fungible == null) {
      return SizedBox.shrink();
    }
    final networkInfo = ReownAppKitModalNetworks.getNetworkInfo(
      _fungible!.chainId!,
      _fungible!.chainId!,
    );
    final selectedAsset = _dweService.depositAsset.value!;
    return BaseButton(
      semanticsLabel: '${runtimeType}_title_button',
      size: BaseButtonSize.small,
      buttonStyle: _buttonStyle,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              RoundedIcon(
                assetPath: 'lib/modal/assets/icons/coin.svg',
                imageUrl: _fungible!.iconUrl,
                size: BaseButtonSize.small.height * 0.6,
                assetColor: themeColors.inverse100,
                padding: 5.0,
              ),
              const SizedBox.square(dimension: 4.0),
            ],
          ),
          Text(
            CoreUtils.toPrecision(
              _dweService.depositAmountInAsset.value,
              withSymbol: selectedAsset.metadata.symbol,
            ),
            style: themeData.textStyles.paragraph400,
          ),
          Visibility(
            visible: _dweService.showNetworkIcon,
            child: Text(
              ' on ${networkInfo?.name}',
              style: themeData.textStyles.small400.copyWith(
                color: themeColors.foreground300,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
      overridePadding: WidgetStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.only(left: 6.0, right: 10.0),
      ),
    );
  }

  ButtonStyle get _buttonStyle {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    final borderRadius = radiuses.isSquare()
        ? 0.0
        : BaseButtonSize.small.height / 2;

    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        return themeColors.grayGlass005;
      }),
      foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        return themeColors.foreground100;
      }),
      shape: WidgetStateProperty.resolveWith<RoundedRectangleBorder>((states) {
        return RoundedRectangleBorder(
          side: BorderSide(color: themeColors.grayGlass005, width: 1.0),
          borderRadius: BorderRadius.circular(borderRadius),
        );
      }),
    );
  }
}
