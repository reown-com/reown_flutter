import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/services/dwe_service/i_dwe_service.dart';
import 'package:reown_appkit/modal/services/toast_service/i_toast_service.dart';
import 'package:reown_appkit/modal/services/toast_service/models/toast_message.dart';
import 'package:reown_appkit/modal/utils/core_utils.dart';
import 'package:reown_appkit/modal/widgets/circular_loader.dart';
import 'package:reown_appkit/modal/widgets/icons/rounded_icon.dart';
import 'package:reown_appkit/modal/widgets/lists/list_items/account_list_item.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/reown_appkit.dart';

class ExchangesListWidget extends StatefulWidget {
  final String? recipient;
  final Function(Exchange exchange, GetExchangeUrlResult result) onSelect;
  const ExchangesListWidget({this.recipient, required this.onSelect});

  @override
  State<ExchangesListWidget> createState() => _ExchangesListWidgetState();
}

class _ExchangesListWidgetState extends State<ExchangesListWidget> {
  IDWEService get _dweService => GetIt.I<IDWEService>();
  ExchangeAsset? _selectedAsset;
  final List<Exchange> _exchanges = [];

  @override
  Widget build(BuildContext context) {
    final chainInfo = ModalProvider.of(context).instance.selectedChain;
    if (chainInfo == null) {
      return SizedBox.shrink();
    }

    return ValueListenableBuilder(
      valueListenable: _dweService.selectedAsset,
      builder: (context, selectedAsset, _) {
        if (selectedAsset == null) {
          return const SizedBox.shrink();
        }
        if (selectedAsset.toCaip19() == _selectedAsset?.toCaip19() &&
            _exchanges.isNotEmpty) {
          // no re-request
          return _ExchangesList(
            exchanges: _exchanges,
            recipient: widget.recipient,
            onSelect: widget.onSelect,
          );
        }

        return FutureBuilder(
          future: _dweService.getExchanges(
            params: GetExchangesParams(page: 1, asset: selectedAsset),
          ),
          builder: (context, snapshot) {
            if (!snapshot.hasData && !snapshot.hasError) {
              return CircularLoader();
            }
            if (snapshot.hasError) {
              GetIt.I<IToastService>().show(
                ToastMessage(
                  type: ToastType.error,
                  text: 'Unable to get exchanges',
                ),
              );
            }
            _exchanges
              ..clear()
              ..addAll(snapshot.data?.exchanges ?? []);
            return _ExchangesList(
              exchanges: _exchanges,
              recipient: widget.recipient,
              onSelect: widget.onSelect,
            );
          },
        );
      },
    );
  }
}

class _ExchangesList extends StatefulWidget {
  const _ExchangesList({
    required this.exchanges,
    required this.recipient,
    required this.onSelect,
  });
  final List<Exchange> exchanges;
  final String? recipient;
  final Function(Exchange exchange, GetExchangeUrlResult result) onSelect;

  @override
  State<_ExchangesList> createState() => __ExchangesListState();
}

class __ExchangesListState extends State<_ExchangesList> {
  IDWEService get _dweService => GetIt.I<IDWEService>();
  Exchange? _selectedExchange;

  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    final exchanges = widget.exchanges;
    return exchanges.isEmpty
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'No exchanges available at the moment',
              style: themeData.textStyles.paragraph400.copyWith(
                color: themeColors.foreground100,
              ),
            ),
          )
        : Column(
            children: exchanges
                .map(
                  (exchange) => Padding(
                    padding: const EdgeInsets.only(top: kPadding8),
                    child: ValueListenableBuilder(
                      valueListenable: _dweService.selectedAmount,
                      builder: (context, amount, _) {
                        return AccountListItem(
                          iconWidget: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4.0,
                            ),
                            child: RoundedIcon(
                              borderRadius: radiuses.isSquare() ? 0.0 : null,
                              imageUrl: exchange.imageUrl,
                              assetColor: themeColors.background100,
                            ),
                          ),
                          title: exchange.name,
                          titleStyle: themeData.textStyles.paragraph500
                              .copyWith(color: themeColors.foreground100),
                          onTap: amount > 0.0
                              ? () => _selectExchange(exchange)
                              : null,
                          trailing: _selectedExchange?.id == exchange.id
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox.square(
                                      dimension: 15.0,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 1.8,
                                        color: themeColors.foreground200,
                                      ),
                                    ),
                                    const SizedBox(width: 10.0),
                                  ],
                                )
                              : null,
                        );
                      },
                    ),
                  ),
                )
                .toList(),
          );
  }

  Future<void> _selectExchange(Exchange exchange) async {
    // 2 GET PAYMENT URL
    setState(() => _selectedExchange = exchange);
    final selectedAsset = _dweService.selectedAsset.value!;
    final chainId = selectedAsset.network;
    final namespace = NamespaceUtils.getNamespaceFromChain(chainId);
    final appKitModal = ModalProvider.of(context).instance;
    final recipient =
        widget.recipient ?? appKitModal.session?.getAddress(namespace);
    if (recipient == null) {
      appKitModal.onModalError.broadcast(ModalError('No recipient found'));
      setState(() => _selectedExchange = null);
      return;
    }

    try {
      final amount = _dweService.selectedAmount.value;
      final getExchangeUrlParams = GetExchangeUrlParams(
        exchangeId: exchange.id,
        asset: selectedAsset,
        amount: '${amount.toDouble()}',
        recipient: '$chainId:$recipient',
      );
      final GetExchangeUrlResult result = await _dweService.getExchangeUrl(
        params: getExchangeUrlParams,
      );
      setState(() => _selectedExchange = null);
      await ReownCoreUtils.openURL(result.url);
      widget.onSelect.call(exchange, result);
    } on JsonRpcError catch (e) {
      appKitModal.onModalError.broadcast(ModalError(e.cleanMessage));
      setState(() => _selectedExchange = null);
    } catch (e) {
      appKitModal.onModalError.broadcast(
        ModalError('Something wrong happened'),
      );
      setState(() => _selectedExchange = null);
    }
  }
}
