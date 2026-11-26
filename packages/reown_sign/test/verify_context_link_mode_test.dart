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

  group('Link mode verify context', () {
    late ReownSign signEngine;
    late ReownCore core;

    const payload = JsonRpcRequest(
      id: 1,
      method: 'wc_sessionAuthenticate',
      params: {},
    );

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

    test('resolves to UNKNOWN with empty origin when metadata hosts match',
        () async {
      // Link mode is not attested by the Verify service, so the verify context
      // resolves to UNKNOWN with an empty origin even when the metadata hosts
      // match.
      final metadata = PairingMetadata(
        name: 'Requester',
        description: 'Requester metadata',
        url: 'https://example.com',
        icons: const [],
        redirect: Redirect(
          native: 'requester://',
          universal: 'https://example.com/app',
          linkMode: true,
        ),
      );

      final context = await signEngine.getVerifyContextLinkMode(
        payload,
        metadata,
      );

      expect(context.validation, Validation.UNKNOWN);
      expect(context.origin, '');
      expect(context.isScam, isNot(true));
    });

    test('resolves to UNKNOWN with empty origin when metadata hosts differ',
        () async {
      final metadata = PairingMetadata(
        name: 'Requester',
        description: 'Requester metadata',
        url: 'https://example.com',
        icons: const [],
        redirect: Redirect(
          native: 'requester://',
          universal: 'https://unrelated.example.net/app',
          linkMode: true,
        ),
      );

      final context = await signEngine.getVerifyContextLinkMode(
        payload,
        metadata,
      );

      expect(context.validation, Validation.UNKNOWN);
      expect(context.origin, '');
    });

    test('resolves to UNKNOWN with empty origin when redirect is absent',
        () async {
      const metadata = PairingMetadata(
        name: 'Requester',
        description: 'Requester metadata',
        url: 'https://example.com',
        icons: [],
      );

      final context = await signEngine.getVerifyContextLinkMode(
        payload,
        metadata,
      );

      expect(context.validation, Validation.UNKNOWN);
      expect(context.origin, '');
    });
  });
}
