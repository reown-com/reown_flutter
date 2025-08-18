import 'dart:async';
import 'package:reown_yttrium/clients/models/rust_sign_client.dart';

abstract class ISignClient {
  abstract Function(
    String topic,
    SessionRequestJsonRpcFfi request,
  ) onSessionRequest;

  Future<bool> init({required String projectId});

  Future<void> initListener();

  Future<bool> setKey({required String key});

  Future<String> generateKey();

  Future<SessionProposalFfi> pair({
    required String uri,
  });

  Future<ApproveResultFfi> approve({
    required SessionProposalFfi proposal,
    required Map<String, SettleNamespaceFfi> approvedNamespaces,
    required MetadataFfi selfMetadata,
  });
}
