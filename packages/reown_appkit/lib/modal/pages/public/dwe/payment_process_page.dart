import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/services/dwe_service/i_dwe_service.dart';
import 'package:reown_appkit/modal/services/explorer_service/i_explorer_service.dart';
import 'package:reown_appkit/modal/services/toast_service/i_toast_service.dart';
import 'package:reown_appkit/modal/services/toast_service/models/toast_message.dart';
import 'package:reown_appkit/modal/services/transfers/models/quote_models.dart';
import 'package:reown_appkit/modal/utils/core_utils.dart';
import 'package:reown_appkit/modal/widgets/buttons/base_button.dart';
import 'package:reown_appkit/modal/widgets/icons/rounded_icon.dart';
import 'package:reown_appkit/modal/widgets/lists/list_items/account_list_item.dart';
import 'package:reown_appkit/modal/widgets/lists/list_items/wallet_item_chip.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/i_widget_stack.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:shimmer/shimmer.dart';

class PaymentProcessPage extends StatefulWidget {
  final Quote quoteResult;
  final Exchange exchange;
  const PaymentProcessPage({required this.quoteResult, required this.exchange})
    : super(key: KeyConstants.paymentProcessPage);

  @override
  State<PaymentProcessPage> createState() => _PaymentProcessPageState();
}

class _PaymentProcessPageState extends State<PaymentProcessPage> {
  IDWEService get _dweService => GetIt.I<IDWEService>();
  bool _depositError = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startPayment();
    });
  }

  Future<void> _startPayment() async {
    setState(() => _depositError = false);
    final appKitModal = ModalProvider.of(context).instance;
    if (widget.quoteResult.steps.length > 1) {
      appKitModal.onModalError.broadcast(ModalError('Something went wrong'));
      return;
    }

    final step = widget.quoteResult.steps.first;
    final String requestId = step.requestId;

    final depositAsset = widget.quoteResult.origin.currency;
    final depositAssetChain = depositAsset.network;

    late final String recipient;
    late final String amount;
    if (step.isDeposit) {
      final receiver = (step as QuoteStepDeposit).deposit.receiver;
      recipient = '$depositAssetChain:$receiver';
      amount = widget.quoteResult.formattedAmount(withSymbol: false);
    } else {
      appKitModal.onModalError.broadcast(ModalError('Something went wrong'));
      return;
      // TO ENABLE WHEN DEPOSIT FROM WALLET IS DEVELOPED
      // final namespace = NamespaceUtils.getNamespaceFromChain(depositAssetChain);
      // final configuredRecipient = _dweService.configuredRecipients[namespace];
      // final connectedAddress = appKitModal.session?.getAddress(namespace);
      // final finalRecipient = configuredRecipient ?? connectedAddress;
      // if (finalRecipient == null) {
      //   appKitModal.onModalError.broadcast(ModalError('No recipient found'));
      //   setState(() => _depositError = true);
      //   return;
      // }
      // recipient = '$depositAssetChain:$finalRecipient';
      // amount = _dweService.depositAmountInAsset.value.toStringAsFixed(8);
    }

    try {
      final getExchangeUrlParams = GetExchangeUrlParams(
        exchangeId: widget.exchange.id,
        asset: depositAsset,
        amount: amount,
        recipient: recipient,
      );
      final GetExchangeUrlResult urlResult = await _dweService.getExchangeUrl(
        params: getExchangeUrlParams,
      );
      await ReownCoreUtils.openURL(urlResult.url);

      if (requestId == 'direct-transfer') {
        _loopOnDepositStatusCheck(urlResult.sessionId);
      } else {
        await _loopOnTransferStatusCheck();
      }
    } on JsonRpcError catch (e) {
      appKitModal.onModalError.broadcast(ModalError(e.cleanMessage));
      _dweService.stopCheckingStatus();
      setState(() => _depositError = true);
    } catch (e) {
      appKitModal.onModalError.broadcast(ModalError('Something went wrong'));
      _dweService.stopCheckingStatus();
      setState(() => _depositError = true);
    }
  }

  void _loopOnDepositStatusCheck(String sessionId) async {
    _dweService.loopOnDepositStatusCheck(widget.exchange.id, sessionId, (
      statusCheckResult,
    ) async {
      await _processStatus(statusCheckResult);
    });
  }

  Future<void> _loopOnTransferStatusCheck() async {
    final requestId = widget.quoteResult.steps.first.requestId;
    _dweService.loopOnTransferStatusCheck(widget.exchange.id, requestId, (
      statusCheckResult,
    ) async {
      await _processStatus(statusCheckResult);
    });
  }

  QuoteStatus _quoteStatus = QuoteStatus.waiting;

  Future<void> _processStatus(
    (QuoteStatus status, dynamic data) statusCheckResult,
  ) async {
    debugPrint('[$runtimeType] _processStatus ${statusCheckResult.$1.name}');
    _quoteStatus = statusCheckResult.$1;
    final appKitModal = ModalProvider.of(context).instance;
    if (_quoteStatus.isSuccess) {
      appKitModal.onDepositSuccess.broadcast(
        DepositSuccessEvent(widget.exchange),
      );
      // Trigger rebuild to show checkmarks before the delayed navigation
      setState(() {});
      await Future.delayed(const Duration(milliseconds: 400));
      if (!mounted) return;
      await appKitModal.loadAccountData();
      if (!mounted) return;
      final widgetStack = GetIt.I<IWidgetStack>();
      if (widgetStack.containsKey(KeyConstants.walletFeaturesPage)) {
        widgetStack.popUntil(KeyConstants.walletFeaturesPage);
      } else if (widgetStack.containsKey(KeyConstants.eoAccountPage)) {
        widgetStack.popUntil(KeyConstants.eoAccountPage);
      } else if (widgetStack.containsKey(KeyConstants.depositPageKey)) {
        widgetStack.popUntil(KeyConstants.depositPageKey);
      }
      GetIt.I<IToastService>().show(
        ToastMessage(
          type: ToastType.success,
          text: 'Deposit successful',
        ),
      );
      return;
    }
    if (_quoteStatus.isError) {
      GetIt.I<IToastService>().show(
        ToastMessage(
          type: ToastType.error,
          text: _quoteStatus.name.toUpperCase(),
        ),
      );
    }
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    return ModalNavbar(
      title: 'Processing payment...',
      safeAreaLeft: true,
      safeAreaRight: true,
      safeAreaBottom: false,
      divider: false,
      onBack: () {
        _dweService.stopCheckingStatus();
        GetIt.I<IWidgetStack>().pop();
      },
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _CircledSendWidget(),
          SizedBox.square(dimension: kPadding12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPadding12),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Payment method',
                      style: themeData.textStyles.paragraph400.copyWith(
                        color: themeColors.foreground200,
                      ),
                    ),
                    Spacer(),
                    Text(
                      widget.quoteResult.formattedAmount(),
                      style: themeData.textStyles.paragraph400,
                    ),
                  ],
                ),
                Builder(
                  builder: (context) {
                    final networkInfo = ReownAppKitModalNetworks.getNetworkInfo(
                      widget.quoteResult.origin.currency.network,
                      widget.quoteResult.origin.currency.network,
                    );
                    final chainIcon = GetIt.I<IExplorerService>().getChainIcon(
                      networkInfo,
                    );
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'on ',
                          style: themeData.textStyles.small400.copyWith(
                            color: themeColors.foreground200,
                          ),
                        ),
                        RoundedIcon(
                          imageUrl: chainIcon,
                          padding: 0.0,
                          size: themeData.textStyles.small400.fontSize!,
                        ),
                        Text(
                          ' ${networkInfo!.name}',
                          style: themeData.textStyles.small400.copyWith(
                            color: themeColors.foreground200,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox.square(dimension: kPadding16),
          Divider(
            color: themeColors.grayGlass010,
            height: 0.0,
            indent: kPadding12,
            endIndent: kPadding12,
          ),
          SizedBox.square(dimension: kPadding16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPadding12),
            child: Row(
              children: [
                Text(
                  'Exchange',
                  style: themeData.textStyles.paragraph400.copyWith(
                    color: themeColors.foreground200,
                  ),
                ),
                Spacer(),
                Text(
                  '${widget.exchange.name} ',
                  style: themeData.textStyles.paragraph400,
                ),
                RoundedIcon(
                  imageUrl: widget.exchange.imageUrl,
                  padding: 0.0,
                  size: themeData.textStyles.paragraph400.fontSize! + 5,
                ),
              ],
            ),
          ),
          SizedBox.square(dimension: kPadding16),
          SizedBox.square(dimension: kPadding8),
          Container(
            padding: const EdgeInsets.all(kPadding12),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'PAYMENT CYCLE',
                      style: themeData.textStyles.tiny400.copyWith(
                        color: themeColors.foreground200,
                      ),
                    ),
                    Spacer(),
                    WalletItemChip(
                      value: '🕒 Est. ${widget.quoteResult.timeInSeconds} sec',
                      textStyle: themeData.textStyles.tiny400.copyWith(
                        color: themeColors.foreground100,
                      ),
                      color: themeColors.grayGlass005,
                    ),
                  ],
                ),
                SizedBox.square(dimension: kPadding12),
                _PaymentDetails(
                  quoteResult: widget.quoteResult,
                  depositError: _depositError,
                  status: _quoteStatus,
                ),
                SizedBox.square(
                  dimension: MediaQuery.of(context).padding.bottom + kPadding6,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentDetails extends StatelessWidget {
  const _PaymentDetails({
    required this.quoteResult,
    required this.depositError,
    required this.status,
  });
  final Quote? quoteResult;
  final QuoteStatus status;
  final bool depositError;

  Widget _inactiveDot(ReownAppKitModalColors themeColors) {
    return Center(
      child: Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: themeColors.foreground300,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    final isError = depositError || status.isError;
    final isSuccess = status.isSuccess;
    return Column(
      children: [
        AccountListItem(
          padding: const EdgeInsets.all(0.0),
          backgroundColor: WidgetStatePropertyAll(Colors.transparent),
          iconWidget: Padding(
            padding: const EdgeInsets.only(left: kPadding6),
            child: RoundedIcon(
              assetPath: 'lib/modal/assets/icons/receive.svg',
              assetColor: themeColors.foreground300,
              borderRadius: radiuses.isSquare() ? 0.0 : null,
              // size: 36.0,
            ),
          ),
          title: ' Receiving funds',
          titleStyle: themeData.textStyles.small400.copyWith(
            color: themeColors.foreground125,
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(right: kPadding6),
            child: SizedBox.square(
              dimension: 15,
              child: Builder(
                builder: (_) {
                  if (status == QuoteStatus.waiting) {
                    return CircularProgressIndicator(strokeWidth: 1.0);
                  }
                  if (isError) {
                    return Icon(Icons.close, color: themeColors.error100);
                  }
                  return Icon(Icons.check, color: themeColors.success100);
                },
              ),
            ),
          ),
        ),
        AccountListItem(
          padding: const EdgeInsets.all(0.0),
          backgroundColor: WidgetStatePropertyAll(Colors.transparent),
          iconWidget: Padding(
            padding: const EdgeInsets.only(left: kPadding6),
            child: RoundedIcon(
              assetPath: 'lib/modal/assets/icons/swap_horizontal.svg',
              assetColor: themeColors.foreground300,
              borderRadius: radiuses.isSquare() ? 0.0 : null,
              // size: 36.0,
            ),
          ),
          title: ' Swapping assets',
          titleStyle: themeData.textStyles.small400.copyWith(
            color: themeColors.foreground125,
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(right: kPadding6),
            child: SizedBox.square(
              dimension: 15,
              child: Builder(
                builder: (_) {
                  if (status == QuoteStatus.waiting) {
                    return _inactiveDot(themeColors);
                  }
                  if (status == QuoteStatus.pending) {
                    return CircularProgressIndicator(strokeWidth: 1.0);
                  }
                  if (isError) {
                    return Icon(Icons.close, color: themeColors.error100);
                  }
                  return Icon(Icons.check, color: themeColors.success100);
                },
              ),
            ),
          ),
        ),
        AccountListItem(
          padding: const EdgeInsets.all(0.0),
          backgroundColor: WidgetStatePropertyAll(Colors.transparent),
          iconWidget: Padding(
            padding: const EdgeInsets.only(left: kPadding6),
            child: RoundedIcon(
              assetPath: 'lib/modal/assets/icons/send.svg',
              assetColor: themeColors.foreground300,
              borderRadius: radiuses.isSquare() ? 0.0 : null,
              // size: 36.0,
            ),
          ),
          title: ' Sending asset to the recipient address',
          titleStyle: themeData.textStyles.small400.copyWith(
            color: themeColors.foreground125,
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(right: kPadding6),
            child: SizedBox.square(
              dimension: 15,
              child: Builder(
                builder: (_) {
                  if (isSuccess) {
                    return Icon(Icons.check, color: themeColors.success100);
                  }
                  if (isError) {
                    return Icon(Icons.close, color: themeColors.error100);
                  }
                  return _inactiveDot(themeColors);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CircledSendWidget extends StatefulWidget {
  @override
  State<_CircledSendWidget> createState() => __CircledSendWidgetState();
}

class __CircledSendWidgetState extends State<_CircledSendWidget> {
  IDWEService get _dweService => GetIt.I<IDWEService>();

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final selectedAsset = _dweService.depositAsset.value!;

    return FutureBuilder(
      future: _dweService.getFungiblePrice(asset: selectedAsset),
      builder: (context, snapshot) {
        if (snapshot.data == null) return SizedBox.shrink();
        final fungible = snapshot.data!;
        final networkInfo = ReownAppKitModalNetworks.getNetworkInfo(
          fungible.chainId!,
          fungible.chainId!,
        );
        final chainIcon = GetIt.I<IExplorerService>().getChainIcon(networkInfo);
        return Stack(
          alignment: AlignmentGeometry.center,
          children: [
            Shimmer.fromColors(
              baseColor: themeColors.accent100,
              highlightColor: themeColors.background100,
              child: Stack(
                alignment: AlignmentGeometry.center,
                children: [
                  Container(
                    width: 170.0,
                    height: 170.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(170.0)),
                      border: Border.fromBorderSide(
                        BorderSide(
                          color: themeColors.accenGlass005,
                          width: 2.0,
                        ),
                      ),
                      color: Colors.transparent,
                    ),
                  ),
                  Container(
                    width: 145.0,
                    height: 145.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(145.0)),
                      border: Border.fromBorderSide(
                        BorderSide(
                          color: themeColors.accenGlass020,
                          width: 2.0,
                        ),
                      ),
                      color: Colors.transparent,
                    ),
                  ),
                  Container(
                    width: 105.0,
                    height: 105.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(105.0)),
                      border: Border.fromBorderSide(
                        BorderSide(
                          color: themeColors.accenGlass020,
                          width: 2.0,
                        ),
                      ),
                      color: Colors.transparent,
                    ),
                  ),
                  RoundedIcon(
                    assetPath: 'lib/modal/assets/icons/send.svg',
                    size: 70,
                    assetColor: themeColors.accent100,
                    circleColor: themeColors.accenGlass015,
                    borderColor: themeColors.accenGlass015,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              child: Container(
                color: themeColors.background125,
                child: BaseButton(
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
                            imageUrl: _dweService.showNetworkIcon
                                ? chainIcon
                                : fungible.iconUrl,
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
                    ],
                  ),
                  overridePadding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.only(left: 6.0, right: 10.0),
                  ),
                ),
              ),
            ),
          ],
        );
      },
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
        return themeColors.background175;
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
