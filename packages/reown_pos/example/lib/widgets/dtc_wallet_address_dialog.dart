import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:example/providers/wallet_address_provider.dart';

class DtcWalletAddressDialog extends ConsumerStatefulWidget {
  final String? initialValue;
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback? onSuccess;

  const DtcWalletAddressDialog({
    super.key,
    this.initialValue,
    this.title = 'Set Recipient',
    this.message = 'Enter the wallet address where you want to receive payments:',
    this.buttonText = 'Save',
    this.onSuccess,
  });

  @override
  ConsumerState<DtcWalletAddressDialog> createState() => _DtcWalletAddressDialogState();
}

class _DtcWalletAddressDialogState extends ConsumerState<DtcWalletAddressDialog> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialValue ?? '');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.message),
          const SizedBox(height: 16),
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Wallet Address',
              hintText: '0x...',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (controller.text.isNotEmpty) {
              await ref.read(walletAddressProvider.notifier).save(controller.text);
              if (context.mounted) {
                Navigator.pop(context);
                widget.onSuccess?.call();
              }
            }
          },
          child: Text(widget.buttonText),
        ),
      ],
    );
  }
}
