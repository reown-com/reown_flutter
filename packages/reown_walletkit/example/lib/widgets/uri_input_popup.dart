import 'package:flutter/material.dart';
import 'package:reown_walletkit_wallet/utils/constants.dart';
import 'package:reown_walletkit_wallet/utils/string_constants.dart';

class UriInputPopup extends StatelessWidget {
  UriInputPopup({
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
      height: 280.0,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          Text(
            StringConstants.enterUri,
            style: TextStyle(fontSize: 18.0),
          ),
          const Text(
            StringConstants.enterUriMessage,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0),
          ),
          const SizedBox(height: StyleConstants.magic10),
          SizedBox(
            height: 46.0,
            child: TextFormField(
              controller: controller,
              textAlignVertical: TextAlignVertical.center,
              cursorColor: Colors.blue,
              enableSuggestions: false,
              autocorrect: false,
              cursorHeight: 16.0,
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                isDense: true,
                hintText: 'wc://as87d6...',
                hintStyle: const TextStyle(color: Colors.grey),
                border: unfocusedBorder,
                errorBorder: unfocusedBorder,
                enabledBorder: unfocusedBorder,
                disabledBorder: unfocusedBorder,
                focusedBorder: focusedBorder,
                filled: true,
                fillColor: Colors.grey[200],
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
                backgroundColor:
                    WidgetStateProperty.all<Color>(Color(0xFF667DFF)),
                foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
              ),
              child: const Text('Connect'),
            ),
          ),
          const SizedBox(height: StyleConstants.magic10),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(null),
              child: const Text(
                'Cancel',
                style: TextStyle(color: Color(0xFF667DFF)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
