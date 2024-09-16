import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/pages/approve_magic_request_page.dart';
import 'package:reown_appkit/modal/pages/confirm_email_page.dart';
import 'package:reown_appkit/modal/services/explorer_service/explorer_service_singleton.dart';
import 'package:reown_appkit/modal/services/magic_service/magic_service_singleton.dart';
import 'package:reown_appkit/modal/services/magic_service/models/magic_events.dart';
import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/utils/render_utils.dart';
import 'package:reown_appkit/modal/widgets/avatars/account_avatar.dart';
import 'package:reown_appkit/modal/widgets/buttons/balance_button.dart';
import 'package:reown_appkit/modal/widgets/buttons/base_button.dart';
import 'package:reown_appkit/modal/widgets/icons/rounded_icon.dart';
import 'package:reown_appkit/modal/widgets/circular_loader.dart';
import 'package:reown_appkit/modal/widgets/widget_stack/widget_stack_singleton.dart';
import 'package:reown_appkit/reown_appkit.dart';

class AppKitModalAccountButton extends StatefulWidget {
  const AppKitModalAccountButton({
    super.key,
    required this.appKit,
    this.size = BaseButtonSize.regular,
    this.avatar,
    this.context,
    this.custom,
  });

  final IReownAppKitModal appKit;
  final BaseButtonSize size;
  final String? avatar;
  final BuildContext? context;
  final Widget? custom;

  @override
  State<AppKitModalAccountButton> createState() =>
      _AppKitModalAccountButtonState();
}

class _AppKitModalAccountButtonState extends State<AppKitModalAccountButton> {
  String _balance = BalanceButton.balanceDefault;
  String _address = '';
  String? _tokenImage;
  String? _tokenName;

  @override
  void initState() {
    super.initState();
    _modalNotifyListener();
    widget.appKit.addListener(_modalNotifyListener);
    // TODO [AppKitModalAccountButton] this should go in ReownAppKitModal but for that, init() method of ReownAppKitModal should receive a BuildContext, which would be a breaking change
    magicService.instance.onMagicRpcRequest.subscribe(_approveSign);
    magicService.instance.onMagicLoginRequest.subscribe(_loginRequested);
  }

  @override
  void dispose() {
    widget.appKit.removeListener(_modalNotifyListener);
    magicService.instance.onMagicRpcRequest.unsubscribe(_approveSign);
    magicService.instance.onMagicLoginRequest.unsubscribe(_loginRequested);
    super.dispose();
  }

  void _modalNotifyListener() {
    setState(() {
      _address = widget.appKit.session?.address ?? '';
      final chainId = widget.appKit.selectedChain?.chainId ?? '';
      final imageId = ReownAppKitModalNetworks.getNetworkIconId(chainId);
      _tokenImage = explorerService.instance.getAssetImageUrl(imageId);
      _balance = widget.appKit.chainBalance;
      _tokenName = widget.appKit.selectedChain?.currency;
    });
  }

  void _onTap() {
    widget.appKit.openModalView();
  }

  void _approveSign(MagicRequestEvent? args) async {
    if (args?.request != null) {
      if (widget.appKit.isOpen) {
        widgetStack.instance.push(ApproveTransactionPage());
      } else {
        widget.appKit.openModalView(ApproveTransactionPage());
      }
    }
  }

  void _loginRequested(MagicSessionEvent? args) {
    if (widget.appKit.isOpen) {
      widgetStack.instance.popAllAndPush(ConfirmEmailPage());
    } else {
      widget.appKit.openModalView(ConfirmEmailPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.custom != null) {
      return widget.custom!;
    }
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    final borderRadius = radiuses.isSquare() ? 0.0 : widget.size.height / 2;
    final enabled = _address.isNotEmpty && widget.appKit.status.isInitialized;
    // TODO [AppKitModalAccountButton] this button should be able to be disable by passing a null onTap action
    // I should decouple an AccountButton from AppKitModalAccountButton like on ConnectButton and NetworkButton
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        BaseButton(
          size: widget.size,
          onTap: enabled ? _onTap : null,
          overridePadding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.only(left: 4.0, right: 4.0),
          ),
          buttonStyle: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (states) {
                if (states.contains(MaterialState.disabled)) {
                  return themeColors.grayGlass005;
                }
                return themeColors.grayGlass010;
              },
            ),
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
              (states) {
                if (states.contains(MaterialState.disabled)) {
                  return themeColors.grayGlass015;
                }
                return themeColors.foreground175;
              },
            ),
            shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
              (states) {
                return RoundedRectangleBorder(
                  side: states.contains(MaterialState.disabled)
                      ? BorderSide(color: themeColors.grayGlass005, width: 1.0)
                      : BorderSide(color: themeColors.grayGlass010, width: 1.0),
                  borderRadius: BorderRadius.circular(borderRadius),
                );
              },
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _BalanceButton(
                isLoading: widget.appKit.status.isLoading,
                balance: _balance,
                tokenName: _tokenName,
                tokenImage: _tokenImage,
                iconSize: widget.size.iconSize,
                buttonSize: widget.size,
                onTap: enabled ? _onTap : null,
              ),
              const SizedBox.square(dimension: 4.0),
              _AddressButton(
                address: _address,
                buttonSize: widget.size,
                appKit: widget.appKit,
                onTap: enabled ? _onTap : null,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AddressButton extends StatelessWidget {
  const _AddressButton({
    required this.buttonSize,
    required this.address,
    required this.appKit,
    required this.onTap,
  });
  final BaseButtonSize buttonSize;
  final VoidCallback? onTap;
  final String address;
  final IReownAppKitModal appKit;

  @override
  Widget build(BuildContext context) {
    if (address.isEmpty) {
      return SizedBox.shrink();
    }
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final textStyle = buttonSize == BaseButtonSize.small
        ? themeData.textStyles.small600
        : themeData.textStyles.paragraph600;
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    final innerBorderRadius =
        radiuses.isSquare() ? 0.0 : BaseButtonSize.small.height / 2;
    return Padding(
      padding: EdgeInsets.only(
        top: buttonSize == BaseButtonSize.small ? 4.0 : 0.0,
        bottom: buttonSize == BaseButtonSize.small ? 4.0 : 0.0,
      ),
      child: BaseButton(
        size: BaseButtonSize.small,
        onTap: onTap,
        overridePadding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.only(
            left: buttonSize == BaseButtonSize.small ? 4.0 : 6.0,
            right: 8.0,
          ),
        ),
        buttonStyle: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return themeColors.grayGlass005;
              }
              return themeColors.grayGlass010;
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(MaterialState.disabled)) {
                return themeColors.grayGlass015;
              }
              return themeColors.foreground175;
            },
          ),
          shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
            (states) {
              return RoundedRectangleBorder(
                side: states.contains(MaterialState.disabled)
                    ? BorderSide(
                        color: themeColors.grayGlass005,
                        width: 1.0,
                      )
                    : BorderSide(
                        color: themeColors.grayGlass010,
                        width: 1.0,
                      ),
                borderRadius: BorderRadius.circular(innerBorderRadius),
              );
            },
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(buttonSize.iconSize),
                border: Border.all(
                  color: themeColors.grayGlass005,
                  width: 1.0,
                  strokeAlign: BorderSide.strokeAlignInside,
                ),
              ),
              child: AccountAvatar(
                appKit: appKit,
                size: buttonSize.iconSize,
                disabled: false,
              ),
            ),
            const SizedBox.square(dimension: 4.0),
            Text(
              RenderUtils.truncate(
                address,
                length: buttonSize == BaseButtonSize.small ? 2 : 4,
              ),
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}

class _BalanceButton extends StatelessWidget {
  const _BalanceButton({
    required this.onTap,
    required this.isLoading,
    required this.balance,
    required this.tokenName,
    required this.tokenImage,
    required this.iconSize,
    required this.buttonSize,
  });
  final VoidCallback? onTap;
  final bool isLoading;
  final String balance;
  final String? tokenName;
  final String? tokenImage;
  final double iconSize;
  final BaseButtonSize buttonSize;

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final textStyle = buttonSize == BaseButtonSize.small
        ? themeData.textStyles.small600
        : themeData.textStyles.paragraph600;
    return BaseButton(
      size: BaseButtonSize.small,
      onTap: onTap,
      overridePadding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.only(left: 2.0),
      ),
      buttonStyle: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              return themeColors.grayGlass015;
            }
            return themeColors.foreground100;
          },
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          isLoading
              ? Row(
                  children: [
                    const SizedBox.square(dimension: kPadding6),
                    CircularLoader(
                      size: 16.0,
                      strokeWidth: 1.5,
                    ),
                    const SizedBox.square(dimension: kPadding6),
                  ],
                )
              : (tokenImage ?? '').isEmpty
                  ? RoundedIcon(
                      assetPath: 'lib/modal/assets/icons/network.svg',
                      size: iconSize,
                      assetColor: themeColors.inverse100,
                      padding: 4.0,
                    )
                  : RoundedIcon(
                      imageUrl: tokenImage,
                      size: iconSize + 2.0,
                    ),
          const SizedBox.square(dimension: 4.0),
          Text(
            '$balance ${tokenName ?? ''}',
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
