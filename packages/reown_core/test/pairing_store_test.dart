import 'package:flutter_test/flutter_test.dart';

import 'package:reown_core/pairing/i_json_rpc_history.dart';
import 'package:reown_core/pairing/i_pairing.dart';
import 'package:reown_core/pairing/json_rpc_history.dart';
import 'package:reown_core/pairing/pairing.dart';
import 'package:reown_core/pairing/pairing_store.dart';
import 'package:reown_core/reown_core.dart';
import 'package:reown_core/store/generic_store.dart';

import 'shared/shared_test_utils.dart';
import 'shared/shared_test_values.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  mockPackageInfo();
  mockConnectivity();

  group('Pairing store', () {
    late IReownCore coreA;
    late IReownCore coreB;

    late IPairing pairing;
    late IJsonRpcHistory history;
    late IPairingStore pairingStore;
    late GenericStore<ReceiverPublicKey> topicToReceiverPublicKey;

    setUp(() async {
      coreA = ReownCore(
        relayUrl: TEST_RELAY_URL,
        projectId: TEST_PROJECT_ID,
        memoryStore: true,
        httpClient: getHttpWrapper(),
      );
      coreB = ReownCore(
        relayUrl: TEST_RELAY_URL,
        projectId: TEST_PROJECT_ID,
        memoryStore: true,
        httpClient: getHttpWrapper(),
      );
      await coreA.start();
      await coreB.start();

      pairingStore = PairingStore(
        storage: coreA.storage,
        context: StoreVersions.CONTEXT_PAIRINGS,
        version: StoreVersions.VERSION_PAIRINGS,
        fromJson: (dynamic value) {
          return PairingInfo.fromJson(value as Map<String, dynamic>);
        },
      );
      history = JsonRpcHistory(
        storage: coreA.storage,
        context: StoreVersions.CONTEXT_JSON_RPC_HISTORY,
        version: StoreVersions.VERSION_JSON_RPC_HISTORY,
        fromJson: (dynamic value) => JsonRpcRecord.fromJson(value),
      );
      topicToReceiverPublicKey = GenericStore(
        storage: coreA.storage,
        context: StoreVersions.CONTEXT_TOPIC_TO_RECEIVER_PUBLIC_KEY,
        version: StoreVersions.VERSION_TOPIC_TO_RECEIVER_PUBLIC_KEY,
        fromJson: (dynamic value) => ReceiverPublicKey.fromJson(value),
      );
      pairing = Pairing(
        core: coreA,
        pairings: pairingStore,
        history: history,
        topicToReceiverPublicKey: topicToReceiverPublicKey,
      );
    });

    tearDown(() async {
      await coreA.relayClient.disconnect();
      await coreB.relayClient.disconnect();
    });

    group('pairing init', () {
      test('deletes expired records', () async {
        await history.init();
        await history.set(
          '1',
          const JsonRpcRecord(
            id: 1,
            topic: '1',
            method: 'eth_sign',
            params: '',
          ),
        );
        await history.set(
          '2',
          const JsonRpcRecord(
            id: 2,
            topic: '1',
            method: 'eth_sign',
            params: '',
            expiry: 0,
          ),
        );
        await pairingStore.init();
        await pairingStore.set(
          'expired',
          PairingInfo(
            topic: 'expired',
            expiry: -1,
            relay: Relay(
              ReownConstants.RELAYER_DEFAULT_PROTOCOL,
            ),
            active: true,
          ),
        );
        await topicToReceiverPublicKey.init();
        await topicToReceiverPublicKey.set(
          'abc',
          const ReceiverPublicKey(
            topic: 'abc',
            publicKey: 'def',
            expiry: -1,
          ),
        );

        expect(history.getAll().length, 2);
        expect(pairingStore.getAll().length, 1);
        expect(topicToReceiverPublicKey.getAll().length, 1);
        await pairing.init();
        expect(history.getAll().length, 0);
        expect(pairingStore.getAll().length, 0);
        expect(topicToReceiverPublicKey.getAll().length, 0);
      });
    });
  });
}
