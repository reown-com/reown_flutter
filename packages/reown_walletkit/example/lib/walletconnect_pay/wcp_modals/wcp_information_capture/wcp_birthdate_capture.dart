import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/utils/constants.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_shared_widgets.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_utils.dart';

class WCPBirthdateCapture extends StatefulWidget {
  const WCPBirthdateCapture({super.key, required this.collectDataField});

  final CollectDataField collectDataField;

  @override
  State<WCPBirthdateCapture> createState() => _WCPBirthdateCaptureState();
}

class _WCPBirthdateCaptureState extends State<WCPBirthdateCapture> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    // Default to a reasonable date (e.g., 18 years ago)
    final now = DateTime.now();
    _selectedDate = DateTime(now.year - 18, now.month, now.day);
  }

  void _handleContinue() {
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop(
        CollectDataFieldResult(
          id: widget.collectDataField.id,
          value: _selectedDate.formatted,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(StyleConstants.linear48),
      ),
      padding: const EdgeInsets.only(
        left: StyleConstants.linear8,
        bottom: StyleConstants.linear8,
        right: StyleConstants.linear8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // WCPStepsIndicator(
          //   currentStep: 2,
          //   totalSteps: 3,
          // ),
          const SizedBox(height: StyleConstants.linear24),
          WCModalTitle(text: 'What\'s your date of birth?'),
          const SizedBox(height: StyleConstants.linear32),
          DatePicker(
            initialDate: _selectedDate,
            onDateChanged: (date) {
              setState(() {
                _selectedDate = date;
              });
            },
          ),
          const SizedBox(height: StyleConstants.linear32),
          WCPrimaryButton(
            onPressed: _handleContinue,
            text: 'Continue',
            enabled: true,
          ),
        ],
      ),
    );
  }
}

class DatePicker extends StatelessWidget {
  const DatePicker({
    super.key,
    required this.initialDate,
    required this.onDateChanged,
  });

  final DateTime initialDate;
  final ValueChanged<DateTime> onDateChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: CupertinoDatePicker(
        initialDateTime: initialDate,
        mode: CupertinoDatePickerMode.date,
        maximumDate: DateTime.now(),
        minimumDate: DateTime(1900),
        onDateTimeChanged: onDateChanged,
      ),
    );
  }
}
