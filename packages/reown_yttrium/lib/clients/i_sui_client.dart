import 'package:reown_yttrium/models/chain_abstraction.dart';

abstract class ISuiClient {
  Future<bool> init({
    required String projectId,
    required PulseMetadataCompat pulseMetadata,
  });

  Future<String> generateKeyPair();

  Future<String> getPublicKeyFromKeyPair({required String keyPair});

  Future<String> getAddressFromPublicKey({required String publicKey});

  Future<String> personalSign({
    required String keyPair,
    required String message,
  });

  Future<String> signTransaction({
    required String chainId,
    required String keyPair,
    required String txData,
  });

  Future<String> signAndExecuteTransaction({
    required String chainId,
    required String keyPair,
    required String txData,
  });
}
