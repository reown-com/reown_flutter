import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reown_appkit/reown_appkit.dart';

import 'package:reown_appkit_dapp/utils/constants.dart';

class PairingItem extends StatelessWidget {
  const PairingItem({
    required Key key,
    required this.pairing,
    required this.onTap,
  }) : super(key: key);

  final PairingInfo pairing;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final expiryTimestamp = DateTime.fromMillisecondsSinceEpoch(
      pairing.expiry * 1000,
    );
    final dateFormat = DateFormat.yMd().add_jm();
    final expiryDate = dateFormat.format(expiryTimestamp);
    final inDays = expiryTimestamp.difference(DateTime.now()).inDays + 1;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        color: pairing.active
            ? ReownAppKitModalTheme.colorsOf(context).accenGlass020
            : ReownAppKitModalTheme.colorsOf(context).error100.withOpacity(0.2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pairing.peerMetadata?.name ?? 'Unknown',
              style: StyleConstants.paragraph.copyWith(
                color: ReownAppKitModalTheme.colorsOf(context).foreground100,
              ),
            ),
            Text(
              pairing.peerMetadata?.url ?? 'Expiry: $expiryDate ($inDays days)',
              style: TextStyle(
                color: ReownAppKitModalTheme.colorsOf(context).foreground100,
              ),
            ),
            Text(
              pairing.topic,
              style: TextStyle(
                color: ReownAppKitModalTheme.colorsOf(context).foreground100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
