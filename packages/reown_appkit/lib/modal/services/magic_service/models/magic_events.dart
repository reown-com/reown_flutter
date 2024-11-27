import 'package:reown_appkit/modal/services/magic_service/models/magic_data.dart';
import 'package:reown_appkit/reown_appkit.dart';

class MagicLoginEvent implements EventArgs {
  final MagicData? data;
  MagicLoginEvent(this.data);

  @override
  String toString() => data?.toString() ?? '';
}

class MagicSessionEvent implements EventArgs {
  String? email;
  String? userName;
  AppKitSocialOption? provider;
  String? address;
  String? chainId;

  MagicSessionEvent({
    this.email,
    this.userName,
    this.provider,
    this.address,
    this.chainId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> params = {};
    if ((email ?? '').isNotEmpty) {
      params['email'] = email;
    }
    if ((userName ?? '').isNotEmpty) {
      params['userName'] = userName;
    }
    if (provider != null) {
      params['provider'] = provider;
    }
    if ((address ?? '').isNotEmpty) {
      params['address'] = address;
    }
    if (chainId != null) {
      params['chainId'] = chainId;
    }

    return params;
  }

  @override
  String toString() => toJson().toString();
}

class MagicRequestEvent implements EventArgs {
  dynamic request;
  dynamic result;
  bool? success;

  MagicRequestEvent({
    required this.request,
    this.result,
    this.success,
  });

  @override
  String toString() => 'request: $request, success: $success, result: $result';
}

class MagicConnectEvent implements EventArgs {
  final bool connected;
  MagicConnectEvent(this.connected);
}

class MagicErrorEvent implements EventArgs {
  final String? error;
  MagicErrorEvent(this.error);
}

class IsConnectedErrorEvent extends MagicErrorEvent {
  IsConnectedErrorEvent() : super('Error checking connection');
}

class ConnectEmailErrorEvent extends MagicErrorEvent {
  final String? message;
  ConnectEmailErrorEvent({this.message})
      : super(
          message ?? 'Error connecting email',
        );
}

class UpdateEmailErrorEvent extends MagicErrorEvent {
  final String? message;
  UpdateEmailErrorEvent({this.message})
      : super(message ?? 'Error updating email');
}

class UpdateEmailPrimaryOtpErrorEvent extends MagicErrorEvent {
  final String? message;
  UpdateEmailPrimaryOtpErrorEvent({this.message})
      : super(
          message ?? 'Error validating OTP code',
        );
}

class UpdateEmailSecondaryOtpErrorEvent extends MagicErrorEvent {
  final String? message;
  UpdateEmailSecondaryOtpErrorEvent({this.message})
      : super(
          message ?? 'Error validating OTP code',
        );
}

class ConnectOtpErrorEvent extends MagicErrorEvent {
  final String? message;
  ConnectOtpErrorEvent({this.message})
      : super(
          message ?? 'Error validating OTP code',
        );
}

class GetUserErrorEvent extends MagicErrorEvent {
  final String? message;
  GetUserErrorEvent({this.message}) : super('Error getting user');
}

class SwitchNetworkErrorEvent extends MagicErrorEvent {
  final String? message;
  SwitchNetworkErrorEvent({this.message})
      : super(
          message ?? 'Error switching network',
        );
}

class SignOutErrorEvent extends MagicErrorEvent {
  SignOutErrorEvent() : super('Error on Signing out');
}

class RpcRequestErrorEvent extends MagicErrorEvent {
  RpcRequestErrorEvent(String? message)
      : super(message ?? 'Error during request');
}

class CompleteSocialLoginEvent implements EventArgs {
  final String url;
  CompleteSocialLoginEvent(this.url);
}
