import 'package:reown_appkit/modal/services/blockchain_service/models/blockchain_identity.dart';
// import 'package:reown_appkit/reown_appkit.dart';

abstract class IBlockChainService {
  Future<void> init();

  /// Gets the name and avatar of a provided address on the given chain
  Future<BlockchainIdentity> getIdentity(String address);

  Future<dynamic> getBalance({
    required String address,
    required String namespace,
    required String chainId,
  });

  // Future<dynamic> rpcRequest({
  //   required String chainId,
  //   required SessionRequestParams request,
  // });
}
