import 'dart:convert';

import 'package:solana_web3/solana_web3.dart' as solana;
import 'package:pinenacl/digests.dart';
import 'package:pinenacl/x25519.dart';
import 'package:ed25519_edwards/ed25519_edwards.dart' as ed25519;

class PhantomHelper {
  /// (required): A url used to fetch app metadata (i.e. title, icon) using the same properties found in Displaying Your App. URL-encoded.
  late final String _appUrl;

  /// (required): The URI where Phantom should redirect the user upon connection. Please review Specifying Redirects for more details. URL-encoded.
  late final String _redirectLink;

  /// (optional): The network that should be used for subsequent interactions. Can be either: mainnet-beta, testnet, or devnet. Defaults to mainnet-beta.
  late final String _cluster;

  /// Private/Public keypair for encryption and decryption of data response
  late PrivateKey _privateKey;
  String get selfPublicKey => solana.base58.encode(
        _privateKey.publicKey.asTypedList,
      );

  /// [walletPublicKey] once session is established with Phantom Wallet (i.e. user has approved the connection) we get user's Publickey (the Solana address)
  late final String walletPublicKey;

  /// When a user connects to Phantom Wallet for the first time, Phantom will return a session param that represents the user's connection.
  String? _sessionToken;

  /// [_sharedSecret] is used to encrypt and decrypt the session token and other data.
  Box? _sharedSecret;

  /// We need to provide [appUrl] and [redirectLink] as parameters to create new [PhantomHelper] object. [cluster] is optional
  PhantomHelper({
    required String appUrl,
    required String redirectLink,
    String cluster = 'mainnet-beta',
  }) {
    _appUrl = appUrl;
    _redirectLink = redirectLink;
    _cluster = cluster;
    _privateKey = PrivateKey.generate();
  }

  /// Generate an URL to connect to Phantom Wallet
  Uri buildConnectionUri() => Uri(
        scheme: 'https',
        host: 'phantom.app',
        path: '/ul/v1/connect',
        queryParameters: {
          'dapp_encryption_public_key': selfPublicKey,
          'cluster': _cluster,
          'app_url': _appUrl,
          'redirect_link': '$_redirectLink?phantomRequest=connect',
        },
      );

  /// Generate an URL to disconnect from Phantom Wallet and destroy the session.
  Uri buildDisconnectUri() {
    final payLoad = {'session': _sessionToken};
    final encryptedPayload = _encryptPayload(payLoad);

    final launchUri = Uri(
      scheme: 'https',
      host: 'phantom.app',
      path: '/ul/v1/disconnect',
      queryParameters: {
        'dapp_encryption_public_key': selfPublicKey,
        'nonce': solana.base58.encode(encryptedPayload['nonce']),
        'redirect_link': '$_redirectLink?phantomRequest=disconnect',
        'payload': solana.base58.encode(encryptedPayload['encryptedPayload']),
      },
    );
    // TODO do this on dispatchEnvelope() only if disconnect is succesfull
    _sharedSecret = null;
    _sessionToken = null;
    return launchUri;
  }

  /// Generate an URL with given [transaction] to signAndSend transaction with Phantom Wallet.
  Uri buildSignAndSendTransactionUri({required String transaction}) {
    final payload = {
      'session': _sessionToken,
      'transaction': solana.base58.encode(
        Uint8List.fromList(
          base64.decode(transaction),
        ),
      ),
    };
    final encryptedPayload = _encryptPayload(payload);

    return Uri(
      scheme: 'https',
      host: 'phantom.app',
      path: '/ul/v1/signAndSendTransaction',
      queryParameters: {
        'dapp_encryption_public_key': selfPublicKey,
        'nonce': solana.base58.encode(encryptedPayload['nonce']),
        'redirect_link': '$_redirectLink?phantomRequest=signAndSendTransaction',
        'payload': solana.base58.encode(encryptedPayload['encryptedPayload'])
      },
    );
  }

  /// Generate an URL with given [transaction] to sign transaction with Phantom Wallet.
  Uri buildSignTransactionUri({required String transaction}) {
    final payload = {
      'transaction': solana.base58.encode(
        Uint8List.fromList(
          base64.decode(transaction),
        ),
      ),
      'session': _sessionToken,
    };
    final encryptedPayload = _encryptPayload(payload);

    return Uri(
      scheme: 'https',
      host: 'phantom.app',
      path: '/ul/v1/signTransaction',
      queryParameters: {
        'dapp_encryption_public_key': selfPublicKey,
        'nonce': solana.base58.encode(encryptedPayload['nonce']),
        'redirect_link': '$_redirectLink?phantomRequest=signTransaction',
        'payload': solana.base58.encode(encryptedPayload['encryptedPayload'])
      },
    );
  }

  /// Generate an URL with given [transactions] to sign all transaction with Phantom Wallet.
  Uri buildUriSignAllTransactions({required List<String> transactions}) {
    final payload = {
      'transactions': transactions
          .map((e) => solana.base58.encode(
                Uint8List.fromList(
                  base64.decode(e),
                ),
              ))
          .toList(),
      'session': _sessionToken,
    };
    final encryptedPayload = _encryptPayload(payload);

    return Uri(
      scheme: 'https',
      host: 'phantom.app',
      path: '/ul/v1/signAllTransactions',
      queryParameters: {
        'dapp_encryption_public_key': selfPublicKey,
        'nonce': solana.base58.encode(encryptedPayload['nonce']),
        'redirect_link': '$_redirectLink?phantomRequest=signAllTransactions',
        'payload': solana.base58.encode(encryptedPayload['encryptedPayload'])
      },
    );
  }

  /// Generates an URL with given [nonce] to be signed by Phantom Wallet to verify the ownership of the wallet.
  Uri buildSignMessageUri({required String message, Uint8List? nonce}) {
    /// Hash the nonce so that it is not exposed to the user
    final hashedNonce = Hash.sha256(nonce ?? PineNaClUtils.randombytes(24));

    final m = '$message Nonce: ${solana.base58.encode(hashedNonce)}';
    final payload = {
      'session': _sessionToken,
      'message': solana.base58.encode(m.codeUnits.toUint8List()),
    };

    final encryptedPayload = _encryptPayload(payload);

    return Uri(
      scheme: 'https',
      host: 'phantom.app',
      path: 'ul/v1/signMessage',
      queryParameters: {
        'dapp_encryption_public_key': selfPublicKey,
        'nonce': solana.base58.encode(encryptedPayload['nonce']),
        'redirect_link': '$_redirectLink?phantomRequest=signMessage',
        'payload': solana.base58.encode(encryptedPayload['encryptedPayload']),
      },
    );
  }

  /// Creates [_sharedSecret] using [_privateKey] and [phantom_encryption_public_key].
  bool createSession(Map<String, String> params) {
    try {
      // `phantom_encryption_public_key` is the public key of Phantom Wallet.
      final phantomPublicKey = solana.base58.decode(
        params['phantom_encryption_public_key']!,
      );

      // Created a shared secret between Phantom Wallet and our DApp using our [_privateKey] and [phantom_encryption_public_key].
      _sharedSecret = Box(
        myPrivateKey: _privateKey,
        theirPublicKey: PublicKey(phantomPublicKey),
      );
      final decryptedData = decryptPayload(
        data: params['data']!,
        nonce: params['nonce']!,
      );
      _sessionToken = decryptedData['session'];
      walletPublicKey = decryptedData['public_key'];
    } catch (e) {
      return false;
    }
    return true;
  }

  /// Verifies the [signature] returned by Phantom Wallet.
  // TODO this can be achieve with core package probably
  Future<bool> validateSignature(String signature, Uint8List nonce) async {
    Uint8List hashedNonce = Hash.sha256(nonce);
    final message =
        'Sign this message for authenticating with your wallet. Nonce: ${solana.base58.encode(hashedNonce)}';
    final messageBytes = message.codeUnits.toUint8List();
    final signatureBytes = solana.base58.decode(signature);

    final verify = ed25519.verify(
      ed25519.PublicKey(solana.base58.decode(walletPublicKey)),
      messageBytes,
      signatureBytes,
    );
    nonce = Uint8List(0);
    return verify;
  }

  /// Decrypts the [data] payload returned by Phantom Wallet
  Map<dynamic, dynamic> decryptPayload({
    required String data,
    required String nonce,
  }) {
    if (_sharedSecret == null) {
      return <String, String>{};
    }

    final decryptedData = _sharedSecret?.decrypt(
      ByteList(solana.base58.decode(data)),
      nonce: Uint8List.fromList(solana.base58.decode(nonce)),
    );

    return JsonDecoder().convert(String.fromCharCodes(decryptedData!));
  }

  /// Encrypts the data payload to be sent to Phantom Wallet.
  Map<String, dynamic> _encryptPayload(Map<String, dynamic> data) {
    if (_sharedSecret == null) {
      return <String, String>{};
    }
    final nonce = PineNaClUtils.randombytes(24);
    final payload = jsonEncode(data).codeUnits;
    final encryptedPayload = _sharedSecret
        ?.encrypt(
          payload.toUint8List(),
          nonce: nonce,
        )
        .cipherText;
    return {
      'encryptedPayload': encryptedPayload?.asTypedList,
      'nonce': nonce,
    };
  }
}
