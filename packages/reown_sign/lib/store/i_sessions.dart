import 'package:reown_core/relay_client/relay_client_models.dart';
import 'package:reown_core/store/i_generic_store.dart';
import 'package:reown_sign/models/session_models.dart';

abstract class ISessions extends IGenericStore<SessionData> {
  Future<void> update(
    String topic, {
    int? expiry,
    Map<String, Namespace>? namespaces,
    TransportType? transportType,
  });
}
