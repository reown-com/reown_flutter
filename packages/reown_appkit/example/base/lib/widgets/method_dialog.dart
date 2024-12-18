// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reown_appkit_dapp/utils/constants.dart';
import 'package:reown_appkit_dapp/utils/string_constants.dart';
import 'package:toastification/toastification.dart';

class MethodDialog extends StatefulWidget {
  static Future<void> show(
    BuildContext context,
    String method,
    Future<dynamic> response,
  ) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return MethodDialog(
          method: method,
          response: response,
        );
      },
    );
  }

  const MethodDialog({
    super.key,
    required this.method,
    required this.response,
  });

  final String method;
  final Future<dynamic> response;

  @override
  MethodDialogState createState() => MethodDialogState();
}

class MethodDialogState extends State<MethodDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.method),
      content: FutureBuilder<dynamic>(
        future: widget.response,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            final String t = jsonEncode(snapshot.data);
            return InkWell(
              onTap: () {
                Clipboard.setData(ClipboardData(text: t)).then(
                  (_) => toastification.show(
                    title: const Text(StringConstants.copiedToClipboard),
                    context: context,
                    autoCloseDuration: Duration(seconds: 2),
                    alignment: Alignment.bottomCenter,
                  ),
                );
              },
              child: Text(t),
            );
          } else if (snapshot.hasError) {
            return InkWell(
              onTap: () {
                Clipboard.setData(ClipboardData(text: snapshot.data.toString()))
                    .then(
                  (_) => toastification.show(
                    title: const Text(StringConstants.copiedToClipboard),
                    context: context,
                    autoCloseDuration: Duration(seconds: 2),
                    alignment: Alignment.bottomCenter,
                  ),
                );
              },
              child: Text(
                snapshot.error.toString(),
              ),
            );
          } else {
            return const SizedBox(
              width: StyleConstants.linear48,
              height: StyleConstants.linear48,
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            StringConstants.close,
          ),
        ),
      ],
    );
  }
}
