import 'package:reown_appkit/modal/services/blockchain_service/models/blockchain_identity.dart';
import 'package:reown_appkit/modal/services/blockchain_service/models/gas_price.dart';
import 'package:reown_appkit/modal/services/blockchain_service/models/token_balance.dart';
import 'package:reown_appkit/modal/services/blockchain_service/models/wallet_activity.dart';

abstract class IBlockChainService {
  ActivityData? get activityData;
  List<TokenBalance>? get tokensList;
  TokenBalance? get selectedSendToken;

  Future<void> init();

  /// Gets the name and avatar of a provided address on the given chain
  Future<BlockchainIdentity> getIdentity({
    required String address,
  });

  Future<ActivityData> getHistory({
    required String address,
    String? caip2Chain,
    String? cursor,
  });

  Future<List<TokenBalance>> getBalance({
    required String address,
    String? caip2Chain,
  });

  void selectSendToken(TokenBalance? token);

  Future<GasPrice> gasPrice({
    required String caip2Chain,
  });

  Future<double> getTokenBalance({
    required String address,
    required String namespace,
    required String chainId,
  });

  Future<BigInt> estimateGas({
    required Map<String, dynamic> transaction,
    required String caip2Chain,
  });

  Future<dynamic> checkAllowance({
    required String senderAddress,
    required String receiverAddress,
    required String contractAddress,
    required String caip2Chain,
  });

  void dispose();
}
