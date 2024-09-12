import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:reown_appkit/modal/services/magic_service/magic_service_singleton.dart';
import 'package:reown_appkit/modal/utils/core_utils.dart';
import 'package:reown_appkit/modal/widgets/circular_loader.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/searchbar.dart';
import 'package:reown_appkit/reown_appkit.dart';

class InputEmailWidget extends StatefulWidget {
  final Function(String value) onSubmitted;
  final String? initialValue;
  final Function(String value)? onValueChange;
  final Widget? suffixIcon;
  final Function(bool value)? onFocus;
  const InputEmailWidget({
    super.key,
    required this.onSubmitted,
    this.initialValue,
    this.onValueChange,
    this.suffixIcon,
    this.onFocus,
  });

  @override
  State<InputEmailWidget> createState() => _InputEmailWidgetState();
}

class _InputEmailWidgetState extends State<InputEmailWidget> {
  bool hasFocus = false;
  late TextEditingController _controller;
  bool _ready = false;
  bool _timedOut = false;
  bool _submitted = false;
  //
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _ready = magicService.instance.isReady.value;
    _timedOut = magicService.instance.isTimeout.value;
    magicService.instance.isReady.addListener(_updateStatus);
    magicService.instance.isTimeout.addListener(_updateStatus);
  }

  void _updateStatus() {
    setState(() {
      _ready = magicService.instance.isReady.value;
      _timedOut = magicService.instance.isTimeout.value;
    });
  }

  @override
  void didUpdateWidget(covariant InputEmailWidget oldWidget) {
    _updateStatus();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    magicService.instance.isTimeout.addListener(_updateStatus);
    magicService.instance.isReady.removeListener(_updateStatus);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return ModalSearchBar(
      enabled: !_timedOut && _ready && !_submitted,
      controller: _controller,
      initialValue: _controller.text,
      hint: 'Email',
      iconPath: 'lib/modal/assets/icons/mail.svg',
      textInputType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
      onSubmitted: _validate,
      debounce: false,
      onTextChanged: (value) {
        widget.onValueChange?.call(value);
      },
      onFocusChange: _onFocusChange,
      suffixIcon: widget.suffixIcon ??
          (!magicService.instance.isReady.value || _submitted
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularLoader(size: 20.0, strokeWidth: 2.0),
                  ],
                )
              : ValueListenableBuilder<String>(
                  valueListenable: magicService.instance.email,
                  builder: (context, value, _) {
                    if (!hasFocus || _invalidEmail(value)) {
                      return SizedBox.shrink();
                    }
                    return GestureDetector(
                      onTap: () => _validate(value),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(
                          'lib/modal/assets/icons/chevron_right.svg',
                          package: 'reown_appkit',
                          colorFilter: ColorFilter.mode(
                            themeColors.foreground300,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    );
                  },
                )),
    );
  }

  void _onFocusChange(bool focus) {
    if (hasFocus == focus) return;
    widget.onFocus?.call(focus);
    setState(() => hasFocus = focus);
  }

  bool _invalidEmail(String value) {
    return value.isEmpty || !CoreUtils.isValidEmail(value);
  }

  void _validate(String value) {
    if (_invalidEmail(value)) {
      if (value.isEmpty) {
        _clearEmail();
      }
      return;
    }
    widget.onSubmitted(value);
    setState(() => _submitted = true);
  }

  void _clearEmail() {
    _controller.clear();
    magicService.instance.setEmail('');
    magicService.instance.setNewEmail('');
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
