import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:example/providers/multi_wallet_address_provider.dart';

class DtcWalletAddressDialog extends ConsumerStatefulWidget {
  final String? initialEvmValue;
  final String? initialSolanaValue;
  final String? initialTronValue;
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback? onSuccess;
  final VoidCallback? onCancel;

  const DtcWalletAddressDialog({
    super.key,
    this.initialEvmValue,
    this.initialSolanaValue,
    this.initialTronValue,
    this.title = 'Set Recipient Addresses',
    this.message = 'Enter wallet addresses for different networks:',
    this.buttonText = 'Save',
    this.onSuccess,
    this.onCancel,
  });

  @override
  ConsumerState<DtcWalletAddressDialog> createState() =>
      _DtcWalletAddressDialogState();
}

class _DtcWalletAddressDialogState
    extends ConsumerState<DtcWalletAddressDialog> {
  late TextEditingController evmController;
  late TextEditingController solanaController;
  late TextEditingController tronController;

  @override
  void initState() {
    super.initState();
    evmController = TextEditingController(text: widget.initialEvmValue ?? '');
    solanaController = TextEditingController(
      text: widget.initialSolanaValue ?? '',
    );
    tronController = TextEditingController(text: widget.initialTronValue ?? '');
  }

  @override
  void dispose() {
    evmController.dispose();
    solanaController.dispose();
    tronController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.message),
            const SizedBox(height: 16),
            // EVM Address
            TextField(
              controller: evmController,
              decoration: const InputDecoration(
                labelText: 'EVM Wallet Address (Ethereum, Polygon, etc.)',
                hintText: '0x...',
                prefixIcon: Icon(
                  Icons.account_balance_wallet,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Solana Address
            TextField(
              controller: solanaController,
              decoration: const InputDecoration(
                labelText: 'Solana Wallet Address',
                hintText: 'Base58...',
                prefixIcon: Icon(
                  Icons.account_balance_wallet,
                  color: Colors.purple,
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Tron Address
            TextField(
              controller: tronController,
              decoration: const InputDecoration(
                labelText: 'Tron Wallet Address',
                hintText: 'T...',
                prefixIcon: Icon(
                  Icons.account_balance_wallet,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
            widget.onCancel?.call();
          },
        ),
        ElevatedButton(
          onPressed: () async {
            final multiWalletNotifier = ref.read(
              multiWalletAddressProvider.notifier,
            );

            // Save addresses if they are not empty
            if (evmController.text.isNotEmpty) {
              await multiWalletNotifier.saveEvmAddress(evmController.text);
            }
            if (solanaController.text.isNotEmpty) {
              await multiWalletNotifier.saveSolanaAddress(
                solanaController.text,
              );
            }
            if (tronController.text.isNotEmpty) {
              await multiWalletNotifier.saveTronAddress(tronController.text);
            }

            if (context.mounted) {
              Navigator.pop(context);
              widget.onSuccess?.call();
            }
          },
          child: Text(widget.buttonText),
        ),
      ],
    );
  }
}
