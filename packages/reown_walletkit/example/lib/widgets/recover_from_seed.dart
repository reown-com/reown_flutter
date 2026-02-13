import 'package:flutter/material.dart';
import 'package:reown_walletkit_wallet/theme/app_colors.dart';
import 'package:reown_walletkit_wallet/theme/app_spacing.dart';
import 'package:reown_walletkit_wallet/theme/app_typography.dart';

class RecoverFromSeed extends StatelessWidget {
  RecoverFromSeed({super.key});

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final unfocusedBorder = OutlineInputBorder(
      borderSide: BorderSide(color: colors.inputBorder, width: 1.0),
      borderRadius: BorderRadius.circular(12.0),
    );
    final focusedBorder = unfocusedBorder.copyWith(
      borderSide: BorderSide(color: colors.inputBorderFocused, width: 1.0),
    );
    return Container(
      height: 340.0,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.s5),
      child: Column(
        children: [
          Text(
            'Import Wallet',
            style: context.textStyles.subtitleText.copyWith(fontSize: 18.0),
          ),
          const SizedBox(height: 10.0),
          Text(
            'Only Ethereum private key is supported for now, if you want to restore other chains as well please use mnemonic phrase',
            style: context.textStyles.bodyText,
          ),
          const SizedBox(height: AppSpacing.s5),
          SizedBox(
            height: 60.0,
            child: TextFormField(
              controller: controller,
              maxLines: 4,
              textAlignVertical: TextAlignVertical.center,
              cursorColor: colors.accent,
              enableSuggestions: false,
              autocorrect: false,
              cursorHeight: 16.0,
              style: TextStyle(color: colors.textPrimary),
              decoration: InputDecoration(
                isDense: true,
                hintStyle: TextStyle(color: colors.textSecondary),
                border: unfocusedBorder,
                errorBorder: unfocusedBorder,
                enabledBorder: unfocusedBorder,
                disabledBorder: unfocusedBorder,
                focusedBorder: focusedBorder,
                filled: true,
                fillColor: colors.inputFill,
                contentPadding: const EdgeInsets.all(AppSpacing.s2),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(controller.text),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(colors.accent),
                foregroundColor:
                    WidgetStateProperty.all<Color>(colors.onAccent),
              ),
              child: const Text('Import'),
            ),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(null),
              child: Text(
                'Cancel',
                style: TextStyle(color: colors.textSecondary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
