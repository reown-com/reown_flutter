/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'package:reown_appkit/solana/solana_common/extensions.dart';

/// Lamports
/// ------------------------------------------------------------------------------------------------

/// The number of lamport per sol (1 billion).
const int lamportsPerSol = 1000000000;

/// Converts [sol] to lamports.
BigInt _intToLamports(final int sol) {
  return sol.toBigInt() * lamportsPerSol.toBigInt();
}

/// Converts [sol] to lamports.
BigInt _numToLamports(final num sol) {
  const int decimalPlaces = 9;
  final String value = sol.toStringAsFixed(decimalPlaces);
  final int decimalPosition = value.length - decimalPlaces;
  return BigInt.parse(
    value.substring(0, decimalPosition - 1) + value.substring(decimalPosition),
  );
}

/// Converts [sol] to lamports.
BigInt solToLamports(final num sol) {
  assert(sol is int || sol is double);
  return sol is int ? _intToLamports(sol) : _numToLamports(sol);
}

/// Converts [lamports] to sol.
double lamportsToSol(final BigInt lamports) {
  assert(
    lamports <= (BigInt.from(double.maxFinite) * lamportsPerSol.toBigInt()),
    'The lamports value $lamports overflows the max double value ${double.maxFinite}.',
  );
  return lamports / lamportsPerSol.toBigInt();
}
