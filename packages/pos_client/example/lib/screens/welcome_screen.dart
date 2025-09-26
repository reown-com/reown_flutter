// import 'package:example/providers/available_networks_provider.dart';
import 'package:example/providers/available_tokens_provider.dart';
import 'package:example/providers/pos_client_provider.dart';
import 'package:example/providers/multi_wallet_address_provider.dart';
import 'package:example/screens/amount_screen.dart';
import 'package:example/widgets/dtc_app_bar.dart';
import 'package:example/widgets/dtc_card.dart';
import 'package:example/widgets/dtc_footer.dart';
import 'package:example/widgets/dtc_wallet_address_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pos_client/pos_client.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  bool _initializing = false;
  late final IPosClient _posInstance;

  @override
  void initState() {
    super.initState();
    _posInstance = ref.read(posClilentProvider);
    _posInstance.onPosEvent.subscribe(_onPosEvent);
  }

  void _onPosEvent(PosEvent event) {
    if (event is InitializedEvent) {
      setState(() => _initializing = false);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AmountScreen()),
      );
    }
  }

  void _initPosAndNavigate() {
    setState(() => _initializing = true);

    final multiWalletAddresses = ref.read(multiWalletAddressProvider);

    if (!multiWalletAddresses.hasAnyAddress) {
      _showSetRecipientDialog();
      return;
    }

    final availableTokens = ref.watch(availableTokensProvider);
    final tokens = availableTokens.map((e) => e.posToken).toList();
    final posIntance = ref.read(posClilentProvider);
    // [PosClient SDK API] 2. call setTokens to construct namespaces with your supported networks
    posIntance
      ..setTokens(tokens: tokens)
      // [PosClient SDK API] 3. initialize PosClient SDK
      ..init();
  }

  void _showSetRecipientDialog() {
    final multiWalletAddresses = ref.read(multiWalletAddressProvider);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => DtcWalletAddressDialog(
        initialEvmValue: multiWalletAddresses.evmWalletAddress,
        initialSolanaValue: multiWalletAddresses.solanaWalletAddress,
        initialTronValue: multiWalletAddresses.tronWalletAddress,
        title: 'Set Recipient Addresses',
        message:
            'Please set wallet addresses for different networks to receive payments before starting.',
        buttonText: 'Set Addresses',
        onSuccess: _initPosAndNavigate,
        onCancel: () {
          setState(() => _initializing = false);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final posInstance = ref.read(posClilentProvider);
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
                          onPressed: _initializing ? null : _initPosAndNavigate,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4CAF50),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: (_initializing)
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
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
                        'pos_client v$packageVersion, preview - ref: fb2056aa669855b23150920161cd5e1c267d4922',
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
