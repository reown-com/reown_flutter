import 'package:reown_core/models/json_rpc_models.dart';
import 'package:reown_pos/services/models/query_models.dart';

abstract class IBlockchainService {
  Future<JsonRpcResponse> reownPosBuildTransaction({
    required BuildTransactionParams params,
    required QueryParams queryParams,
  });

  Future<JsonRpcResponse> reownPosCheckTransaction({
    required CheckTransactionParams params,
    required QueryParams queryParams,
  });
}
