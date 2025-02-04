/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../configs/get_signature_statuses_config.dart';
import '../interfaces/json_rpc_list_context_method.dart';
import '../models/signature_status.dart';

/// Get Signature Statuses
/// ------------------------------------------------------------------------------------------------

/// A codec for `getSignatureStatuses` JSON RPC methods.
class GetSignatureStatuses
    extends JsonRpcListContextMethod<Map<String, dynamic>?, SignatureStatus?> {
  /// Creates a codec for `getSignatureStatuses` JSON RPC methods.
  GetSignatureStatuses(
    final List<String> signatures, {
    final GetSignatureStatusesConfig? config,
  }) : super(
          'getSignatureStatuses',
          values: [signatures],
          config: config ?? const GetSignatureStatusesConfig(),
        );

  @override
  SignatureStatus? itemDecoder(
    final Map<String, dynamic>? item,
  ) =>
      item != null ? SignatureStatus.fromJson(item) : null;
}
