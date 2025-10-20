import 'package:flutter/foundation.dart';
import 'package:reown_appkit/modal/services/blockchain_service/models/token_balance.dart';
import 'package:reown_appkit/reown_appkit.dart';

abstract class IDWEService {
  abstract final List<ExchangeAsset> supportedAssets;
  abstract final ValueNotifier<ExchangeAsset?> selectedAsset;
  abstract final ValueNotifier<double> selectedAmount;

  Future<void> init();

  void setSupportedAssets(List<ExchangeAsset> assets);

  List<ExchangeAsset> getPaymentAssetsForNetwork({String? chainId});

  Future<GetExchangesResult> getExchanges({required GetExchangesParams params});

  Future<GetExchangeUrlResult> getExchangeUrl({
    required GetExchangeUrlParams params,
  });

  // Future<GetExchangeDepositStatusResult> getExchangeDepositStatus({
  //   required GetExchangeDepositStatusParams params,
  // });

  bool get isCheckingStatus;

  void loopOnStatusCheck(
    String exchangeId,
    String sessionId,
    Function(GetExchangeDepositStatusResult?) completer,
  );

  void stopCheckingStatus();

  Future<TokenBalance?> getFungiblePrice({required ExchangeAsset asset});

  void clearState();
}
