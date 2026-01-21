import 'package:flutter/material.dart';
import 'package:reown_walletkit_wallet/utils/constants.dart';

class InputWalletConnectPayApiKey extends StatelessWidget {
  InputWalletConnectPayApiKey({super.key});

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final unfocusedBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
      borderRadius: BorderRadius.circular(12.0),
    );
    final focusedBorder = unfocusedBorder.copyWith(
      borderSide: BorderSide(color: StyleConstants.accentPrimary, width: 1.0),
    );
    return Container(
      height: 280.0,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          Text(
            'Insert WalletConnectPay API Key',
            style: StyleConstants.subtitleText.copyWith(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
              fontSize: 18.0,
            ),
          ),
          const SizedBox(height: StyleConstants.magic20),
          SizedBox(
            height: 60.0,
            // padding: const EdgeInsets.all(3.0),
            child: TextFormField(
              controller: controller,
              maxLines: 4,
              textAlignVertical: TextAlignVertical.center,
              cursorColor: StyleConstants.accentPrimary,
              enableSuggestions: false,
              autocorrect: false,
              cursorHeight: 16.0,
              decoration: InputDecoration(
                isDense: true,
                hintStyle: const TextStyle(color: Colors.grey),
                border: unfocusedBorder,
                errorBorder: unfocusedBorder,
                enabledBorder: unfocusedBorder,
                disabledBorder: unfocusedBorder,
                focusedBorder: focusedBorder,
                filled: true,
                fillColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white24
                    : Colors.black12,
                contentPadding: const EdgeInsets.all(8.0),
              ),
            ),
          ),
          const SizedBox(height: StyleConstants.magic10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(controller.text),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(
                  StyleConstants.accentPrimary,
                ),
                foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
              ),
              child: const Text('Set'),
            ),
          ),
          const SizedBox(height: StyleConstants.magic10),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(''),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
          ),
        ],
      ),
    );
  }
}
