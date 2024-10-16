import 'dart:convert';

import 'package:reown_appkit/modal/constants/string_constants.dart';
import 'package:reown_appkit/modal/utils/render_utils.dart';
import 'package:reown_appkit/reown_appkit.dart';

class FrameMessage {
  final MessageData? data;
  final String? origin;

  FrameMessage({this.data, this.origin});

  FrameMessage copyWith({MessageData? data, String? origin}) => FrameMessage(
        data: data ?? this.data,
        origin: origin ?? this.origin,
      );

  factory FrameMessage.fromRawJson(String str) {
    return FrameMessage.fromJson(json.decode(str));
  }

  String toRawJson() => json.encode(toJson());

  factory FrameMessage.fromJson(Map<String, dynamic> json) => FrameMessage(
        data: MessageData.fromJson(json['data']),
        origin: json['origin'],
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'origin': origin,
      };

  bool get isValidOrigin {
    final authority1 = Uri.parse(UrlConstants.secureDashboard).authority;
    final authority2 = Uri.parse(UrlConstants.secureService).authority;
    final originAuthority = Uri.parse(origin ?? '').authority;
    return originAuthority == authority1 || originAuthority == authority2;
  }

  bool get isValidData {
    return data != null;
  }
}

class MessageData {
  final String? type;
  final dynamic payload;

  MessageData({this.type, this.payload});

  MessageData copyWith({String? type, dynamic payload}) {
    return MessageData(
      type: type ?? this.type,
      payload: payload ?? this.payload,
    );
  }

  factory MessageData.fromRawJson(String str) {
    return MessageData.fromJson(json.decode(str));
  }

  String toRawJson() => json.encode(toJson());

  factory MessageData.fromJson(Map<String, dynamic> json) => MessageData(
        type: json['type'],
        payload: json['payload'],
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        if (payload != null) 'payload': payload,
      };

  T getPayloadMapKey<T>(String key) {
    final p = payload as Map<String, dynamic>;
    return p[key] as T;
  }

  // @w3m-frame events
  bool get syncThemeSuccess => type == '@w3m-frame/SYNC_THEME_SUCCESS';
  bool get syncThemeError => type == '@w3m-frame/SYNC_THEME_ERROR';
  bool get syncDataSuccess => type == '@w3m-frame/SYNC_DAPP_DATA_SUCCESS';
  bool get syncDataError => type == '@w3m-frame/SYNC_DAPP_DATA_ERROR';
  bool get getSocialRedirectUriSuccess =>
      type == '@w3m-frame/GET_SOCIAL_REDIRECT_URI_SUCCESS';
  bool get getSocialRedirectUriError =>
      type == '@w3m-frame/GET_SOCIAL_REDIRECT_URI_ERROR';
  bool get getFarcasterUriSuccess =>
      type == '@w3m-frame/GET_FARCASTER_URI_SUCCESS';
  bool get getFarcasterUriError => type == '@w3m-frame/GET_FARCASTER_URI_ERROR';
  bool get connectFarcasterSuccess =>
      type == '@w3m-frame/CONNECT_FARCASTER_SUCCESS';
  bool get connectFarcasterError =>
      type == '@w3m-frame/CONNECT_FARCASTER_ERROR';
  bool get connectSocialSuccess => type == '@w3m-frame/CONNECT_SOCIAL_SUCCESS';
  bool get connectSocialError => type == '@w3m-frame/CONNECT_SOCIAL_ERROR';
  bool get connectEmailSuccess => type == '@w3m-frame/CONNECT_EMAIL_SUCCESS';
  bool get connectEmailError => type == '@w3m-frame/CONNECT_EMAIL_ERROR';
  bool get updateEmailSuccess => type == '@w3m-frame/UPDATE_EMAIL_SUCCESS';
  bool get updateEmailPrimarySuccess =>
      type == '@w3m-frame/UPDATE_EMAIL_PRIMARY_OTP_SUCCESS';
  bool get updateEmailPrimaryOtpError =>
      type == '@w3m-frame/UPDATE_EMAIL_PRIMARY_OTP_ERROR';
  bool get updateEmailSecondarySuccess =>
      type == '@w3m-frame/UPDATE_EMAIL_SECONDARY_OTP_SUCCESS';
  bool get updateEmailSecondaryOtpError =>
      type == '@w3m-frame/UPDATE_EMAIL_SECONDARY_OTP_ERROR';
  bool get updateEmailError => type == '@w3m-frame/UPDATE_EMAIL_ERROR';
  bool get isConnectSuccess => type == '@w3m-frame/IS_CONNECTED_SUCCESS';
  bool get isConnectError => type == '@w3m-frame/IS_CONNECTED_ERROR';
  bool get connectOtpSuccess => type == '@w3m-frame/CONNECT_OTP_SUCCESS';
  bool get connectOtpError => type == '@w3m-frame/CONNECT_OTP_ERROR';
  bool get getUserSuccess => type == '@w3m-frame/GET_USER_SUCCESS';
  bool get getUserError => type == '@w3m-frame/GET_USER_ERROR';
  bool get sessionUpdate => type == '@w3m-frame/SESSION_UPDATE';
  bool get switchNetworkSuccess => type == '@w3m-frame/SWITCH_NETWORK_SUCCESS';
  bool get switchNetworkError => type == '@w3m-frame/SWITCH_NETWORK_ERROR';
  bool get getChainIdSuccess => type == '@w3m-frame/GET_CHAIN_ID_SUCCESS';
  bool get getChainIdError => type == '@w3m-frame/GET_CHAIN_ID_ERROR';
  bool get rpcRequestSuccess => type == '@w3m-frame/RPC_REQUEST_SUCCESS';
  bool get rpcRequestError => type == '@w3m-frame/RPC_REQUEST_ERROR';
  bool get signOutSuccess => type == '@w3m-frame/SIGN_OUT_SUCCESS';
  bool get signOutError => type == '@w3m-frame/SIGN_OUT_ERROR';
}

// @w3m-app events
class IsConnected extends MessageData {
  IsConnected() : super(type: '@w3m-app/IS_CONNECTED');

  @override
  String toString() => '{type: "${super.type}"}';
}

class SwitchNetwork extends MessageData {
  final String chainId;
  SwitchNetwork({
    required this.chainId,
  }) : super(type: '@w3m-app/SWITCH_NETWORK');

  @override
  String toString() => '{type:"${super.type}",payload:{chainId:"$chainId"}}';
}

class GetSocialRedirectUri extends MessageData {
  final String provider;
  final String? schema;
  GetSocialRedirectUri({
    required this.provider,
    this.schema,
  }) : super(type: '@w3m-app/GET_SOCIAL_REDIRECT_URI');

  @override
  String toString() {
    final p = 'provider:"$provider"';
    final s = 'schema:"$schema"';

    if (schema != null) {
      return '{type:"${super.type}",payload:{$p,$s}}';
    }
    return '{type:"${super.type}",payload:{$p}}';
  }
}

class ConnectSocial extends MessageData {
  final String uri;
  ConnectSocial({
    required this.uri,
  }) : super(type: '@w3m-app/CONNECT_SOCIAL');

  @override
  String toString() => '{type:"${super.type}",payload:{uri:"$uri"}}';
}

class GetFarcasterUri extends MessageData {
  GetFarcasterUri() : super(type: '@w3m-app/GET_FARCASTER_URI');

  @override
  String toString() => '{type:"${super.type}"}';
}

// class ConnectFarcaster extends MessageData {
//   ConnectFarcaster() : super(type: '@w3m-app/CONNECT_FARCASTER');

//   @override
//   String toString() => '{type:"${super.type}"}';
// }

class ConnectEmail extends MessageData {
  final String email;
  ConnectEmail({required this.email}) : super(type: '@w3m-app/CONNECT_EMAIL');

  @override
  String toString() => '{type:"${super.type}",payload:{email:"$email"}}';
}

class UpdateEmail extends MessageData {
  final String email;
  UpdateEmail({required this.email}) : super(type: '@w3m-app/UPDATE_EMAIL');

  @override
  String toString() => '{type:"${super.type}",payload:{email:"$email"}}';
}

class UpdateEmailPrimaryOtp extends MessageData {
  final String otp;
  UpdateEmailPrimaryOtp({
    required this.otp,
  }) : super(type: '@w3m-app/UPDATE_EMAIL_PRIMARY_OTP');

  @override
  String toString() => '{type:"${super.type}",payload:{otp:"$otp"}}';
}

class UpdateEmailSecondaryOtp extends MessageData {
  final String otp;
  UpdateEmailSecondaryOtp({
    required this.otp,
  }) : super(type: '@w3m-app/UPDATE_EMAIL_SECONDARY_OTP');

  @override
  String toString() => '{type:"${super.type}",payload:{otp:"$otp"}}';
}

class ConnectOtp extends MessageData {
  final String otp;
  ConnectOtp({required this.otp}) : super(type: '@w3m-app/CONNECT_OTP');

  @override
  String toString() => '{type:"${super.type}",payload:{otp:"$otp"}}';
}

class GetUser extends MessageData {
  final String? chainId;
  GetUser({this.chainId}) : super(type: '@w3m-app/GET_USER');

  @override
  String toString() {
    if ((chainId ?? '').isNotEmpty) {
      return '{type:"${super.type}",payload:{chainId:"$chainId"}}';
    }
    return '{type:"${super.type}"}';
  }
}

class SignOut extends MessageData {
  SignOut() : super(type: '@w3m-app/SIGN_OUT');

  @override
  String toString() => '{type: "${super.type}"}';
}

class GetChainId extends MessageData {
  GetChainId() : super(type: '@w3m-app/GET_CHAIN_ID');

  @override
  String toString() => '{type: "${super.type}"}';
}

class RpcRequest extends MessageData {
  final String method;
  final dynamic params;

  RpcRequest({
    required this.method,
    required this.params,
  }) : super(type: '@w3m-app/RPC_REQUEST');

  @override
  String toString() {
    final m = 'method:"$method"';
    final t = 'type:"${super.type}"';

    if (params is Map) {
      List<String> ps =
          (params as Map).entries.map((e) => '${e.key}:"${e.value}"').toList();
      final pString = ps.join(',');
      return '{$t,payload:{$m,params:{$pString}}}';
    }

    final p = params.map((i) => '$i').toList();

    if (method == 'personal_sign') {
      final data = p.first;
      final address = p.last;
      return '{$t,payload:{$m,params:["$data","$address"]}}';
    }
    if (method == 'eth_sign') {
      final address = p.first;
      final data = p.last;
      return '{$t,payload:{$m,params:["$address","$data"]}}';
    }
    if (method == 'eth_signTypedData_v4' ||
        method == 'eth_signTypedData_v3' ||
        method == 'eth_signTypedData') {
      final data = p.first;
      final address = p.last;
      return '{$t,payload:{$m,params:["$address","$data"]}}';
    }
    if (method == 'eth_sendTransaction' || method == 'eth_signTransaction') {
      final jp = jsonEncode(params.first);
      return '{$t,payload:{$m,params:[$jp]}}';
    }

    final ps = p.join(',');
    return '{$t,payload:{$m,params:[$ps]}}';
  }
}

class SyncTheme extends MessageData {
  final ReownAppKitModalTheme? theme;
  SyncTheme({required this.theme}) : super(type: '@w3m-app/SYNC_THEME');

  @override
  String toString() {
    final mode = theme?.isDarkMode == true ? 'dark' : 'light';
    final themeData = theme?.themeData ?? ReownAppKitModalThemeData();
    late ReownAppKitModalColors colors;
    if (mode == 'dark') {
      colors = themeData.darkColors;
    } else {
      colors = themeData.lightColors;
    }

    final tm = 'themeMode:"$mode"';

    final mix = RenderUtils.colorToRGBA(colors.background125);
    final tv1 = '"--w3m-color-mix":"$mix"';
    // final tv2 = '"--w3m-color-mix-strength":"0%"';
    final tv = 'themeVariables:{$tv1}';

    final accent = RenderUtils.colorToRGBA(colors.accent100);
    final wtv1 = '"--w3m-accent":"$accent"';
    final background = RenderUtils.colorToRGBA(colors.background125);
    final wtv2 = '"--w3m-background":"$background"';
    final w3mtv = 'w3mThemeVariables:{$wtv1,$wtv2}';

    return '{type:"${super.type}",payload:{$tm, $tv,$w3mtv}}';
  }
}

class SyncAppData extends MessageData {
  SyncAppData({
    required this.metadata,
    required this.sdkVersion,
    required this.projectId,
  }) : super(type: '@w3m-app/SYNC_DAPP_DATA');

  final PairingMetadata metadata;
  final String sdkVersion;
  final String projectId;

  @override
  String toString() {
    final v = 'verified: true';
    final p1 = 'projectId:\'$projectId\'';
    final p2 = 'sdkVersion:\'${sdkVersion.replaceAll("'", "\\'")}\'';
    final m1 = 'name:\'${metadata.name.replaceAll("'", "\\'")}\'';
    final m2 = 'description:\'${metadata.description.replaceAll("'", "\\'")}\'';
    final m3 = 'url:\'${metadata.url}\'';
    final m4 = 'icons:["${metadata.icons.first}"]';
    final r1 = 'native:"${metadata.redirect?.native}"';
    final r2 = 'universal:"${metadata.redirect?.universal}"';
    final r3 = 'linkMode:"${metadata.redirect?.linkMode}"';
    final m5 = 'redirect:{$r1,$r2,$r3}';
    final p3 = 'metadata:{$m1,$m2,$m3,$m4,$m5}';
    final p = 'payload:{$v,$p1,$p2,$p3}';
    return '{type:"${super.type}",$p}';
  }
}
