import 'package:reown_core/echo/models/echo_response.dart';

abstract class IEchoClient {
  Future<EchoResponse> register({
    required String projectId,
    required String clientId,
    required String firebaseAccessToken,
  });

  Future<EchoResponse> unregister({
    required String projectId,
    required String clientId,
  });
}
