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
    final sessions = GetIt.I<IWalletKitService>()
        .walletKit
        .sessions
        .getAll()
        .where((element) => element.pairingTopic == pairing.topic)
        .toList();

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
      subtitle: Text(
        sessions.isEmpty
            ? 'No active sessions'
            : 'Active sessions: ${sessions.length}',
        style: TextStyle(
          color: sessions.isEmpty ? null : Color(0xFF667DFF),
          fontSize: 13.0,
          fontWeight: sessions.isEmpty ? FontWeight.normal : FontWeight.bold,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 20.0,
      ),
      onTap: onTap,
    );
  }
}
