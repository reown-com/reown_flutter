import 'package:reown_appkit/reown_appkit.dart';

class ModalConnect extends EventArgs {
  final ReownAppKitModalSession session;
  ModalConnect(this.session);

  @override
  String toString() {
    return 'ModalConnect(session: ${session.toJson()})';
  }
}

class ModalNetworkChange extends EventArgs {
  final String chainId;
  ModalNetworkChange({required this.chainId});

  @override
  String toString() {
    return 'ModalNetworkChange(chainId: $chainId)';
  }
}

class ModalDisconnect extends EventArgs {
  final String? topic;
  final int? id;
  ModalDisconnect({this.topic, this.id});

  @override
  String toString() {
    return 'ModalDisconnect(topic: $topic, id: $id)';
  }
}

class ModalError extends EventArgs {
  final String message;
  ModalError(this.message);

  @override
  String toString() {
    return 'ModalError(message: $message)';
  }
}

class WalletNotInstalled extends ModalError {
  WalletNotInstalled() : super('Wallet app not installed');
}

class ErrorOpeningWallet extends ModalError {
  ErrorOpeningWallet() : super('Unable to open Wallet app');
}

class UserRejectedConnection extends ModalError {
  UserRejectedConnection() : super('User rejected connection');
}
