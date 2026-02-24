import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:reown_walletkit_wallet/dependencies/deep_link_handler.dart';
import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/models/chain_data.dart';
import 'package:reown_walletkit_wallet/widgets/wc_request_modal/wc_request_modal.dart';
import 'package:toastification/toastification.dart';

class MethodsUtils {
  static final walletKit = GetIt.I<IWalletKitService>().walletKit;

  static Future<bool> requestApproval(
    String text, {
    String? method,
    String? chainId,
    String? address,
    required String transportType,
    VerifyContext? verifyContext,
    ConnectionMetadata? requester,
    String? gasValue,
  }) async {
    final appName = requester?.metadata.name ?? '';
    final title = _titleForMethod(method, appName);
    final itemLabel = _itemLabelForMethod(method);
    final approveLabel = _approveLabelForMethod(method);
    final chain = chainId != null
        ? ChainsDataList.allChains
            .where((c) => c.chainId == chainId)
            .firstOrNull
        : null;

    final bottomSheetService = GetIt.I<IBottomSheetService>();
    final WCBottomSheetResult rs = (await bottomSheetService.queueBottomSheet(
          widget: WCRequestModal(
            requester: requester,
            verifyContext: verifyContext,
            chain: chain,
            title: title,
            summaryRows: _summaryRowsForRequest(
              text: text,
              method: method,
              chainId: chainId,
              chainName: chain?.name,
              address: address,
              gasValue: gasValue,
            ),
            items: [
              if (text.isNotEmpty) WCRequestItem(label: itemLabel, value: text),
            ],
            approveLabel: approveLabel,
          ),
        )) ??
        WCBottomSheetResult.reject;

    return rs != WCBottomSheetResult.reject;
  }

  static String _titleForMethod(String? method, String appName) {
    final suffix = appName.isNotEmpty ? ' for $appName' : '';
    if (method == null) return 'Approve request$suffix';

    return switch (method) {
      'personal_sign' || 'eth_sign' => 'Sign a message$suffix',
      'eth_signTypedData' || 'eth_signTypedData_v4' => 'Sign typed data$suffix',
      'eth_signTransaction' => 'Sign transaction$suffix',
      'eth_sendTransaction' => 'Send transaction$suffix',
      'solana_signMessage' ||
      'polkadot_signMessage' ||
      'stx_signMessage' ||
      'sui_signPersonalMessage' ||
      'ton_signData' ||
      'tron_signMessage' =>
        'Sign a message$suffix',
      'solana_signTransaction' ||
      'solana_signAllTransactions' ||
      'polkadot_signTransaction' ||
      'sui_signTransaction' ||
      'cosmos_signDirect' ||
      'kadena_sign_v1' ||
      'kadena_quicksign_v1' ||
      'tron_signTransaction' =>
        'Sign transaction$suffix',
      'sui_signAndExecuteTransaction' ||
      'ton_sendMessage' ||
      'stx_transferStx' =>
        'Send transaction$suffix',
      'cosmos_getAccounts' || 'kadena_getAccounts_v1' => 'Share account$suffix',
      _ => _titleFromMethodName(method, suffix),
    };
  }

  static String _titleFromMethodName(String method, String suffix) {
    final normalized = method.toLowerCase();
    if (normalized.contains('signmessage') ||
        normalized.contains('signpersonal') ||
        normalized.contains('signdata')) {
      return 'Sign a message$suffix';
    }
    if (normalized.contains('signtransaction') ||
        normalized.contains('signalltransactions') ||
        normalized.contains('signdirect') ||
        normalized.contains('quicksign')) {
      return 'Sign transaction$suffix';
    }
    if (normalized.contains('send') ||
        normalized.contains('execute') ||
        normalized.contains('transfer')) {
      return 'Send transaction$suffix';
    }
    if (normalized.contains('getaccounts')) {
      return 'Share account$suffix';
    }
    return 'Approve request$suffix';
  }

  static String _itemLabelForMethod(String? method) {
    return switch (method) {
      'personal_sign' || 'eth_sign' => 'Message',
      'eth_signTypedData' || 'eth_signTypedData_v4' => 'Data',
      'eth_signTransaction' || 'eth_sendTransaction' => 'Transaction',
      _ => 'Data',
    };
  }

  static List<WCRequestSummaryRow> _summaryRowsForRequest({
    required String text,
    String? method,
    String? chainId,
    String? chainName,
    String? address,
    String? gasValue,
  }) {
    final rows = <WCRequestSummaryRow>[
      if (gasValue != null && gasValue.isNotEmpty)
        WCRequestSummaryRow(label: 'Gas', value: gasValue),
    ];
    if (text.isNotEmpty) {
      return rows;
    }

    final methodValue = method ?? 'Unknown';
    final accountValue =
        (address != null && address.isNotEmpty) ? address : 'Unknown';
    final chainValue = (chainName != null && chainName.isNotEmpty)
        ? chainName
        : (chainId ?? 'Unknown');

    rows.add(WCRequestSummaryRow(label: 'Method', value: methodValue));
    rows.add(WCRequestSummaryRow(label: 'Account', value: accountValue));
    rows.add(WCRequestSummaryRow(label: 'Chain', value: chainValue));
    return rows;
  }

  static String _approveLabelForMethod(String? method) {
    if (method == null) return 'Approve';

    return switch (method) {
      'wallet_switchEthereumChain' => 'Switch',
      'wallet_addEthereumChain' => 'Add',
      'eth_sendTransaction' || 'ton_sendMessage' => 'Send',
      'personal_sign' ||
      'eth_sign' ||
      'eth_signTypedData' ||
      'eth_signTypedData_v4' ||
      'eth_signTransaction' ||
      'ton_signData' =>
        'Sign',
      _ => _approveLabelFromMethodName(method),
    };
  }

  static String _approveLabelFromMethodName(String method) {
    final normalized = method.toLowerCase();
    if (normalized.contains('switch')) return 'Switch';
    if (normalized.contains('add')) return 'Add';
    if (normalized.contains('send')) return 'Send';
    if (normalized.contains('sign')) return 'Sign';
    return 'Approve';
  }

  static void handleRedirect(
    String topic,
    Redirect? redirect, [
    String? error,
    bool success = false,
  ]) {
    debugPrint(
      '[SampleWallet] handleRedirect topic: $topic, redirect: $redirect, error: $error',
    );
    openApp(
      topic,
      redirect,
      onFail: (e) => goBackModal(
        title: success ? 'Success' : 'Error',
        message: error,
        success: success,
      ),
    );
  }

  static void openApp(
    String topic,
    Redirect? redirect, {
    int delay = 100,
    Function(ReownSignError? error)? onFail,
  }) async {
    await Future.delayed(Duration(milliseconds: delay));
    DeepLinkHandler.waiting.value = false;
    try {
      await walletKit.redirectToDapp(topic: topic, redirect: redirect);
    } on ReownSignError catch (e) {
      onFail?.call(e);
    }
  }

  static void goBackModal({
    String? title,
    String? message,
    bool success = true,
  }) {
    DeepLinkHandler.waiting.value = false;
    final normalizedMessage = message?.trim();
    final hasMessage =
        normalizedMessage != null && normalizedMessage.isNotEmpty;
    final description = hasMessage
        ? normalizedMessage
        : (success ? 'Return to your dApp' : null);
    toastification.show(
      title: Text(title ?? (success ? 'Approved' : 'Error')),
      description: description != null ? Text(description) : null,
      type: success ? ToastificationType.success : ToastificationType.error,
      autoCloseDuration: Duration(seconds: success ? 3 : 5),
      alignment: Alignment.bottomCenter,
    );
  }
}
