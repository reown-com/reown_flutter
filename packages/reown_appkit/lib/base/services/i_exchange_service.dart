// import 'package:reown_appkit/base/services/models/query_models.dart';
import 'package:reown_appkit/base/services/models/query_models.dart';
import 'package:reown_core/models/json_rpc_models.dart';

abstract class IExchangeService {
  Future<JsonRpcResponse> getExchanges({required GetExchangesParams params});

  Future<JsonRpcResponse> getExchangeUrl({
    required GetExchangeUrlParams params,
  });

  Future<JsonRpcResponse> getExchangeDepositStatus({
    required GetExchangeDepositStatusParams params,
  });
}
