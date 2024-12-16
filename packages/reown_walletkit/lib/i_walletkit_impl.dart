import 'package:reown_sign/i_sign_wallet.dart';
import 'package:reown_sign/reown_sign.dart';
import 'package:yttrium_dart/generated/lib.dart';

abstract class IReownWalletKit implements IReownSignWallet {
  final String protocol = 'wc';
  final int version = 2;

  abstract final IReownSign reOwnSign;

  ///---------- CHAIN ABSTRACTION ----------///

  Future<Eip1559Estimation> estimateFees({required String chainId});

  Future<RouteResponse> route({required InitTransaction transaction});

  Future<StatusResponse> status({required String orchestrationId});

  Future<StatusResponseCompleted> waitForSuccessWithTimeout({
    required String orchestrationId,
    required BigInt checkIn,
    required BigInt timeout,
  });
}
