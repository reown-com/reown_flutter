import 'package:reown_core/models/json_rpc_models.dart';
import 'package:reown_core/utils/constants.dart';

class MethodConstants {
  static const WC_PAIRING_PING = 'wc_pairingPing';
  static const WC_PAIRING_DELETE = 'wc_pairingDelete';
  static const UNREGISTERED_METHOD = 'unregistered_method';

  static const WC_SESSION_PROPOSE = 'wc_sessionPropose';
  static const WC_SESSION_SETTLE = 'wc_sessionSettle';
  static const WC_SESSION_UPDATE = 'wc_sessionUpdate';
  static const WC_SESSION_EXTEND = 'wc_sessionExtend';
  static const WC_SESSION_REQUEST = 'wc_sessionRequest';
  static const WC_SESSION_EVENT = 'wc_sessionEvent';
  static const WC_SESSION_DELETE = 'wc_sessionDelete';
  static const WC_SESSION_PING = 'wc_sessionPing';
  static const WC_SESSION_AUTHENTICATE = 'wc_sessionAuthenticate';

  static const Map<String, Map<String, RpcOptions>> RPC_OPTS = {
    WC_PAIRING_PING: {
      'req': RpcOptions(
        ttl: ReownConstants.ONE_DAY,
        prompt: false,
        tag: 1000,
      ),
      'res': RpcOptions(
        ttl: ReownConstants.ONE_DAY,
        prompt: false,
        tag: 1001,
      ),
    },
    WC_PAIRING_DELETE: {
      'req': RpcOptions(
        ttl: ReownConstants.THIRTY_SECONDS,
        prompt: false,
        tag: 1002,
      ),
      'res': RpcOptions(
        ttl: ReownConstants.THIRTY_SECONDS,
        prompt: false,
        tag: 1003,
      ),
    },
    UNREGISTERED_METHOD: {
      'req': RpcOptions(
        ttl: ReownConstants.ONE_DAY,
        prompt: false,
        tag: 0,
      ),
      'res': RpcOptions(
        ttl: ReownConstants.ONE_DAY,
        prompt: false,
        tag: 0,
      ),
    },
    WC_SESSION_PROPOSE: {
      'req': RpcOptions(
        ttl: ReownConstants.FIVE_MINUTES,
        prompt: true,
        tag: 1100,
      ),
      'res': RpcOptions(
        ttl: ReownConstants.FIVE_MINUTES,
        prompt: false,
        tag: 1101,
      ),
      'reject': RpcOptions(
        ttl: ReownConstants.FIVE_MINUTES,
        prompt: false,
        tag: 1120,
      ),
      'autoReject': RpcOptions(
        ttl: ReownConstants.FIVE_MINUTES,
        prompt: false,
        tag: 1121,
      ),
    },
    WC_SESSION_SETTLE: {
      'req': RpcOptions(
        ttl: ReownConstants.FIVE_MINUTES,
        prompt: false,
        tag: 1102,
      ),
      'res': RpcOptions(
        ttl: ReownConstants.FIVE_MINUTES,
        prompt: false,
        tag: 1103,
      ),
    },
    WC_SESSION_UPDATE: {
      'req': RpcOptions(
        ttl: ReownConstants.ONE_DAY,
        prompt: false,
        tag: 1104,
      ),
      'res': RpcOptions(
        ttl: ReownConstants.ONE_DAY,
        prompt: false,
        tag: 1105,
      ),
    },
    WC_SESSION_EXTEND: {
      'req': RpcOptions(
        ttl: ReownConstants.ONE_DAY,
        prompt: false,
        tag: 1106,
      ),
      'res': RpcOptions(
        ttl: ReownConstants.ONE_DAY,
        prompt: false,
        tag: 1107,
      ),
    },
    WC_SESSION_REQUEST: {
      'req': RpcOptions(
        ttl: ReownConstants.FIVE_MINUTES,
        prompt: true,
        tag: 1108,
      ),
      'res': RpcOptions(
        ttl: ReownConstants.FIVE_MINUTES,
        prompt: false,
        tag: 1109,
      ),
    },
    WC_SESSION_EVENT: {
      'req': RpcOptions(
        ttl: ReownConstants.FIVE_MINUTES,
        prompt: true,
        tag: 1110,
      ),
      'res': RpcOptions(
        ttl: ReownConstants.FIVE_MINUTES,
        prompt: false,
        tag: 1111,
      ),
    },
    WC_SESSION_DELETE: {
      'req': RpcOptions(
        ttl: ReownConstants.ONE_DAY,
        prompt: false,
        tag: 1112,
      ),
      'res': RpcOptions(
        ttl: ReownConstants.ONE_DAY,
        prompt: false,
        tag: 1113,
      ),
    },
    WC_SESSION_PING: {
      'req': RpcOptions(
        ttl: ReownConstants.THIRTY_SECONDS,
        prompt: false,
        tag: 1114,
      ),
      'res': RpcOptions(
        ttl: ReownConstants.THIRTY_SECONDS,
        prompt: false,
        tag: 1115,
      ),
    },
    WC_SESSION_AUTHENTICATE: {
      'req': RpcOptions(
        ttl: ReownConstants.ONE_HOUR,
        prompt: false,
        tag: 1116,
      ),
      'res': RpcOptions(
        ttl: ReownConstants.ONE_HOUR,
        prompt: false,
        tag: 1117,
      ),
      'reject': RpcOptions(
        ttl: ReownConstants.FIVE_MINUTES,
        prompt: false,
        tag: 1118,
      ),
      'autoReject': RpcOptions(
        ttl: ReownConstants.FIVE_MINUTES,
        prompt: false,
        tag: 1119,
      ),
    }
  };
}
