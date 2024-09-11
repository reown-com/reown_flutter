import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:reown_core/reown_core.dart';
import 'package:reown_core/store/i_store.dart';
import 'package:reown_core/store/shared_prefs_store.dart';
import 'package:reown_sign/reown_sign.dart';

import 'shared/engine_constants.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Store', () {
    late IStore<Map<String, dynamic>> store;

    setUp(() async {
      store = SharedPrefsStores(
        memoryStore: true,
      );
      await store.init();
    });

    group('special stores', () {
      test('sessions', () async {
        ISessions specialStore = Sessions(
          storage: store,
          context: 'messageTracker',
          version: 'swag',
          fromJson: (dynamic value) {
            return SessionData.fromJson(value);
          },
        );

        await specialStore.init();

        await specialStore.set(
          '1',
          SessionData(
            topic: '1',
            pairingTopic: '2',
            relay: Relay('irn'),
            expiry: -1,
            acknowledged: false,
            controller: 'controller',
            namespaces: {
              'eth': const Namespace(accounts: [], methods: [], events: []),
            },
            self: TEST_CONNECTION_METADATA_REQUESTER,
            peer: TEST_CONNECTION_METADATA_REQUESTER,
          ),
        );

        Completer updateComplete = Completer();
        Completer syncComplete = Completer();
        specialStore.onUpdate.subscribe((args) {
          updateComplete.complete();
        });
        specialStore.onSync.subscribe((args) {
          syncComplete.complete();
        });

        expect(
          specialStore.get('1')!.expiry,
          -1,
        );

        await specialStore.update(
          '1',
          expiry: 2,
        );

        await updateComplete.future;
        await syncComplete.future;

        expect(
          specialStore.get('1')!.expiry,
          2,
        );
      });
    });
  });
}
