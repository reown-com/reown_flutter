import 'package:reown_core/pairing/utils/pairing_models.dart';
import 'package:reown_core/store/i_generic_store.dart';

abstract class IPairingStore extends IGenericStore<PairingInfo> {
  Future<void> update(
    String topic, {
    int? expiry,
    bool? active,
    PairingMetadata? metadata,
  });
}
