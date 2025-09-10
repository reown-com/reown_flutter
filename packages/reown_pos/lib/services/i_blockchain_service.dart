import 'package:reown_core/models/json_rpc_models.dart';
import 'package:reown_pos/services/models/query_models.dart';

abstract class IBlockchainService {
  Future<JsonRpcResponse> posBuildTransaction({
    required BuildTransactionParams params,
    required QueryParams queryParams,
  });

  Future<JsonRpcResponse> posCheckTransaction({
    required CheckTransactionParams params,
    required QueryParams queryParams,
  });

  Future<JsonRpcResponse> posSupportedNetworks({
    required QueryParams queryParams,
  });
}
