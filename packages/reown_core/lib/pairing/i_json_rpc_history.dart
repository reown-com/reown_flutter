import 'package:reown_core/pairing/utils/pairing_models.dart';
import 'package:reown_core/store/i_generic_store.dart';

abstract class IJsonRpcHistory extends IGenericStore<JsonRpcRecord> {
  Future<void> resolve(Map<String, dynamic> response);
}
