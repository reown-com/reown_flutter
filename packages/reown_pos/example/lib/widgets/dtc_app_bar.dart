import 'package:example/providers/reown_pos_provider.dart';
import 'package:example/providers/multi_wallet_address_provider.dart';
import 'package:example/widgets/dtc_wallet_address_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DtcAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final bool showBackButton;
  const DtcAppBar({super.key, this.showBackButton = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posInstance = ref.read(reownPosProvider);
    final multiWalletAddresses = ref.watch(multiWalletAddressProvider);
    
    return AppBar(
      backgroundColor: const Color(0xFF4CAF50),
      elevation: 0,
      leading: const SizedBox.shrink(),
      title: Column(
        children: [
          Text(
            posInstance.reOwnSign!.metadata.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            posInstance.reOwnSign!.metadata.description,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () =>
              _showWalletAddressDialog(context, ref, multiWalletAddresses),
          icon: const Icon(Icons.settings, color: Colors.white),
        ),
      ],
    );
  }

  void _showWalletAddressDialog(
    BuildContext context,
    WidgetRef ref,
    MultiWalletAddresses multiWalletAddresses,
  ) {
    showDialog(
      context: context,
      builder: (context) => DtcWalletAddressDialog(
        initialEvmValue: multiWalletAddresses.evmWalletAddress,
        initialSolanaValue: multiWalletAddresses.solanaWalletAddress,
        initialTronValue: multiWalletAddresses.tronWalletAddress,
        title: 'Set Recipient Addresses',
        message: 'Enter wallet addresses for different networks:',
        buttonText: 'Save',
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
