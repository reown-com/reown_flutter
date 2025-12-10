import 'package:eth_sig_util_plus/eth_sig_util_plus.dart';
import 'package:eth_sig_util_plus/util/bigint.dart';
import 'package:eth_sig_util_plus/util/utils.dart';
import 'package:reown_yttrium_utils/models/chain_abstraction.dart';

extension SignatureExtension on String {
  PrimitiveSignatureCompat toPrimitiveSignature() {
    final ecdsaSignature = SignatureUtil.fromRpcSig(this);

    // Extract r, s, and v
    final rHex = bytesToHex(encodeBigInt(ecdsaSignature.r));
    final sHex = bytesToHex(encodeBigInt(ecdsaSignature.s));

    // Convert v to yParity (Ethereum EIP-1559 format)
    final bool yParity = (ecdsaSignature.v == 28);

    return PrimitiveSignatureCompat(
      r: rHex,
      s: sHex,
      yParity: yParity,
      hexValue: this,
    );
  }
}
