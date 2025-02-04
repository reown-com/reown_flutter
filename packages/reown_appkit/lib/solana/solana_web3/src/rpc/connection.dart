/// Imports
/// ------------------------------------------------------------------------------------------------
library;

import 'dart:async' show TimeoutException;
import 'dart:typed_data' show Uint8List;
import 'package:reown_appkit/solana/solana_common/async.dart';
import 'package:reown_appkit/solana/solana_web3/solana_web3.dart';
import 'package:reown_core/reown_core.dart';
import '../programs/address_lookup_table/state.dart';
import '../programs/metaplex_token_metadata/program.dart';
import '../rpc/configs/get_address_lookup_table_config.dart';
import '../constants/timing.dart';
import '../crypto/nacl.dart' as nacl;
import '../exceptions/transaction_block_height_exceeded_exception.dart';
import '../exceptions/transaction_exception.dart';
import '../exceptions/transaction_nonce_invalid_exception.dart';
import 'http_connection.dart';
import 'websocket_connection.dart';

/// Connection
/// ------------------------------------------------------------------------------------------------

/// {@template solana_web3.Connection}
///
/// Creates a connection to invoke JSON RPC methods. HTTP method calls are sent to the [httpCluster]
/// and Websocket method calls are sent to the [websocketCluster].
///
/// The [commitment] level will be set as the default value for all methods that accept a
/// commitment parameter. Use a method call's `config` parameter to override the default value.
///
/// ```
/// final connection = Connection(Cluster.mainnet);
///
/// final accountInfo = await connection.getAccountInfo(
///   Pubkey.fromBase58('Es9vMFrzaCERmJfrF4H2FYD4KCoNkY11McCe8BenwNYB'),
///   config: GetAccountInfoConfig(
///     commitment: Commitment.finalized, // override default.
///   ),
/// );
///
/// print('Account Info ${accountInfo?.toJson()}');
/// ```
/// {@endtemplate}
///
// TODO: Auto connect / resubscribe when the device's connection status changes.
class Connection with HttpConnection, WebsocketConnection {
  /// Creates a connection to invoke JSON RPC methods.
  Connection(
    this.httpCluster, {
    final Cluster? websocketCluster,
    this.commitment = Commitment.confirmed,
  }) : websocketCluster = websocketCluster ?? httpCluster.toWebsocket() {
    httpClient = JsonRpcHttpClient(httpCluster.uri);
    websocketClient = JsonRpcWebsocketClient.withStringDecoder(
      this.websocketCluster.uri,
      onConnect: onWebsocketConnect,
      onDisconnect: onWebsocketDisconnect,
      onData: onWebsocketData,
      onError: onWebsocketError,
    );
  }

  /// The HTTP cluster.
  final Cluster httpCluster;

  /// The Websocket cluster.
  final Cluster websocketCluster;

  @override
  late final JsonRpcHttpClient httpClient;

  @override
  late final JsonRpcWebsocketClient websocketClient;

  @override
  final Commitment? commitment;

  /// Disposes of all the acquired resources.
  void dispose() {
    httpClient.dispose();
    websocketClient.dispose();
  }

  /// Returns the health status of [httpCluster].
  Future<HealthStatus> health() => httpClient.health();

  /// Returns the address lookup table of the provided [pubkey].
  Future<AddressLookupTableAccount?> getAddressLookupTable(
    final Pubkey pubkey, {
    final GetAddressLookupTableConfig? config,
  }) async {
    final AccountInfo? accountInfo = await getAccountInfo(pubkey,
        config: GetAccountInfoConfig(
          commitment: config?.commitment,
          encoding: AccountEncoding.base64,
          minContextSlot: config?.minContextSlot,
        ));
    final state =
        AddressLookupTableState.tryFromBorshBase64(accountInfo?.binaryData);
    return state != null
        ? AddressLookupTableAccount(key: pubkey, state: state)
        : null;
  }

  /// Requests an airdrop of [lamports] to [pubkey] and wait for transaction confirmation.
  ///
  /// Returns the transaction signature as a base-58 encoded string.
  Future<TransactionSignature> requestAndConfirmAirdrop(
    final Pubkey pubkey,
    final u64 lamports, {
    final CommitmentConfig? config,
  }) async {
    final TransactionSignature signature =
        await requestAirdrop(pubkey, lamports, config: config);
    final SignatureNotification notification =
        await confirmTransaction(signature, config: config);
    return notification.err != null
        ? Future.error(notification.err)
        : Future.value(signature);
  }

  /// Sign, send and confirm a [transaction].
  Future<TransactionSignature> sendAndConfirmTransaction(
    final Transaction transaction, {
    final SendAndConfirmTransactionConfig? config,
  }) async {
    final String signature = await sendTransaction(
      transaction,
      config: config?.toSendTransactionConfig(),
    );
    await confirmTransaction(
      signature,
      config: config?.toConfirmTransactionConfig(),
    );
    return signature;
  }

  /// Returns the current block height of the node or -1 if the request fails.
  Future<int> _checkBlockHeight({
    required final CommitmentAndMinContextSlotConfig? config,
  }) async {
    try {
      return await getBlockHeight(config: config);
    } catch (_) {
      return -1;
    }
  }

  /// Returns an error when [BlockhashWithExpiryBlockHeight.lastValidBlockHeight] has been exceeded.
  Future<SignatureNotification> _confirmTransactionBlockHeightExceeded(
    final BlockhashWithExpiryBlockHeight blockhash,
    final Commitment? commitment,
  ) async {
    final config = GetBlockHeightConfig(commitment: commitment);
    u64 blockHeight = await _checkBlockHeight(config: config);
    while (blockHeight <= blockhash.lastValidBlockHeight) {
      await Future.delayed(const Duration(seconds: 1));
      blockHeight = await _checkBlockHeight(config: config);
    }
    return Future.error(
      const TransactionBlockHeightExceededException(
        'Transaction signature block height exceeded.',
      ),
    );
  }

  /// Returns an error when the timeout duration for [commitment] elapsed.
  Future<SignatureNotification> _confirmTransactionTimeout<T>(
    final Commitment? commitment,
  ) {
    return Future.delayed(
      Duration(
        seconds:
            commitment == null || commitment == Commitment.finalized ? 60 : 30,
      ),
      () => Future.error(
        TimeoutException('Transaction signature confirmation timed out.'),
      ),
    );
  }

  /// Returns an error when the [nonce] information has changed.
  Future<SignatureNotification> _confirmTransactionNonceInvalid(
      final NonceWithMinContextSlot nonce, final Commitment? commitment,
      {final int maxAttempts = 10}) async {
    for (int i = 0; i < maxAttempts; ++i) {
      try {
        final nonceResponse = await getNonceAccountRaw(
          nonce.nonceAccount,
          config: GetNonceAccountConfig(
            commitment: commitment,
            minContextSlot: nonce.minContextSlot,
          ),
        );
        if (nonce.nonce != nonceResponse.result?.value?.nonce) {
          return Future.error(
            TransactionNonceInvalidException(
              'Transaction signature nonce invalid.',
              slot: nonceResponse.result?.context.slot,
            ),
          );
        }
      } catch (_) {
        // Try again...
      }
      await Future.delayed(const Duration(seconds: 2));
    }

    return Future.error(
        TimeoutException('Transaction signature nonce timed out.'));
  }

  /// Confirms a transaction by subscribing to receive a [signature] notification when the
  /// transaction has been confirmed.
  Future<SignatureNotification> confirmTransaction(
    final TransactionSignature signature, {
    final ConfirmTransactionConfig? config,
    final BlockhashWithExpiryBlockHeight? blockhash,
    final NonceWithMinContextSlot? nonce,
  }) async {
    assert(
      blockhash == null || nonce == null,
      'Confirm transaction by [blockhash] or [nonce], but not both.',
    );

    try {
      final Uint8List decodedSignature = base58.decode(signature);
      check(decodedSignature.length == nacl.signatureLength,
          'Invalid signature length.');
    } catch (error) {
      throw TransactionException(
          'Failed to decode base58 signature $signature.');
    }

    final SafeCompleter<SignatureNotification> completer = SafeCompleter();
    await signatureSubscribe(
      signature,
      onData: completer.complete,
      onError: completer.completeError,
      onDone: () => completer.completeError('Subscription closed.'),
      cancelOnError: true,
      config: SignatureSubscribeConfig(
        commitment: config?.commitment,
      ),
    );

    // Wait for a signature notification or one of the timeout strategies to expire.
    final SignatureNotification notification = await Future.any([
      completer.future,
      if (nonce != null)
        _confirmTransactionNonceInvalid(nonce, commitment)
      else if (blockhash != null)
        _confirmTransactionBlockHeightExceeded(blockhash, commitment)
      else
        _confirmTransactionTimeout(commitment),
    ]);

    // Use the signature status for [TransactionNonceInvalidException]s.
    final notificationErr = notification.err;
    if (notificationErr is TransactionNonceInvalidException) {
      return confirmSignatureStatus(
        signature,
        commitment: commitment,
        minContext: notificationErr.slot,
      );
    }

    // Return the result.
    return notificationErr != null
        ? Future.error(notificationErr)
        : Future.value(notification);
  }

  // /// Waits for the [subscription]'s transaction [signature] notification.
  // Future<SignatureNotification> confirmSignatureSubscription(
  //   final TransactionSignature signature,
  //   final WebsocketSubscription<SignatureNotification> subscription, {
  //   final BlockhashWithExpiryBlockHeight? blockhash,
  //   final NonceWithMinContextSlot? nonce,
  // }) async {
  //   assert(
  //     blockhash == null || nonce == null,
  //     'Confirm transaction by [blockhash] or [nonce]',
  //   );

  //   // Wait for a signature notification or one of the timeout strategies to expire.
  //   final SignatureNotification notification = await Future.any([
  //     // subscription.first,
  //     if (nonce != null)
  //       _confirmTransactionNonceInvalid(nonce, commitment)
  //     else if (blockhash != null)
  //       _confirmTransactionBlockHeightExceeded(blockhash, commitment)
  //     else
  //       _confirmTransactionTimeout(commitment),
  //   ]);

  //   // // Make sure the subscription has been cancelled.
  //   // unsubscribe(subscription).ignore();

  //   // Use the signature status for [TransactionNonceInvalidException]s.
  //   final notificationErr = notification.err;
  //   if (notificationErr is TransactionNonceInvalidException) {
  //     return confirmSignatureStatus(
  //       signature,
  //       commitment: commitment,
  //       minContext: notificationErr.slot,
  //     );
  //   }

  //   // Return the result.
  //   return notificationErr != null
  //     ? Future.error(notificationErr)
  //     : Future.value(notification);
  // }

  /// Confirms a transaction by fetching the status of [signature] and comparing its
  /// `confirmationStatus` to [commitment].
  ///
  /// The [signature] is considered confirmed if it has a `confirmationStatus` level >= to
  /// [commitment] and the slot in which it was processed is >= [minContext].
  Future<SignatureNotification> confirmSignatureStatus(
    final TransactionSignature signature, {
    final GetSignatureStatusesConfig? config,
    final Commitment? commitment,
    final int? minContext,
  }) async {
    SignatureStatus? status =
        await getSignatureStatus(signature, config: config);
    while (status != null && minContext != null && status.slot < minContext) {
      final int slots = minContext - status.slot;
      final int delay = slots * millisecondsPerSlot.floor();
      await Future.delayed(Duration(milliseconds: delay));
      status = await getSignatureStatus(signature, config: config);
    }
    if (status == null) {
      return const SignatureNotification(
        err: TransactionException(
          'Transaction signature status not found.',
        ),
      );
    }
    if (status.err != null) {
      return SignatureNotification(
        err: status.err,
      );
    }
    final Commitment commitmentLevel =
        commitment ?? this.commitment ?? Commitment.finalized;
    return SignatureNotification(
      err: commitmentLevel.compareTo(status.confirmationStatus) > 0
          ? const TransactionException(
              'Transaction signature status has not been confirmed.')
          : null,
    );
  }

  /// Returns all token `Metadata` accounts in [collectionMint].
  ///
  /// The metadata account structure can be found
  /// [here](https://docs.metaplex.com/programs/token-metadata/accounts#metadata).
  ///
  /// The [numberOfCreators] must include the candy machine creator (if any). For example, if
  /// your collection has 2 creators and you've used candy machine, [numberOfCreators] will be 3.
  Future<List<ProgramAccount>> getMetaplexCollection(
    final Pubkey collectionMint, {
    required final int numberOfCreators,
    final AccountEncoding encoding = AccountEncoding.base64,
    final DataSlice? dataSlice,
    final int? minContextSlot,
  }) async {
    const int maxCreators = 5;
    assert(numberOfCreators >= 0 && numberOfCreators <= maxCreators);

    // See https://docs.metaplex.com/programs/token-metadata/accounts#metadata fields for data sizes
    // and offsets.
    const int keySize = 1;
    const int updateAuthoritySize = 32;
    const int mintSize = 32;
    const int nameSize = 32;
    const int symbolSize = 10;
    const int uriSize = 200;
    const int sellerFeeBasisPointsSize = 2;
    const int creatorsAddressSize = 32;
    const int creatorsVerifiedSize = 1;
    const int creatorsShareSize = 1;
    const int primarySaleHappenedSize = 1;
    const int isMutableSize = 1;
    const int editionNonceSize = 1;
    const int tokenStandardSize = 1;
    const int collectionVerifiedSize = 1;
    const int collectionKeySize = 32;
    const int usesUseMethodSize = 1;
    const int usesRemainingSize = 8;
    const int usesTotalSize = 8;
    const int collectionDetailsSize = 9;
    const int programmableConfigSize = 34;

    const int encodedLengthSize = 4;
    const int optionFlagSize = 1;

    const int creatorsOffset = keySize +
        updateAuthoritySize +
        mintSize +
        encodedLengthSize +
        nameSize +
        encodedLengthSize +
        symbolSize +
        encodedLengthSize +
        uriSize +
        sellerFeeBasisPointsSize +
        optionFlagSize +
        encodedLengthSize; // Creators array option flag (1) + encoded length (4).

    const int creatorsSize =
        creatorsAddressSize + creatorsVerifiedSize + creatorsShareSize;
    final int currentCreatorsSize = numberOfCreators * creatorsSize;
    const int maxCreatorsSize = maxCreators * creatorsSize;

    final int collectionOffset = creatorsOffset +
        currentCreatorsSize +
        primarySaleHappenedSize +
        isMutableSize +
        optionFlagSize +
        editionNonceSize +
        optionFlagSize +
        tokenStandardSize +
        optionFlagSize; // Collection field's option flag (1).

    final int maxDataSize = collectionOffset +
        collectionVerifiedSize +
        collectionKeySize +
        optionFlagSize +
        usesUseMethodSize +
        usesRemainingSize +
        usesTotalSize +
        optionFlagSize +
        collectionDetailsSize +
        optionFlagSize +
        programmableConfigSize +
        80 +
        (maxCreatorsSize -
            currentCreatorsSize); // padding (80) + offset adjustment.

    return getProgramAccounts(
      MetaplexTokenMetadataProgram.programId,
      config: GetProgramAccountsConfig(
        commitment: commitment,
        encoding: encoding,
        dataSlice: dataSlice,
        minContextSlot: minContextSlot,
        filters: [
          DataSize(
            dataSize: maxDataSize,
          ),
          MemCmp(
            offset: collectionOffset + collectionVerifiedSize,
            bytes: collectionMint.toBase58(),
          ),
        ],
      ),
    );
  }
}
