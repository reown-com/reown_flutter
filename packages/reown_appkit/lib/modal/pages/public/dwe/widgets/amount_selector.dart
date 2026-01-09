import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/services/blockchain_service/models/token_balance.dart';
import 'package:reown_appkit/modal/services/dwe_service/i_dwe_service.dart';
import 'package:reown_appkit/modal/utils/core_utils.dart';
import 'package:reown_appkit/modal/widgets/buttons/base_button.dart';
import 'package:reown_appkit/reown_appkit.dart';

class AmountSelector extends StatefulWidget {
  @override
  State<AmountSelector> createState() => _AmountSelectorState();
}

class _AmountSelectorState extends State<AmountSelector> {
  IDWEService get _dweService => GetIt.I<IDWEService>();

  late final TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(
      text: _dweService.depositAmountInUSD.value > 0.0
          ? _dweService.depositAmountInUSD.value.toStringAsFixed(2)
          : '',
    );
    _amountController.addListener(() {
      try {
        _dweService.depositAmountInUSD.value = _amountController.text.isEmpty
            ? 0.0
            : double.parse(_amountController.text);
      } catch (_) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_dweService.supportedAssets.isEmpty) {
      return _AmountInputBody(
        amountController: _amountController,
        amountToReceive: 'No assets supported',
        onTapAmount: (e) {},
      );
    }
    return ValueListenableBuilder(
      valueListenable: _dweService.depositAsset,
      builder: (context, selectedAsset, _) {
        if (selectedAsset == null) {
          return const SizedBox.shrink();
        }
        return FutureBuilder<TokenBalance?>(
          future: _dweService.getFungiblePrice(asset: selectedAsset),
          builder: (context, snapshot) {
            return ValueListenableBuilder(
              valueListenable: _dweService.depositAmountInUSD,
              builder: (context, selectedAmount, _) {
                final tokenBalance = snapshot.data;
                final amountToDeposit = _setAmountToDeposit(
                  selectedAsset,
                  tokenBalance,
                );
                return _AmountInputBody(
                  amountController: _amountController,
                  amountToReceive: amountToDeposit,
                  onTapAmount: (e) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    _dweService.depositAmountInUSD.value = e.toDouble();
                    _amountController.text = e.toDouble().toStringAsFixed(2);
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  String _setAmountToDeposit(
    ExchangeAsset selectedExchangeAsset,
    TokenBalance? tokenBalance,
  ) {
    if (tokenBalance == null) {
      return 'Unable to estimate';
    }
    final tokenPrice = (tokenBalance.price ?? 0.0);
    final usdValue = _dweService.depositAmountInUSD.value;
    final amount = usdValue / tokenPrice;
    _dweService.depositAmountInAsset.value = amount;
    return CoreUtils.toPrecision(amount, withSymbol: tokenBalance.symbol!);
  }
}

class _AmountInputBody extends StatelessWidget {
  IDWEService get _dweService => GetIt.I<IDWEService>();

  const _AmountInputBody({
    required this.amountController,
    required this.onTapAmount,
    required this.amountToReceive,
  });

  final TextEditingController amountController;
  final Function(int) onTapAmount;
  final String amountToReceive;

  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 40.0),
            IntrinsicWidth(
              child: TextField(
                maxLines: 1,
                cursorHeight: 40.0,
                controller: amountController,
                style: themeData.textStyles.title400.copyWith(
                  color: themeColors.foreground150,
                  fontSize: 40.0,
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  DecimalTextInputFormatter(),
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}$')),
                  LengthLimitingTextInputFormatter(10),
                ],
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '0.00',
                  hintStyle: themeData.textStyles.title400.copyWith(
                    color: themeColors.foreground275,
                    fontSize: 40.0,
                  ),
                ),
              ),
            ),
            Text(
              ' USD',
              style: themeData.textStyles.paragraph500.copyWith(
                color: themeColors.foreground275,
              ),
            ),
          ],
        ),
        Visibility(
          visible: amountToReceive.isNotEmpty,
          child: Text(
            amountToReceive,
            style: themeData.textStyles.paragraph400.copyWith(
              color: themeColors.foreground275,
            ),
          ),
        ),
        const SizedBox.square(dimension: kPadding16),
        Row(
          children: [10, 50, 100].map((e) {
            return Expanded(
              child: _AmountButton(
                value: e,
                selected: _dweService.depositAmountInUSD.value == e,
                onTap: () => onTapAmount.call(e),
              ),
            );
          }).toList(),
        ),
      ],
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
        semanticsLabel: '${runtimeType}_$value',
        size: BaseButtonSize.regular,
        child: Text('\$$value USD'),
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
          shadowColor: WidgetStateProperty.all<Color>(themeColors.grayGlass002),
          shape: WidgetStateProperty.resolveWith<RoundedRectangleBorder>((
            states,
          ) {
            return RoundedRectangleBorder(
              side: BorderSide(color: themeColors.grayGlass002, width: 1.0),
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

class DecimalTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(',', '.');
    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
