import 'package:flutter_test/flutter_test.dart';
import 'package:reown_core/reown_core.dart';
import 'package:reown_sign/reown_sign.dart';
import 'package:reown_sign/utils/sign_api_validator_utils.dart';

import '../shared/shared_test_values.dart';
import 'sign_client_constants.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('NamespaceUtils', () {
    test('isValidChainId', () {
      expect(
        NamespaceUtils.isValidChainId(TEST_ETHEREUM_CHAIN),
        true,
      );
      expect(NamespaceUtils.isValidChainId(TEST_CHAIN_INVALID_1), false);
      expect(NamespaceUtils.isValidChainId(TEST_CHAIN_INVALID_2), false);
    });

    test('isValidAccount', () {
      expect(
        NamespaceUtils.isValidAccount(
          TEST_ETHEREUM_ACCOUNT,
        ),
        true,
      );
      expect(NamespaceUtils.isValidAccount(TEST_ACCOUNT_INVALID_1), false);
      expect(NamespaceUtils.isValidAccount(TEST_ACCOUNT_INVALID_2), false);
      expect(NamespaceUtils.isValidAccount(TEST_ACCOUNT_INVALID_3), false);
    });

    test('isValidUrl', () {
      expect(
        NamespaceUtils.isValidUrl(TEST_RELAY_URL),
        true,
      );
    });

    test('getAccount', () {
      expect('invalid', 'invalid');
      expect(
        NamespaceUtils.getAccount(TEST_ACCOUNTS[0]),
        TEST_ACCOUNTS[0].split(':')[2],
      );
    });

    test('getChainFromAccount', () {
      expect('invalid', 'invalid');
      expect(
        NamespaceUtils.getChainFromAccount(TEST_ACCOUNTS[0]),
        TEST_CHAINS[0],
      );
    });

    test('getChainsFromAccounts', () {
      expect(NamespaceUtils.getChainsFromAccounts([]), []);
      expect(
        NamespaceUtils.getChainsFromAccounts(TEST_ACCOUNTS),
        TEST_CHAINS,
      );
      expect(
        NamespaceUtils.getChainsFromAccounts(
          [
            ...TEST_ACCOUNTS,
            ...TEST_ACCOUNTS,
          ],
        ),
        TEST_CHAINS,
      );
    });

    test('getNamespaceFromChain', () {
      expect(NamespaceUtils.getNamespaceFromChain('invalid'), 'invalid');
      expect(
        NamespaceUtils.getNamespaceFromChain(TEST_ETHEREUM_CHAIN),
        'eip155',
      );
    });

    test('getChainsFromNamespace', () {
      expect(
        NamespaceUtils.getChainIdsFromNamespace(
          nsOrChainId: EVM_NAMESPACE,
          namespace: TEST_ETH_ARB_NAMESPACE,
        ),
        TEST_CHAINS,
      );
      expect(
        NamespaceUtils.getChainIdsFromNamespace(
          nsOrChainId: TEST_AVALANCHE_CHAIN,
          namespace: TEST_AVA_NAMESPACE,
        ),
        [TEST_AVALANCHE_CHAIN],
      );
    });

    test('getChainsFromNamespaces', () {
      expect(
        NamespaceUtils.getChainIdsFromNamespaces(
          namespaces: TEST_NAMESPACES,
        ),
        [...TEST_CHAINS, TEST_AVALANCHE_CHAIN],
      );
    });

    test('getNamespacesMethodsForChainId', () {
      expect(
        NamespaceUtils.getNamespacesMethodsForChainId(
          chainId: TEST_ETHEREUM_CHAIN,
          namespaces: TEST_NAMESPACES,
        ),
        TEST_METHODS_1,
      );
      expect(
        NamespaceUtils.getNamespacesMethodsForChainId(
          chainId: TEST_ARBITRUM_CHAIN,
          namespaces: TEST_NAMESPACES,
        ),
        TEST_METHODS_1,
      );
      expect(
        NamespaceUtils.getNamespacesMethodsForChainId(
          chainId: TEST_AVALANCHE_CHAIN,
          namespaces: TEST_NAMESPACES,
        ),
        TEST_METHODS_2,
      );
    });

    test('getNamespacesEventsForChainId', () {
      expect(
        NamespaceUtils.getNamespacesEventsForChain(
          chainId: TEST_ETHEREUM_CHAIN,
          namespaces: TEST_NAMESPACES,
        ),
        [TEST_EVENT_1],
      );
      expect(
        NamespaceUtils.getNamespacesEventsForChain(
          chainId: TEST_ARBITRUM_CHAIN,
          namespaces: TEST_NAMESPACES,
        ),
        [TEST_EVENT_1],
      );
      expect(
        NamespaceUtils.getNamespacesEventsForChain(
          chainId: TEST_AVALANCHE_CHAIN,
          namespaces: TEST_NAMESPACES,
        ),
        [TEST_EVENT_2],
      );
    });

    test('getChainsFromRequiredNamespace', () {
      expect(
        NamespaceUtils.getChainsFromRequiredNamespace(
          nsOrChainId: EVM_NAMESPACE,
          requiredNamespace: TEST_ETH_ARB_REQUIRED_NAMESPACE,
        ),
        TEST_CHAINS,
      );
      expect(
        NamespaceUtils.getChainsFromRequiredNamespace(
          nsOrChainId: TEST_AVALANCHE_CHAIN,
          requiredNamespace: TEST_AVA_REQUIRED_NAMESPACE,
        ),
        [TEST_AVALANCHE_CHAIN],
      );
    });

    test('getChainsFromRequiredNamespaces', () {
      expect(
        NamespaceUtils.getChainIdsFromRequiredNamespaces(
          requiredNamespaces: TEST_REQUIRED_NAMESPACES,
        ),
        [...TEST_CHAINS, TEST_AVALANCHE_CHAIN],
      );
    });

    group('constructNamespaces', () {
      test('constructs namespaces with required namespaces', () {
        Map<String, Namespace> namespaces = NamespaceUtils.generateNamespaces(
          availableAccounts: availableAccounts,
          availableMethods: availableMethods,
          availableEvents: availableEvents,
          requiredNamespaces: requiredNamespacesInAvailable,
        );

        expect(namespaces.length, 2);
        expect(
          namespaces['namespace1:chain1']!.accounts,
          ['namespace1:chain1:address1', 'namespace1:chain1:address2'],
        );
        expect(
          namespaces['namespace1:chain1']!.methods,
          ['method1'],
        );
        expect(
          namespaces['namespace1:chain1']!.events,
          ['event1'],
        );

        expect(namespaces['namespace2']!.accounts, [
          'namespace2:chain1:address3',
          'namespace2:chain1:address4',
          'namespace2:chain2:address5',
        ]);
        expect(
          namespaces['namespace2']!.methods,
          ['method3'],
        );
        expect(
          namespaces['namespace2']!.events,
          ['event3'],
        );

        expect(
          SignApiValidatorUtils.isConformingNamespaces(
            requiredNamespaces: requiredNamespacesInAvailable,
            namespaces: namespaces,
            context: '',
          ),
          true,
        );

        namespaces = NamespaceUtils.generateNamespaces(
          availableAccounts: availableAccounts,
          availableMethods: availableMethods,
          availableEvents: availableEvents,
          requiredNamespaces: requiredNamespacesInAvailable2,
        );

        expect(namespaces.length, 2);
        expect(
          namespaces['namespace1']!.accounts,
          ['namespace1:chain1:address1', 'namespace1:chain1:address2'],
        );
        expect(
          namespaces['namespace1']!.methods,
          ['method1'],
        );
        expect(
          namespaces['namespace1']!.events,
          ['event1'],
        );

        expect(namespaces['namespace2']!.accounts, [
          'namespace2:chain1:address3',
          'namespace2:chain1:address4',
          'namespace2:chain2:address5',
        ]);
        expect(
          namespaces['namespace2']!.methods,
          ['method3'],
        );
        expect(
          namespaces['namespace2']!.events,
          ['event3'],
        );

        expect(
          SignApiValidatorUtils.isConformingNamespaces(
            requiredNamespaces: requiredNamespacesInAvailable2,
            namespaces: namespaces,
            context: '',
          ),
          true,
        );

        namespaces = NamespaceUtils.generateNamespaces(
          availableAccounts: availableAccounts,
          availableMethods: availableMethods,
          availableEvents: availableEvents,
          requiredNamespaces: requiredNamespacesMatchingAvailable1,
        );

        expect(namespaces.length, 2);
        expect(
          namespaces['namespace1:chain1']!.accounts,
          ['namespace1:chain1:address1', 'namespace1:chain1:address2'],
        );
        expect(
          namespaces['namespace1:chain1']!.methods,
          ['method1', 'method2'],
        );
        expect(
          namespaces['namespace1:chain1']!.events,
          ['event1', 'event2'],
        );

        expect(namespaces['namespace2']!.accounts, [
          'namespace2:chain1:address3',
          'namespace2:chain1:address4',
        ]);
        expect(
          namespaces['namespace2']!.methods,
          ['method3', 'method4'],
        );
        expect(
          namespaces['namespace2']!.events,
          ['event3', 'event4'],
        );

        expect(
          SignApiValidatorUtils.isConformingNamespaces(
            requiredNamespaces: requiredNamespacesMatchingAvailable1,
            namespaces: namespaces,
            context: '',
          ),
          true,
        );
      });

      test('constructs namespaces with required and optional namespaces', () {
        Map<String, Namespace> namespaces = NamespaceUtils.generateNamespaces(
          availableAccounts: availableAccounts3,
          availableMethods: availableMethods3,
          availableEvents: availableEvents3,
          requiredNamespaces: requiredNamespacesInAvailable3,
          optionalNamespaces: optionalNamespacesInAvailable3,
        );

        expect(namespaces.length, 1);
        expect(
          namespaces['eip155']!.accounts,
          availableAccounts3.toList(),
        );
        expect(
          namespaces['eip155']!.methods,
          availableMethods3.map((m) => m.split(':').last).toList(),
        );
        expect(
          namespaces['eip155']!.events,
          availableEvents3.map((m) => m.split(':').last).toList(),
        );

        expect(
          SignApiValidatorUtils.isConformingNamespaces(
            requiredNamespaces: requiredNamespacesInAvailable3,
            namespaces: namespaces,
            context: '',
          ),
          true,
        );
      });

      test('constructNamespaces trims off unrequested', () {
        final reqNamespace = {
          'eip155': const RequiredNamespace(
              chains: ['eip155:1'],
              methods: ['eth_sendTransaction', 'personal_sign'],
              events: ['chainChanged', 'accountsChanged']),
        };
        final optionalNamespace = {
          'eip155': const RequiredNamespace(
            chains: ['eip155:137'],
            methods: [
              'eth_sendTransaction',
              'personal_sign',
              'eth_accounts',
              'eth_requestAccounts',
              'eth_call',
              'eth_getBalance',
              'eth_sendRawTransaction',
              'eth_sign',
              'eth_signTransaction',
              'eth_signTypedData',
              'eth_signTypedData_v3',
              'eth_signTypedData_v4',
              'wallet_switchEthereumChain',
              'wallet_addEthereumChain',
              'wallet_getPermissions',
              'wallet_requestPermissions',
              'wallet_registerOnboarding',
              'wallet_watchAsset',
              'wallet_scanQRCode'
            ],
            events: [
              'chainChanged',
              'accountsChanged',
              'message',
              'disconnect',
              'connect'
            ],
          )
        };
        final Set<String> availableAccounts = {
          'eip155:1:0x83ba3013f776d4e2801010ee88581aedf5349b43',
          'eip155:5:0x83ba3013f776d4e2801010ee88581aedf5349b43',
          'eip155:137:0x83ba3013f776d4e2801010ee88581aedf5349b43',
          'eip155:80001:0x83ba3013f776d4e2801010ee88581aedf5349b43',
        };
        final Set<String> availableMethods = {
          'eip155:1:personal_sign',
          'eip155:1:eth_sign',
          'eip155:1:eth_signTransaction',
          'eip155:1:eth_sendTransaction',
          'eip155:1:eth_signTypedData',
          'eip155:137:personal_sign',
          'eip155:137:eth_sign',
          'eip155:137:eth_signTransaction',
          'eip155:137:eth_sendTransaction',
          'eip155:137:eth_signTypedData',
          'eip155:5:personal_sign',
          'eip155:5:eth_sign',
          'eip155:5:eth_signTransaction',
          'eip155:5:eth_sendTransaction',
          'eip155:5:eth_signTypedData',
          'eip155:80001:personal_sign',
          'eip155:80001:eth_sign',
          'eip155:80001:eth_signTransaction',
          'eip155:80001:eth_sendTransaction',
          'eip155:80001:eth_signTypedData',
        };
        final Set<String> availableEvents = {
          'eip155:1:chainChanged',
          'eip155:1:accountsChanged',
          'eip155:137:chainChanged',
          'eip155:137:accountsChanged',
          'eip155:5:chainChanged',
          'eip155:5:accountsChanged',
          'eip155:80001:chainChanged',
          'eip155:80001:accountsChanged',
        };

        final Map<String, Namespace> namespaces =
            NamespaceUtils.generateNamespaces(
          availableAccounts: availableAccounts,
          availableMethods: availableMethods,
          availableEvents: availableEvents,
          requiredNamespaces: reqNamespace,
          optionalNamespaces: optionalNamespace,
        );
        final Namespace? eip155 = namespaces['eip155'];
        // print(eip155);

        expect(eip155 != null, true);
        expect(
          eip155!.accounts,
          [
            'eip155:1:0x83ba3013f776d4e2801010ee88581aedf5349b43',
            'eip155:137:0x83ba3013f776d4e2801010ee88581aedf5349b43'
          ],
        );
        expect(
          eip155.methods,
          [
            'personal_sign',
            'eth_sendTransaction',
            'eth_sign',
            'eth_signTransaction',
            'eth_signTypedData'
          ],
        );
        expect(
          eip155.events,
          ['chainChanged', 'accountsChanged'],
        );
      });

      test('nonconforming if available information does not satisfy required',
          () {
        final List nonconforming = [
          requiredNamespacesNonconformingAccounts1,
          requiredNamespacesNonconformingMethods1,
          requiredNamespacesNonconformingMethods2,
          requiredNamespacesNonconformingEvents1,
          requiredNamespacesNonconformingEvents2,
        ];
        final List expected = [
          Errors.getSdkError(
            Errors.UNSUPPORTED_CHAINS,
            context:
                " namespaces chains don't satisfy requiredNamespaces chains for namespace3. Requested: [namespace3:chain1], Supported: []",
          ).message,
          Errors.getSdkError(
            Errors.UNSUPPORTED_METHODS,
            context:
                " namespaces methods don't satisfy requiredNamespaces methods for namespace1:chain1. Requested: [method1, method2, method3], Supported: [method1, method2]",
          ).message,
          Errors.getSdkError(
            Errors.UNSUPPORTED_METHODS,
            context:
                " namespaces methods don't satisfy requiredNamespaces methods for namespace1:chain1. Requested: [method1, method2, method3], Supported: [method1, method2]",
          ).message,
          Errors.getSdkError(
            Errors.UNSUPPORTED_EVENTS,
            context:
                " namespaces events don't satisfy requiredNamespaces events for namespace1:chain1. Requested: [event1, event2, event3], Supported: [event1, event2]",
          ).message,
          Errors.getSdkError(
            Errors.UNSUPPORTED_EVENTS,
            context:
                " namespaces events don't satisfy requiredNamespaces events for namespace1:chain1. Requested: [event1, event2, event3], Supported: [event1, event2]",
          ).message,
        ];

        for (int i = 0; i < nonconforming.length; i++) {
          final namespaces = NamespaceUtils.generateNamespaces(
            availableAccounts: availableAccounts,
            availableMethods: availableMethods,
            availableEvents: availableEvents,
            requiredNamespaces: nonconforming[i],
          );

          // Expect a thrown error
          expect(
            () => SignApiValidatorUtils.isConformingNamespaces(
              requiredNamespaces: nonconforming[i],
              namespaces: namespaces,
              context: '',
            ),
            throwsA(
              isA<ReownSignError>().having(
                (e) => e.message,
                'message',
                expected[i],
              ),
            ),
          );
        }
      });

      test('constructs namespaces with optional namespaces', () {
        Map<String, Namespace> namespaces = NamespaceUtils.generateNamespaces(
          availableAccounts: availableAccounts,
          availableMethods: availableMethods,
          availableEvents: availableEvents,
          requiredNamespaces: requiredNamespacesInAvailable,
          optionalNamespaces: optionalNamespaces,
        );

        // print(namespaces);
        expect(namespaces.keys.length, 3);

        expect(
          namespaces['namespace4:chain1']!.accounts,
          ['namespace4:chain1:address6'],
        );
        expect(
          namespaces['namespace4:chain1']!.methods,
          ['method5'],
        );
        expect(
          namespaces['namespace4:chain1']!.events,
          ['event5'],
        );

        expect(
          SignApiValidatorUtils.isConformingNamespaces(
            requiredNamespaces: requiredNamespacesInAvailable,
            namespaces: namespaces,
            context: '',
          ),
          true,
        );
      });
    });

    group('mergeRequiredIntoOptionalNamespaces', () {
      test('merges required namespaces into empty optional namespaces', () {
        final requiredNamespaces = {
          'eip155': const RequiredNamespace(
            chains: ['eip155:1', 'eip155:137'],
            methods: ['eth_sendTransaction', 'personal_sign'],
            events: ['chainChanged', 'accountsChanged'],
          ),
        };
        final optionalNamespaces = <String, RequiredNamespace>{};

        final result = NamespaceUtils.mergeRequiredIntoOptionalNamespaces(
          requiredNamespaces,
          optionalNamespaces,
        );

        expect(result.length, 1);
        expect(result['eip155'], requiredNamespaces['eip155']);
      });

      test('merges required namespaces into existing optional namespaces', () {
        final requiredNamespaces = {
          'eip155': const RequiredNamespace(
            chains: ['eip155:1'],
            methods: ['eth_sendTransaction'],
            events: ['chainChanged'],
          ),
        };
        final optionalNamespaces = {
          'eip155': const RequiredNamespace(
            chains: ['eip155:137'],
            methods: ['personal_sign'],
            events: ['accountsChanged'],
          ),
        };

        final result = NamespaceUtils.mergeRequiredIntoOptionalNamespaces(
          requiredNamespaces,
          optionalNamespaces,
        );

        expect(result.length, 1);
        expect(result['eip155']!.chains, ['eip155:1', 'eip155:137']);
        expect(result['eip155']!.methods,
            ['eth_sendTransaction', 'personal_sign']);
        expect(result['eip155']!.events, ['chainChanged', 'accountsChanged']);
      });

      test(
          'merges overlapping chains, methods, and events with duplicates removed',
          () {
        final requiredNamespaces = {
          'eip155': const RequiredNamespace(
            chains: ['eip155:1', 'eip155:137'],
            methods: ['eth_sendTransaction', 'personal_sign'],
            events: ['chainChanged', 'accountsChanged'],
          ),
        };
        final optionalNamespaces = {
          'eip155': const RequiredNamespace(
            chains: ['eip155:137', 'eip155:80001'], // eip155:137 is duplicate
            methods: [
              'personal_sign',
              'eth_call'
            ], // personal_sign is duplicate
            events: [
              'accountsChanged',
              'message'
            ], // accountsChanged is duplicate
          ),
        };

        final result = NamespaceUtils.mergeRequiredIntoOptionalNamespaces(
          requiredNamespaces,
          optionalNamespaces,
        );

        expect(result.length, 1);
        expect(result['eip155']!.chains,
            ['eip155:1', 'eip155:137', 'eip155:80001']);
        expect(result['eip155']!.methods,
            ['eth_sendTransaction', 'personal_sign', 'eth_call']);
        expect(result['eip155']!.events,
            ['chainChanged', 'accountsChanged', 'message']);
      });

      test('handles multiple namespaces correctly', () {
        final requiredNamespaces = {
          'eip155': const RequiredNamespace(
            chains: ['eip155:1'],
            methods: ['eth_sendTransaction'],
            events: ['chainChanged'],
          ),
          'solana': const RequiredNamespace(
            chains: ['solana:mainnet'],
            methods: ['solana_signTransaction'],
            events: ['accountChanged'],
          ),
        };
        final optionalNamespaces = {
          'eip155': const RequiredNamespace(
            chains: ['eip155:137'],
            methods: ['personal_sign'],
            events: ['accountsChanged'],
          ),
          'cosmos': const RequiredNamespace(
            chains: ['cosmos:cosmoshub-4'],
            methods: ['cosmos_signDirect'],
            events: ['chainChanged'],
          ),
        };

        final result = NamespaceUtils.mergeRequiredIntoOptionalNamespaces(
          requiredNamespaces,
          optionalNamespaces,
        );

        expect(result.length, 3);

        // Check eip155 (merged)
        expect(result['eip155']!.chains, ['eip155:1', 'eip155:137']);
        expect(result['eip155']!.methods,
            ['eth_sendTransaction', 'personal_sign']);
        expect(result['eip155']!.events, ['chainChanged', 'accountsChanged']);

        // Check solana (only in required)
        expect(result['solana']!.chains, ['solana:mainnet']);
        expect(result['solana']!.methods, ['solana_signTransaction']);
        expect(result['solana']!.events, ['accountChanged']);

        // Check cosmos (only in optional)
        expect(result['cosmos']!.chains, ['cosmos:cosmoshub-4']);
        expect(result['cosmos']!.methods, ['cosmos_signDirect']);
        expect(result['cosmos']!.events, ['chainChanged']);
      });

      test('handles null chains correctly', () {
        final requiredNamespaces = {
          'eip155': const RequiredNamespace(
            chains: null,
            methods: ['eth_sendTransaction'],
            events: ['chainChanged'],
          ),
        };
        final optionalNamespaces = {
          'eip155': const RequiredNamespace(
            chains: ['eip155:1', 'eip155:137'],
            methods: ['personal_sign'],
            events: ['accountsChanged'],
          ),
        };

        final result = NamespaceUtils.mergeRequiredIntoOptionalNamespaces(
          requiredNamespaces,
          optionalNamespaces,
        );

        expect(result.length, 1);
        expect(result['eip155']!.chains, ['eip155:1', 'eip155:137']);
        expect(result['eip155']!.methods,
            ['eth_sendTransaction', 'personal_sign']);
        expect(result['eip155']!.events, ['chainChanged', 'accountsChanged']);
      });

      test('handles both null chains correctly', () {
        final requiredNamespaces = {
          'eip155': const RequiredNamespace(
            chains: null,
            methods: ['eth_sendTransaction'],
            events: ['chainChanged'],
          ),
        };
        final optionalNamespaces = {
          'eip155': const RequiredNamespace(
            chains: null,
            methods: ['personal_sign'],
            events: ['accountsChanged'],
          ),
        };

        final result = NamespaceUtils.mergeRequiredIntoOptionalNamespaces(
          requiredNamespaces,
          optionalNamespaces,
        );

        expect(result.length, 1);
        expect(result['eip155']!.chains, null);
        expect(result['eip155']!.methods,
            ['eth_sendTransaction', 'personal_sign']);
        expect(result['eip155']!.events, ['chainChanged', 'accountsChanged']);
      });

      test('preserves order of methods and events', () {
        final requiredNamespaces = {
          'eip155': const RequiredNamespace(
            chains: ['eip155:1'],
            methods: ['eth_sendTransaction', 'personal_sign'],
            events: ['chainChanged', 'accountsChanged'],
          ),
        };
        final optionalNamespaces = {
          'eip155': const RequiredNamespace(
            chains: ['eip155:137'],
            methods: ['eth_call', 'eth_getBalance'],
            events: ['message', 'disconnect'],
          ),
        };

        final result = NamespaceUtils.mergeRequiredIntoOptionalNamespaces(
          requiredNamespaces,
          optionalNamespaces,
        );

        expect(result.length, 1);
        expect(result['eip155']!.methods, [
          'eth_sendTransaction',
          'personal_sign',
          'eth_call',
          'eth_getBalance'
        ]);
        expect(result['eip155']!.events,
            ['chainChanged', 'accountsChanged', 'message', 'disconnect']);
      });

      test('handles empty required namespaces', () {
        final requiredNamespaces = <String, RequiredNamespace>{};
        final optionalNamespaces = {
          'eip155': const RequiredNamespace(
            chains: ['eip155:1'],
            methods: ['eth_sendTransaction'],
            events: ['chainChanged'],
          ),
        };

        final result = NamespaceUtils.mergeRequiredIntoOptionalNamespaces(
          requiredNamespaces,
          optionalNamespaces,
        );

        expect(result.length, 1);
        expect(result['eip155'], optionalNamespaces['eip155']);
      });

      test('handles empty optional namespaces', () {
        final requiredNamespaces = {
          'eip155': const RequiredNamespace(
            chains: ['eip155:1'],
            methods: ['eth_sendTransaction'],
            events: ['chainChanged'],
          ),
        };
        final optionalNamespaces = <String, RequiredNamespace>{};

        final result = NamespaceUtils.mergeRequiredIntoOptionalNamespaces(
          requiredNamespaces,
          optionalNamespaces,
        );

        expect(result.length, 1);
        expect(result['eip155'], requiredNamespaces['eip155']);
      });

      test('handles both empty maps', () {
        final requiredNamespaces = <String, RequiredNamespace>{};
        final optionalNamespaces = <String, RequiredNamespace>{};

        final result = NamespaceUtils.mergeRequiredIntoOptionalNamespaces(
          requiredNamespaces,
          optionalNamespaces,
        );

        expect(result.length, 0);
      });
    });
  });
}
