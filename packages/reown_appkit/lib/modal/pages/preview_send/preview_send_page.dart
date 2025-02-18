import 'package:flutter/material.dart';

import 'package:reown_appkit/modal/constants/key_constants.dart';
import 'package:reown_appkit/modal/models/send_data.dart';
import 'package:reown_appkit/modal/pages/preview_send/preview_send_evm.dart';
import 'package:reown_appkit/modal/pages/preview_send/preview_send_solana.dart';
import 'package:reown_appkit/modal/services/blockchain_service/models/token_balance.dart';
import 'package:reown_appkit/modal/utils/core_utils.dart';
import 'package:reown_appkit/reown_appkit.dart';
import 'package:reown_appkit/modal/widgets/modal_provider.dart';

class PreviewSendPage extends StatelessWidget {
  final SendData sendData;
  final TokenBalance sendTokenData;
  final TokenBalance? networkTokenData;

  const PreviewSendPage({
    required this.sendData,
    required this.sendTokenData,
    required this.networkTokenData,
  }) : super(key: KeyConstants.previewSendPageKey);

  String get _namespace => NamespaceUtils.getNamespaceFromChain(
        sendTokenData.chainId!,
      );

  String get _originalSendValue => CoreUtils.formatStringBalance(
        sendData.amount!,
        precision: _getDecimals(nativeToken: false),
      );

  bool get _isMaxSend {
    final maxAllowance = CoreUtils.formatStringBalance(
      sendTokenData.quantity!.numeric!,
      precision: _getDecimals(nativeToken: false),
    );

    return _originalSendValue == maxAllowance;
  }

  // if sendTokenData.address is not null it means a contract should be called
  bool get _isContractCall => sendTokenData.address != null;

  int _getDecimals({required bool nativeToken}) {
    if (nativeToken) {
      final decimals = networkTokenData?.quantity?.decimals ?? '18';
      return int.parse(decimals);
    }
    final decimals = sendTokenData.quantity?.decimals ?? '18';
    return int.parse(decimals);
  }

  @override
  Widget build(BuildContext context) {
    final appKitModal = ModalProvider.of(context).instance;
    final chainId = sendTokenData.chainId!;
    final namespace = NamespaceUtils.getNamespaceFromChain(chainId);
    final senderAddress = appKitModal.session!.getAddress(namespace)!;

    if (_namespace == NetworkUtils.solana) {
      return PreviewSendSolana(
        sendData: sendData,
        sendTokenData: sendTokenData,
        networkTokenData: networkTokenData,
        originalSendValue: _originalSendValue,
        isMaxSend: _isMaxSend,
        isContractCall: _isContractCall,
        senderAddress: senderAddress,
        recipientAddress: sendData.address!,
      );
    }

    return PreviewSendEvm(
      sendData: sendData,
      sendTokenData: sendTokenData,
      networkTokenData: networkTokenData,
      originalSendValue: _originalSendValue,
      isMaxSend: _isMaxSend,
      isContractCall: _isContractCall,
      senderAddress: senderAddress,
      recipientAddress: sendData.address!,
    );
  }
}
