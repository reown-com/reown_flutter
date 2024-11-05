import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_appkit/modal/constants/style_constants.dart';
import 'package:reown_appkit/modal/services/toast_service/i_toast_service.dart';
import 'package:reown_appkit/modal/services/toast_service/models/toast_message.dart';
import 'package:reown_appkit/modal/widgets/miscellaneous/searchbar.dart';
import 'package:reown_appkit/reown_appkit.dart';

class VerifyOtpView extends StatefulWidget {
  final Future<void> Function({required String value}) resendEmail;
  final Future<void> Function({required String otp}) verifyOtp;
  final String currentEmail;

  VerifyOtpView({
    super.key,
    required this.resendEmail,
    required this.verifyOtp,
    required this.currentEmail,
  });

  @override
  State<VerifyOtpView> createState() => _VerifyOtpViewState();
}

class _VerifyOtpViewState extends State<VerifyOtpView>
    with WidgetsBindingObserver {
  late DateTime _resendEnabledAt;
  static const _emptyString = ' ';
  final List<FocusNode> _focusNodes = [
    FocusNode(debugLabel: 'focus0'),
    FocusNode(debugLabel: 'focus1'),
    FocusNode(debugLabel: 'focus2'),
    FocusNode(debugLabel: 'focus3'),
    FocusNode(debugLabel: 'focus4'),
    FocusNode(debugLabel: 'focus5'),
  ];

  final List<TextEditingController> _controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  final Map<int, String> _digit = {
    0: _emptyString,
    1: _emptyString,
    2: _emptyString,
    3: _emptyString,
    4: _emptyString,
    5: _emptyString,
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _resendEnabledAt = DateTime.now().add(Duration(seconds: 30));
    _focusNodes.first.requestFocus();
    for (var fn in _focusNodes) {
      fn.addListener(_focusListener);
    }
  }

  void _resendEmail() async {
    final diff = DateTime.now().difference(_resendEnabledAt).inSeconds;
    if (diff < 0) {
      GetIt.I<IToastService>().show(ToastMessage(
        type: ToastType.error,
        text: 'Try again after ${diff.abs()} seconds',
      ));
    } else {
      final email = widget.currentEmail;
      widget.resendEmail(value: email);
      _resendEnabledAt = DateTime.now().add(Duration(seconds: 30));
      GetIt.I<IToastService>().show(ToastMessage(
        type: ToastType.success,
        text: 'Code email resent',
      ));
    }
  }

  @override
  void dispose() {
    for (var fn in _focusNodes) {
      fn.removeListener(_focusListener);
    }
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _focusListener() {
    int? emptyIndex = _digit.entries.firstWhereOrNull((e) {
      return e.value.trim().isEmpty;
    })?.key;
    final firstEmptyIndex = emptyIndex ?? -1;
    final focusedIndex = _focusNodes.indexWhere((fn) => fn.hasFocus);
    //
    for (var entry in _digit.entries) {
      if (entry.key >= focusedIndex) {
        _digit[entry.key] = _emptyString;
        _controllers[entry.key].text = _emptyString;
      }
    }
    if (focusedIndex > firstEmptyIndex && firstEmptyIndex >= 0) {
      _focusNodes[firstEmptyIndex].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeColors = ReownAppKitModalTheme.colorsOf(context);
    final textStyles = ReownAppKitModalTheme.getDataOf(context).textStyles;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: kPadding8,
            horizontal: kPadding12,
          ),
          child: Column(
            children: [
              const SizedBox.square(dimension: kPadding16),
              Text(
                'Enter the code we sent to ',
                textAlign: TextAlign.center,
                style: textStyles.paragraph400.copyWith(
                  color: themeColors.foreground100,
                ),
              ),
              Text(
                widget.currentEmail,
                textAlign: TextAlign.center,
                style: textStyles.paragraph500.copyWith(
                  color: themeColors.foreground100,
                ),
              ),
              const SizedBox.square(dimension: kPadding12),
              Text(
                'The code expires in 20 minutes',
                style: textStyles.small400.copyWith(
                  color: themeColors.foreground200,
                ),
              ),
              const SizedBox.square(dimension: kPadding16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _focusNodes
                    .mapIndexed(
                      (index, fn) => ModalSearchBar(
                        width: kSearchFieldHeight + 8.0,
                        initialValue: _digit[index]!,
                        controller: _controllers[index],
                        focusNode: fn,
                        textInputType: TextInputType.number,
                        textAlign: TextAlign.center,
                        showCursor: false,
                        debounce: false,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(2),
                        ],
                        textStyle: textStyles.large400.copyWith(
                          color: themeColors.foreground100,
                        ),
                        prefixIcon: const SizedBox.shrink(),
                        suffixIcon: const SizedBox.shrink(),
                        noIcons: true,
                        onTextChanged: (value) {
                          _onTextChanged(index, value, fn);
                        },
                      ),
                    )
                    .toList(),
              ),
              const SizedBox.square(dimension: kPadding16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Didn\'t receive it?',
                    style: textStyles.small400.copyWith(
                      color: themeColors.foreground200,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _resendEmail();
                    },
                    child: Text(
                      'Resend code',
                      style: textStyles.small600.copyWith(
                        color: themeColors.accent100,
                      ),
                    ),
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all<Color>(
                        themeColors.accenGlass010,
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(horizontal: 8.0),
                      ),
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      final clipboardHasData = await Clipboard.hasStrings();
      if (clipboardHasData) {
        final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
        await Clipboard.setData(ClipboardData(text: ''));
        final code = clipboardData?.text ?? '';
        if (code.isNotEmpty) {
          widget.verifyOtp(otp: code);
        }
      }
    }
  }

  void _onTextChanged(int index, String value, FocusNode node) {
    _digit[index] = value.trim();
    if (_digit[index]!.isNotEmpty) {
      if (index == 5) {
        final code = _digit.values.join();
        widget.verifyOtp(otp: code);
      } else {
        node.nextFocus();
      }
    } else {
      if (_digit[index]!.isEmpty) {
        _digit[index] = _emptyString;
      }
      if (index > 0) {
        node.previousFocus();
      }
    }
  }
}
