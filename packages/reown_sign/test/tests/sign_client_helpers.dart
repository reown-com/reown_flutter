import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:reown_core/reown_core.dart';
import 'package:reown_sign/i_sign_dapp.dart';
import 'package:reown_sign/i_sign_wallet.dart';
import 'package:reown_sign/reown_sign.dart';

import '../shared/shared_test_values.dart';
import '../utils/sign_client_constants.dart';

class TestConnectMethodReturn {
  PairingInfo pairing;
  SessionData session;
  int connectLatency;
  int settleLatency;

  TestConnectMethodReturn(
    this.pairing,
    this.session,
    this.connectLatency,
    this.settleLatency,
  );
}

class SignClientHelpers {
  static Future<TestConnectMethodReturn> testConnectPairApprove(
    IReownSignDapp a,
    IReownSignWallet b, {
    Map<String, Namespace>? namespaces,
    Map<String, RequiredNamespace>? requiredNamespaces,
    Map<String, List<String>>? accounts,
    Map<String, List<String>>? methods,
    Map<String, List<String>>? events,
    List<Relay>? relays,
    String? pairingTopic,
    int? qrCodeScanLatencyMs,
  }) async {
    final start = DateTime.now().millisecondsSinceEpoch;
    final Map<String, RequiredNamespace> reqNamespaces =
        requiredNamespaces ?? TEST_REQUIRED_NAMESPACES;

    Map<String, Namespace> workingNamespaces = namespaces ?? TEST_NAMESPACES;

    Map<String, List<String>> workingAccounts = accounts ??
        {
          TEST_ETHEREUM_CHAIN: [TEST_ETHEREUM_ADDRESS],
          TEST_ARBITRUM_CHAIN: [TEST_ETHEREUM_ADDRESS],
          TEST_AVALANCHE_CHAIN: [TEST_ETHEREUM_ADDRESS],
        };

    Map<String, List<String>> workingMethods = methods ??
        {
          TEST_ETHEREUM_CHAIN: TEST_METHODS_1,
          TEST_ARBITRUM_CHAIN: TEST_METHODS_1,
          TEST_AVALANCHE_CHAIN: TEST_METHODS_2,
        };

    Map<String, List<String>> workingEvents = events ??
        {
          TEST_ETHEREUM_CHAIN: [TEST_EVENT_1],
          TEST_ARBITRUM_CHAIN: [TEST_EVENT_1],
          TEST_AVALANCHE_CHAIN: [TEST_EVENT_2],
        };

    // Register the data: accounts, methods, events
    for (final chainId in workingAccounts.keys) {
      for (final account in workingAccounts[chainId]!) {
        b.registerAccount(
          chainId: chainId,
          accountAddress: account,
        );
      }
    }
    for (final chainId in workingMethods.keys) {
      for (final method in workingMethods[chainId]!) {
        b.registerRequestHandler(chainId: chainId, method: method);
      }
    }
    for (final chainId in workingEvents.keys) {
      for (final event in workingEvents[chainId]!) {
        b.registerEventEmitter(
          chainId: chainId,
          event: event,
        );
      }
    }

    late SessionData sessionA;
    SessionData? sessionB;

    // Listen for a proposal via connect to avoid race conditions
    Completer sessionBCompleter = Completer();
    func(SessionProposalEvent? args) async {
      // print('B Session Proposal');

      expect(
        args!.params.requiredNamespaces,
        reqNamespaces,
      );

      expect(b.getPendingSessionProposals().length, 1);

      Completer completer = Completer();
      b.onSessionConnect.subscribe((args) {
        // ignore: unnecessary_null_comparison
        expect(args != null, true);
        completer.complete();
      });

      workingNamespaces = args.params.generatedNamespaces ?? workingNamespaces;

      ApproveResponse response = await b.approveSession(
        id: args.id,
        namespaces: workingNamespaces,
      );
      sessionB = response.session;

      if (!completer.isCompleted) {
        await completer.future;
      }

      b.onSessionConnect.unsubscribeAll();
      sessionBCompleter.complete();

      // print('B Session assigned: $sessionB');
      // expect(b.core.expirer.has(args.params.id.toString()), true);
    }

    b.onSessionProposal.subscribe(func);

    // Connect to client b from a, this will trigger the above event
    // print('connecting');
    ConnectResponse connectResponse = await a.connect(
      requiredNamespaces: reqNamespaces,
      pairingTopic: pairingTopic,
      relays: relays,
    );
    connectResponse.session.future.then(
      (value) => sessionA = value,
    );
    Uri? uri = connectResponse.uri;

    // Track latency
    final clientAConnectLatencyMs =
        DateTime.now().millisecondsSinceEpoch - start;

    // Track pairings from "QR Scans"
    PairingInfo? pairingA;
    PairingInfo? pairingB;

    if (pairingTopic == null) {
      // Simulate qr code scan latency if we want
      if (uri == null) {
        throw Exception('uri is missing');
      }
      if (qrCodeScanLatencyMs != null) {
        await Future.delayed(
          Duration(
            milliseconds: qrCodeScanLatencyMs,
          ),
        );
      }

      final uriParams = ReownCoreUtils.parseUri(connectResponse.uri!);
      pairingA = a.pairings.get(uriParams.topic);
      expect(pairingA != null, true);
      expect(pairingA!.topic, uriParams.topic);
      expect(pairingA.relay.protocol, uriParams.v2Data!.relay.protocol);

      // If we recieved no pairing topic, then we want to create one
      // e.g. we pair from b to a using the uri created from the connect
      // params (The QR code).
      const pairTimeoutMs = 15000;
      final timeout = Timer(const Duration(milliseconds: pairTimeoutMs), () {
        throw Exception('Pair timed out after $pairTimeoutMs ms');
      });
      // print('pairing B -> A');
      pairingB = await b.pair(uri: uri);
      timeout.cancel();
      expect(pairingA.topic, pairingB.topic);
      expect(pairingA.relay.protocol, pairingB.relay.protocol);
    } else {
      pairingA = a.pairings.get(pairingTopic);
      pairingB = b.pairings.get(pairingTopic);
    }

    if (pairingA == null) {
      throw Exception('expect pairing A to be defined');
    }

    // Assign session now that we have paired
    if (!connectResponse.session.isCompleted) {
      a.core.logger.i('signClientHelpers waiting connectResponseCompleter');
      // print('Waiting for connect response');
      await connectResponse.session.future;
    }

    final settlePairingLatencyMs = DateTime.now().millisecondsSinceEpoch -
        start -
        (qrCodeScanLatencyMs ?? 0);

    if (!sessionBCompleter.isCompleted) {
      a.core.logger.i('signClientHelpers waiting sessionBCompleter');
      await sessionBCompleter.future;
    }

    // if (sessionA == null) throw Exception("expect session A to be defined");
    if (sessionB == null) throw Exception('expect session B to be defined');

    expect(sessionA.topic, sessionB!.topic);
    // relay
    expect(
      sessionA.relay.protocol,
      TEST_RELAY_OPTIONS['protocol'],
    );
    expect(sessionA.relay.protocol, sessionB!.relay.protocol);
    // namespaces
    expect(sessionA.namespaces, workingNamespaces);
    expect(sessionA.namespaces, sessionB!.namespaces);
    // expiry
    expect((sessionA.expiry - sessionB!.expiry).abs() < 5, true);
    // Check that there is an expiry
    expect(a.core.expirer.has(sessionA.topic), true);
    expect(b.core.expirer.has(sessionB!.topic), true);
    // acknowledged
    expect(sessionA.acknowledged, true);
    expect(sessionB!.acknowledged, true);
    // participants
    expect(sessionA.self, sessionB!.peer);
    expect(sessionA.peer, sessionB!.self);
    // controller

    expect(sessionA.controller, sessionB!.controller);
    expect(sessionA.controller, sessionA.peer.publicKey);
    expect(sessionB!.controller, sessionB!.self.publicKey);
    // metadata
    expect(sessionA.self.metadata, sessionB!.peer.metadata);
    expect(sessionB!.self.metadata, sessionA.peer.metadata);

    // if (pairingA == null) throw Exception("expect pairing A to be defined");
    if (pairingB == null) throw Exception('expect pairing B to be defined');

    // update pairing state beforehand
    pairingA = a.pairings.get(pairingA.topic);
    pairingB = b.pairings.get(pairingB.topic);

    // topic
    expect(pairingA!.topic, pairingB!.topic);
    // relay
    expect(
      pairingA.relay.protocol,
      TEST_RELAY_OPTIONS['protocol'],
    );
    expect(
      pairingB.relay.protocol,
      TEST_RELAY_OPTIONS['protocol'],
    );
    // active
    expect(pairingA.active, true);
    expect(pairingB.active, true);
    // metadata
    expect(
      pairingA.peerMetadata,
      sessionA.peer.metadata,
    );
    expect(
      pairingB.peerMetadata,
      sessionB!.peer.metadata,
    );

    b.onSessionProposal.unsubscribe(func);

    return TestConnectMethodReturn(
      pairingA,
      sessionA,
      clientAConnectLatencyMs,
      settlePairingLatencyMs,
    );
  }

  static Future<void> testConnectPairReject(
    IReownSignDapp a,
    IReownSignWallet b, {
    Map<String, Namespace>? namespaces,
    Map<String, RequiredNamespace>? requiredNamespaces,
    List<Relay>? relays,
    String? pairingTopic,
    int? qrCodeScanLatencyMs,
  }) async {
    final start = DateTime.now().millisecondsSinceEpoch;
    final Map<String, RequiredNamespace> reqNamespaces =
        requiredNamespaces ?? TEST_REQUIRED_NAMESPACES;

    // Map<String, Namespace> workingNamespaces =
    //     namespaces != null ? namespaces : TEST_NAMESPACES;

    // SessionData? sessionA;

    // Listen for a proposal via connect to avoid race conditions
    Completer sessionBCompleter = Completer();
    f(SessionProposalEvent? args) async {
      expect(
        args!.params.requiredNamespaces,
        reqNamespaces,
      );

      // expect(b.getPendingSessionProposals().length, 1);

      await b.rejectSession(
        id: args.id,
        reason: ReownSignError.fromJson(
          Errors.getSdkError(Errors.USER_REJECTED).toJson(),
        ),
      );
      sessionBCompleter.complete();

      // print('B Session assigned: $sessionB');
      // expect(b.core.expirer.has(args.params.id.toString()), true);
    }

    b.onSessionProposal.subscribe(f);

    // Connect to client b from a, this will trigger the above event
    // print('connecting');
    ConnectResponse connectResponse = await a.connect(
      requiredNamespaces: reqNamespaces,
      pairingTopic: pairingTopic,
      relays: relays,
    );
    Uri? uri = connectResponse.uri;

    // Track latency
    final _ = DateTime.now().millisecondsSinceEpoch - start;

    // Track pairings from "QR Scans"
    PairingInfo? pairingA;
    PairingInfo? pairingB;

    if (pairingTopic == null) {
      // Simulate qr code scan latency if we want
      if (uri == null) {
        throw Exception('uri is missing');
      }
      if (qrCodeScanLatencyMs != null) {
        await Future.delayed(
          Duration(
            milliseconds: qrCodeScanLatencyMs,
          ),
        );
      }

      final uriParams = ReownCoreUtils.parseUri(connectResponse.uri!);
      pairingA = a.pairings.get(uriParams.topic);
      expect(pairingA != null, true);
      expect(pairingA!.topic, uriParams.topic);
      expect(pairingA.relay.protocol, uriParams.v2Data!.relay.protocol);

      // If we recieved no pairing topic, then we want to create one
      // e.g. we pair from b to a using the uri created from the connect
      // params (The QR code).
      const pairTimeoutMs = 15000;
      final timeout = Timer(const Duration(milliseconds: pairTimeoutMs), () {
        throw Exception('Pair timed out after $pairTimeoutMs ms');
      });
      // print('pairing B -> A');
      pairingB = await b.pair(uri: uri);
      timeout.cancel();
      expect(pairingA.topic, pairingB.topic);
      expect(pairingA.relay.protocol, pairingB.relay.protocol);
    } else {
      pairingA = a.pairings.get(pairingTopic);
      pairingB = b.pairings.get(pairingTopic);
    }

    if (pairingA == null) {
      throw Exception('expect pairing A to be defined');
    }

    // Assign session now that we have paired
    // print('Waiting for connect response');
    try {
      if (!connectResponse.session.isCompleted) {
        // print('Waiting for connect response');
        await connectResponse.session.future;
      }
      await sessionBCompleter.future;
    } catch (e) {
      b.onSessionProposal.unsubscribe(f);
      expect(e is JsonRpcError, true);
      final e2 = e as JsonRpcError;
      expect(e2.code, Errors.getSdkError(Errors.USER_REJECTED).code);
      expect(e2.message, Errors.getSdkError(Errors.USER_REJECTED).message);
    }

    // expect(true, false);
  }
}
