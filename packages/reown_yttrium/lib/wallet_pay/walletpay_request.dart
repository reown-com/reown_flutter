import 'package:reown_yttrium/models/walletpay_models.dart';
import 'package:reown_yttrium/reown_yttrium_method_channel.dart';
import 'package:reown_yttrium/wallet_pay/i_walletpay_request.dart';

class WalletPayRequest implements IWalletPayRequest {
  final _methodChannel = MethodChannelReownYttrium();

  @override
  Future<DisplayData> getDisplayData() async {
    try {
      final response = await _methodChannel.walletPayChannel.getDisplayData();
      return DisplayData.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<WalletPayAction> getPaymentAction({required int optionIndex}) async {
    try {
      final response = await _methodChannel.walletPayChannel.getPaymentAction(
        optionIndex: optionIndex.toString(),
      );
      return WalletPayAction.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<WalletPayAction> getActionFromPaymentOption({
    required Map<String, dynamic> paymentOption,
  }) async {
    try {
      final response = await _methodChannel.walletPayChannel
          .getActionFromPaymentOption(paymentOption: paymentOption);
      return WalletPayAction.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<WalletPayResponseResultV1> finalize({
    required int optionIndex,
    required String signature,
  }) async {
    try {
      final result = await _methodChannel.walletPayChannel.finalize(
        optionIndex: optionIndex.toString(),
        signature: signature,
      );
      return WalletPayResponseResultV1.fromJson(result);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> dispose() async {
    try {
      final result = await _methodChannel.walletPayChannel.dispose();
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
