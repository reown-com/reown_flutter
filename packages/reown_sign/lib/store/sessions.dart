import 'package:reown_core/relay_client/relay_client_models.dart';
import 'package:reown_core/store/generic_store.dart';
//
import 'package:reown_sign/store/i_sessions.dart';
import 'package:reown_sign/models/session_models.dart';

class Sessions extends GenericStore<SessionData> implements ISessions {
  Sessions({
    required super.storage,
    required super.context,
    required super.version,
    required super.fromJson,
  });

  @override
  Future<void> update(
    String topic, {
    int? expiry,
    Map<String, Namespace>? namespaces,
    TransportType? transportType,
  }) async {
    checkInitialized();

    SessionData? info = get(topic);
    if (info == null) {
      return;
    }

    if (expiry != null) {
      info = info.copyWith(expiry: expiry);
    }
    if (namespaces != null) {
      info = info.copyWith(namespaces: namespaces);
    }
    if (transportType != null) {
      info = info.copyWith(transportType: transportType);
    }

    await set(topic, info);
  }
}
