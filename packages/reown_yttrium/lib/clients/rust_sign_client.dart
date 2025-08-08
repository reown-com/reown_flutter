import 'package:reown_yttrium/channels/rust_sign_client_channel.dart';
import 'package:reown_yttrium/clients/i_rust_sign_client.dart';
import 'package:reown_yttrium/models/rust_sign_client.dart';
import 'package:reown_yttrium/reown_yttrium_platform_interface.dart';

class SignClient implements ISignClient {
  MethodChannelSign get signChannel =>
      ReownYttriumPlatformInterface.instance.signChannel;

  @override
  Future<bool> init({required String projectId}) async {
    return await signChannel.init(
      projectId: projectId,
    );
  }

  @override
  Future<String> generateKey() async {
    return await signChannel.generateKey();
  }

  @override
  Future<bool> setKey({required String key}) async {
    return await signChannel.setKey(
      key: key,
    );
  }

  @override
  Future<SessionProposalFfi> pair({
    required String uri,
  }) async {
    final Map<String, dynamic> result = await signChannel.pair(
      uri: uri,
    );
    return SessionProposalFfi.fromJson(result);
  }

  @override
  Future<ApproveResultFfi> approve({
    required SessionProposalFfi proposal,
    required Map<String, SettleNamespaceFfi> approvedNamespaces,
    required MetadataFfi selfMetadata,
  }) async {
    final Map<String, dynamic> result = await signChannel.approve(
      proposal: proposal.toJson(),
      approvedNamespaces: approvedNamespaces.map(
        (key, value) => MapEntry(key, value.toJson()),
      ),
      selfMetadata: selfMetadata.toJson(),
    );
    return ApproveResultFfi.fromJson(result);
  }
}
