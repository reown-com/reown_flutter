import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/services/dwe_service/i_dwe_service.dart';
import 'package:reown_appkit/modal/services/toast_service/i_toast_service.dart';
import 'package:reown_appkit/modal/services/toast_service/models/toast_message.dart';
import 'package:reown_appkit/modal/widgets/circular_loader.dart';
import 'package:reown_appkit/modal/widgets/icons/rounded_icon.dart';
import 'package:reown_appkit/modal/widgets/lists/list_items/account_list_item.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/reown_appkit.dart';

class ExchangesListWidget extends StatefulWidget {
  final String? recipient;
  final Function(Exchange) onSelect;
  const ExchangesListWidget({this.recipient, required this.onSelect});

  @override
  State<ExchangesListWidget> createState() => _ExchangesListWidgetState();
}

class _ExchangesListWidgetState extends State<ExchangesListWidget> {
  IDWEService get _dweService => GetIt.I<IDWEService>();

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
            final exchanges = snapshot.data?.exchanges ?? [];
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
                            child: AccountListItem(
                              iconWidget: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4.0,
                                ),
                                child: RoundedIcon(
                                  borderRadius: radiuses.isSquare()
                                      ? 0.0
                                      : null,
                                  imageUrl: exchange.imageUrl,
                                  assetColor: themeColors.background100,
                                ),
                              ),
                              title: exchange.name,
                              titleStyle: themeData.textStyles.paragraph500
                                  .copyWith(color: themeColors.foreground100),
                              onTap: () {
                                widget.onSelect.call(exchange);
                              },
                              // trailing: SizedBox.square(
                              //   dimension: 15.0,
                              //   child: CircularProgressIndicator(
                              //     strokeWidth: 1.5,
                              //     color: themeColors.foreground200,
                              //   ),
                              // )
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
