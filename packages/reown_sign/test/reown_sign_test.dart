import 'package:flutter_test/flutter_test.dart';
import 'package:reown_core/reown_core.dart';
import 'package:reown_core/store/generic_store.dart';
import 'package:reown_sign/reown_sign.dart';

import 'shared/shared_test_utils.dart';
import 'shared/shared_test_values.dart';
import 'tests/sign_common.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  mockPackageInfo();
  mockConnectivity();

  signEngineTests(
    context: 'SignEngine',
    clientACreator: (PairingMetadata metadata) async {
      final core = ReownCore(
        projectId: TEST_PROJECT_ID,
        relayUrl: TEST_RELAY_URL,
        memoryStore: true,
        logLevel: LogLevel.info,
        httpClient: getHttpWrapper(),
      );
      IReownSign engineA = ReownSign(
        core: core,
        metadata: metadata,
        proposals: GenericStore(
          storage: core.storage,
          context: StoreVersions.CONTEXT_PROPOSALS,
          version: StoreVersions.VERSION_PROPOSALS,
          fromJson: (dynamic value) {
            return ProposalData.fromJson(value);
          },
        ),
        sessions: Sessions(
          storage: core.storage,
          context: StoreVersions.CONTEXT_SESSIONS,
          version: StoreVersions.VERSION_SESSIONS,
          fromJson: (dynamic value) {
            return SessionData.fromJson(value);
          },
        ),
        pendingRequests: GenericStore(
          storage: core.storage,
          context: StoreVersions.CONTEXT_PENDING_REQUESTS,
          version: StoreVersions.VERSION_PENDING_REQUESTS,
          fromJson: (dynamic value) {
            return SessionRequest.fromJson(value);
          },
        ),
        authKeys: GenericStore(
          storage: core.storage,
          context: StoreVersions.CONTEXT_AUTH_KEYS,
          version: StoreVersions.VERSION_AUTH_KEYS,
          fromJson: (dynamic value) {
            return AuthPublicKey.fromJson(value);
          },
        ),
        pairingTopics: GenericStore(
          storage: core.storage,
          context: StoreVersions.CONTEXT_PAIRING_TOPICS,
          version: StoreVersions.VERSION_PAIRING_TOPICS,
          fromJson: (dynamic value) {
            return value;
          },
        ),
        sessionAuthRequests: GenericStore(
          storage: core.storage,
          context: StoreVersions.CONTEXT_AUTH_REQUESTS,
          version: StoreVersions.VERSION_AUTH_REQUESTS,
          fromJson: (dynamic value) {
            return PendingSessionAuthRequest.fromJson(value);
          },
        ),
      );
      await core.start();
      await engineA.init();

      return engineA;
    },
    clientBCreator: (PairingMetadata metadata) async {
      final core = ReownCore(
        projectId: TEST_PROJECT_ID,
        relayUrl: TEST_RELAY_URL,
        memoryStore: true,
        logLevel: LogLevel.info,
        httpClient: getHttpWrapper(),
      );
      IReownSign engineB = ReownSign(
        core: core,
        metadata: metadata,
        proposals: GenericStore(
          storage: core.storage,
          context: StoreVersions.CONTEXT_PROPOSALS,
          version: StoreVersions.VERSION_PROPOSALS,
          fromJson: (dynamic value) {
            return ProposalData.fromJson(value);
          },
        ),
        sessions: Sessions(
          storage: core.storage,
          context: StoreVersions.CONTEXT_SESSIONS,
          version: StoreVersions.VERSION_SESSIONS,
          fromJson: (dynamic value) {
            return SessionData.fromJson(value);
          },
        ),
        pendingRequests: GenericStore(
          storage: core.storage,
          context: StoreVersions.CONTEXT_PENDING_REQUESTS,
          version: StoreVersions.VERSION_PENDING_REQUESTS,
          fromJson: (dynamic value) {
            return SessionRequest.fromJson(value);
          },
        ),
        authKeys: GenericStore(
          storage: core.storage,
          context: StoreVersions.CONTEXT_AUTH_KEYS,
          version: StoreVersions.VERSION_AUTH_KEYS,
          fromJson: (dynamic value) {
            return AuthPublicKey.fromJson(value);
          },
        ),
        pairingTopics: GenericStore(
          storage: core.storage,
          context: StoreVersions.CONTEXT_PAIRING_TOPICS,
          version: StoreVersions.VERSION_PAIRING_TOPICS,
          fromJson: (dynamic value) {
            return value;
          },
        ),
        sessionAuthRequests: GenericStore(
          storage: core.storage,
          context: StoreVersions.CONTEXT_AUTH_REQUESTS,
          version: StoreVersions.VERSION_AUTH_REQUESTS,
          fromJson: (dynamic value) {
            return PendingSessionAuthRequest.fromJson(value);
          },
        ),
      );
      await core.start();
      await engineB.init();

      return engineB;
    },
  );
}
