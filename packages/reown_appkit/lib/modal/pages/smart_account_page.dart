import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/pages/activity_page.dart';
import 'package:reown_appkit/modal/pages/account_page.dart';
import 'package:reown_appkit/modal/pages/receive_page.dart';
import 'package:reown_appkit/modal/pages/send_page.dart';
import 'package:reown_appkit/modal/services/analytics_service/models/analytics_event.dart';
import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';
import 'package:reown_appkit/modal/services/blockchain_service/i_blockchain_service.dart';
import 'package:reown_appkit/modal/services/blockchain_service/models/token_balance.dart';
import 'package:reown_appkit/modal/services/explorer_service/i_explorer_service.dart';
import 'package:reown_appkit/modal/utils/core_utils.dart';
import 'package:reown_appkit/modal/widgets/buttons/address_button.dart';
import 'package:reown_appkit/modal/widgets/buttons/network_button.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/content_loading.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/responsive_container.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/segmented_control.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar_action_button.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/widget_stack_singleton.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/modal/widgets/buttons/simple_icon_button.dart';
import 'package:reown_appkit/modal/widgets/icons/rounded_icon.dart';
import 'package:reown_appkit/modal/widgets/lists/list_items/account_list_item.dart';
import 'package:reown_appkit/reown_appkit.dart';

class SmartAccountPage extends StatefulWidget {
  const SmartAccountPage() : super(key: KeyConstants.smartAccountPage);

  @override
  State<SmartAccountPage> createState() => _SmartAccountPageState();
}

class _SmartAccountPageState extends State<SmartAccountPage>
    with WidgetsBindingObserver {
  IReownAppKitModal? _appKitModal;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _appKitModal = ModalProvider.of(context).instance;
      _appKitModal?.addListener(_rebuild);
      _rebuild();
    });
  }

  void _rebuild() => setState(() {});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _rebuild();
    }
  }

  @override
  void dispose() {
    _appKitModal?.removeListener(_rebuild);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_appKitModal == null) {
      return ContentLoading(viewHeight: 400.0);
    }

    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return ModalNavbar(
      title: '',
      safeAreaLeft: true,
      safeAreaRight: true,
      safeAreaBottom: false,
      divider: false,
      leftAction: NavbarActionButton(
        child: GestureDetector(
          onTap: () => widgetStack.instance.push(
            ReownAppKitModalSelectNetworkPage(),
            event: ClickNetworksEvent(),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Row(
              children: [
                const SizedBox.square(dimension: 20.0),
                NetworkButton(
                  serviceStatus: _appKitModal!.status,
                  chainInfo: _appKitModal!.selectedChain,
                  size: BaseButtonSize.small,
                  iconOnly: true,
                ),
                const SizedBox.square(dimension: 4.0),
                SvgPicture.asset(
                  'lib/modal/assets/icons/chevron_down.svg',
                  package: 'reown_appkit',
                  colorFilter: ColorFilter.mode(
                    themeColors.foreground200,
                    BlendMode.srcIn,
                  ),
                  width: 14.0,
                  height: 14.0,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPadding12),
        child: _SmartAccountView(
          appKitModal: _appKitModal!,
        ),
      ),
    );
  }
}

class _SmartAccountView extends StatefulWidget {
  const _SmartAccountView({required this.appKitModal});
  final IReownAppKitModal appKitModal;

  @override
  State<_SmartAccountView> createState() => _SmartAccountViewState();
}

class _SmartAccountViewState extends State<_SmartAccountView> {
  IBlockChainService get _blockchainService => GetIt.I<IBlockChainService>();
  SegmentOption _selectedSegment = SegmentOption.option1;
  List<TokenBalance> _tokens = [];

  @override
  void initState() {
    super.initState();
    final chainId = widget.appKitModal.selectedChain!.chainId;
    final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(
      chainId,
    );
    final address = widget.appKitModal.session!.getAddress(namespace)!;

    // cached items
    final cachedTokens = _blockchainService.tokensList ?? <TokenBalance>[];
    if (cachedTokens.isNotEmpty) {
      _tokens = List<TokenBalance>.from(cachedTokens);
      setState(() {});
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        _tokens = await _blockchainService.getBalance(
          address: address,
          caip2Chain: '$namespace:$chainId',
        );
        setState(() {});
      } catch (_) {}
    });
  }

  String get _sumBalance {
    String? tokenBalance = '0.00';
    if (_tokens.isNotEmpty) {
      final sum = _tokens.map((e) => e.value).reduce((prev, curr) {
            return (prev ?? 0.0) + (curr ?? 0.0);
          }) ??
          0.0;
      tokenBalance = CoreUtils.formatChainBalance(sum);
    }
    return tokenBalance;
  }

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    final chainId = widget.appKitModal.selectedChain!.chainId;
    final imageId = ReownAppKitModalNetworks.getNetworkIconId(chainId);
    final chainIcon = GetIt.I<IExplorerService>().getAssetImageUrl(imageId);
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: ResponsiveData.maxHeightOf(context),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AddressButton(
            service: widget.appKitModal,
            onTap: () {
              widgetStack.instance.push(EOAccountPage());
            },
          ),
          const SizedBox.square(dimension: kPadding8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '\$${_sumBalance.split('.').first}',
                  style: themeData.textStyles.large400.copyWith(
                    color: themeColors.foreground100,
                    fontSize: 38.0,
                  ),
                ),
                TextSpan(
                  text: '.${_sumBalance.split('.').last}',
                  style: themeData.textStyles.large400.copyWith(
                    color: themeColors.foreground200,
                    fontSize: 38.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox.square(dimension: kPadding16),
          Row(
            children: [
              Expanded(
                child: SimpleIconButton(
                  rightIcon: 'lib/modal/assets/icons/arrow_bottom_circle.svg',
                  backgroundColor: themeColors.accenGlass010,
                  foregroundColor: themeColors.accent100,
                  borderRadius: kPadding16,
                  title: '',
                  size: BaseButtonSize.big,
                  iconSize: 20.0,
                  fontSize: 1.0,
                  onTap: () => widgetStack.instance.push(ReceivePage()),
                ),
              ),
              const SizedBox.square(dimension: kPadding8),
              Expanded(
                child: SimpleIconButton(
                  rightIcon: 'lib/modal/assets/icons/paperplane.svg',
                  backgroundColor: themeColors.accenGlass010,
                  foregroundColor: themeColors.accent100,
                  borderRadius: kPadding16,
                  title: '',
                  size: BaseButtonSize.big,
                  iconSize: 20.0,
                  fontSize: 1.0,
                  onTap: _tokens.isEmpty
                      ? null
                      : () => widgetStack.instance.push(SendPage()),
                ),
              ),
            ],
          ),
          const SizedBox.square(dimension: kPadding12),
          LayoutBuilder(
            builder: (context, constraints) {
              return SegmentedControl(
                width: (constraints.maxWidth / 2) - 2.0,
                option1Title: 'Tokens',
                option1Icon: '',
                option2Title: 'Activity',
                option2Icon: '',
                onChange: (option) => setState(() {
                  _selectedSegment = option;
                }),
              );
            },
          ),
          const SizedBox.square(dimension: kPadding12),
          Visibility(
            visible: _selectedSegment == SegmentOption.option1,
            child: _tokens.isNotEmpty
                ? Column(
                    children: [
                      ..._tokens.mapIndexed((index, token) {
                        return AccountListItem(
                          padding: const EdgeInsets.all(0.0),
                          backgroundColor: WidgetStatePropertyAll(
                            Colors.transparent,
                          ),
                          iconWidget: Padding(
                            padding: const EdgeInsets.only(left: kPadding6),
                            child: Stack(
                              children: [
                                (_tokens[index].iconUrl ?? '').isEmpty
                                    ? RoundedIcon(
                                        assetPath:
                                            'lib/modal/assets/icons/coin.svg',
                                        assetColor: themeColors.inverse100,
                                        borderRadius:
                                            radiuses.isSquare() ? 0.0 : null,
                                      )
                                    : ClipRRect(
                                        borderRadius: radiuses.isSquare()
                                            ? BorderRadius.zero
                                            : BorderRadius.circular(34),
                                        child: CachedNetworkImage(
                                          imageUrl: _tokens[index].iconUrl!,
                                          height: 38,
                                          width: 38,
                                          errorWidget: (context, url, error) {
                                            return RoundedIcon(
                                              assetPath:
                                                  'lib/modal/assets/icons/coin.svg',
                                              assetColor:
                                                  themeColors.inverse100,
                                              borderRadius: radiuses.isSquare()
                                                  ? 0.0
                                                  : null,
                                            );
                                          },
                                        ),
                                      ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: themeColors.background150,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.0)),
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
                          title: _tokens[index].name ?? '',
                          titleStyle:
                              themeData.textStyles.paragraph500.copyWith(
                            color: themeColors.foreground100,
                          ),
                          subtitle: '${CoreUtils.formatStringBalance(
                            _tokens[index].quantity?.numeric ?? '0.0',
                          )} ${_tokens[index].symbol ?? ''}',
                          subtitleStyle: themeData.textStyles.small400.copyWith(
                            color: themeColors.foreground200,
                          ),
                          trailing: Row(
                            children: [
                              Text(
                                '\$${CoreUtils.formatChainBalance(_tokens[index].value)}',
                                style:
                                    themeData.textStyles.paragraph500.copyWith(
                                  color: themeColors.foreground100,
                                ),
                              ),
                              SizedBox.square(dimension: kPadding6),
                            ],
                          ),
                        );
                      }),
                      SizedBox.square(
                        dimension:
                            MediaQuery.of(context).padding.bottom + kPadding6,
                      ),
                    ],
                  )
                : _ReceiveFundsEmptyStateButton(),
          ),
          Visibility(
            visible: _selectedSegment == SegmentOption.option2,
            child: Expanded(
              child: ActivityListViewBuilder(
                appKitModal: widget.appKitModal,
              ),
            ),
          ),
          // const SizedBox.square(dimension: 20.0),
        ],
      ),
    );
  }
}

class _ReceiveFundsEmptyStateButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return Column(
      children: [
        AccountListItem(
          padding: const EdgeInsets.symmetric(
            horizontal: kPadding8,
            vertical: kPadding8,
          ),
          iconWidget: Padding(
            padding: const EdgeInsets.all(4.0),
            child: RoundedIcon(
              borderRadius: 30.0,
              size: 30.0,
              assetPath: 'lib/modal/assets/icons/arrow_bottom_circle.svg',
              assetColor: themeColors.error100,
              circleColor: themeColors.error100.withOpacity(0.15),
              borderColor: themeColors.error100.withOpacity(0.15),
            ),
          ),
          title: 'Receive funds',
          subtitle: 'Transfer tokens on your wallet',
          flexible: true,
          titleStyle: themeData.textStyles.small500.copyWith(
            color: themeColors.foreground100,
          ),
          subtitleStyle: themeData.textStyles.tiny400.copyWith(
            color: themeColors.foreground150,
          ),
          onTap: () => widgetStack.instance.push(ReceivePage()),
        ),
        SizedBox.square(
          dimension: MediaQuery.of(context).padding.bottom + kPadding6,
        ),
      ],
    );
  }
}

// class _ConnectedWalletButton extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final service = ModalProvider.of(context).instance;
//     final themeData = ReownAppKitModalTheme.getDataOf(context);
//     final themeColors = ReownAppKitModalTheme.colorsOf(context);
//     final radiuses = ReownAppKitModalTheme.radiusesOf(context);
//     String iconImage = '';
//     if ((service.session!.peer?.metadata.icons ?? []).isNotEmpty) {
//       iconImage = service.session!.peer?.metadata.icons.first ?? '';
//     }
//     final walletInfo = GetIt.I<IExplorerService>().getConnectedWallet();
//     return Column(
//       children: [
//         const SizedBox.square(dimension: kPadding8),
//         AccountListItem(
//           iconWidget: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 4.0),
//             child: iconImage.isEmpty
//                 ? RoundedIcon(
//                     assetPath: 'lib/modal/assets/icons/wallet.svg',
//                     assetColor: themeColors.inverse100,
//                     borderRadius: radiuses.isSquare() ? 0.0 : null,
//                   )
//                 : ClipRRect(
//                     borderRadius: radiuses.isSquare()
//                         ? BorderRadius.zero
//                         : BorderRadius.circular(34),
//                     child: CachedNetworkImage(
//                       imageUrl: iconImage,
//                       height: 34,
//                       width: 34,
//                       errorWidget: (context, url, error) {
//                         return RoundedIcon(
//                           assetPath: 'lib/modal/assets/icons/wallet.svg',
//                           assetColor: themeColors.inverse100,
//                           borderRadius: radiuses.isSquare() ? 0.0 : null,
//                         );
//                       },
//                     ),
//                   ),
//           ),
//           title: service.session!.peer?.metadata.name ?? 'Connected Wallet',
//           titleStyle: themeData.textStyles.paragraph500.copyWith(
//             color: themeColors.foreground100,
//           ),
//           onTap:
//               walletInfo != null ? () => service.launchConnectedWallet() : null,
//         ),
//       ],
//     );
//   }
// }
