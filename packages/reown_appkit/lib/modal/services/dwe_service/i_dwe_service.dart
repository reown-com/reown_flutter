import 'package:flutter/foundation.dart';
import 'package:reown_appkit/modal/services/blockchain_service/models/token_balance.dart';
import 'package:reown_appkit/reown_appkit.dart';

abstract class IDWEService {
  abstract final ValueNotifier<ExchangeAsset?> selectedAsset;
  abstract final ValueNotifier<double> selectedAmount;

  List<ExchangeAsset> get supportedAssets;
  ExchangeAsset? get preselectedAsset;
  bool get showNetworkIcon;
  bool get filterByNetwork;
  Map<String, String> get configuredRecipients;
  bool get isCheckingStatus;

  Future<void> init();

  void configDeposit({
    List<ExchangeAsset>? supportedAssets,
    ExchangeAsset? preselectedAsset,
    bool? showNetworkIcon,
    bool? filterByNetwork,
    Map<String, String> configuredRecipients = const {},
  });

  List<ExchangeAsset> getAvailableAssets({String? chainId});

  Future<GetExchangesResult> getExchanges({required GetExchangesParams params});

  Future<GetExchangeUrlResult> getExchangeUrl({
    required GetExchangeUrlParams params,
  });

  void loopOnStatusCheck(
    String exchangeId,
    String sessionId,
    Function(GetExchangeDepositStatusResult?) completer,
  );

  void stopCheckingStatus();

  Future<TokenBalance?> getFungiblePrice({required ExchangeAsset asset});

  void clearState();
}
