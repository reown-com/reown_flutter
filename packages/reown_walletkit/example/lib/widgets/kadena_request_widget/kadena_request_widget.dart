import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kadena_dart_sdk/kadena_dart_sdk.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/theme/app_colors.dart';
import 'package:reown_walletkit_wallet/theme/app_spacing.dart';
import 'package:reown_walletkit_wallet/widgets/custom_button.dart';
import 'package:reown_walletkit_wallet/widgets/shared/app_icon_widget.dart';
import 'package:reown_walletkit_wallet/widgets/shared/request_info_row.dart';

/// Multi-step signing modal for Kadena requests.
///
/// Handles both single-payload (kadena_sign_v1) and multi-payload
/// (kadena_quicksign_v1) flows. The user approves or rejects each
/// [PactCommandPayload] one at a time.
///
/// Returns a [List<bool>] where each entry corresponds to the user's
/// decision for the payload at the same index.
class KadenaRequestWidget extends StatefulWidget {
  const KadenaRequestWidget({
    super.key,
    this.requester,
    required this.payloads,
  });

  final ConnectionMetadata? requester;
  final List<PactCommandPayload> payloads;

  @override
  State<KadenaRequestWidget> createState() => _KadenaRequestWidgetState();
}

class _KadenaRequestWidgetState extends State<KadenaRequestWidget> {
  int _currentIndex = 0;
  final List<bool> _responses = [];

  bool get _isMultiStep => widget.payloads.length > 1;

  String get _title {
    final appName = widget.requester?.metadata.name ?? '';
    final suffix = appName.isNotEmpty ? ' for $appName' : '';
    if (_isMultiStep) {
      return 'Sign ${_currentIndex + 1} of ${widget.payloads.length}$suffix';
    }
    return 'Sign transaction$suffix';
  }

  void _onApprove() {
    _responses.add(true);
    _advance();
  }

  void _onReject() {
    _responses.add(false);
    _advance();
  }

  void _advance() {
    if (_currentIndex < widget.payloads.length - 1) {
      setState(() => _currentIndex++);
    } else {
      Navigator.of(context).pop(_responses);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final metadata = widget.requester?.metadata;
    final payload = widget.payloads[_currentIndex];
    final caps =
        payload.signers.isNotEmpty ? (payload.signers.first.clist ?? []) : [];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: AppSpacing.s2),
        if (metadata != null)
          Center(child: AppIcon(metadata: metadata, size: 64.0)),
        const SizedBox(height: AppSpacing.s3),
        Text(
          _title,
          style: TextStyle(
            color: colors.textPrimary,
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
            letterSpacing: -0.6,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.s5),
        Flexible(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RequestInfoRow(
                  label: 'Pact Command',
                  value: jsonEncode(payload),
                ),
                ...caps.map(
                  (cap) {
                    final dynamic rawName = cap.name;
                    final String label = rawName?.toString() ?? 'Unknown';
                    final dynamic rawArgs = cap.args;
                    final List<dynamic> argsList =
                        rawArgs is List ? rawArgs : const [];
                    final String value = argsList.isEmpty
                        ? '—'
                        : argsList.map((a) => a.toString()).join(', ');

                    return Padding(
                      padding: const EdgeInsets.only(top: AppSpacing.s2),
                      child: RequestInfoRow(
                        label: label,
                        value: value,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.s5),
        Row(
          children: [
            CustomButton(
              onTap: _onReject,
              style: CustomButtonStyle.outlined,
              child: Text(
                'Reject',
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: AppSpacing.s3),
            CustomButton(
              onTap: _onApprove,
              type: CustomButtonType.normal,
              child: Text(
                'Sign',
                style: TextStyle(
                  color: colors.onAccent,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
