/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import '../../crypto/pubkey.dart';
import '../configs/get_signatures_for_address_config.dart';
import '../interfaces/json_rpc_list_method.dart';
import '../models/confirmed_signature_info.dart';

/// Get Signatures For Address
/// ------------------------------------------------------------------------------------------------

/// A codec for `getSignaturesForAddress` JSON RPC methods.
class GetSignaturesForAddress
    extends JsonRpcListMethod<Map<String, dynamic>, ConfirmedSignatureInfo> {
  /// Creates a codec for `getSignaturesForAddress` JSON RPC methods.
  GetSignaturesForAddress(
    final Pubkey address, {
    final GetSignaturesForAddressConfig? config,
  }) : super(
         'getSignaturesForAddress',
         values: [address.toBase58()],
         config: config ?? const GetSignaturesForAddressConfig(),
       );

  @override
  ConfirmedSignatureInfo itemDecoder(final Map<String, dynamic> item) =>
      ConfirmedSignatureInfo.fromJson(item);
}
