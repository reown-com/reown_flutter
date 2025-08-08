import 'package:reown_yttrium/models/rust_sign_client.dart';

abstract class ISignClient {
  Future<bool> init({required String projectId});

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
