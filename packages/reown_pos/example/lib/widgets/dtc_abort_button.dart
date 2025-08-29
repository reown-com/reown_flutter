import 'package:example/providers/available_tokens_provider.dart';
import 'package:example/providers/payment_info_provider.dart';
import 'package:example/providers/reown_pos_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DtcRestartButton extends ConsumerWidget {
  const DtcRestartButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {
        ref.read(paymentInfoProvider.notifier).clear();
        ref.read(availableTokensProvider.notifier).clear();
        ref.read(reownPosProvider).restart();
        Navigator.of(context).popUntil((route) => route.settings.name == '/');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 0,
      ),
      child: const Text(
        'Restart',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
