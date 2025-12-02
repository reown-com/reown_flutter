import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit/utils/walletkit_utils.dart';

part 'platform_models.freezed.dart';
part 'platform_models.g.dart';

@freezed
sealed class PlatformSessionProposal with _$PlatformSessionProposal {
  const factory PlatformSessionProposal({
    required String pairingTopic,
    required String name,
    required String description,
    required String url,
    required List<String> icons,
    required String redirect,
    required Map<String, RequiredNamespace> requiredNamespaces,
    required Map<String, RequiredNamespace> optionalNamespaces,
    required String proposerPublicKey,
    required String relayProtocol,
    dynamic relayData,
    dynamic scopedProperties,
    dynamic properties,
  }) = _PlatformSessionProposal;

  factory PlatformSessionProposal.fromJson(Map<String, dynamic> json) =>
      _$PlatformSessionProposalFromJson(json);
}

extension PlatformSessionProposalExtension on PlatformSessionProposal {
  ProposalData toProposalData(
    int id,
    Set<String> accounts,
    Set<String> events,
    Set<String> methods,
  ) {
    return ProposalData(
      id: id,
      expiry: WalletKitUtils.calculateExpiry(ReownConstants.FIVE_MINUTES),
      relays: [Relay(relayProtocol)],
      proposer: ConnectionMetadata(
        publicKey: proposerPublicKey,
        metadata: PairingMetadata(
          name: name,
          description: description,
          url: url,
          icons: icons,
          redirect: Redirect(native: redirect),
        ),
      ),
      requiredNamespaces: requiredNamespaces.map(
        (key, value) => MapEntry(
          key,
          RequiredNamespace.fromJson(value as Map<String, dynamic>),
        ),
      ),
      optionalNamespaces: optionalNamespaces.map(
        (key, value) => MapEntry(
          key,
          RequiredNamespace(
            chains: value.chains,
            methods: value.methods,
            events: value.events,
          ),
        ),
      ),
      pairingTopic: pairingTopic,
      sessionProperties: properties,
      generatedNamespaces: WalletKitUtils.generateNamespaces(
        accounts,
        events,
        methods,
        requiredNamespaces,
        optionalNamespaces,
      ),
    );
  }
}

@freezed
sealed class PlatformSessionSettle with _$PlatformSessionSettle {
  const factory PlatformSessionSettle({
    required String type,
    required PlatformSession session,
  }) = _PlatformSessionSettle;

  factory PlatformSessionSettle.fromJson(Map<String, dynamic> json) =>
      _$PlatformSessionSettleFromJson(json);
}

@freezed
sealed class PlatformSession with _$PlatformSession {
  const factory PlatformSession({
    required String pairingTopic,
    required String topic,
    required int expiry,
    required Map<String, dynamic> requiredNamespaces,
    required Map<String, PlatformNamespace> optionalNamespaces,
    required Map<String, PlatformNamespaceWithAccounts> namespaces,
    required PlatformMetaData metaData,
    required String redirect,
  }) = _PlatformSession;

  factory PlatformSession.fromJson(Map<String, dynamic> json) =>
      _$PlatformSessionFromJson(json);
}

@freezed
sealed class PlatformNamespace with _$PlatformNamespace {
  const factory PlatformNamespace({
    required List<String> chains,
    required List<String> methods,
    required List<String> events,
  }) = _PlatformNamespace;

  factory PlatformNamespace.fromJson(Map<String, dynamic> json) =>
      _$PlatformNamespaceFromJson(json);
}

@freezed
sealed class PlatformNamespaceWithAccounts
    with _$PlatformNamespaceWithAccounts {
  const factory PlatformNamespaceWithAccounts({
    required List<String> chains,
    required List<String> accounts,
    required List<String> methods,
    required List<String> events,
  }) = _PlatformNamespaceWithAccounts;

  factory PlatformNamespaceWithAccounts.fromJson(Map<String, dynamic> json) =>
      _$PlatformNamespaceWithAccountsFromJson(json);
}

@freezed
sealed class PlatformMetaData with _$PlatformMetaData {
  const factory PlatformMetaData({
    required String name,
    required String description,
    required String url,
    required List<String> icons,
    required String redirect,
  }) = _PlatformMetaData;

  factory PlatformMetaData.fromJson(Map<String, dynamic> json) =>
      _$PlatformMetaDataFromJson(json);
}

extension PlatformSessionSettleExtension on PlatformSessionSettle {
  // SessionData toSessionData(String peerPublicKey) {
  //   return SessionData(
  //     topic: session.topic,
  //     pairingTopic: session.pairingTopic,
  //     relay: Relay('irn'), // TODO [WRAP REFACTOR] Check this
  //     expiry: session.expiry,
  //     acknowledged: true,
  //     controller: peerPublicKey,
  //     namespaces: session.namespaces.map(
  //       (key, value) => MapEntry(
  //         key,
  //         Namespace(
  //           accounts: value.accounts,
  //           methods: value.methods,
  //           events: value.events,
  //           chains: value.chains,
  //         ),
  //       ),
  //     ),
  //     self: ConnectionMetadata(publicKey: publicKey, metadata: metadata),
  //     peer: ConnectionMetadata(
  //       publicKey: peerPublicKey,
  //       metadata: PairingMetadata(
  //         name: session.metaData.name,
  //         description: session.metaData.description,
  //         url: session.metaData.url,
  //         icons: session.metaData.icons,
  //         redirect: Redirect(native: session.metaData.redirect),
  //       ),
  //     ),
  //     transportType: TransportType.relay,
  //   );
  // }
}
