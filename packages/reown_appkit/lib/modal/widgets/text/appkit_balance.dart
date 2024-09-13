import 'package:flutter/material.dart';
import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';
import 'package:reown_appkit/modal/theme/public/appkit_modal_theme.dart';
import 'package:reown_appkit/modal/widgets/buttons/balance_button.dart';
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
  String _balance = BalanceButton.balanceDefault;
  String? _tokenName;
  IReownAppKitModal? _service;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _service = ModalProvider.of(context).instance;
      _modalNotifyListener();
      _service?.addListener(_modalNotifyListener);
    });
  }

  @override
  void dispose() {
    _service?.removeListener(_modalNotifyListener);
    super.dispose();
  }

  void _modalNotifyListener() {
    if (_service == null) return;
    setState(() {
      _balance = _service!.chainBalance;
      _tokenName = _service?.selectedChain?.currency;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = ReownAppKitModalTheme.getDataOf(context);
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return Text(
      '$_balance ${_tokenName ?? ''}',
      style: themeData.textStyles.paragraph500.copyWith(
        color: themeColors.foreground200,
      ),
    );
  }
}
