/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:convert' show base64, utf8;
import 'dart:typed_data' show ByteBuffer, Uint8List;
import 'package:crypto/crypto.dart' show sha256;
import 'package:reown_appkit/solana/solana_buffer/extensions.dart';
import 'package:reown_appkit/solana/solana_common/models.dart';
import 'package:reown_appkit/solana/solana_common/validators.dart';
import 'package:reown_core/reown_core.dart';
import '../exceptions/ed25519_exception.dart';
import '../exceptions/pubkey_exception.dart';
import '../programs/associated_token/program.dart';
import '../programs/token/program.dart';
import '../rpc/models/program_address.dart';
import 'nacl.dart' as nacl show pubkeyLength, maxSeedLength;
import 'nacl_low_level.dart' as nacl_low_level;

/// Public Key
/// ------------------------------------------------------------------------------------------------

class Pubkey extends Serializable {
  /// Creates a [Pubkey] from an `ed25519` public key [value].
  const Pubkey(
    final BigInt value,
  ) : _value = value;

  /// The public key's `ed25519` value.
  final BigInt _value;

  /// Creates a default [Pubkey] (0 => '11111111111111111111111111111111').
  factory Pubkey.zero() {
    return Pubkey(BigInt.zero);
  }

  /// Creates a [Pubkey] from a `base-58` encoded [pubkey].
  factory Pubkey.fromString(final String pubkey) = Pubkey.fromBase58;

  /// Creates a [Pubkey] from a `base-58` encoded [pubkey].
  factory Pubkey.fromJson(final String pubkey) = Pubkey.fromBase58;

  /// Creates a [Pubkey] from a `base-58` encoded [pubkey].
  factory Pubkey.fromBase58(final String pubkey) {
    return Pubkey.fromUint8List(base58.decode(pubkey));
  }

  /// Creates a [Pubkey] from a `base-58` encoded [pubkey].
  ///
  /// Returns `null` if [pubkey] is omitted.
  static Pubkey? tryFromBase58(final String? pubkey) {
    return pubkey != null ? Pubkey.fromBase58(pubkey) : null;
  }

  /// Creates a [Pubkey] from a `base-64` encoded [pubkey].
  factory Pubkey.fromBase64(final String pubkey) {
    return Pubkey.fromUint8List(base64.decode(pubkey));
  }

  /// Creates a [Pubkey] from a `base-64` encoded [pubkey].
  ///
  /// Returns `null` if [pubkey] is omitted.
  static Pubkey? tryFromBase64(final String? pubkey) {
    return pubkey != null ? Pubkey.fromBase64(pubkey) : null;
  }

  /// Creates a [Pubkey] from a byte array [pubkey].
  factory Pubkey.fromUint8List(final Iterable<int> pubkey) {
    check(pubkey.length <= nacl.pubkeyLength, 'Invalid public key length.');
    return Pubkey(BufferSerializable.fromUint8List(pubkey));
  }

  /// Creates a [Pubkey] from a byte array [pubkey].
  ///
  /// Returns `null` if [pubkey] is omitted.
  static Pubkey? tryFromUint8List(final Iterable<int>? pubkey) {
    return pubkey != null ? Pubkey.fromUint8List(pubkey) : null;
  }

  @override
  int get hashCode => _value.hashCode;

  @override
  bool operator ==(Object other) {
    return other is Pubkey && _value == other._value;
  }

  /// Compares this [Pubkey] to [other].
  ///
  /// Returns a negative value if `this` is ordered before `other`, a positive value if `this` is
  /// ordered after `other`, or zero if `this` and `other` are equivalent. Ordering is based on the
  /// [BigInt] value of the public keys.
  int compareTo(final Pubkey other) {
    return _value.compareTo(other._value);
  }

  /// Returns true if this [Pubkey] is equal to the provided [pubkey].
  bool equals(final Pubkey pubkey) {
    return _value == pubkey._value;
  }

  /// Returns this [Pubkey] as a `base-58` encoded string.
  String toBase58() {
    return base58.encode(toBytes());
  }

  /// Returns this [Pubkey] as a `base-64` encoded string.
  String toBase64() {
    return base64.encode(toBytes());
  }

  /// Returns this [Pubkey] as a byte array.
  Uint8List toBytes() {
    return _value.toUint8List(nacl.pubkeyLength);
  }

  /// Returns this [Pubkey] as a byte buffer.
  ByteBuffer toBuffer() {
    return toBytes().buffer;
  }

  /// Returns this [Pubkey] as a `base-58` encoded string.
  @override
  String toString() {
    return toBase58();
  }

  /// Returns this [Pubkey] as a `base-58` encoded string.
  @override
  String toJson() {
    return toBase58();
  }

  /// Derives a [Pubkey] from another [pubkey], [seed], and [programId].
  ///
  /// The program Id will also serve as the owner of the public key, giving it permission to write
  /// data to the account.
  static Pubkey createWithSeed(
    final Pubkey pubkey,
    final String seed,
    final Pubkey programId,
  ) {
    final Uint8List seedBytes = Uint8List.fromList(utf8.encode(seed));
    final List<int> buffer = pubkey.toBytes() + seedBytes + programId.toBytes();
    return Pubkey.fromUint8List(sha256.convert(buffer).bytes);
  }

  /// Derives a program address from the [seeds] and [programId].
  ///
  /// Throws an [AssertionError] if [seeds] contains an invalid seed.
  ///
  /// Throws an [ED25519Exception] if the generated [Pubkey] falls on the `ed25519` curve.
  static Pubkey createProgramAddress(
    final List<List<int>> seeds,
    final Pubkey programId,
  ) {
    final List<int> buffer = [];

    for (final List<int> seed in seeds) {
      check(seed.length <= nacl.maxSeedLength, 'Invalid seed length.');
      buffer.addAll(seed);
    }

    buffer
      ..addAll(programId.toBytes())
      ..addAll(utf8.encode('ProgramDerivedAddress'));

    final digestBytes = Uint8List.fromList(sha256.convert(buffer).bytes);

    if (isOnCurve(digestBytes)) {
      throw ED25519Exception('Invalid seeds $seeds\n'
          'The public key address must fall off the `ed25519` curve.');
    }

    return Pubkey.fromUint8List(digestBytes);
  }

  /// Finds a valid program address for the given [seeds] and [programId].
  ///
  /// `Valid program addresses must fall off the ed25519 curve.` This function iterates a nonce
  /// until it finds one that can be combined with the seeds to produce a valid program address.
  ///
  /// Throws an [AssertionError] if [seeds] contains an invalid seed.
  ///
  /// Throws a [PubkeyException] if a valid program address could not be found.
  static ProgramAddress findProgramAddress(
    final List<List<int>> seeds,
    final Pubkey programId,
  ) {
    for (int nonce = 255; nonce > 0; --nonce) {
      try {
        final List<List<int>> seedsWithNonce = seeds +
            [
              [nonce]
            ];
        final Pubkey address = createProgramAddress(seedsWithNonce, programId);
        return ProgramAddress(address, nonce);
      } on AssertionError {
        rethrow;
      } catch (_) {}
    }

    throw const PubkeyException(
        'Unable to find a viable program address nonce.');
  }

  /// Finds the associated token address for an existing [wallet] and [tokenMint].
  static ProgramAddress findAssociatedTokenAddress(
    final Pubkey wallet,
    final Pubkey tokenMint,
  ) {
    return Pubkey.findProgramAddress(
      [
        wallet.toBytes(),
        TokenProgram.programId.toBytes(),
        tokenMint.toBytes(),
      ],
      AssociatedTokenProgram.programId,
    );
  }

  /// Returns true if [pubkey] falls on the `ed25519` curve.
  static bool isOnCurve(final Uint8List pubkey) {
    return nacl_low_level.isOnCurve(pubkey) == 1;
  }
}
