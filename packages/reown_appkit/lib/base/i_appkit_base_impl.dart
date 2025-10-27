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

  ///
  /// ℹ️ Get supported assets on the given chainId (CAIP-2)
  /// Null value will return all supported assets in all networks
  ///
  List<ExchangeAsset> getPaymentAssetsForNetwork({
    String? chainId,
    bool includeNative = true,
  });

  ///
  /// ℹ️ Get a list of Exchanges supporting the given configuration
  /// Use `includeOnly`, `exclude` to filter the results
  ///
  Future<GetExchangesResult> getExchanges({required GetExchangesParams params});

  ///
  /// ℹ️ Get the deposit/payment URL on the selected exchange
  ///
  Future<GetExchangeUrlResult> getExchangeUrl({
    required GetExchangeUrlParams params,
  });

  ///
  /// ℹ️ Check the status of the deposit/transaction
  /// Better to call this in a loop
  ///
  Future<GetExchangeDepositStatusResult> getExchangeDepositStatus({
    required GetExchangeDepositStatusParams params,
  });
}
