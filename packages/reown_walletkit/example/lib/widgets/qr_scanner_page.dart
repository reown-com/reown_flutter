import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:reown_walletkit_wallet/theme/app_spacing.dart';

/// Full-screen QR scanner backed by `mobile_scanner`.
///
/// Pops with the first detected barcode's raw value (a `String`), or `null`
/// if the user closes it without scanning.
///
/// Unlike the previous `qr_code_scanner`/`QRView` based scanner, this uses a
/// texture-backed camera preview that initializes and tears down off the UI
/// thread, so opening and (especially) closing it no longer freezes the app
/// while the next modal animates in.
class QrScannerPage extends StatefulWidget {
  const QrScannerPage({super.key});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage>
    with WidgetsBindingObserver {
  // autoStart must be false: we start/stop the controller ourselves in
  // initState and the lifecycle handler. If left true, the MobileScanner widget
  // would also call start(), double-starting the shared platform camera and
  // throwing `controllerAlreadyInitialized` on the second scan.
  final MobileScannerController _controller = MobileScannerController(
    autoStart: false,
    formats: const [BarcodeFormat.qrCode],
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  StreamSubscription<Object?>? _subscription;
  bool _handled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _subscription = _controller.barcodes.listen(_onDetect);
    unawaited(_controller.start());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // The camera can only be paused/resumed once permission is granted.
    if (!_controller.value.hasCameraPermission) return;

    switch (state) {
      case AppLifecycleState.resumed:
        _subscription = _controller.barcodes.listen(_onDetect);
        unawaited(_controller.start());
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
      case AppLifecycleState.detached:
        unawaited(_subscription?.cancel());
        _subscription = null;
        unawaited(_controller.stop());
    }
  }

  void _onDetect(BarcodeCapture capture) {
    if (_handled) return;
    final code = capture.barcodes
        .map((b) => b.rawValue)
        .firstWhere((v) => v != null && v.isNotEmpty, orElse: () => null);
    if (code == null) return;
    _handled = true;
    Navigator.of(context).pop(code);
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_subscription?.cancel());
    _subscription = null;
    super.dispose();
    await _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: MobileScanner(
              controller: _controller,
              // We manage the detection stream manually, so no onDetect here.
              errorBuilder: (context, error, child) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.s6),
                    child: Text(
                      'Unable to access the camera.\n${error.errorCode.name}',
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  ),
                );
              },
            ),
          ),
          // Darken everything except a clear square in the center, with the
          // torch + hint positioned just below that square.
          Positioned.fill(
            child: _ScannerOverlay(
              borderColor: Colors.black,
              onToggleTorch: () => unawaited(_controller.toggleTorch()),
            ),
          ),
          // Close button, top-right.
          Positioned(
            top: 0.0,
            right: 0.0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.s4),
                child: _CircleIconButton(
                  icon: Icons.close,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black45,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.s2),
          child: Icon(icon, color: Colors.white, size: 24.0),
        ),
      ),
    );
  }
}

/// Darkens the screen with a clear, rounded square cut-out in the center, and
/// places the torch toggle + hint text just below the square.
class _ScannerOverlay extends StatelessWidget {
  const _ScannerOverlay({
    required this.borderColor,
    required this.onToggleTorch,
  });

  final Color borderColor;
  final VoidCallback onToggleTorch;

  static const double _cutoutFraction = 0.7;
  static const double _cutoutRadius = 24.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        final side = size.shortestSide * _cutoutFraction;
        final cutout = Rect.fromCenter(
          center: Offset(size.width / 2, size.height / 2),
          width: side,
          height: side,
        );

        return Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _ScannerScrimPainter(
                  cutout: cutout,
                  radius: _cutoutRadius,
                  borderColor: borderColor,
                ),
              ),
            ),
            Positioned(
              top: cutout.bottom + AppSpacing.s6,
              left: 0.0,
              right: 0.0,
              child: Column(
                children: [
                  _CircleIconButton(
                    icon: Icons.flashlight_on_outlined,
                    onPressed: onToggleTorch,
                  ),
                  const SizedBox(height: AppSpacing.s4),
                  const Text(
                    'Scan a WalletConnect QR code',
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Paints a semi-transparent scrim everywhere except a rounded square hole,
/// with a colored border around the hole.
class _ScannerScrimPainter extends CustomPainter {
  _ScannerScrimPainter({
    required this.cutout,
    required this.radius,
    required this.borderColor,
  });

  final Rect cutout;
  final double radius;
  final Color borderColor;

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(cutout, Radius.circular(radius));
    final scrim = Path.combine(
      PathOperation.difference,
      Path()..addRect(Offset.zero & size),
      Path()..addRRect(rrect),
    );
    canvas.drawPath(
      scrim,
      Paint()..color = Colors.black.withValues(alpha: 0.6),
    );
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.0,
    );
  }

  @override
  bool shouldRepaint(covariant _ScannerScrimPainter oldDelegate) {
    return oldDelegate.cutout != cutout ||
        oldDelegate.radius != radius ||
        oldDelegate.borderColor != borderColor;
  }
}
