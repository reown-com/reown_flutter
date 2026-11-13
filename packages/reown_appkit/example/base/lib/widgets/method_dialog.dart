// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reown_appkit_dapp/utils/constants.dart';
import 'package:reown_appkit_dapp/utils/string_constants.dart';
import 'package:toastification/toastification.dart';

class MethodDialog extends StatefulWidget {
  static Future<dynamic> show(
    BuildContext context,
    String method,
    Future<dynamic> response,
  ) async {
    return showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) {
        return MethodDialog(method: method, response: response);
      },
    );
  }

  const MethodDialog({super.key, required this.method, required this.response});

  final String method;
  final Future<dynamic> response;

  @override
  MethodDialogState createState() => MethodDialogState();
}

class MethodDialogState extends State<MethodDialog> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: widget.response,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        // A rejected request either throws (hasError) or, for some SDK
        // errors, completes with no result; both are an error. The title
        // ("<method> success" / "<method> error") is what the connect E2E
        // flows check (.maestro/flows/connect_dapp_sign_result.yaml).
        final done = snapshot.connectionState == ConnectionState.done;
        String result = '';
        if (done) {
          if (snapshot.hasError || snapshot.data == null) {
            result = ' error';
          } else {
            final response = jsonEncode(snapshot.data).replaceAll('"', '');
            result = response.contains('error') ? ' error' : ' success';
          }
        }
        return AlertDialog(
          title: Text('${widget.method}$result'),
          content: Builder(
            builder: (BuildContext context) {
              if (!done) {
                return const SizedBox(
                  width: StyleConstants.linear48,
                  height: StyleConstants.linear48,
                  child: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError) {
                return InkWell(
                  onTap: () {
                    Clipboard.setData(
                      ClipboardData(text: snapshot.data.toString()),
                    ).then(
                      (_) => toastification.show(
                        title: const Text(StringConstants.copiedToClipboard),
                        context: context,
                        autoCloseDuration: Duration(seconds: 2),
                        alignment: Alignment.bottomCenter,
                      ),
                    );
                  },
                  child: Text(snapshot.error.toString()),
                );
              } else {
                final response = const JsonEncoder.withIndent(
                  '   ',
                ).convert(snapshot.data);
                return InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: response)).then(
                      (_) => toastification.show(
                        title: const Text(StringConstants.copiedToClipboard),
                        context: context,
                        autoCloseDuration: Duration(seconds: 2),
                        alignment: Alignment.bottomCenter,
                      ),
                    );
                  },
                  child: Text(response),
                );
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(snapshot.data);
              },
              child: const Text(StringConstants.close),
            ),
          ],
        );
      },
    );
  }
}
