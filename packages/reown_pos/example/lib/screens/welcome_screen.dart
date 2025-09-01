// import 'package:example/providers/available_networks_provider.dart';
import 'package:example/providers/available_tokens_provider.dart';
import 'package:example/providers/payment_info_provider.dart';
import 'package:example/providers/reown_pos_provider.dart';
import 'package:example/providers/wallet_address_provider.dart';
import 'package:example/screens/amount_screen.dart';
import 'package:example/widgets/dtc_app_bar.dart';
import 'package:example/widgets/dtc_card.dart';
import 'package:example/widgets/dtc_footer.dart';
import 'package:example/widgets/dtc_wallet_address_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  void _initPosAndNavigate() {
    final walletAddress = ref.read(walletAddressProvider);

    if (walletAddress == null || walletAddress.isEmpty) {
      _showSetRecipientDialog();
      return;
    }

    final paymentInfoNotifier = ref.read(paymentInfoProvider.notifier);
    paymentInfoNotifier.update(recipient: walletAddress);
    
    final availableTokens = ref.watch(availableTokensProvider);
    final tokens = availableTokens.map((e) => e.posToken).toList();
    ref.read(reownPosProvider)
      // [ReownPos SDK API] 2. call setTokens to construct namespaces with your supported networks
      ..setTokens(tokens: tokens)
      // [ReownPos SDK API] 3. initialize ReownPos SDK
      ..init();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AmountScreen()),
    );
  }

  void _showSetRecipientDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => DtcWalletAddressDialog(
        title: 'Set Recipient',
        message:
            'Please set a wallet address to receive payments before starting.',
        buttonText: 'Set Address',
        onSuccess: _initPosAndNavigate,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final posInstance = ref.read(reownPosProvider);
    return Scaffold(
      backgroundColor: const Color(0xFF4CAF50),
      appBar: DtcAppBar(showBackButton: false),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(
                        'Welcome to ${posInstance.reOwnSign!.metadata.name}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        posInstance.reOwnSign!.metadata.description,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      // Merchant Information Card
                      DtcCard(
                        child: Column(
                          children: [
                            const Text(
                              "Mario's Italian Restaurant",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Ready to accept crypto payments',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      // Start Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _initPosAndNavigate,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4CAF50),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Start',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Version Information
                      const Text(
                        'V1: Multi-step payment flow',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Manual token & network selection',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: DtcFooter(),
    );
  }
}
