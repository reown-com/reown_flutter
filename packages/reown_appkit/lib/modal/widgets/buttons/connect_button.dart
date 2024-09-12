import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/constants/string_constants.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_theme.dart';
import 'package:reown_appkit/modal/widgets/buttons/base_button.dart';
import 'package:reown_appkit/modal/widgets/circular_loader.dart';

enum ConnectButtonState {
  error,
  idle,
  disabled,
  connecting,
  connected,
  none,
}

class ConnectButton extends StatelessWidget {
  const ConnectButton({
    super.key,
    this.size = BaseButtonSize.regular,
    this.state = ConnectButtonState.idle,
    this.serviceStatus = ReownAppKitModalStatus.idle,
    this.titleOverride,
    this.onTap,
  });
  final BaseButtonSize size;
  final ConnectButtonState state;
  final ReownAppKitModalStatus serviceStatus;
  final String? titleOverride;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final connecting = state == ConnectButtonState.connecting;
    final disabled = state == ConnectButtonState.disabled;
    final connected = state == ConnectButtonState.connected;
    final radiuses = ReownAppKitModalTheme.radiusesOf(context);
    final borderRadius = radiuses.isSquare() ? 0.0 : size.height / 2;
    final showLoading = connecting || serviceStatus.isLoading;
    return BaseButton(
      onTap: disabled || connecting
          ? null
          : serviceStatus.isInitialized
              ? onTap
              : null,
      size: size,
      buttonStyle: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (states) {
            if (connecting) {
              return themeColors.grayGlass010;
            }
            if (states.contains(MaterialState.disabled)) {
              return themeColors.grayGlass005;
            }
            return themeColors.accent100;
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (states) {
            if (connecting) {
              return themeColors.accent100;
            }
            if (states.contains(MaterialState.disabled)) {
              return themeColors.grayGlass015;
            }
            return themeColors.inverse100;
          },
        ),
        shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
          (states) {
            return RoundedRectangleBorder(
              side: (states.contains(MaterialState.disabled) || connecting)
                  ? BorderSide(color: themeColors.grayGlass010, width: 1.0)
                  : BorderSide.none,
              borderRadius: BorderRadius.circular(borderRadius),
            );
          },
        ),
      ),
      overridePadding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        showLoading
            ? const EdgeInsets.only(left: 6.0, right: 16.0)
            : const EdgeInsets.only(left: 16.0, right: 16.0),
      ),
      child: showLoading
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox.square(dimension: kPadding6),
                CircularLoader(
                  size: size.height * 0.4,
                  strokeWidth: size == BaseButtonSize.small ? 1.0 : 1.5,
                ),
                const SizedBox.square(dimension: kPadding6),
                if (connecting)
                  Text(titleOverride ?? UIConstants.connectButtonConnecting),
                if (serviceStatus.isLoading)
                  size == BaseButtonSize.small
                      ? Text(
                          titleOverride ?? UIConstants.connectButtonIdleShort)
                      : Text(titleOverride ?? UIConstants.connectButtonIdle),
              ],
            )
          : connected
              ? Text(titleOverride ?? UIConstants.connectButtonConnected)
              : size == BaseButtonSize.small
                  ? Text(titleOverride ?? UIConstants.connectButtonIdleShort)
                  : Text(titleOverride ?? UIConstants.connectButtonIdle),
    );
  }
}
