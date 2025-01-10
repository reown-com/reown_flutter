import 'dart:convert';

import 'package:solana_web3/solana_web3.dart' as solana;
import 'package:pinenacl/digests.dart';
import 'package:pinenacl/x25519.dart';
import 'package:ed25519_edwards/ed25519_edwards.dart' as ed25519;

class PhantomHelper {
  /// (required): A url used to fetch app metadata (i.e. title, icon)
  /// We do this provinding name, description, url and icons in PairingMetadata
  /// Used in /connect URI to show the user this metadata in the approval modal
  late final String _appUrl;

  /// (required): The URI Phantom Wallet calls when redirecting back after a request
  /// We do this with the redirect object of PairingMetadata
  /// Used in every URI
  late final String _redirectLink;

  /// Private/Public keypair for encryption and decryption of phantom responses
  /// `_privateKey` remains on dapp side and should be securely stored
  PrivateKey? _privateKey;

  /// `publicKey` is encoded in base58 and is sent in every URI/request
  String get publicKey => solana.base58.encode(
        _privateKey!.publicKey.asTypedList,
      );

  /// When a user connects to Phantom Wallet for the first time, Phantom will return a session token param that represents the user's connection.
  /// Will have to be securely stored
  /// Is then used in the payload of every request/URI
  String? _sessionToken;

  /// used to encrypt and decrypt the payload from and to Phantom Wallet
  Box? _sharedSecretBox;

  /// [solanaAddress] once session is established with Phantom Wallet we get user's wallet Publickey (the Solana address)
  String solanaAddress = '';

  /// Initialization of `PhantomHelper` instance
  PhantomHelper({
    required String appUrl,
    required String redirectLink,
  }) {
    _appUrl = appUrl;
    _redirectLink = redirectLink;
  }

  bool restoreSession(String sessionToken, String phantomKey) {
    try {
      _privateKey = PrivateKey.generate();
      _createSharedSecret(phantomPublicKey: phantomKey);
      _sessionToken = sessionToken;
      return true;
    } catch (e) {
      rethrow;
    }
  }

  /// Generate an URL to connect to Phantom Wallet
  Uri buildConnectionUri({String? cluster}) {
    _privateKey = PrivateKey.generate();

    return Uri(
      scheme: 'https',
      host: 'phantom.app',
      path: '/ul/v1/connect',
      queryParameters: {
        'dapp_encryption_public_key': publicKey,
        'cluster': cluster ?? 'mainnet-beta',
        'app_url': _appUrl,
        'redirect_link': '$_redirectLink?phantomRequest=connect',
      },
    );
  }

  /// Generate an URL to disconnect from Phantom Wallet and destroy the session.
  Uri buildDisconnectUri({Uint8List? nonce}) {
    final requestNonce = nonce ?? PineNaClUtils.randombytes(24);

    final payLoad = {'session': _sessionToken};

    final encryptedPayload = encryptPayload(payLoad, requestNonce);

    final launchUri = Uri(
      scheme: 'https',
      host: 'phantom.app',
      path: '/ul/v1/disconnect',
      queryParameters: {
        'redirect_link': '$_redirectLink?phantomRequest=disconnect',
        'dapp_encryption_public_key': publicKey,
        'nonce': solana.base58.encode(requestNonce),
        'payload': solana.base58.encode(encryptedPayload!),
      },
    );
    return launchUri;
  }

  bool _isBase58String(String input) {
    final base58Regex = RegExp(
        r'^[123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz]+$');
    return base58Regex.hasMatch(input);
  }

  /// Generates an URL with given [nonce] to be signed by Phantom Wallet
  /// If `nonce` is not passed it will generate one
  Uri buildSignMessageUri({required String message, Uint8List? nonce}) {
    final requestNonce = nonce ?? PineNaClUtils.randombytes(24);

    /// Hash the nonce so that it is not exposed to the user
    final hashedNonce = Hash.sha256(requestNonce);
    final hashedMessage =
        '$message\n\nNonce: ${solana.base58.encode(hashedNonce)}';

    final payload = {
      'session': _sessionToken,
      'message': _isBase58String(message)
          ? message
          : solana.base58.encode(
              hashedMessage.codeUnits.toUint8List(),
            ),
    };

    final encryptedPayload = encryptPayload(payload, requestNonce);

    return Uri(
      scheme: 'https',
      host: 'phantom.app',
      path: 'ul/v1/signMessage',
      queryParameters: {
        'redirect_link': '$_redirectLink?phantomRequest=signMessage',
        'dapp_encryption_public_key': publicKey,
        'nonce': solana.base58.encode(requestNonce),
        'payload': solana.base58.encode(encryptedPayload!),
      },
    );
  }

  /// Generate an URL with given [transaction] to signAndSend it with Phantom Wallet.
  Uri buildSignAndSendTransactionUri({
    required String transaction,
    Uint8List? nonce,
  }) {
    final requestNonce = nonce ?? PineNaClUtils.randombytes(24);

    final payload = {
      'session': _sessionToken,
      'transaction': solana.base58.encode(
        Uint8List.fromList(
          base64.decode(transaction),
        ),
      ),
    };
    final encryptedPayload = encryptPayload(payload, requestNonce);

    return Uri(
      scheme: 'https',
      host: 'phantom.app',
      path: '/ul/v1/signAndSendTransaction',
      queryParameters: {
        'redirect_link': '$_redirectLink?phantomRequest=signAndSendTransaction',
        'dapp_encryption_public_key': publicKey,
        'nonce': solana.base58.encode(requestNonce),
        'payload': solana.base58.encode(encryptedPayload!),
      },
    );
  }

  /// Generate an URL with given [transaction] to sign it with Phantom Wallet.
  Uri buildSignTransactionUri({
    required String transaction,
    Uint8List? nonce,
  }) {
    final requestNonce = nonce ?? PineNaClUtils.randombytes(24);

    final payload = {
      'transaction': solana.base58.encode(
        Uint8List.fromList(
          base64.decode(transaction),
        ),
      ),
      'session': _sessionToken,
    };

    final encryptedPayload = encryptPayload(payload, requestNonce);

    return Uri(
      scheme: 'https',
      host: 'phantom.app',
      path: '/ul/v1/signTransaction',
      queryParameters: {
        'redirect_link': '$_redirectLink?phantomRequest=signTransaction',
        'dapp_encryption_public_key': publicKey,
        'nonce': solana.base58.encode(requestNonce),
        'payload': solana.base58.encode(encryptedPayload!),
      },
    );
  }

  /// Generate an URL with given [transactions] to sign all with Phantom Wallet.
  Uri buildUriSignAllTransactions({
    required List<String> transactions,
    Uint8List? nonce,
  }) {
    final requestNonce = nonce ?? PineNaClUtils.randombytes(24);

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

    final encryptedPayload = encryptPayload(payload, requestNonce);

    return Uri(
      scheme: 'https',
      host: 'phantom.app',
      path: '/ul/v1/signAllTransactions',
      queryParameters: {
        'redirect_link': '$_redirectLink?phantomRequest=signAllTransactions',
        'dapp_encryption_public_key': publicKey,
        'nonce': solana.base58.encode(requestNonce),
        'payload': solana.base58.encode(encryptedPayload!),
      },
    );
  }

  /// Verifies the [signature] returned by Phantom Wallet.
  Future<bool> validateSignature(String message, String signature) async {
    final messageBytes = message.codeUnits.toUint8List();
    final signatureBytes = solana.base58.decode(signature);

    return ed25519.verify(
      ed25519.PublicKey(solana.base58.decode(solanaAddress)),
      messageBytes,
      signatureBytes,
    );
  }

  /// Decrypts the [data] payload returned by Phantom Wallet
  Map<String, dynamic> decryptPayload({required Map<String, String> params}) {
    if (params.containsKey('errorCode')) {
      return params;
    }

    final phantomRequest = params['phantomRequest'] ?? '';
    // phantom_encryption_public_key is Phantom publicKey (not solana Address)
    final phantomPublicKey = params['phantom_encryption_public_key'] ?? '';

    if (phantomRequest == 'connect') {
      // executed only once after successful /connect
      _createSharedSecret(phantomPublicKey: phantomPublicKey);
    }

    if (phantomRequest == 'disconnect') {
      return <String, dynamic>{'phantomRequest': phantomRequest};
    }

    final data = params['data']!;
    final nonce = params['nonce']!;
    final decryptedData = _sharedSecretBox?.decrypt(
      ByteList(solana.base58.decode(data)),
      nonce: Uint8List.fromList(solana.base58.decode(nonce)),
    );

    final payload = <String, dynamic>{
      ...JsonDecoder().convert(String.fromCharCodes(
        decryptedData!,
      )),
      if (phantomPublicKey.isNotEmpty)
        'phantom_encryption_public_key': phantomPublicKey,
      if (phantomRequest.isNotEmpty) 'phantomRequest': phantomRequest,
    };

    _sessionToken = payload['session'] ?? _sessionToken;
    solanaAddress = payload['public_key'] ?? solanaAddress;

    return payload;
  }

  /// Encrypts the data payload to be sent to Phantom Wallet.
  Uint8List? encryptPayload(
    Map<String, dynamic> data,
    Uint8List? nonce,
  ) {
    if (_sharedSecretBox == null) {
      return null;
    }

    // final n = nonce ?? PineNaClUtils.randombytes(24);
    final payload = jsonEncode(data).codeUnits;
    final encryptedPayload = _sharedSecretBox?.encrypt(
      payload.toUint8List(),
      nonce: nonce,
    );
    return encryptedPayload?.cipherText.asTypedList;
  }

  void _createSharedSecret({required String phantomPublicKey}) {
    final phPublicKey = solana.base58.decode(phantomPublicKey);
    // Create a shared secret between Phantom Wallet and our DApp using our [_privateKey] and [phantom_encryption_public_key].
    _sharedSecretBox = Box(
      myPrivateKey: _privateKey!,
      theirPublicKey: PublicKey(phPublicKey),
    );
  }

  void resetSharedSecret() {
    // TODO do this on dispatchEnvelope() only if disconnect is succesfull
    _privateKey = null;
    _sharedSecretBox = null;
    _sessionToken = null;
  }
}
