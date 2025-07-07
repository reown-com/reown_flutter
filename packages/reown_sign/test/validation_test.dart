import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:reown_sign/reown_sign.dart';
import 'package:reown_sign/utils/sign_api_validator_utils.dart';

import 'shared/shared_test_values.dart';
import 'utils/sign_client_constants.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SignApiValidatorUtils', () {
    test('isContainedIn', () {
      expect(
        SignApiValidatorUtils.isContainedIn(
          container: ['a', 'b'],
          contained: ['a', 'b'],
        ),
        true,
      );
      expect(
        SignApiValidatorUtils.isContainedIn(
          container: ['a', 'b'],
          contained: ['b'],
        ),
        true,
      );
      expect(
        SignApiValidatorUtils.isContainedIn(
          container: ['a', 'b'],
          contained: [],
        ),
        true,
      );
      expect(
        SignApiValidatorUtils.isContainedIn(
          container: ['a', 'b'],
          contained: ['c'],
        ),
        false,
      );
      expect(
        SignApiValidatorUtils.isContainedIn(
          container: ['a', 'b'],
          contained: ['a', 'b', 'c'],
        ),
        false,
      );
      expect(
        SignApiValidatorUtils.isContainedIn(
          container: ['a', 'b'],
          contained: ['a', 'c'],
        ),
        false,
      );
    });
  });

  test('isValidChains', () {
    expect(
      SignApiValidatorUtils.isValidChains(
        nsOrChainId: TEST_ETHEREUM_CHAIN,
        context: 'test',
      ),
      true,
    );
    expect(
      SignApiValidatorUtils.isValidChains(
        nsOrChainId: EVM_NAMESPACE,
        chains: TEST_CHAINS,
        context: 'test',
      ),
      true,
    );
    expect(
      () => SignApiValidatorUtils.isValidChains(
        nsOrChainId: TEST_ETHEREUM_CHAIN,
        chains: TEST_CHAINS,
        context: 'test',
      ),
      throwsA(
        isA<ReownSignError>().having(
          (e) => e.message,
          'message',
          'Unsupported chains. test, namespace is a chainId, but chains is not empty',
        ),
      ),
    );
    expect(
      () => SignApiValidatorUtils.isValidChains(
        nsOrChainId: EVM_NAMESPACE,
        chains: TEST_CHAINS_INVALID,
        context: 'test',
      ),
      throwsA(
        isA<ReownSignError>().having(
          (e) => e.message,
          'message',
          'Unsupported chains. test, chain $TEST_CHAIN_INVALID_1 should conform to "CAIP-2" format',
        ),
      ),
    );
  });

  test('isValidRequiredNamespaces', () {
    expect(
      SignApiValidatorUtils.isValidRequiredNamespaces(
        requiredNamespaces: TEST_REQUIRED_NAMESPACES,
        context: 'test',
      ),
      true,
    );
    expect(
      () => SignApiValidatorUtils.isValidRequiredNamespaces(
        requiredNamespaces: TEST_REQUIRED_NAMESPACES_INVALID_CHAINS_1,
        context: 'test',
      ),
      throwsA(
        isA<ReownSignError>().having(
          (e) => e.message,
          'message',
          'Unsupported chains. test requiredNamespace, namespace is a chainId, but chains is not empty',
        ),
      ),
    );
    expect(
      () => SignApiValidatorUtils.isValidRequiredNamespaces(
        requiredNamespaces: TEST_REQUIRED_NAMESPACES_INVALID_CHAINS_2,
        context: 'test',
      ),
      throwsA(
        isA<ReownSignError>().having(
          (e) => e.message,
          'message',
          'Unsupported chains. test requiredNamespace, chain $TEST_CHAIN_INVALID_1 should conform to "CAIP-2" format',
        ),
      ),
    );
  });

  test('isValidSessionProperties', () {
    final String type = 'test';
    expect(
      SignApiValidatorUtils.isValidSessionProperties(
        properties: {'key': 'value'},
        type: type,
      ),
      true,
    );
    expect(
      () => SignApiValidatorUtils.isValidSessionProperties(
        properties: {'key': null},
        type: type,
      ),
      throwsA(
        isA<ReownSignError>().having(
          (e) => e.message,
          'message',
          'Malformed request parameters. $type must contain an existing value for each key. Received: null for key key',
        ),
      ),
    );
  });

  test('isValidScopedProperties', () {
    expect(
      SignApiValidatorUtils.isValidScopedProperties(
        properties: {'eip155:1': {}},
        namespaces: [
          ...TEST_REQUIRED_NAMESPACES.keys,
        ],
      ),
      true,
    );
    // should reject connect with scopedProperties when not defined in requiredNamespaces or optionalNamespaces
    expect(
      () => SignApiValidatorUtils.isValidScopedProperties(
        properties: {'eip155:1': {}},
        namespaces: [],
      ),
      throwsA(
        isA<ReownSignError>().having(
          (e) => e.message,
          'message',
          'Malformed request parameters. scopedProperties must be a subset of namespaces, received: {"eip155:1":{}}, namespaces: []',
        ),
      ),
    );
    // should reject connect with scopedProperties when not defined in requiredNamespaces or optionalNamespaces
    expect(
      () => SignApiValidatorUtils.isValidScopedProperties(
        properties: {'test:1': {}},
        namespaces: TEST_REQUIRED_NAMESPACES.keys.toList(),
      ),
      throwsA(
        isA<ReownSignError>().having(
          (e) => e.message,
          'message',
          'Malformed request parameters. scopedProperties must be a subset of namespaces, received: {"test:1":{}}, namespaces: ${jsonEncode(TEST_REQUIRED_NAMESPACES.keys.toList())}',
        ),
      ),
    );
  });

  test('isValidAccounts', () {
    expect(
      SignApiValidatorUtils.isValidAccounts(
        accounts: TEST_ACCOUNTS,
        context: 'test',
      ),
      true,
    );
    expect(
      () => SignApiValidatorUtils.isValidAccounts(
        accounts: TEST_ACCOUNTS_INVALID,
        context: 'test',
      ),
      throwsA(
        isA<ReownSignError>().having(
          (e) => e.message,
          'message',
          'Unsupported accounts. test, account $TEST_ACCOUNT_INVALID_1 should conform to "namespace:chainId:address" format',
        ),
      ),
    );
  });

  test('isValidNamespaces', () {
    expect(
      SignApiValidatorUtils.isValidNamespaces(
        namespaces: TEST_NAMESPACES,
        context: 'test',
      ),
      true,
    );
    expect(
      () => SignApiValidatorUtils.isValidNamespaces(
        namespaces: TEST_NAMESPACES_INVALID_ACCOUNTS,
        context: 'test',
      ),
      throwsA(
        isA<ReownSignError>().having(
          (e) => e.message,
          'message',
          'Unsupported accounts. test namespace, account $TEST_ACCOUNT_INVALID_1 should conform to "namespace:chainId:address" format',
        ),
      ),
    );
  });

  test('isValidNamespacesChainId', () {
    expect(
      SignApiValidatorUtils.isValidNamespacesChainId(
        namespaces: TEST_NAMESPACES,
        chainId: TEST_ETHEREUM_CHAIN,
      ),
      true,
    );
    expect(
      () => SignApiValidatorUtils.isValidNamespacesChainId(
        namespaces: TEST_NAMESPACES,
        chainId: TEST_UNINCLUDED_CHAIN,
      ),
      throwsA(
        isA<ReownSignError>().having(
          (e) => e.message,
          'message',
          'Unsupported chains. The chain $TEST_UNINCLUDED_CHAIN is not supported',
        ),
      ),
    );
    expect(
      () => SignApiValidatorUtils.isValidNamespacesChainId(
        namespaces: TEST_NAMESPACES,
        chainId: TEST_CHAIN_INVALID_1,
      ),
      throwsA(
        isA<ReownSignError>().having(
          (e) => e.message,
          'message',
          'Unsupported chains. chain $TEST_CHAIN_INVALID_1 should conform to "CAIP-2" format',
        ),
      ),
    );
    expect(
      () => SignApiValidatorUtils.isValidNamespacesChainId(
        namespaces: TEST_NAMESPACES_INVALID_ACCOUNTS,
        chainId: TEST_ETHEREUM_CHAIN,
      ),
      throwsA(
        isA<ReownSignError>().having(
          (e) => e.message,
          'message',
          'Unsupported accounts. isValidNamespacesChainId namespace, account $TEST_CHAIN_INVALID_1 should conform to "namespace:chainId:address" format',
        ),
      ),
    );
  });

  test('isValidNamespacesRequest', () {
    expect(
      SignApiValidatorUtils.isValidNamespacesRequest(
        namespaces: TEST_NAMESPACES,
        chainId: TEST_ETHEREUM_CHAIN,
        method: TEST_METHOD_1,
      ),
      true,
    );
    expect(
      () => SignApiValidatorUtils.isValidNamespacesRequest(
        namespaces: TEST_NAMESPACES,
        chainId: TEST_ETHEREUM_CHAIN,
        method: TEST_METHOD_3,
      ),
      throwsA(
        isA<ReownSignError>().having(
          (e) => e.message,
          'message',
          'Unsupported methods. The method $TEST_METHOD_3 is not supported',
        ),
      ),
    );
    expect(
      () => SignApiValidatorUtils.isValidNamespacesRequest(
        namespaces: TEST_NAMESPACES,
        chainId: TEST_CHAIN_INVALID_1,
        method: TEST_METHOD_1,
      ),
      throwsA(
        isA<ReownSignError>().having(
          (e) => e.message,
          'message',
          'Unsupported chains. chain $TEST_CHAIN_INVALID_1 should conform to "CAIP-2" format',
        ),
      ),
    );
    expect(
      () => SignApiValidatorUtils.isValidNamespacesRequest(
        namespaces: TEST_NAMESPACES_INVALID_ACCOUNTS,
        chainId: TEST_ETHEREUM_CHAIN,
        method: TEST_METHOD_1,
      ),
      throwsA(
        isA<ReownSignError>().having(
          (e) => e.message,
          'message',
          'Unsupported accounts. isValidNamespacesRequest namespace, account $TEST_CHAIN_INVALID_1 should conform to "namespace:chainId:address" format',
        ),
      ),
    );
  });

  test('isValidNamespacesEvent', () {
    expect(
      SignApiValidatorUtils.isValidNamespacesEvent(
        namespaces: TEST_NAMESPACES,
        chainId: TEST_ETHEREUM_CHAIN,
        eventName: TEST_EVENT_1,
      ),
      true,
    );
    expect(
      () => SignApiValidatorUtils.isValidNamespacesEvent(
        namespaces: TEST_NAMESPACES,
        chainId: TEST_ETHEREUM_CHAIN,
        eventName: TEST_EVENT_2,
      ),
      throwsA(
        isA<ReownSignError>().having(
          (e) => e.message,
          'message',
          'Unsupported events. The event $TEST_EVENT_2 is not supported',
        ),
      ),
    );
    expect(
      () => SignApiValidatorUtils.isValidNamespacesEvent(
        namespaces: TEST_NAMESPACES,
        chainId: TEST_CHAIN_INVALID_1,
        eventName: TEST_EVENT_1,
      ),
      throwsA(
        isA<ReownSignError>().having(
          (e) => e.message,
          'message',
          'Unsupported chains. chain $TEST_CHAIN_INVALID_1 should conform to "CAIP-2" format',
        ),
      ),
    );
    expect(
      () => SignApiValidatorUtils.isValidNamespacesEvent(
        namespaces: TEST_NAMESPACES_INVALID_ACCOUNTS,
        chainId: TEST_ETHEREUM_CHAIN,
        eventName: TEST_EVENT_1,
      ),
      throwsA(
        isA<ReownSignError>().having(
          (e) => e.message,
          'message',
          'Unsupported accounts. isValidNamespacesEvent namespace, account $TEST_CHAIN_INVALID_1 should conform to "namespace:chainId:address" format',
        ),
      ),
    );
  });

  test('isConformingNamespaces', () {
    expect(
      SignApiValidatorUtils.isConformingNamespaces(
        requiredNamespaces: TEST_REQUIRED_NAMESPACES,
        namespaces: TEST_NAMESPACES,
        context: 'test',
      ),
      true,
    );
    expect(
      SignApiValidatorUtils.isConformingNamespaces(
        requiredNamespaces: TEST_REQUIRED_NAMESPACES,
        namespaces: TEST_NAMESPACES,
        context: 'test',
      ),
      true,
    );
    final List nonconformingNamespaces = [
      TEST_NAMESPACES_NONCONFORMING_KEY_1,
      TEST_NAMESPACES_NONCONFORMING_KEY_2,
      TEST_NAMESPACES_NONCONFORMING_CHAINS,
      TEST_NAMESPACES_NONCONFORMING_METHODS,
      TEST_NAMESPACES_NONCONFORMING_EVENTS,
    ];
    final List errors = [
      "Unsupported namespace key. test namespaces keys don't satisfy requiredNamespaces",
      "Unsupported namespace key. test namespaces keys don't satisfy requiredNamespaces",
      "Unsupported chains. test namespaces chains don't satisfy requiredNamespaces chains for $EVM_NAMESPACE. Requested: [eip155:1, eip155:42161], Supported: [eip155:1]",
      "Unsupported methods. test namespaces methods don't satisfy requiredNamespaces methods for $EVM_NAMESPACE. Requested: [eth_sendTransaction, eth_signTransaction], Supported: [eth_invalid]",
      "Unsupported events. test namespaces events don't satisfy requiredNamespaces events for $EVM_NAMESPACE. Requested: [chainChanged], Supported: [eth_event_invalid]",
    ];
    for (int i = 0; i < nonconformingNamespaces.length; i++) {
      expect(
        () => SignApiValidatorUtils.isConformingNamespaces(
          requiredNamespaces: TEST_REQUIRED_NAMESPACES,
          namespaces: nonconformingNamespaces[i],
          context: 'test',
        ),
        throwsA(
          isA<ReownSignError>().having(
            (e) => e.message,
            'message',
            errors[i],
          ),
        ),
      );
    }
  });

  test('isSessionCompatible', () {
    expect(
      SignApiValidatorUtils.isSessionCompatible(
        session: testSessionValid,
        requiredNamespaces: TEST_REQUIRED_NAMESPACES,
      ),
      true,
    );
    final List nonconformingNamespaces = [
      TEST_NAMESPACES_NONCONFORMING_KEY_1,
      TEST_NAMESPACES_NONCONFORMING_KEY_2,
      TEST_NAMESPACES_NONCONFORMING_CHAINS,
      TEST_NAMESPACES_NONCONFORMING_METHODS,
      TEST_NAMESPACES_NONCONFORMING_EVENTS,
    ];
    for (int i = 0; i < nonconformingNamespaces.length; i++) {
      final SessionData newSessionData = testSessionValid.copyWith(
        namespaces: nonconformingNamespaces[i],
      );
      expect(
        SignApiValidatorUtils.isSessionCompatible(
          session: newSessionData,
          requiredNamespaces: TEST_REQUIRED_NAMESPACES,
        ),
        false,
      );
    }
  });
}
