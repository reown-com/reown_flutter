import 'package:reown_yttrium/models/chain_abstraction.dart';

abstract class ISuiClient {
  Future<bool> init({
    required String projectId,
    required PulseMetadataCompat pulseMetadata,
  });
}
