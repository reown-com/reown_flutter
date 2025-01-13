import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';
import 'package:reown_walletkit_wallet/dependencies/key_service/i_key_service.dart';
import 'package:reown_walletkit_wallet/utils/constants.dart';
import 'package:reown_walletkit_wallet/utils/namespace_model_builder.dart';
import 'package:reown_walletkit_wallet/utils/string_constants.dart';
import 'package:reown_walletkit_wallet/widgets/wc_connection_widget/wc_connection_widget.dart';

import '../wc_connection_widget/wc_connection_model.dart';

class WCConnectionRequestWidget extends StatelessWidget {
  const WCConnectionRequestWidget({
    super.key,
    // this.authPayloadParams,
    this.sessionAuthPayload,
    this.proposalData,
    this.requester,
    this.verifyContext,
  });

  // final AuthPayloadParams? authPayloadParams;
  final SessionAuthPayload? sessionAuthPayload;
  final ProposalData? proposalData;
  final ConnectionMetadata? requester;
  final VerifyContext? verifyContext;

  @override
  Widget build(BuildContext context) {
    if (requester == null) {
      return const Text('ERROR');
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(StyleConstants.linear8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: StyleConstants.linear8),
          Text(
            '${requester!.metadata.name} ${StringConstants.wouldLikeToConnect}',
            style: StyleConstants.subtitleText.copyWith(
              fontSize: 18,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: StyleConstants.linear8),
          (sessionAuthPayload != null)
              ? _buildSessionAuthRequestView()
              : _buildSessionProposalView(context),
        ],
      ),
    );
  }

  Widget _buildSessionAuthRequestView() {
    final walletKit = GetIt.I<IWalletKitService>().walletKit;
    //
    final cacaoPayload = CacaoRequestPayload.fromSessionAuthPayload(
      sessionAuthPayload!,
    );
    //
    final List<WCConnectionModel> messagesModels = [];
    for (var chain in sessionAuthPayload!.chains) {
      final chainKeys = GetIt.I<IKeyService>().getKeysForChain(chain);
      final iss = 'did:pkh:$chain:${chainKeys.first.address}';
      final message = walletKit.formatAuthMessage(
        iss: iss,
        cacaoPayload: cacaoPayload,
      );
      messagesModels.add(
        WCConnectionModel(
          title: 'Message ${messagesModels.length + 1}',
          elements: [
            message,
          ],
        ),
      );
    }
    //
    return WCConnectionWidget(
      title: '${messagesModels.length} Messages',
      info: messagesModels,
    );
  }

  Widget _buildSessionProposalView(BuildContext context) {
    // Create the connection models using the required and optional namespaces provided by the proposal data
    // The key is the title and the list of values is the data
    final views = ConnectionWidgetBuilder.buildFromRequiredNamespaces(
      proposalData!.generatedNamespaces!,
    );

    return Column(
      children: views,
    );
  }
}

class VerifyContextWidget extends StatelessWidget {
  const VerifyContextWidget({
    super.key,
    required this.verifyContext,
  });
  final VerifyContext? verifyContext;

  @override
  Widget build(BuildContext context) {
    if (verifyContext == null) {
      return const SizedBox.shrink();
    }

    if (verifyContext!.validation.scam) {
      return VerifyBanner(
        color: StyleConstants.errorColor,
        origin: verifyContext!.origin,
        title: 'Security risk',
        text: 'This domain is flagged as unsafe by multiple security providers.'
            ' Leave immediately to protect your assets.',
      );
    }
    if (verifyContext!.validation.invalid) {
      return VerifyBanner(
        color: StyleConstants.errorColor,
        origin: verifyContext!.origin,
        title: 'Domain mismatch',
        text:
            'This website has a domain that does not match the sender of this request.'
            ' Approving may lead to loss of funds.',
      );
    }
    if (verifyContext!.validation.valid) {
      return VerifyHeader(
        iconColor: StyleConstants.successColor,
        title: verifyContext!.origin,
      );
    }
    return VerifyBanner(
      color: Colors.orange,
      origin: verifyContext!.origin,
      title: 'Cannot verify',
      text: 'This domain cannot be verified. '
          'Check the request carefully before approving.',
    );
  }
}

class VerifyHeader extends StatelessWidget {
  const VerifyHeader({
    super.key,
    required this.iconColor,
    required this.title,
  });
  final Color iconColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.shield_outlined,
          color: iconColor,
        ),
        const SizedBox(width: StyleConstants.linear8),
        Text(
          title,
          style: TextStyle(
            color: iconColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class VerifyBanner extends StatelessWidget {
  const VerifyBanner({
    super.key,
    required this.origin,
    required this.title,
    required this.text,
    required this.color,
  });
  final String origin, title, text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          origin,
          style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox.square(dimension: 8.0),
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          ),
          child: Column(
            children: [
              VerifyHeader(
                iconColor: color,
                title: title,
              ),
              const SizedBox(height: 4.0),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
