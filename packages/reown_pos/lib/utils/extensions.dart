import 'package:collection/collection.dart';
import 'package:reown_pos/reown_pos.dart';
import 'package:reown_pos/utils/caip_validator.dart';

extension SessionDataExtensions on SessionData {
  String? getSenderCaip10Account(String chainId) {
    final ns = NamespaceUtils.getNamespaceFromChain(chainId);
    final namespace = namespaces[ns];
    final account = namespace?.accounts.firstWhereOrNull(
      (account) => account.startsWith(chainId),
    );
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
}

extension PaymentIntentExtension on PaymentIntent {
  PaymentIntent toCAIP() {
    return copyWith(
      token: CaipValidator.isValidCaip19(token)
          ? token
          : '$chainId/erc20:$token',
      recipient: CaipValidator.isValidCaip10(recipient)
          ? recipient
          : '$chainId:$recipient',
    );
  }
}
