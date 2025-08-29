import 'package:reown_pos/models/pos_models.dart';
import 'package:reown_pos/services/i_validator_service.dart';
import 'package:reown_pos/utils/caip_validator.dart';
import 'package:reown_pos/utils/extensions.dart';
import 'package:reown_sign/models/session_models.dart';
import 'package:reown_sign/utils/namespace_utils.dart';

mixin ValidatorService implements IValidatorService {
  @override
  void isValidPaymentIntent(PaymentIntent intent) {
    try {
      double.tryParse(intent.amount);
    } catch (_) {
      throw StateError(
        'invalid amount value. Should be double expressed as String (${intent.amount})',
      );
    }
    final chainId = intent.token.network.chainId;
    if (!CaipValidator.isValidCaip2(chainId)) {
      throw StateError('chainId should conform to "CAIP-2" format ($chainId)');
    }
    // if (!CaipValidator.isValidCaip19(intent.token)) {
    //   throw StateError(
    //     'token should conform to "CAIP-19" format (${intent.token})',
    //   );
    // }
    // if (!CaipValidator.isValidCaip10(intent.recipient)) {
    //   throw StateError(
    //     'recipient should conform to "CAIP-10" format (${intent.recipient})',
    //   );
    // }
  }

  @override
  void isValidSessionApproved(SessionData approvedSession, String chainId) {
    final methods = NamespaceUtils.getNamespacesMethodsForChainId(
      chainId: chainId,
      namespaces: approvedSession.namespaces,
    );
    if (methods.isEmpty) {
      throw StateError('No method available');
    }

    final senderAddress = approvedSession.getSenderCaip10Account(chainId);
    if (senderAddress == null) {
      throw StateError("No matching account found for chain $chainId");
    }
  }
}
