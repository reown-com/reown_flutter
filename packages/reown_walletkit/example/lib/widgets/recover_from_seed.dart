import 'package:flutter/material.dart';
import 'package:reown_walletkit_wallet/utils/constants.dart';

class RecoverFromSeed extends StatelessWidget {
  RecoverFromSeed({
    super.key,
  });

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final unfocusedBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
      borderRadius: BorderRadius.circular(12.0),
    );
    final focusedBorder = unfocusedBorder.copyWith(
      borderSide: const BorderSide(color: Colors.blue, width: 1.0),
    );
    return Container(
      height: 340.0,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          Text(
            'Insert Mnemonic or Private Key',
            style: StyleConstants.subtitleText.copyWith(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
              fontSize: 18.0,
            ),
          ),
          const SizedBox(height: StyleConstants.magic10),
          Text(
            'Only Ethereum private key is supported for now, if you want to restore other chains as well please use mnemonic phrase',
            style: StyleConstants.bodyText.copyWith(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
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
              cursorColor: Colors.blue,
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
                backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
                foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
              ),
              child: const Text('Recover'),
            ),
          ),
          const SizedBox(height: StyleConstants.magic10),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(null),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
