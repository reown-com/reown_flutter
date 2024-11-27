import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/services/magic_service/i_magic_service.dart';
import 'package:reown_appkit/modal/services/magic_service/models/magic_events.dart';
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
  IMagicService get _magicService => GetIt.I<IMagicService>();

  late TextEditingController _controller;
  bool hasFocus = false;
  bool _ready = false;
  bool _timedOut = false;
  bool _submitted = false;
  //
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _ready = _magicService.isReady.value;
    _timedOut = _magicService.isTimeout.value;
    _magicService.onMagicError.subscribe(_onMagicErrorEvent);
    _magicService.isReady.addListener(_updateStatus);
    _magicService.isTimeout.addListener(_updateStatus);
  }

  void _updateStatus() {
    if (!mounted) return;
    setState(() {
      _ready = _magicService.isReady.value;
      _timedOut = _magicService.isTimeout.value;
    });
  }

  void _onMagicErrorEvent(MagicErrorEvent? event) {
    if (!mounted) return;
    _submitted = false;
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant InputEmailWidget oldWidget) {
    _updateStatus();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _magicService.onMagicError.subscribe(_onMagicErrorEvent);
    _magicService.isTimeout.addListener(_updateStatus);
    _magicService.isReady.removeListener(_updateStatus);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    return ModalSearchBar(
      height: kListItemHeight,
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
          (!_magicService.isReady.value || _submitted
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        CircularLoader(size: 20.0, strokeWidth: 2.0),
                        const SizedBox.square(
                          dimension: kListViewSeparatorHeight,
                        ),
                      ],
                    )
                  ],
                )
              : ValueListenableBuilder<String>(
                  valueListenable: _magicService.email,
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
    _magicService.setEmail('');
    _magicService.setNewEmail('');
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
