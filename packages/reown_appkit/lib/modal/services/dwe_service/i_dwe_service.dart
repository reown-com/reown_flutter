import 'package:flutter/foundation.dart';
import 'package:reown_appkit/modal/services/blockchain_service/models/token_balance.dart';
import 'package:reown_appkit/reown_appkit.dart';

abstract class IDWEService {
  abstract final List<ExchangeAsset> supportedAssets;
  abstract final ValueNotifier<ExchangeAsset?> selectedAsset;
  abstract final ValueNotifier<double> selectedAmount;

  Future<void> init();
  void setSupportedAssets(List<ExchangeAsset> assets);
  Future<TokenBalance?> getFungiblePrice({required ExchangeAsset asset});
  void clearState();
}
