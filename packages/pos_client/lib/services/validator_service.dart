import 'package:pos_client/models/pos_models.dart';
import 'package:pos_client/services/i_validator_service.dart';
import 'package:pos_client/utils/caip_validator.dart';
import 'package:pos_client/utils/extensions.dart';
import 'package:reown_sign/models/session_models.dart';
import 'package:reown_sign/utils/namespace_utils.dart';

mixin ValidatorService implements IValidatorService {
  @override
  void isValidPaymentIntents(PaymentIntent intent) {
    try {
      double.tryParse(intent.amount);
    } catch (_) {
      throw StateError(
        'invalid amount value. Should be double expressed as String (${intent.toJson()})',
      );
    }
    final chainId = intent.token.network.chainId;
    if (!CaipValidator.isValidCaip2(chainId)) {
      throw StateError(
        'chainId should conform to "CAIP-2" format (${intent.toJson()})',
      );
    }
  }

  @override
  void isValidSessionApproved(
    SessionData approvedSession,
    PaymentIntent intent,
  ) {
    final chainId = intent.token.network.chainId;

    final senderAddress = approvedSession.getSenderCaip10Account(chainId);
    if (senderAddress == null) {
      throw StateError("No matching account found for chain $chainId");
    }

    final methods = NamespaceUtils.getNamespacesMethodsForChainId(
      chainId: chainId,
      namespaces: approvedSession.namespaces,
    );
    if (methods.isEmpty) {
      throw StateError('No method available for chain $chainId');
    }
  }
}
