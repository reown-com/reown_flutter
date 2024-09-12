import 'package:reown_appkit/reown_appkit.dart';

abstract class ISiweService {
  SIWEConfig? get config;

  bool get enabled;
  bool get signOutOnDisconnect;
  bool get signOutOnAccountChange;
  bool get signOutOnNetworkChange;
  int get nonceRefetchIntervalMs;
  int get sessionRefetchIntervalMs;

  Future<String> getNonce();

  Future<String> createMessage({
    required String chainId,
    required String address,
  });

  Future<String> signMessageRequest(
    String message, {
    required ReownAppKitModalSession session,
  });

  Future<bool> verifyMessage({
    required String message,
    required String signature,
    Cacao? cacao,
    String? clientId,
  });

  Future<SIWESession> getSession();

  Future<void> signOut();

  String formatMessage(SIWECreateMessageArgs params);
}
