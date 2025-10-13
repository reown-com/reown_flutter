import 'package:reown_core/verify/models/verify_context.dart';

abstract class IVerify {
  Future<void> init();

  Future<AttestationResponse?> resolve({
    required String attestationId,
    required String? attestationJWT,
  });

  Validation getValidation(
    AttestationResponse? attestation,
    Uri? metadataUri,
  );
}
