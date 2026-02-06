import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:reown_appkit/modal/services/blockchain_service/models/token_balance.dart';
import 'package:reown_appkit/modal/services/transfers/models/quote_models.dart';
import 'package:reown_appkit/reown_appkit.dart';

abstract class IDWEService {
  abstract final ValueNotifier<ExchangeAsset?> depositAsset;
  abstract final ValueNotifier<double> depositAmountInUSD;
  abstract final ValueNotifier<double> depositAmountInAsset;

  List<ExchangeAsset> get supportedAssets;
  ExchangeAsset? get preselectedAsset;
  bool get showNetworkIcon;
  bool get filterByNetwork;
  bool get depositAssetButton;
  Map<String, String> get configuredRecipients;
  bool get isCheckingStatus;

  Future<void> init();

  void configDeposit({
    List<ExchangeAsset>? supportedAssets,
    ExchangeAsset? preselectedAsset,
    bool? showNetworkIcon,
    bool? filterByNetwork,
    bool? depositAssetButton,
    Map<String, String> configuredRecipients = const {},
  });

  List<ExchangeAsset> getAvailableAssets({String? chainId});

  Future<GetExchangesResult> getExchanges({required GetExchangesParams params});

  Future<GetExchangeUrlResult> getExchangeUrl({
    required GetExchangeUrlParams params,
  });

  void loopOnDepositStatusCheck(
    String exchangeId,
    String sessionId,
    FutureOr<void> Function((QuoteStatus status, dynamic data)) completer,
  );

  void loopOnTransferStatusCheck(
    String exchangeId,
    String requestId,
    FutureOr<void> Function((QuoteStatus status, dynamic data)) completer,
  );

  void stopCheckingStatus();

  Future<TokenBalance?> getFungiblePrice({
    required ExchangeAsset asset,
    bool forceFetch = false,
  });

  void clearState();
}
