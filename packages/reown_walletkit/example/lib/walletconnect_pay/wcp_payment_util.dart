import 'package:reown_walletkit/reown_walletkit.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_native_price_service.dart';
import 'package:reown_walletkit_wallet/walletconnect_pay/wcp_utils.dart';

/// Resolved gas-fee estimate for a single Pay option. `fiatDisplay` is
/// preferred for the UI when populated; otherwise fall back to [nativeDisplay].
class WCPFeeEstimate {
  WCPFeeEstimate({
    required this.feeWei,
    required this.nativeSymbol,
    this.fiatValue,
    this.fiatCurrency,
  });

  final BigInt feeWei;
  final String nativeSymbol;
  final double? fiatValue;
  final String? fiatCurrency;

  String get display => fiatDisplay ?? nativeDisplay;

  String? get fiatDisplay {
    if (fiatValue == null || fiatCurrency == null) return null;
    return formatFiatGas(fiatValue!, fiatCurrency!);
  }

  String get nativeDisplay => formatNativeGas(feeWei, nativeSymbol);

  WCPFeeEstimate withFiat(NativeTokenPrice? price) {
    if (price == null) return this;
    final ether = feeWei.toDouble() / 1e18;
    if (!ether.isFinite || ether <= 0) return this;
    return WCPFeeEstimate(
      feeWei: feeWei,
      nativeSymbol: nativeSymbol,
      fiatValue: ether * price.price,
      fiatCurrency: price.currency,
    );
  }
}

/// True when any action in [actions] is an `eth_sendTransaction` (Permit2
/// approval is the canonical case). Equivalent to RN `requiresApproval`.
bool wcpRequiresApproval(List<Action> actions) {
  return actions.any((a) => a.walletRpc.method == 'eth_sendTransaction');
}

/// Returns the option whose [PayAmount.unit] matches [unit], or null when no
/// option matches (different merchant, expired token, etc.). Mirrors RN
/// `findPreferredOption` and Kotlin `PaymentSelectionResolver`.
PaymentOption? findPreferredOption(List<PaymentOption> options, String? unit) {
  if (unit == null || unit.isEmpty) return null;
  for (final option in options) {
    if (option.amount.unit == unit) return option;
  }
  return null;
}

/// Renders gas like `0.0012 ETH` or `< 0.0001 ETH`. Native-only fallback when
/// the fiat price lookup failed or is still pending.
String formatNativeGas(BigInt? feeWei, String? symbol) {
  if (feeWei == null || symbol == null) return '…';
  final ether = feeWei.toDouble() / 1e18;
  if (!ether.isFinite || ether <= 0) return '0 $symbol';
  if (ether < 0.0001) return '< 0.0001 $symbol';
  final scale = ether >= 0.01 ? 4 : 6;
  var str = ether.toStringAsFixed(scale);
  if (str.contains('.')) {
    str = str.replaceFirst(RegExp(r'0+$'), '').replaceFirst(RegExp(r'\.$'), '');
  }
  return '$str $symbol';
}

/// Renders fiat like `0.012€`. `currency` is an ISO-4217 code (`EUR`, `USD`).
String formatFiatGas(double fiatValue, String currency) {
  if (!fiatValue.isFinite || fiatValue <= 0) {
    return '${_fiatSymbol(currency)}0.00';
  }
  final symbol = _fiatSymbol(currency);
  final scale = fiatValue >= 1 ? 2 : 3;
  var str = fiatValue.toStringAsFixed(scale);
  // Strip trailing zeros so `0.010` → `0.01` but keep `0.50`.
  if (str.contains('.')) {
    str = str.replaceFirst(RegExp(r'0+$'), '').replaceFirst(RegExp(r'\.$'), '');
  }
  // EUR convention in the Figma puts the symbol after the value (`0.012€`).
  // USD puts it before (`$0.012`). Anything else: ISO code after, separator.
  switch (currency.toUpperCase()) {
    case 'EUR':
      return '$str$symbol';
    case 'USD':
      return '$symbol$str';
    default:
      return '$str $currency';
  }
}

String _fiatSymbol(String currency) {
  switch (currency.toUpperCase()) {
    case 'EUR':
      return '€';
    case 'USD':
      return r'$';
    default:
      return currency;
  }
}

/// Inline `+amount` chip rendered on a Pay option row beside the gas-pump
/// glyph. `null` when no approval / fee not yet resolved.
String? formatInlineApprovalFee(WCPFeeEstimate? estimate) {
  if (estimate == null) return null;
  final fiat = estimate.fiatDisplay;
  if (fiat != null) return '+$fiat';
  return '+${estimate.nativeDisplay}';
}

/// Pay-button label. Returns `Pay 2500€` for native flows and
/// `Pay 2500€ (incl. gas fee)` when an approval is present. We deliberately do
/// NOT sum gas into the merchant total — gas is in native chain currency and
/// summing requires an extra fiat conversion that the merchant total may not
/// represent cleanly.
String formatPayButtonLabel({
  required PayAmount merchantAmount,
  required bool hasApprovalFee,
}) {
  final amount = formatPayAmount(merchantAmount);
  if (!hasApprovalFee) return 'Pay $amount';
  return 'Pay $amount (incl. gas fee)';
}
