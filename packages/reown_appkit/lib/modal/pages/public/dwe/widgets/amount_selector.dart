import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/services/dwe_service/i_dwe_service.dart';
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
      text: _dweService.selectedAmount.value > 0.0
          ? _dweService.selectedAmount.value.toString()
          : '',
    );
    _amountController.addListener(() {
      try {
        _dweService.selectedAmount.value = _amountController.text.isEmpty
            ? 0.0
            : double.parse(_amountController.text);
      } catch (_) {}
    });
  }

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
          future: _dweService.getFungiblePrice(asset: selectedAsset),
          builder: (context, snapshot) {
            return ValueListenableBuilder(
              valueListenable: _dweService.selectedAmount,
              builder: (context, selectedAmount, _) {
                final token = snapshot.data;
                final amountToReceive = token != null
                    ? (_dweService.selectedAmount.value.toDouble() /
                              (token.price ?? 0.0))
                          .toStringAsFixed(4)
                    : 'Unable to estimate ';
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
                            controller: _amountController,
                            style: themeData.textStyles.title400.copyWith(
                              color: themeColors.foreground150,
                              fontSize: 40.0,
                            ),
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            inputFormatters: [
                              DecimalTextInputFormatter(),
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d{0,2}$'),
                              ),
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
                    Text(
                      '$amountToReceive ${selectedAsset.metadata.symbol}',
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
                            selected: _dweService.selectedAmount.value == e,
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              _dweService.selectedAmount.value = e.toDouble();
                              _amountController.text = _dweService
                                  .selectedAmount
                                  .value
                                  .toString();
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
