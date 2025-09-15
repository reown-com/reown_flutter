import 'package:collection/collection.dart';
import 'package:example/providers/available_tokens_provider.dart';
import 'package:example/providers/payment_info_provider.dart';
import 'package:example/providers/reown_pos_provider.dart';
import 'package:example/screens/payment_screen.dart';
import 'package:example/widgets/dtc_abort_button.dart';
import 'package:example/widgets/dtc_app_bar.dart';
import 'package:example/widgets/dtc_card.dart';
import 'package:example/widgets/dtc_footer.dart';
import 'package:example/widgets/dtc_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reown_pos/models/pos_models.dart';

class NetworkScreen extends ConsumerStatefulWidget {
  const NetworkScreen({super.key});

  @override
  ConsumerState<NetworkScreen> createState() => _NetworkScreenState();
}

class _NetworkScreenState extends ConsumerState<NetworkScreen> {
  void _createPaymentAndNavigate() {
    final paymentInfo = ref.read(paymentInfoProvider);
    // [ReownPos SDK API] 4. create a payment intent with the PaymentIntent object
    final posInstance = ref.read(reownPosProvider);
    posInstance.createPaymentIntent(paymentIntents: [paymentInfo]);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaymentScreen()),
    );
  }

  String get tokenSymbol =>
      ref
          .watch(availableTokensProvider)
          .firstWhereOrNull((token) => token.selected)
          ?.posToken
          .symbol ??
      '';

  PosToken _tokenSelected(String chainId) {
    final availableToken = ref.watch(availableTokensProvider).firstWhere((
      availableToken,
    ) {
      return availableToken.posToken.symbol == tokenSymbol &&
          availableToken.posToken.network.chainId == chainId;
    });
    return availableToken.posToken;
  }

  void _selectNetwork(PosNetwork network) {
    // final chainId = network.chainId;
    final tokenAddress = _tokenSelected(network.chainId);
    final paymentInfoNotifier = ref.read(paymentInfoProvider.notifier);
    paymentInfoNotifier.update(token: tokenAddress, network: network);
  }

  @override
  Widget build(BuildContext context) {
    final configuredTokens = ref.watch(reownPosProvider).configuredTokens;
    final availableTokens = ref.watch(availableTokensProvider);

    // Filter availableTokens to only include those that match supportedTokens
    final filteredAvailableTokens = availableTokens.where((availableToken) {
      return configuredTokens.any(
        (supportedToken) =>
            supportedToken.symbol == availableToken.posToken.symbol &&
            supportedToken.network.chainId ==
                availableToken.posToken.network.chainId &&
            supportedToken.address.toLowerCase() ==
                availableToken.posToken.address.toLowerCase(),
      );
    }).toList();

    final avaibleNetworks = filteredAvailableTokens
        .where(
          (availableToken) => availableToken.posToken.symbol == tokenSymbol,
        )
        .map((e) => e.posToken.network)
        .toList();
    final paymentInfo = ref.watch(paymentInfoProvider);
    debugPrint('[ReownPos] paymentInfo ${paymentInfo.toJson()}');
    return Scaffold(
      backgroundColor: const Color(0xFF4CAF50),
      appBar: const DtcAppBar(),
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
                      const Text(
                        'Select Network',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Step 4: Choose blockchain network',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      // Network Selection Cards
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (BuildContext context, int index) {
                            final network = avaibleNetworks[index];
                            return GestureDetector(
                              onTap: () => _selectNetwork(network),
                              child: DtcCard(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal: 12.0,
                                ),
                                child: DtcItem(
                                  icon: Icons.circle,
                                  iconColor: Colors.black,
                                  title: network.name,
                                  // subtitle: 'Fee ${network.fee}',
                                  trailing:
                                      network.chainId ==
                                          paymentInfo.token.network.chainId
                                      ? Icon(Icons.check)
                                      : null,
                                ),
                              ),
                            );
                          },
                          itemCount: avaibleNetworks.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox.square(dimension: 12.0);
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Select Network button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: paymentInfo.token.network.chainId.isEmpty
                              ? null
                              : _createPaymentAndNavigate,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4CAF50),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Start Payment',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: DtcRestartButton(),
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
