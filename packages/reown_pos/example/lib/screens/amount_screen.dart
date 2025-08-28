import 'package:example/providers/payment_info_provider.dart';
import 'package:example/screens/token_screen.dart';
import 'package:example/widgets/dtc_app_bar.dart';
import 'package:example/widgets/dtc_card.dart';
import 'package:example/widgets/dtc_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//

class AmountScreen extends ConsumerStatefulWidget {
  const AmountScreen({super.key});

  @override
  ConsumerState<AmountScreen> createState() => _AmountScreenState();
}

class _AmountScreenState extends ConsumerState<AmountScreen> {
  void _onAmountChanged(String value) {
    try {
      String amount = '';
      if (value.isNotEmpty) {
        final parsedValue = value.replaceAll(',', '.');
        amount = double.tryParse(parsedValue).toString();
      }
      ref.read(paymentInfoProvider.notifier).update(amount: amount);
    } catch (_) {}
    setState(() {});
  }

  void _navigateToTokenScreen() {
    final paymentInfo = ref.watch(paymentInfoProvider);
    debugPrint('[ReownPos] paymentInfo ${paymentInfo.toJson()}');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TokenScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const Text(
                                'Enter Payment Amount',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'Step 2: Enter the amount to charge',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 40),
                              // Payment Input Field
                              DtcCard(
                                child: Column(
                                  children: [
                                    // Dollar amount input field
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          '\$',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 48,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: TextField(
                                            onChanged: _onAmountChanged,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 48,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            keyboardType:
                                                const TextInputType.numberWithOptions(
                                                  decimal: true,
                                                ),
                                            textAlign: TextAlign.center,
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                              hintText: '0',
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 48,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    // Divider line
                                    Container(
                                      width: double.infinity,
                                      height: 1,
                                      color: Colors.grey.withValues(alpha: 0.5),
                                    ),
                                    const SizedBox(height: 16),
                                    // Manual token selection text
                                    const Text(
                                      'Manual token selection',
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
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Select Token Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed:
                              ref.read(paymentInfoProvider).amount.isNotEmpty
                              ? _navigateToTokenScreen
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
                            'Select Token',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
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
