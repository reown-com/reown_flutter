import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:pinenacl/x25519.dart' as pncl;
import 'package:reown_appkit/modal/constants/string_constants.dart';

import 'package:reown_core/reown_core.dart';

class SolflareHelper {
  late final String _scheme;
  late final String _host;

  /// (required): A url used to fetch app metadata (i.e. title, icon)
  /// We do this provinding name, description, url and icons in PairingMetadata
  /// Used in /connect URI to show the user this metadata in the approval modal
  late final String _appUrl;

  /// (required): The URI Solflare Wallet calls when redirecting back after a request
  /// We do this with the redirect object of PairingMetadata
  /// Used in every URI
  late final String _redirectLink;

  /// Private/Public keypair for encryption and decryption of solflare responses
  CryptoKeyPair? _currentKeyPair;
  String get dappPublicKey =>
      base58.encode(_currentKeyPair!.getPublicKeyBytes());

  /// When a user connects to Solflare Wallet for the first time, Solflare will return a session token param that represents the user's connection.
  /// Will have to be securely stored
  /// Is then used in the payload of every request/URI
  String? _sessionToken;

  /// used to encrypt and decrypt the payload from and to Solflare Wallet
  pncl.Box? _sharedSecretBox;

  String? _solflarePublicKey;
  String get walletPublicKey => _solflarePublicKey ?? '';

  late final IReownCore _core;

  /// Initialization of `SolflareHelper` instance
  SolflareHelper({
    required Redirect redirect,
    required String appUrl,
    required String? redirectLink,
    required IReownCore core,
  }) {
    _scheme = redirect.linkMode == true
        ? Uri.parse(redirect.universal ?? '').scheme
        : (redirect.native ?? '');
    _host = Uri.parse(redirect.universal ?? '').host;
    _appUrl = appUrl;
    _redirectLink = redirectLink ?? '';
    _core = core;
    _currentKeyPair = _core.crypto.getUtils().generateKeyPair();

    _core.logger.i(
      '[$runtimeType] init with host: $_host, callback: $_redirectLink',
    );
  }

  Future<bool> restoreSession() async {
    try {
      if (_core.secureStorage.has(StorageConstants.solflareSession)) {
        final session = _core.secureStorage.get(
          StorageConstants.solflareSession,
        )!;
        _currentKeyPair = CryptoKeyPair(
          hex.encode(_getKeyBytes('${session['self_private_key']}')),
          hex.encode(_getKeyBytes('${session['self_public_key']}')),
        );
        _solflarePublicKey = session['solflare_encryption_public_key']!;
        _sessionToken = session['session_token']!;
        await _createSharedSecret();
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  /// Generate an URL to connect to Solflare Wallet
  Uri buildConnectionUri({String? cluster}) {
    // https://solflare.com/ul/<version>/<method>
    // solflare://<version>/<method>
    return Uri(
      scheme: _scheme,
      host: _host,
      path: '/ul/v1/connect',
      queryParameters: {
        'dapp_encryption_public_key': dappPublicKey,
        'cluster': cluster ?? 'mainnet-beta',
        'app_url': _appUrl, // has to be valid url to work
        'redirect_link': '$_redirectLink?solflareRequest=connect',
      },
    );
  }

  /// Generate an URL to disconnect from Solflare Wallet and destroy the session.
  Uri buildDisconnectUri({Uint8List? nonce}) {
    final requestNonce = nonce ?? _core.crypto.getUtils().randomBytes(24);

    final payLoad = {'session': _sessionToken};
    final encryptedPayload = encryptPayload(payLoad, requestNonce);

    return Uri(
      scheme: _scheme,
      host: _host,
      path: '/ul/v1/disconnect',
      queryParameters: {
        'redirect_link': '$_redirectLink?solflareRequest=disconnect',
        'dapp_encryption_public_key': dappPublicKey,
        'nonce': base58.encode(requestNonce),
        'payload': base58.encode(encryptedPayload!),
      },
    );
  }

  bool _isBase58String(String input) {
    final base58Regex = RegExp(
      r'^[123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz]+$',
    );
    return base58Regex.hasMatch(input);
  }

  /// Generates an URL with given [nonce] to be signed by Solflare Wallet
  /// If `nonce` is not passed it will generate one
  Uri buildSignMessageUri({required String message, Uint8List? nonce}) {
    final requestNonce = nonce ?? _core.crypto.getUtils().randomBytes(24);

    /// Hash the nonce so that it is not exposed to the user
    final hashedNonce = SHA256Digest().process(requestNonce);
    final hashedMessage = '$message\n\nNonce: ${base58.encode(hashedNonce)}';
    final payload = {
      'session': _sessionToken,
      'message': _isBase58String(message)
          ? message
          : base58.encode(Uint8List.fromList(hashedMessage.codeUnits)),
    };
    final encryptedPayload = encryptPayload(payload, requestNonce);

    return Uri(
      scheme: _scheme,
      host: _host,
      path: 'ul/v1/signMessage',
      queryParameters: {
        'redirect_link': '$_redirectLink?solflareRequest=signMessage',
        'dapp_encryption_public_key': dappPublicKey,
        'nonce': base58.encode(requestNonce),
        'payload': base58.encode(encryptedPayload!),
      },
    );
  }

  /// Generate an URL with given [transaction] to signAndSend it with Solflare Wallet.
  Uri buildSignAndSendTransactionUri({
    required String transaction,
    Uint8List? nonce,
  }) {
    final requestNonce = nonce ?? _core.crypto.getUtils().randomBytes(24);

    final payload = {
      'session': _sessionToken,
      'transaction': base58.encode(
        Uint8List.fromList(base64.decode(transaction)),
      ),
    };
    final encryptedPayload = encryptPayload(payload, requestNonce);

    return Uri(
      scheme: _scheme,
      host: _host,
      path: '/ul/v1/signAndSendTransaction',
      queryParameters: {
        'redirect_link':
            '$_redirectLink?solflareRequest=signAndSendTransaction',
        'dapp_encryption_public_key': dappPublicKey,
        'nonce': base58.encode(requestNonce),
        'payload': base58.encode(encryptedPayload!),
      },
    );
  }

  /// Generate an URL with given [transaction] to sign it with Solflare Wallet.
  Uri buildSignTransactionUri({required String transaction, Uint8List? nonce}) {
    final requestNonce = nonce ?? _core.crypto.getUtils().randomBytes(24);

    final payload = {
      'transaction': base58.encode(
        Uint8List.fromList(base64.decode(transaction)),
      ),
      'session': _sessionToken,
    };

    final encryptedPayload = encryptPayload(payload, requestNonce);

    return Uri(
      scheme: _scheme,
      host: _host,
      path: '/ul/v1/signTransaction',
      queryParameters: {
        'redirect_link': '$_redirectLink?solflareRequest=signTransaction',
        'dapp_encryption_public_key': dappPublicKey,
        'nonce': base58.encode(requestNonce),
        'payload': base58.encode(encryptedPayload!),
      },
    );
  }

  /// Generate an URL with given [transactions] to sign all with Solflare Wallet.
  Uri buildUriSignAllTransactions({
    required List<String> transactions,
    Uint8List? nonce,
  }) {
    final requestNonce = nonce ?? _core.crypto.getUtils().randomBytes(24);

    final payload = {
      'transactions': transactions
          .map((e) => base58.encode(Uint8List.fromList(base64.decode(e))))
          .toList(),
      'session': _sessionToken,
    };

    final encryptedPayload = encryptPayload(payload, requestNonce);

    return Uri(
      scheme: _scheme,
      host: _host,
      path: '/ul/v1/signAllTransactions',
      queryParameters: {
        'redirect_link': '$_redirectLink?solflareRequest=signAllTransactions',
        'dapp_encryption_public_key': dappPublicKey,
        'nonce': base58.encode(requestNonce),
        'payload': base58.encode(encryptedPayload!),
      },
    );
  }

  /// Verifies the [signature] returned by Solflare Wallet.
  bool validateSignature(String message, String signature) {
    final messageBytes = Uint8List.fromList(message.codeUnits);
    final signatureBytes = base58.decode(signature);

    return ReownCoreUtils.ed25519Verify(
      PublicKey(base58.decode(_solflarePublicKey!)),
      messageBytes,
      signatureBytes,
    );
  }

  Future<void> persistSession() async {
    try {
      final currentData =
          _core.secureStorage.has(StorageConstants.solflareSession)
          ? _core.secureStorage.get(StorageConstants.solflareSession)!
          : {};
      await _core.secureStorage.set(StorageConstants.solflareSession, {
        ...currentData,
        'session_token': _sessionToken,
        'solflare_encryption_public_key': _solflarePublicKey,
      });
    } catch (e) {
      _core.logger.e('[$runtimeType] persistSession $e');
    }
  }

  /// Decrypts the [data] payload returned by Solflare Wallet
  Future<Map<String, dynamic>> decryptPayload(
    Map<String, String> params,
  ) async {
    if (params.containsKey('errorCode')) {
      return params;
    }

    final solflareRequest = params['solflareRequest'] ?? '';
    // solflare_encryption_public_key is Solflare publicKey (not solana Address)
    final solflareKey = params['solflare_encryption_public_key'] ?? '';
    _core.logger.d(
      '[$runtimeType] solflare_encryption_public_key $solflareKey',
    );

    if (solflareRequest == 'connect') {
      // executed only once after successful /connect
      _solflarePublicKey = solflareKey;
      await _createSharedSecret();
    }

    if (solflareRequest == 'disconnect') {
      return <String, dynamic>{'solflareRequest': solflareRequest};
    }

    try {
      final data = params['data']!;
      final nonce = params['nonce']!;
      final decryptedData = _sharedSecretBox?.decrypt(
        pncl.ByteList(base58.decode(data)),
        nonce: Uint8List.fromList(base58.decode(nonce)),
      );

      final payload = <String, dynamic>{
        ...JsonDecoder().convert(String.fromCharCodes(decryptedData!)),
        if (solflareKey.isNotEmpty)
          'solflare_encryption_public_key': solflareKey,
        if (solflareRequest.isNotEmpty) 'solflareRequest': solflareRequest,
      };

      _sessionToken = payload['session'] ?? _sessionToken;

      return payload;
    } catch (e) {
      final queryParams = Uri.parse(solflareRequest).queryParameters;
      if (queryParams.containsKey('errorCode')) {
        final errorCode = queryParams['errorCode'];
        final errorMessage = params['errorMessage'];
        return {'errorCode': errorCode, 'errorMessage': errorMessage};
      } else {
        return Errors.getInternalError(
          Errors.MISSING_OR_INVALID,
          context: e.toString(),
        ).toJson();
      }
    }
  }

  /// Encrypts the data payload to be sent to Solflare Wallet.
  Uint8List? encryptPayload(Map<String, dynamic> data, Uint8List? nonce) {
    if (_sharedSecretBox == null) {
      return null;
    }

    final n = nonce ?? _core.crypto.getUtils().randomBytes(24);
    final payload = jsonEncode(data).codeUnits;
    final encryptedPayload = _sharedSecretBox?.encrypt(
      Uint8List.fromList(payload),
      nonce: n,
    );
    return encryptedPayload?.cipherText.asTypedList;
  }

  Uint8List _getKeyBytes(String key) {
    try {
      return base58.decode(key);
    } catch (error, stackTrace) {
      _core.logger.e(
        '[$runtimeType] _getKeyBytes $key',
        error: error,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Future<void> _createSharedSecret() async {
    // Create a shared secret between Solflare Wallet and our DApp using our [_privateKey] and [solflare_encryption_public_key].
    _sharedSecretBox = pncl.Box(
      myPrivateKey: pncl.PrivateKey(_currentKeyPair!.getPrivateKeyBytes()),
      theirPublicKey: pncl.PublicKey(_getKeyBytes(_solflarePublicKey!)),
    );
    try {
      final currentData =
          _core.secureStorage.has(StorageConstants.solflareSession)
          ? _core.secureStorage.get(StorageConstants.solflareSession)!
          : {};
      await _core.secureStorage.set(StorageConstants.solflareSession, {
        ...currentData,
        'self_private_key': _currentKeyPair!.getPrivateKeyBs58(),
        'self_public_key': _currentKeyPair!.getPublicKeyBs58(),
      });
    } catch (e) {
      _core.logger.e('[$runtimeType] _createSharedSecret $e');
    }
  }

  void resetSharedSecret() {
    _sessionToken = null;
    _sharedSecretBox = null;
  }
}
