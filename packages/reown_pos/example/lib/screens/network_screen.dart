import 'package:collection/collection.dart';
import 'package:example/providers/available_networks_provider.dart';
import 'package:example/providers/payment_info_provider.dart';
import 'package:example/providers/reown_pos_provider.dart';
import 'package:example/screens/payment_screen.dart';
import 'package:example/widgets/dtc_app_bar.dart';
import 'package:example/widgets/dtc_card.dart';
import 'package:example/widgets/dtc_footer.dart';
import 'package:example/widgets/dtc_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NetworkScreen extends ConsumerStatefulWidget {
  const NetworkScreen({super.key});

  @override
  ConsumerState<NetworkScreen> createState() => _NetworkScreenState();
}

class _NetworkScreenState extends ConsumerState<NetworkScreen> {
  void _createPaymentAndNavigate() {
    final paymentInfo = ref.watch(paymentInfoProvider);
    ref
        .read(reownPosProvider)
        .createPaymentIntent(paymentIntents: [paymentInfo]);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaymentScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final networks = ref.watch(availableNetworksProvider);
    final networkNotifier = ref.read(availableNetworksProvider.notifier);
    final networkSelected = ref
        .watch(availableNetworksProvider)
        .firstWhereOrNull((network) => network.selected);
    // final paymentInfo = ref.watch(paymentInfoProvider);
    final paymentInfoNotifier = ref.read(paymentInfoProvider.notifier);
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
                            final network = networks[index];
                            return GestureDetector(
                              onTap: () {
                                networkNotifier.select(network.id);
                                paymentInfoNotifier.update(chainId: network.id);
                              },
                              child: DtcCard(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal: 12.0,
                                ),
                                child: DtcItem(
                                  icon: Icons.circle,
                                  iconColor: network.color,
                                  title: network.name,
                                  subtitle: 'Fee ${network.fee}',
                                  trailing: network.selected
                                      ? Icon(Icons.check)
                                      : null,
                                ),
                              ),
                            );
                          },
                          itemCount: networks.length,
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
                          onPressed: networkSelected != null
                              ? _createPaymentAndNavigate
                              : null,
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
                      const SizedBox(height: 24),
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
