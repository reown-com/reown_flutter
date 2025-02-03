import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/models/send_data.dart';
import 'package:reown_appkit/modal/pages/preview_send/preview_send_page.dart';
import 'package:reown_appkit/modal/pages/select_token_page.dart';
import 'package:reown_appkit/modal/services/analytics_service/i_analytics_service.dart';
import 'package:reown_appkit/modal/services/analytics_service/models/analytics_event.dart';
import 'package:reown_appkit/modal/services/blockchain_service/i_blockchain_service.dart';
import 'package:reown_appkit/modal/services/blockchain_service/models/token_balance.dart';
import 'package:reown_appkit/modal/services/explorer_service/i_explorer_service.dart';
import 'package:reown_appkit/modal/utils/core_utils.dart';
import 'package:reown_appkit/modal/widgets/buttons/network_button.dart';
import 'package:reown_appkit/modal/widgets/buttons/primary_button.dart';
import 'package:reown_appkit/modal/widgets/buttons/secondary_button.dart';
import 'package:reown_appkit/modal/widgets/buttons/simple_icon_button.dart';
import 'package:reown_appkit/modal/widgets/icons/rounded_icon.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/searchbar.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/widget_stack_singleton.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar.dart';

class SendPage extends StatefulWidget {
  const SendPage() : super(key: KeyConstants.sendPageKey);

  @override
  State<SendPage> createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> with WidgetsBindingObserver {
  IBlockChainService get _blockchainService => GetIt.I<IBlockChainService>();
  IAnalyticsService get _analyticsService => GetIt.I<IAnalyticsService>();

  final _amountController = TextEditingController();
  final _addressController = TextEditingController();
  var _sendData = SendData();
  final _addressFocus = FocusNode();
  late final TokenBalance _selectedToken;
  late final TokenBalance? _networkToken;

  @override
  void initState() {
    super.initState();
    final cachedTokens = _blockchainService.tokensList ?? <TokenBalance>[];
    _selectedToken = _blockchainService.selectedSendToken ?? cachedTokens.last;
    final namespace = NamespaceUtils.getNamespaceFromChain(
      _selectedToken.chainId!,
    );

    // TODO check this
    if (namespace == 'eip155') {
      _networkToken = cachedTokens.firstWhereOrNull(
        (element) =>
            element.address == null &&
            element.chainId == _selectedToken.chainId,
      );
    } else {
      _networkToken = TokenBalance.fromJson(_selectedToken.toJson());
    }

    _amountController.addListener(() {
      _sendData = _sendData.copyWith(amount: _amountController.text);
      setState(() {});
    });
    _addressController.addListener(() {
      _sendData = _sendData.copyWith(address: _addressController.text);
      setState(() {});
    });

    _analyticsService.sendEvent(WalletFeatureOpenSend(
      network: _selectedToken.chainId!,
    ));
  }

  void _setMaxAmount(String? maxAmount) {
    _sendData = _sendData.copyWith(amount: maxAmount);
    _amountController.text = _sendData.amount!;
    setState(() {});
  }

  void _setAddress(String address) {
    _addressController.text = address;
    setState(() {});
  }

  void _pasteAddress() async {
    final clipboardData = await Clipboard.getData(
      Clipboard.kTextPlain,
    );
    // await Clipboard.setData(ClipboardData(text: ''));
    _setAddress(clipboardData?.text ?? '');
  }

  bool _isValidDecimal(String input) {
    final regex = RegExp(r'^-?\d+(\.\d+)?$');
    return regex.hasMatch(input);
  }

  bool _isValidAddress(String input) {
    final appKitModal = ModalProvider.of(context).instance;
    final chainId = appKitModal.selectedChain!.chainId;
    final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(chainId);
    final regex = RegExp(r'^(0x)?[0-9a-fA-F]{40}$');
    if (namespace == 'eip155') {
      return regex.hasMatch(input);
    }
    return true;
  }

  bool get _pasteIsVisible {
    return _addressController.text.isEmpty;
  }

  bool get _sendButtonEnabled {
    if (_sendData.amount == null) return false;
    if (_sendData.amount!.toString().isEmpty) return false;
    if (!_isValidDecimal(_sendData.amount!)) return false;

    if (_sendData.address == null) return false;
    if (_sendData.address!.toString().isEmpty) return false;
    if (!_isValidAddress(_sendData.address!)) return false;

    try {
      final parsedAmount = double.parse(_sendData.amount!);
      if (parsedAmount <= 0.0) {
        return false;
      }
    } catch (_) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final appKitModal = ModalProvider.of(context).instance;
    final chainId = appKitModal.selectedChain!.chainId;
    final imageId = ReownAppKitModalNetworks.getNetworkIconId(chainId);
    final chainIcon = GetIt.I<IExplorerService>().getAssetImageUrl(imageId);
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final tokenPrice = (_selectedToken.price ?? 0.0).toStringAsFixed(2);
    final sendAmount = _sendData.amount ?? '0.0';
    double sendInFIAT = 0.0;
    if ((_sendData.amount ?? '').isNotEmpty) {
      sendInFIAT = double.parse(sendAmount) * double.parse(tokenPrice);
    }
    return ModalNavbar(
      title: 'Send',
      divider: false,
      body: Container(
        padding: const EdgeInsets.all(kPadding12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InputAmountWidget(
                      controller: _amountController,
                      onSubmitted: (value) {
                        _addressFocus.requestFocus();
                      },
                    ),
                    InputAddressWidget(
                      controller: _addressController,
                      focusNode: _addressFocus,
                      onSubmitted: (value) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                    ),
                  ],
                ),
                // Middle rown down icon
                Container(
                  decoration: BoxDecoration(
                    color: themeColors.background125,
                    border: Border.all(
                      color: themeColors.background200,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  ),
                  padding: const EdgeInsets.all(6.0),
                  child: RoundedIcon(
                    assetPath: 'lib/modal/assets/icons/receive.svg',
                    assetColor: themeColors.foreground275,
                    circleColor: themeColors.grayGlass002,
                    borderColor: themeColors.background125,
                    size: 40.0,
                    borderWidth: 6.0,
                    borderRadius: kPadding12,
                  ),
                ),
                Positioned(
                  top: 18.0,
                  right: kPadding16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Stack(
                        children: [
                          NetworkButton(
                            serviceStatus: appKitModal.status,
                            chainInfo: appKitModal.selectedChain,
                            title: ' ${_selectedToken.symbol}',
                            iconUrl: _selectedToken.iconUrl,
                            onTap: () {
                              widgetStack.instance.push(SelectTokenPage());
                            },
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: themeColors.background150,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0)),
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
                      const SizedBox.square(dimension: 4.0),
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: GestureDetector(
                          onTap: () => _setMaxAmount(
                            _selectedToken.quantity?.numeric,
                          ),
                          child: Row(
                            children: [
                              Text(
                                CoreUtils.formatStringBalance(
                                  _selectedToken.quantity?.numeric ?? '',
                                ),
                                style: themeData.textStyles.small400.copyWith(
                                  color: themeColors.foreground200,
                                ),
                              ),
                              Text(
                                ' Max ',
                                style: themeData.textStyles.small600.copyWith(
                                  color: themeColors.accent100,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 70.0,
                  left: 20.0,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Text(
                      '\$${CoreUtils.formatChainBalance(sendInFIAT, precision: 3)}',
                      style: themeData.textStyles.small400.copyWith(
                        color: themeColors.foreground200,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 28.0,
                  right: kPadding16,
                  child: Visibility(
                    visible: _pasteIsVisible,
                    child: SimpleIconButton(
                      leftIcon: 'lib/modal/assets/icons/copy.svg',
                      title: 'Paste',
                      backgroundColor: themeColors.grayGlass002,
                      foregroundColor: themeColors.foreground125,
                      iconSize: 14.0,
                      fontSize: 14.0,
                      onTap: () => _pasteAddress(),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 60.0),
                  color: themeColors.background125,
                  height: kPadding8,
                  child: SizedBox.square(dimension: 10.0),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 60.0),
                  color: themeColors.background125,
                  height: kPadding8,
                  child: SizedBox.square(dimension: 10.0),
                ),
              ],
            ),
            const SizedBox.square(dimension: kPadding6),
            Row(
              children: [
                const SizedBox.square(dimension: 4.0),
                Expanded(
                  child: SizedBox(
                    height: kListItemHeight,
                    child: _sendButtonEnabled
                        ? PrimaryButton(
                            title: 'Review send',
                            onTap: () {
                              widgetStack.instance.push(PreviewSendPage(
                                sendData: _sendData,
                                sendTokenData: _selectedToken,
                                networkTokenData: _networkToken,
                              ));
                            })
                        : SecondaryButton(
                            title: (_sendData.amount ?? '').isEmpty
                                ? 'Add amount'
                                : (_sendData.address ?? '').isEmpty
                                    ? 'Add address'
                                    : _isValidAddress(_sendData.address!)
                                        ? 'Send'
                                        : 'Invalid address',
                          ),
                  ),
                ),
                const SizedBox.square(dimension: 4.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InputAmountWidget extends StatefulWidget {
  final TextEditingController controller;
  final Function(String value)? onSubmitted;
  final Function(bool value)? onFocus;
  final Widget? suffixIcon;
  const InputAmountWidget({
    super.key,
    required this.controller,
    this.onSubmitted,
    this.onFocus,
    this.suffixIcon,
  });

  @override
  State<InputAmountWidget> createState() => _InputAmountWidgetState();
}

class _InputAmountWidgetState extends State<InputAmountWidget> {
  bool hasFocus = false;

  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return ModalSearchBar(
      height: 100.0,
      controller: widget.controller,
      initialValue: widget.controller.text,
      hint: '0',
      prefixIcon: const SizedBox.square(dimension: kPadding16),
      suffixIcon: const SizedBox.shrink(),
      suffixWidth: 110.0,
      noIcons: true,
      textInputType: TextInputType.datetime,
      textInputAction: TextInputAction.next,
      onSubmitted: widget.onSubmitted,
      debounce: false,
      borderOnFocus: false,
      onTextChanged: (_) {},
      onFocusChange: _onFocusChange,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
      ],
      textStyle: themeData.textStyles.title400.copyWith(
        color: themeColors.foreground100,
        fontSize: 32.0,
        height: 1.0,
      ),
    );
  }

  void _onFocusChange(bool focus) {
    if (hasFocus == focus) return;
    widget.onFocus?.call(focus);
    setState(() => hasFocus = focus);
  }
}

class InputAddressWidget extends StatefulWidget {
  final TextEditingController controller;
  final Function(String value)? onSubmitted;
  final Function(bool value)? onFocus;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  const InputAddressWidget({
    super.key,
    required this.controller,
    this.onSubmitted,
    this.onFocus,
    this.focusNode,
    this.suffixIcon,
  });

  @override
  State<InputAddressWidget> createState() => _InputAddressWidgetState();
}

class _InputAddressWidgetState extends State<InputAddressWidget> {
  bool hasFocus = false;
  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return ModalSearchBar(
      focusNode: widget.focusNode,
      height: 100.0,
      maxLines: widget.controller.text.isEmpty ? 1 : 2,
      controller: widget.controller,
      initialValue: widget.controller.text,
      hint: 'Type or paste address',
      prefixIcon: const SizedBox.square(dimension: kPadding12),
      suffixIcon: const SizedBox.square(dimension: kPadding12),
      noIcons: true,
      textInputType: TextInputType.text,
      textInputAction: TextInputAction.done,
      onSubmitted: widget.onSubmitted,
      debounce: false,
      borderOnFocus: false,
      onTextChanged: (_) {},
      onFocusChange: _onFocusChange,
      textStyle: themeData.textStyles.large500.copyWith(
        color: themeColors.foreground100,
        fontSize: 18.0,
        height: 1.2,
      ),
    );
  }

  void _onFocusChange(bool focus) {
    if (hasFocus == focus) return;
    widget.onFocus?.call(focus);
    setState(() => hasFocus = focus);
  }
}
