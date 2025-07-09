import 'package:reown_yttrium/models/shared.dart';
import 'package:reown_yttrium/models/stacks.dart';

abstract class IStacksClient {
  Future<bool> init({
    required String projectId,
    required PulseMetadataCompat pulseMetadata,
  });

  Future<String> generateWallet();

  Future<String> getAddress({
    required String wallet,
    required StacksVersion version,
  });

  Future<String> signMessage({
    required String wallet,
    required String message,
  });

  Future<TransferStxResponse> transferStx({
    required String wallet,
    required String network,
    required TransferStxRequest request,
  });

  Future<StacksAccount> getAccount({
    required String principal,
    required String network,
  });

  Future<BigInt> transferFees({
    required String network,
  });

  // Future<FeeEstimation> estimateFees({
  //   required String transaction_payload,
  //   required String network,
  // });

  // Future<BigInt> getNonce({
  //   required String principal,
  //   required String network,
  // });
}
