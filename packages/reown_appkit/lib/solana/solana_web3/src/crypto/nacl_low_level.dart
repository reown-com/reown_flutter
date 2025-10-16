/// A dart implementation of @solana-web3.js' is_on_curve() method.
/// Source code: https://github.com/solana-labs/solana-web3.js/blob/master/src/publickey.ts#L241
library;

/// Imports
/// ------------------------------------------------------------------------------------------------

import 'dart:typed_data';
import 'package:pinenacl/tweetnacl.dart' show TweetNaCl;

/// NaCl Low Level
/// ------------------------------------------------------------------------------------------------

List<int> gf([final Iterable<int>? init]) {
  final r = List<int>.filled(16, 0);
  if (init != null) {
    r.setAll(0, init);
  }
  return r;
}

final List<int> gf1 = gf([1]);
final List<int> D = gf([
  0x78a3,
  0x1359,
  0x4dca,
  0x75eb,
  0xd8ab,
  0x4141,
  0x0a4d,
  0x0070,
  0xe898,
  0x7779,
  0x4079,
  0x8cc7,
  0xfe73,
  0x2b6f,
  0x6cee,
  0x5203,
]);
final List<int> I = gf([
  0xa0b0,
  0x4a0e,
  0x1b27,
  0xc4ee,
  0xe478,
  0xad2f,
  0x1806,
  0x2f43,
  0xd7a7,
  0x3dfb,
  0x0099,
  0x2b4d,
  0xdf0b,
  0x4fc1,
  0x2480,
  0x2b83,
]);

void set25519(final List<int> r, final List<int> a) {
  for (int i = 0; i < 16; ++i) {
    r[i] = a[i];
  }
}

void unpack25519(final List<int> o, final Uint8List n) {
  for (int i = 0; i < 16; ++i) {
    o[i] = n[2 * i] + (n[2 * i + 1] << 8);
  }
  o[15] &= 0x7fff;
}

void A(final List<int> o, final List<int> a, final List<int> b) {
  for (int i = 0; i < 16; ++i) {
    o[i] = a[i] + b[i];
  }
}

void Z(final List<int> o, final List<int> a, final List<int> b) {
  for (int i = 0; i < 16; ++i) {
    o[i] = a[i] - b[i];
  }
}

void M(final List<int> o, final List<int> a, final List<int> b) {
  int i;
  final List<int> t = List.filled(31, 0);
  for (i = 0; i < 16; ++i) {
    for (int j = 0; j < 16; ++j) {
      t[i + j] += a[i] * b[j];
    }
  }
  const int len = 16 - 1;
  for (i = 0; i < len; i++) {
    t[i] += 38 * t[i + 16];
  }
  for (i = 0; i < 16; i++) {
    o[i] = t[i];
  }
  car25519(o);
  car25519(o);
}

void car25519(final List<int> o) {
  for (int c, i = 0; i < 16; ++i) {
    o[i] += 65536;
    c = (o[i] / 65536).floor();
    o[(i + 1) * (i < 15 ? 1 : 0)] += c - 1 + 37 * (c - 1) * (i == 15 ? 1 : 0);
    o[i] -= (c * 65536);
  }
}

void S(final List<int> o, final List<int> a) {
  M(o, a, a);
}

void pow2523(final List<int> o, final List<int> i) {
  int a;
  final List<int> c = gf(i);
  for (a = 250; a >= 0; --a) {
    S(c, c);
    if (a != 1) {
      M(c, c, i);
    }
  }
  for (a = 0; a < 16; ++a) {
    o[a] = c[a];
  }
}

int neq25519(final List<int> a, final List<int> b) {
  final c = Uint8List(32), d = Uint8List(32);
  pack25519(c, a);
  pack25519(d, b);
  return TweetNaCl.crypto_verify_32(c, d);
}

int par25519(final List<int> a) {
  final d = Uint8List(32);
  pack25519(d, a);
  return d[0] & 1;
}

void sel25519(final List<int> p, final List<int> q, final int b) {
  int t, c = ~(b - 1);
  for (int i = 0; i < 16; ++i) {
    t = c & (p[i] ^ q[i]);
    p[i] ^= t;
    q[i] ^= t;
  }
}

void pack25519(final Uint8List o, final List<int> n) {
  int i, j, b;
  final List<int> m = gf(), t = gf(n);
  car25519(t);
  car25519(t);
  car25519(t);
  for (j = 0; j < 2; ++j) {
    m[0] = t[0] - 0xffed;
    for (i = 1; i < 15; ++i) {
      m[i] = t[i] - 0xffff - ((m[i - 1] >> 16) & 1);
      m[i - 1] &= 0xffff;
    }
    m[15] = t[15] - 0x7fff - ((m[14] >> 16) & 1);
    b = (m[15] >> 16) & 1;
    m[14] &= 0xffff;
    sel25519(t, m, 1 - b);
  }
  for (i = 0; i < 16; ++i) {
    o[2 * i] = t[i] & 0xff;
    o[2 * i + 1] = t[i] >> 8;
  }
}

/// Returns a non-zero value if [publicKey] falls on the `ed25519` curve.
int isOnCurve(final Uint8List publicKey) {
  final List<List<int>> r = [gf(), gf(), gf(), gf()];

  final List<int> t = gf(),
      chk = gf(),
      num = gf(),
      den = gf(),
      den2 = gf(),
      den4 = gf(),
      den6 = gf();

  set25519(r[2], gf1);
  unpack25519(r[1], publicKey);
  S(num, r[1]);
  M(den, num, D);
  Z(num, num, r[2]);
  A(den, r[2], den);

  S(den2, den);
  S(den4, den2);
  M(den6, den4, den2);
  M(t, den6, num);
  M(t, t, den);

  pow2523(t, t);
  M(t, t, num);
  M(t, t, den);
  M(t, t, den);
  M(r[0], t, den);

  S(chk, r[0]);
  M(chk, chk, den);
  if (neq25519(chk, num) != 0) {
    M(r[0], r[0], I);
  }

  S(chk, r[0]);
  M(chk, chk, den);
  if (neq25519(chk, num) != 0) {
    return 0;
  }

  return 1;
}
