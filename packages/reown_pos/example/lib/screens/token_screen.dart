import 'package:collection/collection.dart';
import 'package:example/models/available_token.dart';
import 'package:example/providers/available_tokens_provider.dart';
import 'package:example/screens/network_screen.dart';
import 'package:example/widgets/dtc_app_bar.dart';

import 'package:example/widgets/dtc_card.dart';
import 'package:example/widgets/dtc_footer.dart';
import 'package:example/widgets/dtc_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//

class TokenScreen extends ConsumerStatefulWidget {
  const TokenScreen({super.key});

  @override
  ConsumerState<TokenScreen> createState() => _TokenScreenState();
}

class _TokenScreenState extends ConsumerState<TokenScreen> {
  void _navigateToNetworkScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NetworkScreen()),
    );
  }

  void _selectToken(AvailableToken token) {
    ref.read(availableTokensProvider.notifier).select(token);
  }

  @override
  Widget build(BuildContext context) {
    final availableTokens = ref.watch(availableTokensProvider);
    final reducedTokens = availableTokens
        .toSet()
        .fold<Map<String, AvailableToken>>({}, (map, token) {
          map.putIfAbsent(token.posToken.symbol, () => token);
          return map;
        })
        .values
        .toList();
    final tokenSelected = ref
        .watch(availableTokensProvider)
        .firstWhereOrNull((token) => token.selected);
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
                        'Select Token',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Step 3: Choose payment token',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      // Token Selection Card
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            final token = reducedTokens[index];
                            return GestureDetector(
                              onTap: () => _selectToken(token),
                              child: DtcCard(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal: 12.0,
                                ),
                                child: DtcItem(
                                  icon: Icons.circle,
                                  iconColor: token.color,
                                  title: token.posToken.symbol.toUpperCase(),
                                  // subtitle:
                                  //     'On ${token.token.network.networkData.name}',
                                  trailing: token.selected
                                      ? Icon(Icons.check)
                                      : null,
                                ),
                              ),
                            );
                          },
                          itemCount: reducedTokens.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox.square(dimension: 12.0);
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Select Network Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: tokenSelected != null
                              ? _navigateToNetworkScreen
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
                            'Select Network',
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
