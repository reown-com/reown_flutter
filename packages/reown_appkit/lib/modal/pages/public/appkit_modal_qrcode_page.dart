import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:shimmer/shimmer.dart';

import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/widgets/buttons/simple_icon_button.dart';
import 'package:reown_appkit/modal/widgets/qr_code_view.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/responsive_container.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar.dart';
import 'package:reown_appkit/modal/services/toast_service/models/toast_message.dart';
import 'package:reown_appkit/modal/services/toast_service/toast_service_singleton.dart';

class ReownAppKitModalQRCodePage extends StatefulWidget {
  const ReownAppKitModalQRCodePage() : super(key: KeyConstants.qrCodePageKey);

  @override
  State<ReownAppKitModalQRCodePage> createState() =>
      _AppKitModalQRCodePageState();
}

class _AppKitModalQRCodePageState extends State<ReownAppKitModalQRCodePage> {
  IReownAppKitModal? _service;
  Widget? _qrQodeWidget;
  //

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _service = ModalProvider.of(context).instance;
      _service!.addListener(_buildWidget);
      _service!.appKit!.core.pairing.onPairingExpire.subscribe(
        _onPairingExpire,
      );
      _service?.onModalError.subscribe(_onError);
      await _service!.buildConnectionUri();
    });
  }

  void _buildWidget() => setState(() {
        _qrQodeWidget = QRCodeView(
          uri: _service!.wcUri!,
          logoPath: 'lib/modal/assets/png/logo_wc.png',
        );
      });

  void _onPairingExpire(EventArgs? args) async {
    await _service!.buildConnectionUri();
    setState(() {});
  }

  void _onError(ModalError? args) {
    final event = args ?? ModalError('An error occurred');
    toastService.instance.show(
      ToastMessage(
        type: ToastType.error,
        text: event.message,
      ),
    );
  }

  @override
  void dispose() async {
    _service?.onModalError.unsubscribe(_onError);
    _service!.appKit!.core.pairing.onPairingExpire.unsubscribe(
      _onPairingExpire,
    );
    _service!.removeListener(_buildWidget);
    _service!.expirePreviousInactivePairings();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    final isPortrait = ResponsiveData.isPortrait(context);

    return ModalNavbar(
      title: 'WalletConnect',
      body: SingleChildScrollView(
        scrollDirection: isPortrait ? Axis.vertical : Axis.horizontal,
        child: Flex(
          direction: isPortrait ? Axis.vertical : Axis.horizontal,
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: _qrQodeWidget ??
                  AspectRatio(
                    aspectRatio: 1.0,
                    child: Shimmer.fromColors(
                      baseColor: themeColors.grayGlass100,
                      highlightColor: themeColors.grayGlass025,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radiuses.radiusL),
                          color: themeColors.grayGlass010,
                        ),
                      ),
                    ),
                  ),
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: isPortrait
                    ? ResponsiveData.maxWidthOf(context)
                    : (ResponsiveData.maxHeightOf(context) -
                        kNavbarHeight -
                        32.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Scan this QR code with your phone',
                    textAlign: TextAlign.center,
                    style: themeData.textStyles.paragraph500.copyWith(
                      color: themeColors.foreground100,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: kPadding12),
                    child: SimpleIconButton(
                      onTap: () => _copyToClipboard(context),
                      leftIcon: 'lib/modal/assets/icons/copy_14.svg',
                      iconSize: 13.0,
                      title: 'Copy link',
                      fontSize: 14.0,
                      backgroundColor: Colors.transparent,
                      foregroundColor: themeColors.foreground200,
                      overlayColor: MaterialStateProperty.all<Color>(
                        themeColors.background200,
                      ),
                      withBorder: false,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _copyToClipboard(BuildContext context) async {
    final service = ModalProvider.of(context).instance;
    await Clipboard.setData(ClipboardData(text: service.wcUri!));
    toastService.instance.show(
      ToastMessage(type: ToastType.success, text: 'Link copied'),
    );
  }
}
