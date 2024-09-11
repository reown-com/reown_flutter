import 'package:reown_core/verify/models/verify_context.dart';

abstract class IVerify {
  Future<void> init({String? verifyUrl});

  Future<AttestationResponse?> resolve({required String attestationId});

  Validation getValidation(
    AttestationResponse? attestation,
    Uri? metadataUri,
  );
}
