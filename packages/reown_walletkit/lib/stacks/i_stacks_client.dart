import 'package:reown_yttrium/models/stacks.dart';

/// ---------------------------------
/// ⚠️ This client is experimental. Use with caution.
/// ---------------------------------
abstract class IStacksClient {
  /// ---------------------------------
  /// ⚠️ This method is experimental. Use with caution.
  /// ---------------------------------
  Future<void> init();

  /// ---------------------------------
  /// ⚠️ This method is experimental. Use with caution.
  /// ---------------------------------
  Future<String> generateWallet();

  /// ---------------------------------
  /// ⚠️ This method is experimental. Use with caution.
  /// ---------------------------------
  Future<String> getAddress({
    required String wallet,
    required StacksVersion version,
  });

  /// ---------------------------------
  /// ⚠️ This method is experimental. Use with caution.
  /// ---------------------------------
  Future<String> signMessage({
    required String wallet,
    required String message,
  });

  /// ---------------------------------
  /// ⚠️ This method is experimental. Use with caution.
  /// ---------------------------------
  Future<TransferStxResponse> transferStx({
    required String wallet,
    required String network,
    required TransferStxRequest request,
  });

  /// ---------------------------------
  /// ⚠️ This method is experimental. Use with caution.
  /// ---------------------------------
  Future<StacksAccount> getAccount({
    required String principal,
    required String network,
  });

  /// ---------------------------------
  /// ⚠️ This method is experimental. Use with caution.
  /// ---------------------------------
  Future<BigInt> transferFees({
    required String network,
  });

  // /// ---------------------------------
  // /// ⚠️ This method is experimental. Use with caution.
  // /// ---------------------------------
  // Future<FeeEstimation> estimateFees({
  //   required String transaction_payload,
  //   required String network,
  // });

  // /// ---------------------------------
  // /// ⚠️ This method is experimental. Use with caution.
  // /// ---------------------------------
  // Future<BigInt> getNonce({
  //   required String principal,
  //   required String network,
  // });
}
