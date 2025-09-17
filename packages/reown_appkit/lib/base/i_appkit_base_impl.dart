import 'package:reown_appkit/base/services/models/asset_models.dart';
import 'package:reown_appkit/base/services/models/query_models.dart';
import 'package:reown_appkit/base/services/models/result_models.dart';
import 'package:reown_sign/i_sign_dapp.dart';
import 'package:reown_sign/reown_sign.dart';

///
abstract class IReownAppKit implements IReownSignDapp {
  ///
  final String protocol = 'wc';

  ///
  final int version = 2;

  ///
  abstract final IReownSign reOwnSign;

  // DWE

  List<ExchangeAsset> getPaymentAssetsForNetwork({String? chainId});

  Future<GetExchangesResult> getExchanges({required GetExchangesParams params});

  Future<GetExchangeUrlResult> getExchangeUrl({
    required GetExchangeUrlParams params,
  });

  Future<GetExchangeByStatusResult> getExchangeByStatus({
    required GetExchangeByStatusParams params,
  });
}
