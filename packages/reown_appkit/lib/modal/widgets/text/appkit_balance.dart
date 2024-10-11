import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_theme.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';
import 'package:reown_appkit/modal/widgets/buttons/base_button.dart';

class BalanceText extends StatefulWidget {
  const BalanceText({
    super.key,
    this.size = BaseButtonSize.regular,
    this.onTap,
  });

  final BaseButtonSize size;
  final VoidCallback? onTap;

  @override
  State<BalanceText> createState() => _BalanceTextState();
}

class _BalanceTextState extends State<BalanceText> {
  IReownAppKitModal? _appKitModal;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _appKitModal = ModalProvider.of(context).instance;
      _modalNotifyListener();
      _appKitModal?.addListener(_modalNotifyListener);
    });
  }

  @override
  void dispose() {
    _appKitModal?.removeListener(_modalNotifyListener);
    super.dispose();
  }

  void _modalNotifyListener() {
    if (_appKitModal == null) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    if (_appKitModal == null) {
      return const SizedBox.shrink();
    }
    return ValueListenableBuilder<String>(
      valueListenable: _appKitModal!.balanceNotifier,
      builder: (_, balance, __) {
        return Text(
          balance,
          style: themeData.textStyles.paragraph500.copyWith(
            color: themeColors.foreground200,
          ),
        );
      },
    );
  }
}
