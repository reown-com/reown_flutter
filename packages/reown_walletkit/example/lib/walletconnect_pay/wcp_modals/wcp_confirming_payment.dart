import 'dart:convert';

import 'package:flutter/material.dart' hide Action;
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/dependencies/chain_services/evm_service.dart';
import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/theme/app_radius.dart';
import 'package:reown_walletkit_wallet/theme/app_spacing.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_shared_widgets.dart';

@visibleForTesting
typedef WCPActionExecutor = Future<String> Function(Action action);

@visibleForTesting
Future<List<String>> collectWCPActionSignatures({
  required List<Action> actions,
  required WCPActionExecutor executeAction,
  void Function(Action action)? onActionStarted,
}) async {
  final signatures = <String>[];
  for (final action in actions) {
    onActionStarted?.call(action);
    signatures.add(await executeAction(action));
  }
  return signatures;
}

class WCPConfirmingPayment extends StatefulWidget {
  const WCPConfirmingPayment({
    super.key,
    required this.paymentRequest,
    required this.actions,
    required this.tokenSymbol,
  });

  final ConfirmPaymentRequest paymentRequest;
  final List<Action> actions;
  final String tokenSymbol;

  @override
  State<WCPConfirmingPayment> createState() => _WCPConfirmingPaymentState();
}

class _WCPConfirmingPaymentState extends State<WCPConfirmingPayment> {
  static const _processingLabel = 'Processing your payment...';
  static const _finalizingLabel = 'Finalizing your payment...';

  final _walletKitService = GetIt.I<IWalletKitService>();
  late final bool _isMultiStep = widget.actions.length > 1;
  late final _stepLabel = ValueNotifier<String>(_processingLabel);

  String get _settingUpLabel =>
      'Setting up ${widget.tokenSymbol} for the first time...';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _run());
  }

  @override
  void dispose() {
    _stepLabel.dispose();
    super.dispose();
  }

  Future<void> _run() async {
    try {
      final signatures = await collectWCPActionSignatures(
        actions: widget.actions,
        executeAction: _executeAction,
        onActionStarted: _updateStepLabel,
      );
      _stepLabel.value = _isMultiStep ? _finalizingLabel : _processingLabel;
      final request = widget.paymentRequest.copyWith(signatures: signatures);
      final response = await _walletKitService.confirmPayment(request);
      if (!mounted) return;
      Navigator.of(context).pop(response.status);
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context).pop(e);
    }
  }

  void _updateStepLabel(Action action) {
    final method = action.walletRpc.method;
    if (method == 'eth_sendTransaction') {
      _stepLabel.value = _settingUpLabel;
    } else {
      _stepLabel.value = _isMultiStep ? _finalizingLabel : _processingLabel;
    }
  }

  Future<String> _executeAction(Action action) async {
    final method = action.walletRpc.method;
    final chainId = action.walletRpc.chainId;
    final params = action.walletRpc.params;
    final service = _walletKitService.getChainService<EVMService>(
      chainId: chainId,
    );

    switch (method) {
      case 'eth_signTypedData_v4':
        final decoded = jsonDecode(params) as List<dynamic>;
        final typedData = _ensureEip712Domain(decoded.last);
        return service.ethSignTypedDataV4(typedData);
      case 'eth_sendTransaction':
        final decoded = jsonDecode(params) as List<dynamic>;
        final txParams = Map<String, dynamic>.from(decoded.first as Map);
        return service.sendPayTransaction(txParams);
      default:
        throw UnimplementedError('Unsupported pay method: $method');
    }
  }

  // eth_sig_util_plus requires an EIP712Domain entry in `types`. The Permit2
  // payload the backend returns omits it (JS libraries inject their own), so
  // synthesize one from the fields actually present in `domain`.
  String _ensureEip712Domain(dynamic typedData) {
    final map = typedData is String
        ? Map<String, dynamic>.from(jsonDecode(typedData) as Map)
        : Map<String, dynamic>.from(typedData as Map);
    final types = Map<String, dynamic>.from(
      (map['types'] as Map?) ?? const <String, dynamic>{},
    );
    if (!types.containsKey('EIP712Domain')) {
      final domain = (map['domain'] as Map?) ?? const <String, dynamic>{};
      const candidates = <(String, String)>[
        ('name', 'string'),
        ('version', 'string'),
        ('chainId', 'uint256'),
        ('verifyingContract', 'address'),
        ('salt', 'bytes32'),
      ];
      types['EIP712Domain'] = [
        for (final (name, type) in candidates)
          if (domain.containsKey(name)) {'name': name, 'type': type},
      ];
    }
    map['types'] = types;
    return jsonEncode(map);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
      ),
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.s11),
          const Center(child: WalletConnectLoading(size: 120.0)),
          const SizedBox(height: AppSpacing.s6),
          Semantics(
            container: true,
            identifier: 'pay-loading-message',
            label: 'pay-loading-message',
            child: ValueListenableBuilder<String>(
              valueListenable: _stepLabel,
              builder: (context, label, _) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (child, animation) =>
                      FadeTransition(opacity: animation, child: child),
                  child: WCModalTitle(key: ValueKey(label), text: label),
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.s6),
        ],
      ),
    );
  }
}
