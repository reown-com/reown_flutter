import 'package:reown_appkit/reown_appkit.dart';

/// Event fired when connection is done
class ModalConnect extends EventArgs {
  final ReownAppKitModalSession session;
  ModalConnect(this.session);

  @override
  String toString() {
    return 'ModalConnect(session: ${session.toJson()})';
  }
}

/// Event fired when network is changed through the modal
class ModalNetworkChange extends EventArgs {
  final String chainId;
  ModalNetworkChange({required this.chainId});

  @override
  String toString() {
    return 'ModalNetworkChange(chainId: $chainId)';
  }
}

/// Event fired when disconnect happens, either from the wallet of the modal
class ModalDisconnect extends EventArgs {
  final String? topic;
  final int? id;
  ModalDisconnect({this.topic, this.id});

  @override
  String toString() {
    return 'ModalDisconnect(topic: $topic, id: $id)';
  }
}

/// Event fired every time an error occurs
class ModalError extends EventArgs {
  final String message;
  ModalError(this.message);

  @override
  String toString() {
    return 'ModalError(message: $message)';
  }
}

/// Event fired when trying to opening a wallet that is not installed
class WalletNotInstalled extends ModalError {
  WalletNotInstalled() : super('Wallet app not installed');
}

/// Error opening wallet
class ErrorOpeningWallet extends ModalError {
  ErrorOpeningWallet() : super('Unable to open Wallet app');
}

/// Event fired when user rejects connection in the wallet
class UserRejectedConnection extends ModalError {
  UserRejectedConnection() : super('User rejected connection');
}
