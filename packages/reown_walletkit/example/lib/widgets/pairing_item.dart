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
                  border: Border.all(width: 1.0, color: Colors.black38),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  child: SvgPicture.network(imageUrl),
                ),
              );
            }
            return CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
            );
          }
          return CircleAvatar(
            backgroundImage: const AssetImage('assets/images/default_icon.png'),
          );
        },
      ),
      title: Text(
        metadata.name,
        style: const TextStyle(color: Colors.black),
      ),
      subtitle: Text(
        sessions.isEmpty
            // ? DeepLinkHandler.waiting.value
            //     ? 'Settling session. Wait...'
            //     : 'No active sessions'
            ? 'No active sessions'
            : 'Active sessions: ${sessions.length}',
        style: TextStyle(
          color: sessions.isEmpty
              // ? DeepLinkHandler.waiting.value
              //     ? Colors.green
              //     : Colors.black
              ? Colors.black
              : Colors.blueAccent,
          fontSize: 13.0,
          fontWeight: sessions.isEmpty
              // ? DeepLinkHandler.waiting.value
              //     ? FontWeight.bold
              //     : FontWeight.normal
              ? FontWeight.normal
              : FontWeight.bold,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 20.0,
        color: Colors.black,
      ),
      onTap: onTap,
    );
  }
}
