import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/pages/social_login_page.dart';
import 'package:reown_appkit/modal/widgets/buttons/primary_button.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/widget_stack_singleton.dart';
import 'package:reown_appkit/reown_appkit.dart';

import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/widgets/qr_code_view.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/responsive_container.dart';
import 'package:reown_appkit/modal/widgets/navigation/navbar.dart';
import 'package:shimmer/shimmer.dart';

class FarcasterQRCodePage extends StatefulWidget {
  const FarcasterQRCodePage({
    required this.farcasterUri,
    required this.farcasterCompleter,
  }) : super(key: KeyConstants.farcasterQrCodePageKey);
  final String farcasterUri;
  final Future<bool>? farcasterCompleter;

  @override
  State<FarcasterQRCodePage> createState() => _FarcasterQRCodePageState();
}

class _FarcasterQRCodePageState extends State<FarcasterQRCodePage> {
  Widget? _qrQodeWidget;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _qrQodeWidget = QRCodeView(
        uri: widget.farcasterUri,
        logoPath: 'lib/modal/assets/png/farcaster.png',
      );
      setState(() {});
      widget.farcasterCompleter?.then((value) {
        widgetStack.instance.push(
          SocialLoginPage(
            socialOption: AppKitSocialOption.Farcaster,
            farcasterCompleter: widget.farcasterCompleter,
          ),
          replace: true,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    final isPortrait = ResponsiveData.isPortrait(context);

    return ModalNavbar(
      title: 'Farcaster',
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
                    'Scan this QR code with your phone or',
                    textAlign: TextAlign.center,
                    style: themeData.textStyles.paragraph500.copyWith(
                      color: themeColors.foreground100,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: kPadding12),
                    child: PrimaryButton(
                      title: 'Open Farcaster',
                      color: Color(0xFF855DCD),
                      borderRadius: (radiuses.isSquare()
                          ? BorderRadius.all(Radius.zero)
                          : BorderRadius.circular(
                              BaseButtonSize.big.height / 2)),
                      onTap: () async {
                        await ReownCoreUtils.openURL(widget.farcasterUri);
                      },
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
}
