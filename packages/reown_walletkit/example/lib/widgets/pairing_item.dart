import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/dependencies/i_walletkit_service.dart';

class PairingItem extends StatelessWidget {
  const PairingItem({
    super.key,
    required this.pairing,
    required this.onTap,
  });

  final PairingInfo pairing;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    PairingMetadata? metadata = pairing.peerMetadata;
    if (metadata == null) {
      return ListTile(
        title: const Text('Unknown'),
        subtitle: const Text('No metadata available'),
        onTap: onTap,
      );
    }

    return ListTile(
      leading: Builder(
        builder: (BuildContext context) {
          if (metadata.icons.isNotEmpty) {
            final imageUrl = metadata.icons.first;
            if (imageUrl.split('.').last == 'svg') {
              return Container(
                width: 40.0,
                height: 40.0,
                padding: const EdgeInsets.all(1.0),
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  child: SvgPicture.network(imageUrl),
                ),
              );
            }
            return CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                imageUrl,
              ),
            );
          }
          return CircleAvatar(
            backgroundColor: Colors.black12,
          );
        },
      ),
      title: Text(metadata.name),
      subtitle: FutureBuilder(
        future: GetIt.I<IWalletKitService>()
            .walletKit
            .getSessionsForPairing(pairingTopic: pairing.topic),
        builder: (context, snapshot) {
          final sessionsMap = snapshot.data;
          if (sessionsMap == null) {
            return const SizedBox.shrink();
          }
          return Text(
            sessionsMap.values.isEmpty
                ? 'No active sessions'
                : 'Active sessions: ${sessionsMap.values.length}',
            style: TextStyle(
              color: sessionsMap.values.isEmpty ? null : Color(0xFF667DFF),
              fontSize: 13.0,
              fontWeight: sessionsMap.values.isEmpty
                  ? FontWeight.normal
                  : FontWeight.bold,
            ),
          );
        },
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 20.0,
      ),
      onTap: onTap,
    );
  }
}
