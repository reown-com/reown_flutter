import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/dependencies/deep_link_handler.dart';
import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/theme/app_colors.dart';
import 'package:reown_walletkit_wallet/theme/app_radius.dart';

class ScanModal extends StatelessWidget {
  const ScanModal({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20.0),
        _OptionCard(
          svgAsset: 'assets/Barcode.svg',
          title: 'Scan QR code',
          onTap: () => _onScanQrCode(context),
          colors: colors,
        ),
        const SizedBox(height: 8.0),
        _OptionCard(
          svgAsset: 'assets/Copy.svg',
          title: 'Paste a URL',
          onTap: () => _onPasteUri(context),
          colors: colors,
        ),
      ],
    );
  }

  void _onScanQrCode(BuildContext context) {
    final navigator = Navigator.of(context);
    navigator.pop();
    try {
      QrBarCodeScannerDialog().getScannedQrBarCode(
        context: context,
        onCode: (value) {
          _pairWithUri(context, value);
        },
      );
    } catch (e) {
      debugPrint('[ScanModal] scan error: $e');
    }
  }

  Future<void> _onPasteUri(BuildContext context) async {
    final navigator = Navigator.of(context);
    navigator.pop();
    try {
      final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
      final uri = clipboardData?.text?.trim();
      if (uri == null || uri.isEmpty) {
        if (context.mounted) _showError(context, 'Clipboard is empty');
        return;
      }
      _pairWithUri(context, uri);
    } catch (e) {
      if (context.mounted) {
        _showError(context, 'Failed to read clipboard');
      }
    }
  }

  Future<void> _pairWithUri(BuildContext context, String? uri) async {
    if (uri == null || uri.isEmpty) return;
    final walletKitService = GetIt.I<IWalletKitService>();
    try {
      DeepLinkHandler.waiting.value = true;
      await walletKitService.pair(uri);
    } on TimeoutException catch (_) {
      if (context.mounted) {
        _showError(context, 'Time out error. Check your connection.');
      }
    } on ReownSignError catch (e) {
      if (context.mounted) {
        _showError(context, '${e.code}:\n${e.message}');
      }
    } on PayInitializeError catch (e) {
      if (context.mounted) {
        _showError(context, '${e.code}:\n${e.message}');
      }
    } on GetPaymentOptionsError catch (e) {
      if (context.mounted) {
        _showError(context, '${e.code}:\n${e.message}');
      }
    } on GetRequiredActionsError catch (e) {
      if (context.mounted) {
        _showError(context, '${e.code}:\n${e.message}');
      }
    } on ConfirmPaymentError catch (e) {
      if (context.mounted) {
        _showError(context, '${e.code}:\n${e.message}');
      }
    } on PayError catch (e) {
      if (context.mounted) {
        _showError(context, '${e.code}\n${e.message}');
      }
    } catch (e) {
      if (context.mounted) {
        _showError(context, 'Invalid URI or connection error:\n$e');
      }
    } finally {
      DeepLinkHandler.waiting.value = false;
    }
  }

  void _showError(BuildContext context, String message) {
    final colors = context.colors;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: colors.background,
          title: Text(
            'Error',
            style: TextStyle(
              color: colors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            message,
            style: TextStyle(color: colors.textPrimary),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child: Text(
                'Close',
                style: TextStyle(
                  color: colors.accent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _OptionCard extends StatelessWidget {
  const _OptionCard({
    required this.svgAsset,
    required this.title,
    required this.onTap,
    required this.colors,
  });

  final String svgAsset;
  final String title;
  final VoidCallback onTap;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: colors.backgroundSecondary,
          borderRadius: AppRadius.borderRadiusLg,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SvgPicture.asset(
              svgAsset,
              width: 20.0,
              height: 20.0,
              colorFilter: ColorFilter.mode(
                colors.textPrimary,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
