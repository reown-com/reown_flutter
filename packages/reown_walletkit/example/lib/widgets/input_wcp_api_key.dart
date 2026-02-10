import 'package:flutter/material.dart';
import 'package:reown_walletkit_wallet/theme/app_colors.dart';
import 'package:reown_walletkit_wallet/theme/app_typography.dart';

class InputWalletConnectPayApiKey extends StatelessWidget {
  InputWalletConnectPayApiKey({super.key});

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final unfocusedBorder = OutlineInputBorder(
      borderSide: BorderSide(color: colors.inputBorder, width: 1.0),
      borderRadius: BorderRadius.circular(12.0),
    );
    final focusedBorder = unfocusedBorder.copyWith(
      borderSide: BorderSide(color: colors.inputBorderFocused, width: 1.0),
    );
    return Container(
      height: 280.0,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          Text(
            'Insert WalletConnectPay API Key',
            style: context.textStyles.subtitleText.copyWith(fontSize: 18.0),
          ),
          const SizedBox(height: 20.0),
          SizedBox(
            height: 60.0,
            child: TextFormField(
              controller: controller,
              maxLines: 4,
              textAlignVertical: TextAlignVertical.center,
              cursorColor: colors.accent,
              enableSuggestions: false,
              autocorrect: false,
              cursorHeight: 16.0,
              style: TextStyle(color: colors.textPrimary),
              decoration: InputDecoration(
                isDense: true,
                hintStyle: TextStyle(color: colors.textSecondary),
                border: unfocusedBorder,
                errorBorder: unfocusedBorder,
                enabledBorder: unfocusedBorder,
                disabledBorder: unfocusedBorder,
                focusedBorder: focusedBorder,
                filled: true,
                fillColor: colors.inputFill,
                contentPadding: const EdgeInsets.all(8.0),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(controller.text),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(colors.accent),
                foregroundColor:
                    WidgetStateProperty.all<Color>(colors.onAccent),
              ),
              child: const Text('Set'),
            ),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(''),
              child: Text(
                'Cancel',
                style: TextStyle(color: colors.textSecondary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
