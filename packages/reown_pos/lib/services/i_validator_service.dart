import 'package:reown_pos/models/pos_models.dart';
import 'package:reown_sign/models/session_models.dart';

abstract class IValidatorService {
  void isValidPaymentIntents(List<PaymentIntent> intents);
  void isValidSessionApproved(SessionData approvedSession, String chainId);
}
