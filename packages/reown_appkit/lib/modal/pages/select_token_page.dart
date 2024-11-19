import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/services/blockchain_service/i_blockchain_service.dart';
import 'package:reown_appkit/modal/services/blockchain_service/models/token_balance.dart';
import 'package:reown_appkit/modal/utils/core_utils.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/modal/widgets/icons/rounded_icon.dart';
import 'package:reown_appkit/modal/widgets/lists/list_items/account_list_item.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/widget_stack_singleton.dart';
import 'package:reown_appkit/reown_appkit.dart';

class SelectTokenPage extends StatefulWidget {
  const SelectTokenPage() : super(key: KeyConstants.selectTokenPage);

  @override
  State<SelectTokenPage> createState() => _SelectTokenPageState();
}

class _SelectTokenPageState extends State<SelectTokenPage> {
  IBlockChainService get _blockchainService => GetIt.I<IBlockChainService>();
  List<TokenBalance> _tokens = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        final appKitModal = ModalProvider.of(context).instance;
        final chainId = appKitModal.selectedChain!.chainId;
        final namespace = ReownAppKitModalNetworks.getNamespaceForChainId(
          chainId,
        );
        final address = appKitModal.session!.getAddress(namespace)!;

        // cached items
        final cachedTokens = _blockchainService.tokensList ?? <TokenBalance>[];
        if (cachedTokens.isNotEmpty) {
          _tokens = List<TokenBalance>.from(cachedTokens);
        } else {
          _tokens = await _blockchainService.getBalance(
            address: address,
            caip2chain: '$namespace:$chainId',
          );
        }
        setState(() {});
      } catch (_) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    return ModalNavbar(
      title: 'Select token',
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
            ..._tokens.mapIndexed((index, token) {
              return AccountListItem(
                padding: const EdgeInsets.all(0.0),
                backgroundColor: MaterialStatePropertyAll(
                  Colors.transparent,
                ),
                iconWidget: Padding(
                  padding: const EdgeInsets.only(left: kPadding6),
                  child: (_tokens[index].iconUrl ?? '').isEmpty
                      ? RoundedIcon(
                          assetPath: 'lib/modal/assets/icons/coin.svg',
                          assetColor: themeColors.inverse100,
                          borderRadius: radiuses.isSquare() ? 0.0 : null,
                        )
                      : ClipRRect(
                          borderRadius: radiuses.isSquare()
                              ? BorderRadius.zero
                              : BorderRadius.circular(34),
                          child: CachedNetworkImage(
                            imageUrl: _tokens[index].iconUrl!,
                            height: 34,
                            width: 34,
                            errorWidget: (context, url, error) {
                              return RoundedIcon(
                                assetPath: 'lib/modal/assets/icons/coin.svg',
                                assetColor: themeColors.inverse100,
                                borderRadius: radiuses.isSquare() ? 0.0 : null,
                              );
                            },
                          ),
                        ),
                ),
                title: _tokens[index].name ?? '',
                titleStyle: themeData.textStyles.paragraph500.copyWith(
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
                      style: themeData.textStyles.paragraph500.copyWith(
                        color: themeColors.foreground100,
                      ),
                    ),
                    SizedBox.square(dimension: kPadding6),
                  ],
                ),
                onTap: () {
                  _blockchainService.selectSendToken(_tokens[index]);
                  widgetStack.instance.pop();
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
