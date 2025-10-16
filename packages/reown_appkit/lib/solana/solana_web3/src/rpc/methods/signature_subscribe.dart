/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_jsonrpc/types.dart'
    show SubscriptionId;
import '../../types.dart' show TransactionSignature;
import '../configs/signature_subscribe_config.dart';
import '../interfaces/json_rpc_type_method.dart';

/// Signature Subscribe
/// ------------------------------------------------------------------------------------------------

/// A method handler for `signatureSubscribe`.
class SignatureSubscribe extends JsonRpcTypeMethod<SubscriptionId> {
  /// Creates a method handler for `signatureSubscribe`.
  SignatureSubscribe(
    final TransactionSignature signature, {
    final SignatureSubscribeConfig? config,
  }) : super(
         'signatureSubscribe',
         values: [signature],
         config: config ?? const SignatureSubscribeConfig(),
       );
}
