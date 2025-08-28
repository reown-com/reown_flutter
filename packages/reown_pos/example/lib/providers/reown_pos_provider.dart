import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reown_pos/reown_pos.dart';

/// Reown POS plugin instance
final reownPosProvider = Provider<IReownPos>((ref) {
  // [ReownPos SDK API] 1. Construct your RoenPos instance
  final metadata = Metadata(
    merchantName: 'DTC Pay',
    description: 'Secure Crypto Payment Terminal',
    url: 'https://appkit-lab.reown.com',
    logoIcon: 'https://avatars.githubusercontent.com/u/179229932',
  );
  return ReownPos(
    projectId: '50f81661a58229027394e0a19e9db752',
    deviceId: "sample_pos_device_${DateTime.now().microsecondsSinceEpoch}",
    metadata: metadata,
  );
});
