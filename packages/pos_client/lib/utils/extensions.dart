import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:pos_client/pos_client.dart';
import 'package:pos_client/services/models/query_models.dart';
import 'package:pos_client/services/models/result_models.dart';
import 'package:pos_client/utils/caip_validator.dart';

extension SessionDataExtensions on SessionData {
  /// Get first CAIP-10 account for the given chain on the approved namespaces
  /// This is currenctly a limitation in the SDK as an approved session could
  /// have more than 1 account per chain approved and we currently pick the first one
  /// in the list risking to pick an empty account (or an account with insufficient funds, for what it matter).
  /// There is no way we can know (at least until wallet_pay) which account
  /// is the more appropriate (or the only appropriate account) to make the
  /// payment if the user decided to approve the session for every account they have in the wallet.
  String? getSenderCaip10Account(String chainId) {
    final ns = NamespaceUtils.getNamespaceFromChain(chainId);
    final namespace = namespaces[ns];
    final account = namespace?.accounts.firstWhereOrNull((account) {
      final accountChain = NamespaceUtils.getChainFromAccount(account);
      return accountChain == chainId;
    });
    return account;
  }
}

extension JsonRpcErrorExtensions on JsonRpcError {
  bool get isUserRejected {
    final regexp = RegExp(
      r'\b(rejected|cancelled|disapproved|denied)\b',
      caseSensitive: false,
    );
    final code = (this.code ?? 0);
    final match = RegExp(r'\b500[0-3]\b').hasMatch(code.toString());
    if (match || code == Errors.getSdkError(Errors.USER_REJECTED_SIGN).code) {
      return true;
    }
    return regexp.hasMatch(toString());
  }

  String get cleanMessage {
    return (message ?? '')
        .replaceAll('wc_pos_buildTransactions:', '')
        .replaceAll('wc_pos_checkTransaction:', '')
        .replaceAll('Internal error:', '')
        .replaceAll('Validation error:', '')
        .replaceAll('Execution error:', '')
        .trim();
  }
}

extension PaymentIntentExtension on PaymentIntent {
  String get caip19Token =>
      '${token.network.chainId}/${token.standard}:${token.address}';

  String get caip10Recipient {
    if (CaipValidator.isValidCaip10(recipient)) {
      return recipient;
    }
    return '${token.network.chainId}:$recipient';
  }

  PaymentIntentParams toPaymentIntentParams(String senderAddress) {
    return PaymentIntentParams.fromPaymentIntent(this, senderAddress);
  }
}

extension ListPaymentIntentExtension on List<PaymentIntent> {
  List<PaymentIntentParams> toPaymentIntentParamsList(
    SessionData approvedSession,
  ) {
    return map((intent) {
      final senderAddress = approvedSession.getSenderCaip10Account(
        intent.token.network.chainId,
      )!;
      return intent.toPaymentIntentParams(senderAddress);
    }).toList();
  }
}

extension ListTokenExtension on List<PosToken> {
  String toJson() {
    return map((t) => jsonEncode(t.toJson())).toList().toString();
  }

  List<String> extractNetworks() {
    return map((e) => e.network.chainId).toSet().toList();
  }

  List<String> getChainsByNamespace(String ns) {
    return extractNetworks().where((e) {
      return NamespaceUtils.getNamespaceFromChain(e) == ns;
    }).toList();
  }

  List<PosToken> removeUnsupported(Iterable<String> supportedNamespaces) {
    return this
      ..removeWhere((e) {
        final ns = NamespaceUtils.getNamespaceFromChain(e.network.chainId);
        return supportedNamespaces.contains(ns) == false;
      });
  }

  List<String> getNamespaces() {
    return map((e) {
      return NamespaceUtils.getNamespaceFromChain(e.network.chainId);
    }).toList();
  }
}

extension ListSupportedNamespaceExtension on List<SupportedNamespace> {
  dynamic getCapabilities() {
    Map<String, dynamic> capabilities = {};
    for (var entry in this) {
      if (entry.capabilities != null) {
        capabilities[entry.name] = entry.capabilities;
      }
    }
    return capabilities;
  }
}
