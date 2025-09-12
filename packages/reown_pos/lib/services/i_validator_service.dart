import 'package:reown_pos/models/pos_models.dart';
import 'package:reown_sign/models/session_models.dart';

abstract class IValidatorService {
  void isValidPaymentIntents(PaymentIntent intent);
  void isValidSessionApproved(
    SessionData approvedSession,
    PaymentIntent intent,
  );
}
