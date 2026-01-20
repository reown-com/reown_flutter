import 'package:walletconnect_pay/models/walletconnect_pay_models.dart';

extension PayAmountExtension on PayAmount {
  String formatAmount({bool withSymbol = true}) {
    final decimals = display.decimals;
    final symbol = withSymbol ? display.assetSymbol : '';
    try {
      final raw = BigInt.parse(value);
      final divisor = BigInt.from(10).pow(decimals);

      final BigInt intPart = raw ~/ divisor;
      BigInt rem = raw % divisor;

      const int scale = 4; // 4 decimal places
      final BigInt factorWithExtra = BigInt.from(
        10,
      ).pow(scale + 1); // extra digit for HALF_UP
      BigInt fracWithExtra = (rem * factorWithExtra) ~/ divisor;

      final BigInt last = fracWithExtra % BigInt.from(10);
      BigInt frac = fracWithExtra ~/ BigInt.from(10);

      if (last >= BigInt.from(5)) frac += BigInt.one; // HALF_UP

      final BigInt maxFrac = BigInt.from(10).pow(scale);
      BigInt finalInt = intPart;
      if (frac >= maxFrac) {
        finalInt += BigInt.one;
        frac = BigInt.zero;
      }

      final String intStr = _withCommas(finalInt.toString());
      String fracStr = frac
          .toString()
          .padLeft(scale, '0')
          .replaceFirst(RegExp(r'0+$'), '');

      return (fracStr.isEmpty ? '$intStr $symbol' : '$intStr.$fracStr $symbol')
          .trim();
    } catch (_) {
      return '$value $symbol'.trim();
    }
  }

  String _withCommas(String s) =>
      s.replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (_) => ',');
}
