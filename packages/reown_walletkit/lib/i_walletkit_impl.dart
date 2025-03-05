import 'package:reown_sign/i_sign_wallet.dart';
import 'package:reown_walletkit/reown_walletkit.dart';

abstract class IReownWalletKit implements IReownSignWallet {
  final String protocol = 'wc';
  final int version = 2;

  abstract final IReownSign reOwnSign;

  ///---------- CHAIN ABSTRACTION ----------///

  Future<Eip1559EstimationCompat> estimateFees({
    required String chainId,
  });

  Future<String> erc20TokenBalance({
    required String chainId,
    required String token,
    required String owner,
  });

  // Future<PrepareResponseCompat> prepare({
  //   required String chainId,
  //   required String from,
  //   required CallCompat call,
  // });

  Future<PrepareDetailedResponseCompat> prepareDetailed({
    required String chainId,
    required String from,
    required CallCompat call,
    required Currency localCurrency,
  });

  // @override
  // Future<FFICall> prepareErc20TransferCall({
  //   required String erc20Address,
  //   required String to,
  //   required BigInt amount,
  // }) async {
  //   if (_chainAbstractionClient == null) {
  //     throw 'ChainAbstractionClient is not initialized';
  //   }
  //   return await _chainAbstractionClient!.prepareErc20TransferCall(
  //     erc20Address: erc20Address,
  //     to: to,
  //     amount: amount,
  //   );
  // }

  // @override
  // Future<UiFieldsCompat> getUiFields({
  //   required PrepareResponseAvailable routeResponse,
  //   required Currency currency,
  // }) async {
  //   return await _chainAbstractionClient.getUiFields(
  //     routeResponse: routeResponse,
  //     currency: currency,
  //   );
  // }

  // @override
  // Future<StatusResponse> status({required String orchestrationId}) async {
  //   return await _chainAbstractionClient.status(
  //     orchestrationId: orchestrationId,
  //   );
  // }

  // @override
  // Future<ExecuteDetails> execute({
  //   required UiFieldsCompat uiFields,
  //   required List<PrimitiveSignatureCompat> routeTxnSigs,
  //   required PrimitiveSignatureCompat initialTxnSig,
  // }) async {
  //   return await _chainAbstractionClient.execute(
  //     uiFields: uiFields,
  //     routeTxnSigs: routeTxnSigs,
  //     initialTxnSig: initialTxnSig,
  //   );
  // }

  // @override
  // Future<StatusResponseCompleted> waitForSuccessWithTimeout({
  //   required String orchestrationId,
  //   required BigInt checkIn,
  //   required BigInt timeout,
  // }) async {
  //   return await _chainAbstractionClient.waitForSuccessWithTimeout(
  //     orchestrationId: orchestrationId,
  //     checkIn: checkIn,
  //     timeout: timeout,
  //   );
  // }

  Future<ExecuteDetailsCompat> execute({
    required UiFieldsCompat uiFields,
    required List<PrimitiveSignatureCompat> routeTxnSigs,
    required PrimitiveSignatureCompat initialTxnSig,
  });
}
