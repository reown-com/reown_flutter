import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:pinenacl/x25519.dart' as pncl;
import 'package:reown_appkit/modal/constants/string_constants.dart';

import 'package:reown_core/reown_core.dart';

class PhantomHelper {
  late final String _scheme;
  late final String _host;

  /// (required): A url used to fetch app metadata (i.e. title, icon)
  /// We do this provinding name, description, url and icons in PairingMetadata
  /// Used in /connect URI to show the user this metadata in the approval modal
  late final String _appUrl;

  /// (required): The URI Phantom Wallet calls when redirecting back after a request
  /// We do this with the redirect object of PairingMetadata
  /// Used in every URI
  late final String _redirectLink;

  /// Private/Public keypair for encryption and decryption of phantom responses
  CryptoKeyPair? _currentKeyPair;
  String get dappPublicKey => base58.encode(
        _currentKeyPair!.getPublicKeyBytes(),
      );

  /// When a user connects to Phantom Wallet for the first time, Phantom will return a session token param that represents the user's connection.
  /// Will have to be securely stored
  /// Is then used in the payload of every request/URI
  String? _sessionToken;

  /// used to encrypt and decrypt the payload from and to Phantom Wallet
  pncl.Box? _sharedSecretBox;

  String? _phantomPublicKey;
  String get walletPublicKey => _phantomPublicKey ?? '';

  late final IReownCore _core;

  /// Initialization of `PhantomHelper` instance
  PhantomHelper({
    required Redirect redirect,
    required String appUrl,
    required String redirectLink,
    required IReownCore core,
  }) {
    _scheme = redirect.linkMode == true
        ? Uri.parse(redirect.universal ?? '').scheme
        : (redirect.native ?? '');
    _host = Uri.parse(redirect.universal ?? '').host;
    _appUrl = appUrl;
    _redirectLink = redirectLink;
    _core = core;
    _currentKeyPair = _core.crypto.getUtils().generateKeyPair();

    _core.logger.i(
      '[$runtimeType] init with host: $_host, callback: $_redirectLink',
    );
  }

  Future<bool> restoreSession() async {
    try {
      if (_core.storage.has(StorageConstants.phantomSession)) {
        final session = _core.storage.get(StorageConstants.phantomSession)!;
        _currentKeyPair = CryptoKeyPair(
          hex.encode(_getKeyBytes('${session['self_private_key']}')),
          hex.encode(_getKeyBytes('${session['self_public_key']}')),
        );
        _phantomPublicKey = session['phantom_encryption_public_key']!;
        _sessionToken = session['session_token']!;
        await _createSharedSecret();
        return true;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  /// Generate an URL to connect to Phantom Wallet
  Uri buildConnectionUri({String? cluster}) {
    // https://phantom.app/ul/<version>/<method>
    // phantom://<version>/<method>
    return Uri(
      scheme: _scheme,
      host: _host,
      path: '/ul/v1/connect',
      queryParameters: {
        'dapp_encryption_public_key': dappPublicKey,
        'cluster': cluster ?? 'mainnet-beta',
        'app_url': _appUrl,
        'redirect_link': '$_redirectLink?phantomRequest=connect',
      },
    );
  }

  /// Generate an URL to disconnect from Phantom Wallet and destroy the session.
  Uri buildDisconnectUri({Uint8List? nonce}) {
    final requestNonce = nonce ?? _core.crypto.getUtils().randomBytes(24);

    final payLoad = {'session': _sessionToken};
    final encryptedPayload = encryptPayload(payLoad, requestNonce);

    return Uri(
      scheme: _scheme,
      host: _host,
      path: '/ul/v1/disconnect',
      queryParameters: {
        'redirect_link': '$_redirectLink?phantomRequest=disconnect',
        'dapp_encryption_public_key': dappPublicKey,
        'nonce': base58.encode(requestNonce),
        'payload': base58.encode(encryptedPayload!),
      },
    );
  }

  bool _isBase58String(String input) {
    final base58Regex = RegExp(
        r'^[123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz]+$');
    return base58Regex.hasMatch(input);
  }

  /// Generates an URL with given [nonce] to be signed by Phantom Wallet
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
          : base58.encode(
              Uint8List.fromList(hashedMessage.codeUnits),
            ),
    };
    final encryptedPayload = encryptPayload(payload, requestNonce);

    return Uri(
      scheme: _scheme,
      host: _host,
      path: 'ul/v1/signMessage',
      queryParameters: {
        'redirect_link': '$_redirectLink?phantomRequest=signMessage',
        'dapp_encryption_public_key': dappPublicKey,
        'nonce': base58.encode(requestNonce),
        'payload': base58.encode(encryptedPayload!),
      },
    );
  }

  /// Generate an URL with given [transaction] to signAndSend it with Phantom Wallet.
  Uri buildSignAndSendTransactionUri({
    required String transaction,
    Uint8List? nonce,
  }) {
    final requestNonce = nonce ?? _core.crypto.getUtils().randomBytes(24);

    final payload = {
      'session': _sessionToken,
      'transaction': base58.encode(
        Uint8List.fromList(
          base64.decode(transaction),
        ),
      ),
    };
    final encryptedPayload = encryptPayload(payload, requestNonce);

    return Uri(
      scheme: _scheme,
      host: _host,
      path: '/ul/v1/signAndSendTransaction',
      queryParameters: {
        'redirect_link': '$_redirectLink?phantomRequest=signAndSendTransaction',
        'dapp_encryption_public_key': dappPublicKey,
        'nonce': base58.encode(requestNonce),
        'payload': base58.encode(encryptedPayload!),
      },
    );
  }

  /// Generate an URL with given [transaction] to sign it with Phantom Wallet.
  Uri buildSignTransactionUri({
    required String transaction,
    Uint8List? nonce,
  }) {
    final requestNonce = nonce ?? _core.crypto.getUtils().randomBytes(24);

    final payload = {
      'transaction': base58.encode(
        Uint8List.fromList(
          base64.decode(transaction),
        ),
      ),
      'session': _sessionToken,
    };

    final encryptedPayload = encryptPayload(payload, requestNonce);

    return Uri(
      scheme: _scheme,
      host: _host,
      path: '/ul/v1/signTransaction',
      queryParameters: {
        'redirect_link': '$_redirectLink?phantomRequest=signTransaction',
        'dapp_encryption_public_key': dappPublicKey,
        'nonce': base58.encode(requestNonce),
        'payload': base58.encode(encryptedPayload!),
      },
    );
  }

  /// Generate an URL with given [transactions] to sign all with Phantom Wallet.
  Uri buildUriSignAllTransactions({
    required List<String> transactions,
    Uint8List? nonce,
  }) {
    final requestNonce = nonce ?? _core.crypto.getUtils().randomBytes(24);

    final payload = {
      'transactions': transactions
          .map((e) => base58.encode(
                Uint8List.fromList(
                  base64.decode(e),
                ),
              ))
          .toList(),
      'session': _sessionToken,
    };

    final encryptedPayload = encryptPayload(payload, requestNonce);

    return Uri(
      scheme: _scheme,
      host: _host,
      path: '/ul/v1/signAllTransactions',
      queryParameters: {
        'redirect_link': '$_redirectLink?phantomRequest=signAllTransactions',
        'dapp_encryption_public_key': dappPublicKey,
        'nonce': base58.encode(requestNonce),
        'payload': base58.encode(encryptedPayload!),
      },
    );
  }

  /// Verifies the [signature] returned by Phantom Wallet.
  bool validateSignature(String message, String signature) {
    final messageBytes = Uint8List.fromList(message.codeUnits);
    final signatureBytes = base58.decode(signature);

    return ReownCoreUtils.ed25519Verify(
      PublicKey(base58.decode(_phantomPublicKey!)),
      messageBytes,
      signatureBytes,
    );
  }

  Future<void> persistSession() async {
    try {
      final currentData = _core.storage.has(StorageConstants.phantomSession)
          ? _core.storage.get(StorageConstants.phantomSession)!
          : {};
      await _core.storage.set(StorageConstants.phantomSession, {
        ...currentData,
        'session_token': _sessionToken,
        'phantom_encryption_public_key': _phantomPublicKey,
      });
    } catch (e) {
      _core.logger.d('[$runtimeType] persistSession $e');
    }
  }

  /// Decrypts the [data] payload returned by Phantom Wallet
  Future<Map<String, dynamic>> decryptPayload(
    Map<String, String> params,
  ) async {
    if (params.containsKey('errorCode')) {
      return params;
    }

    final phantomRequest = params['phantomRequest'] ?? '';
    // phantom_encryption_public_key is Phantom publicKey (not solana Address)
    final phantomKey = params['phantom_encryption_public_key'] ?? '';
    _core.logger.d('[$runtimeType] phantom_encryption_public_key $phantomKey');

    if (phantomRequest == 'connect') {
      // executed only once after successful /connect
      _phantomPublicKey = phantomKey;
      await _createSharedSecret();
    }

    if (phantomRequest == 'disconnect') {
      return <String, dynamic>{'phantomRequest': phantomRequest};
    }

    final data = params['data']!;
    final nonce = params['nonce']!;
    final decryptedData = _sharedSecretBox?.decrypt(
      pncl.ByteList(base58.decode(data)),
      nonce: Uint8List.fromList(base58.decode(nonce)),
    );

    final payload = <String, dynamic>{
      ...JsonDecoder().convert(String.fromCharCodes(
        decryptedData!,
      )),
      if (phantomKey.isNotEmpty) 'phantom_encryption_public_key': phantomKey,
      if (phantomRequest.isNotEmpty) 'phantomRequest': phantomRequest,
    };

    _sessionToken = payload['session'] ?? _sessionToken;

    return payload;
  }

  /// Encrypts the data payload to be sent to Phantom Wallet.
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
    // Create a shared secret between Phantom Wallet and our DApp using our [_privateKey] and [phantom_encryption_public_key].
    _sharedSecretBox = pncl.Box(
      myPrivateKey: pncl.PrivateKey(_currentKeyPair!.getPrivateKeyBytes()),
      theirPublicKey: pncl.PublicKey(_getKeyBytes(_phantomPublicKey!)),
    );
    try {
      final currentData = _core.storage.has(StorageConstants.phantomSession)
          ? _core.storage.get(StorageConstants.phantomSession)!
          : {};
      await _core.storage.set(StorageConstants.phantomSession, {
        ...currentData,
        'self_private_key': _currentKeyPair!.getPrivateKeyBs58(),
        'self_public_key': _currentKeyPair!.getPublicKeyBs58(),
      });
    } catch (e) {
      _core.logger.d('[$runtimeType] _createSharedSecret $e');
    }
  }

  void resetSharedSecret() {
    _sessionToken = null;
    _sharedSecretBox = null;
  }
}
