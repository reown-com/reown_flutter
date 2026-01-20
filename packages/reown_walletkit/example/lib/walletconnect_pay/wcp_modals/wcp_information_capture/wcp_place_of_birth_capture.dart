import 'package:flutter/material.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/utils/constants.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_shared_widgets.dart';

class WCPPlaceOfBirthCapture extends StatefulWidget {
  const WCPPlaceOfBirthCapture({
    super.key,
    required this.collectDataField,
  });

  final CollectDataField collectDataField;

  @override
  State<WCPPlaceOfBirthCapture> createState() => _WCPPlaceOfBirthCaptureState();
}

class _WCPPlaceOfBirthCaptureState extends State<WCPPlaceOfBirthCapture> {
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  final _cityFocusNode = FocusNode();
  final _countryFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _cityFocusNode.requestFocus();
    _cityController.addListener(_updateState);
    _countryController.addListener(_updateState);
  }

  @override
  void dispose() {
    _cityController.removeListener(_updateState);
    _countryController.removeListener(_updateState);
    _cityController.dispose();
    _countryController.dispose();
    _cityFocusNode.dispose();
    _countryFocusNode.dispose();
    super.dispose();
  }

  void _updateState() {
    setState(() {});
  }

  void _handleContinue() {
    final city = _cityController.text.trim();
    final country = _countryController.text.trim();
    if ((city.isNotEmpty && country.isNotEmpty) ||
        !widget.collectDataField.required) {
      // widget.onContinue?.call((city: city, country: country));
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop(
          CollectDataFieldResult(
            id: widget.collectDataField.id,
            value: '$city, $country',
          ),
        );
      }
    }
  }

  bool get _isFormValid {
    return _cityController.text.trim().isNotEmpty &&
        _countryController.text.trim().isNotEmpty;
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
          WCModalTitle(text: 'What is your place of birth?'),
          const SizedBox(height: StyleConstants.linear32),
          WCPTextField(
            controller: _cityController,
            focusNode: _cityFocusNode,
            label: 'City',
            onSubmitted: (_) => _countryFocusNode.requestFocus(),
          ),
          const SizedBox(height: StyleConstants.linear16),
          WCPTextField(
            controller: _countryController,
            focusNode: _countryFocusNode,
            label: 'Country',
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
