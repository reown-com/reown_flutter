import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/dependencies/deep_link_handler.dart';
import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/main.dart' show navigatorKey;
import 'package:reown_walletkit_wallet/theme/app_colors.dart';
import 'package:reown_walletkit_wallet/theme/app_radius.dart';
import 'package:reown_walletkit_wallet/theme/app_spacing.dart';

class ScanModal extends StatelessWidget {
  const ScanModal({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: AppSpacing.s5),
        _OptionCard(
          svgAsset: 'assets/Barcode.svg',
          title: 'Scan QR code',
          onTap: () => _onScanQrCode(context),
          colors: colors,
        ),
        const SizedBox(height: AppSpacing.s2),
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
    Navigator.of(context).pop();
    final rootContext = navigatorKey.currentContext;
    if (rootContext == null) return;
    try {
      QrBarCodeScannerDialog().getScannedQrBarCode(
        context: rootContext,
        onCode: (value) {
          _pairWithUri(value);
        },
      );
    } catch (e) {
      debugPrint('[ScanModal] scan error: $e');
    }
  }

  Future<void> _onPasteUri(BuildContext context) async {
    Navigator.of(context).pop();
    try {
      final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
      final uri = clipboardData?.text?.trim();
      if (uri == null || uri.isEmpty) {
        _showError('Clipboard is empty');
        return;
      }
      await _pairWithUri(uri);
    } catch (e) {
      _showError('Failed to read clipboard');
    }
  }

  Future<void> _pairWithUri(String? uri) async {
    if (uri == null || uri.isEmpty) return;
    final walletKitService = GetIt.I<IWalletKitService>();
    try {
      DeepLinkHandler.waiting.value = true;
      await walletKitService.pair(uri);
    } on TimeoutException catch (_) {
      _showError('Timeout error. Check your connection.');
    } on ReownSignError catch (e) {
      _showError('${e.code}: ${e.message}');
    } on PayInitializeError catch (e) {
      _showError('${e.code}: ${e.message}');
    } on GetPaymentOptionsError catch (e) {
      _showError('${e.code}: ${e.message}');
    } on GetRequiredActionsError catch (e) {
      _showError('${e.code}: ${e.message}');
    } on ConfirmPaymentError catch (e) {
      _showError('${e.code}: ${e.message}');
    } on PayError catch (e) {
      _showError('${e.code}: ${e.message}');
    } catch (e) {
      _showError('Invalid URI or connection error: $e');
    } finally {
      DeepLinkHandler.waiting.value = false;
    }
  }

  void _showError(String message) {
    final context = navigatorKey.currentContext;
    if (context == null) return;
    final colors = context.colors;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: colors.onAccent),
        ),
        backgroundColor: colors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        margin: const EdgeInsets.all(AppSpacing.s4),
      ),
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
        padding: const EdgeInsets.all(AppSpacing.s6),
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
