import 'package:event/event.dart';
import 'package:reown_core/pairing/utils/pairing_models.dart';
import 'package:reown_core/store/i_generic_store.dart';

abstract class IExpirer extends IGenericStore<int> {
  abstract final Event<ExpirationEvent> onExpire;

  Future<bool> checkExpiry(String key, int expiry);
  Future<bool> checkAndExpire(String key);
  Future<void> expire(String key);
}
