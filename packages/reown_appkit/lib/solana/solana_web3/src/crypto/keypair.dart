/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:convert' show utf8;
import 'package:flutter/foundation.dart';
import '../exceptions/keypair_exception.dart';
import 'nacl.dart' as nacl;
import 'pubkey.dart';

/// Signer
/// ------------------------------------------------------------------------------------------------

abstract class Signer {
  /// Keypair signer.
  Signer({required this.pubkey, required this.seckey});

  /// The keypair's public key.
  final Pubkey pubkey;

  /// The keypair's secrey key.
  final Uint8List seckey;
}

/// Ed25519 Keypair
/// ------------------------------------------------------------------------------------------------

class Ed25519Keypair {
  /// Ed25519 keypair.
  const Ed25519Keypair({required this.pubkey, required this.seckey})
    : assert(pubkey.length == nacl.pubkeyLength),
      assert(seckey.length == nacl.seckeyLength);

  /// The Ed25519 public key.
  final Uint8List pubkey;

  /// The Ed25519 signing key.
  final Uint8List seckey;
}

/// Keypair
/// ------------------------------------------------------------------------------------------------

class Keypair implements Signer {
  /// Creates an account keypair used for signing transactions.
  const Keypair(this._keypair);

  /// The public key and secret key pair.
  final Ed25519Keypair _keypair;

  /// The public key for this keypair.
  @override
  Pubkey get pubkey => Pubkey.fromUint8List(_keypair.pubkey);

  /// The secret key for this keypair.
  @override
  Uint8List get seckey => _keypair.seckey;

  /// {@macro Keypair.generateSync}
  static Future<Keypair> generate() async =>
      compute((_) => Keypair.generateSync(), null);

  /// {@template Keypair.generateSync}
  /// Generates a random keypair.
  /// {@endtemplate}
  factory Keypair.generateSync() => Keypair(nacl.sign.keypair.sync());

  /// {@macro Keypair.fromSeckeySync}
  static Future<Keypair> fromSeckey(
    final Uint8List seckey, {
    final bool skipValidation = false,
  }) => compute(
    (_) => Keypair.fromSeckeySync(seckey, skipValidation: skipValidation),
    null,
  );

  /// {@template Keypair.fromSeckeySync}
  /// Creates a [Keypair] from a [seckey] byte array.
  ///
  /// This method should only be used to recreate a keypair from a previously generated [seckey].
  /// Generating keypairs from a random seed should be done with the [Keypair.fromSeedSync] method.
  ///
  /// Throws a [KeypairException] for invalid [seckey]s that do not pass validation.
  /// {@endtemplate}
  factory Keypair.fromSeckeySync(
    final Uint8List seckey, {
    final bool skipValidation = false,
  }) {
    final Ed25519Keypair keypair = nacl.sign.keypair.fromSeckeySync(seckey);
    if (!skipValidation) {
      const String message = 'solana/web3.dart';
      final Uint8List signData = Uint8List.fromList(utf8.encode(message));
      final Uint8List signature = nacl.sign.detached.sync(
        signData,
        keypair.seckey,
      );
      if (!nacl.sign.detached.verifySync(signData, signature, keypair.pubkey)) {
        throw const KeypairException('Invalid secret key.');
      }
    }
    return Keypair(keypair);
  }

  /// {@macro Keypair.fromSeedSync}
  static Future<Keypair> fromSeed(final Uint8List seed) =>
      compute(Keypair.fromSeedSync, seed);

  /// {@template Keypair.fromSeedSync}
  /// Creates a [Keypair] from a `32-byte` [seed].
  /// {@endtemplate}
  factory Keypair.fromSeedSync(final Uint8List seed) =>
      Keypair(nacl.sign.keypair.fromSeedSync(seed));
}
