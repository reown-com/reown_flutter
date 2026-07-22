import 'package:flutter/material.dart';
import 'package:reown_appkit/reown_appkit.dart';

/// Result screen shown after the Pay checkout reports `PAY_SUCCESS`.
///
/// Mirrors the React Native sample's `PaySuccessView`, but uses a plain
/// Material check icon instead of a Lottie animation to avoid an extra
/// dependency in the example app.
class PaySuccessView extends StatelessWidget {
  const PaySuccessView({super.key, this.message, required this.onDone});

  /// Optional human-readable confirmation summary from the checkout.
  final String? message;

  /// Called when the user taps "Done".
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return Scaffold(
      backgroundColor: themeColors.background125,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle,
                  size: 120.0,
                  color: themeColors.success100,
                ),
                const SizedBox(height: 24.0),
                Text(
                  message?.isNotEmpty == true ? message! : 'Payment confirmed',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: themeColors.foreground100,
                  ),
                ),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: onDone,
                  child: const Text('Done'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
