import 'package:flutter/material.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/utils/constants.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_shared_widgets.dart';

class WCPFullNameCapture extends StatefulWidget {
  const WCPFullNameCapture({super.key, required this.collectDataField});

  final CollectDataField collectDataField;

  @override
  State<WCPFullNameCapture> createState() => _WCPFullNameCaptureState();
}

class _WCPFullNameCaptureState extends State<WCPFullNameCapture> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _firstNameFocusNode.requestFocus();
    _firstNameController.addListener(_updateState);
    _lastNameController.addListener(_updateState);
  }

  @override
  void dispose() {
    _firstNameController.removeListener(_updateState);
    _lastNameController.removeListener(_updateState);
    _firstNameController.dispose();
    _lastNameController.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    super.dispose();
  }

  void _updateState() {
    setState(() {});
  }

  void _handleContinue() {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    if ((firstName.isNotEmpty && lastName.isNotEmpty) ||
        !widget.collectDataField.required) {
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop(
          CollectDataFieldResult(
            id: widget.collectDataField.id,
            value: '$firstName $lastName',
          ),
        );
      }
    }
  }

  bool get _isFormValid {
    return _firstNameController.text.trim().isNotEmpty &&
        _lastNameController.text.trim().isNotEmpty;
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
          const SizedBox(height: StyleConstants.linear24),
          WCModalTitle(text: 'What\'s your name?'),
          const SizedBox(height: StyleConstants.linear32),
          WCPTextField(
            controller: _firstNameController,
            focusNode: _firstNameFocusNode,
            label: 'First name',
            keyboardType: TextInputType.name,
            onSubmitted: (_) => _lastNameFocusNode.requestFocus(),
          ),
          const SizedBox(height: 12.0),
          WCPTextField(
            controller: _lastNameController,
            focusNode: _lastNameFocusNode,
            label: 'Last name',
            keyboardType: TextInputType.name,
            onSubmitted: (_) => _handleContinue(),
          ),
          const SizedBox(height: StyleConstants.linear32),
          WCPrimaryButton(
            onPressed: _handleContinue,
            text: 'Continue',
            enabled: _isFormValid,
          ),
        ],
      ),
    );
  }
}
