import 'package:flutter_test/flutter_test.dart';
import 'package:reown_core/reown_core.dart';
import 'package:reown_core/store/generic_store.dart';
import 'package:reown_sign/reown_sign.dart';

import 'shared/shared_test_utils.dart';
import 'shared/shared_test_values.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  mockPackageInfo();
  mockConnectivity();

  group('Unknown verify context', () {
    late ReownSign signEngine;
    late ReownCore core;

    setUp(() async {
      core = ReownCore(
        projectId: TEST_PROJECT_ID,
        relayUrl: TEST_RELAY_URL,
        memoryStore: true,
        logLevel: LogLevel.info,
        httpClient: getHttpWrapper(),
      );

      signEngine = ReownSign(
        core: core,
        metadata: RESPONDER,
        proposals: GenericStore(
          storage: core.storage,
          context: StoreVersions.CONTEXT_PROPOSALS,
          version: StoreVersions.VERSION_PROPOSALS,
          fromJson: (dynamic value) => ProposalData.fromJson(value),
        ),
        sessions: Sessions(
          storage: core.storage,
          context: StoreVersions.CONTEXT_SESSIONS,
          version: StoreVersions.VERSION_SESSIONS,
          fromJson: (dynamic value) => SessionData.fromJson(value),
        ),
        pendingRequests: GenericStore(
          storage: core.storage,
          context: StoreVersions.CONTEXT_PENDING_REQUESTS,
          version: StoreVersions.VERSION_PENDING_REQUESTS,
          fromJson: (dynamic value) => SessionRequest.fromJson(value),
        ),
        authKeys: GenericStore(
          storage: core.storage,
          context: StoreVersions.CONTEXT_AUTH_KEYS,
          version: StoreVersions.VERSION_AUTH_KEYS,
          fromJson: (dynamic value) => AuthPublicKey.fromJson(value),
        ),
        pairingTopics: GenericStore(
          storage: core.storage,
          context: StoreVersions.CONTEXT_PAIRING_TOPICS,
          version: StoreVersions.VERSION_PAIRING_TOPICS,
          fromJson: (dynamic value) => value,
        ),
        sessionAuthRequests: GenericStore(
          storage: core.storage,
          context: StoreVersions.CONTEXT_AUTH_REQUESTS,
          version: StoreVersions.VERSION_AUTH_REQUESTS,
          fromJson: (dynamic value) =>
              PendingSessionAuthRequest.fromJson(value),
        ),
      );

      await core.start();
      await signEngine.init();
    });

    test('leaves origin empty for the UNKNOWN verify context', () {
      final context = signEngine.unknownVerifyContext(
        ReownConstants.VERIFY_SERVER,
      );

      expect(context.validation, Validation.UNKNOWN);
      expect(context.origin, '');
      expect(context.verifyUrl, ReownConstants.VERIFY_SERVER);
    });

    test('preserves the provided verify url', () {
      const customVerifyUrl = 'https://verify.example.com';

      final context = signEngine.unknownVerifyContext(customVerifyUrl);

      expect(context.validation, Validation.UNKNOWN);
      expect(context.origin, '');
      expect(context.verifyUrl, customVerifyUrl);
    });
  });
}
